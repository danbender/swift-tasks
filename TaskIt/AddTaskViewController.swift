import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    func addTask(message:String)
    func addTaskCanceled(message:String)
}

class AddTaskViewController: UIViewController {
        
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var delegate:AddTaskViewControllerDelegate?

    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTaskCanceled("Task was not added!")
        
    }
    
    @IBAction func addTaskButtonTapped(sender: UIButton) {
       
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
         
            task.task = taskTextField.text.capitalizedString
            
        } else {
            
            task.task = taskTextField.text
        }
        
       
        task.subtask = subTaskTextField.text
        task.date = dueDatePicker.date
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
            
            task.completed = true
            
        } else {
            
            task.completed = false
            
        }
        
        appDelegate.saveContext()
        
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
//        & optimization only create memory space when needed; here: in case of error.
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task added!")

    }
}
