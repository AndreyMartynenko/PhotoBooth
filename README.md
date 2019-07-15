# PhotoBooth

### General
It's a simple PhotoBooth app. It allows to take pictures from ether front or back camera of the device, store it into photo gallery (with or without name) and browse previously taken pictures.

### Approach
The idea was to split code into separate components in order to improve readability and reusability. Data is stored locally using Realm framework.
A really simple but concise design was chosen in order to fulfil all acceptance criteria.

### Ideas
There's a lot room for improvements:
1. Renaming already stored photos
2. Improving UI style of photo gallery (Pinterest style for example)
3. Making carousel to present all saved photos while in fullscreen
4. Adding pinch / double tap gestures for fullscreen photos
5. Creating sections inside of photo gallery filtering by days for instance (timestamp is currently being stored but not used)

### Improvements
1. Creating InputView UI component to be used across the app: while storing / renaming photo (containing keyboard notifications logic for instance)
2. Creating generic protocol for AbstractDataService (please refer 'AbstractDataService' for more information)
3. Improving UI: adding animations, smooth transitions, and so on