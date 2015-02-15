package controllers

import play.modules.reactivemongo.MongoController
import play.modules.reactivemongo.json.collection.JSONCollection
import reactivemongo.api.Cursor

import scala.concurrent.Future

import play.api.libs.concurrent.Execution.Implicits.defaultContext

import org.slf4j.{LoggerFactory, Logger}

import javax.inject.Singleton

import play.api.mvc._
import play.api.libs.json._

/**
 * Created by nicholascraig on 2/14/15.
 * Tasks controller *
 */
@Singleton
class Tasks extends Controller with MongoController{
  private final val logger: Logger = LoggerFactory.getLogger(classOf[Tasks])
  
  def collection: JSONCollection = db.collection[JSONCollection]("tasks")
  
  import models.Task
  
  def createTask = Action.async(parse.json){
    request =>
      request.body.validate[Task].map{
        task =>
          collection.insert(task).map{
            lastError=>
              logger.debug(s"Successfully inserted with LastError: $lastError")
              Created(s"Task Created")
            
          }        
      }.getOrElse(Future.successful(BadRequest("invalid task json")))
    
  }
  
  def updateTask(description: String) = Action.async(parse.json){
    request =>
      request.body.validate[Task].map{
        task =>
          val descriptionSelector = Json.obj("description"->description)
          collection.update(descriptionSelector, task).map {
            lastError =>
              logger.debug(s"Successfully updated with LastError: $lastError")
              Created(s"Task updated")
          }
        
      }.getOrElse(Future.successful(BadRequest("invalid json: "+request.body)))
  }
  
  def listTasks = Action.async {
    
    val cursor: Cursor[Task] = collection.
      
      find(Json.obj("complete" -> false)).
      
      sort(Json.obj("created" -> -1)).
      
      cursor[Task]
    
    val futureTasksList: Future[List[Task]] = cursor.collect[List]()
    
    val futureTaskJsonArray: Future[JsArray] = futureTasksList.map { tasks =>
        Json.arr(tasks)      
    }
    futureTaskJsonArray.map {
      tasks =>
        Ok(tasks(0))
      
    }
  }
  
}
