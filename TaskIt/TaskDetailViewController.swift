import UIKit

@objc protocol TaskDetailViewControllerDelegate {
    optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {
    
    var detailTaskModel: TaskModel!
        
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!

    var delegate:TaskDetailViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskTextField.text = detailTaskModel.task
        self.subTaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subTaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
        delegate?.taskDetailEdited!()
    }
}
