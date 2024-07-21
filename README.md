# CalculatorApp
I created a calculator app modeled after the iPhone calculator, where results are computed and updated in real-time on the display. The app supports essential arithmetic operations—addition, subtraction, multiplication, and division—as well as trigonometric functions such as sine, cosine, and tangent. Notably, the calculator gracefully manages errors during computation.
## Key Design Decisions:
- **Queue-based Token Processing**: The app utilizes a queue data structure to process tokens in sequence, ensuring accurate computation based on user input order.
- **Separation of Concerns**: The OperationQueue handles queue functionality, computation, and error handling, while the calculator view model manages overall logic. This division streamlines code organization and improves readability.
- **Refined Calculator Algorithm**: Through rigorous testing and iteration, the calculator logic was structured into ```handleOperand()``` and ```handleOperation()``` methods. Further segmentation based on queue state enhances efficiency and responsiveness.
## Reflections and Improvements:
Upon reflection, while the queue effectively manages token processing, I recognize opportunities for enhancement:
- **Modularization**: Currently, the OperationQueue combines queue functionality with computation and error handling, which blurs separation of concerns. To enhance modularity and reusability, I would refactor to segregate these responsibilities more clearly.
- **Error Handling**: Implementing a more consistent use of the Result type and refining error propagation would improve reliability and maintainability. Rather than passing callbacks for error handling, returning an error enum and delegating error management to the view model would reinforce separation of concerns and modular design principles.

These refinements aim to elevate the app's architecture, ensuring scalability and maintainability while adhering to best practices in software design.
