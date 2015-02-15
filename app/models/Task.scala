package models

/**
 * Created by nicholascraig on 2/14/15.
 */
case class Task(description: String,
                 complete: Boolean)

object Task{
  import play.api.libs.json.Json
  implicit val taskFormat = Json.format[Task]
  
}