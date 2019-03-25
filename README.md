# MemeMe
**MemeMe** is the submitted Udacity iOS Developer project.

## Installation
Clone the GitHub repository and use Xcode to install.

## How to Use
When you first open **MemeMe**, you are presented with an empty Sent Memes table.  Use the '+' icon to create a new meme.

### Sent Memes Table Controls
- Swipe vertically: Scroll through the available memes you created
- Tap a meme: Opens a details page, where you can get a full-screen view of your created meme in-app
- Tap Collection: Opens a collection-style view of the available memes
- '+' icon: Opens the Meme Creator view

### Sent Memes Collection Controls
- Swipe Vertically: Scroll through the available memes
- Tap Table: Return to the Table view

## Meme Creator
Select any photo in your device's gallery, enter the top text, enter the bottom text, save.  That's all there is to creating your own meme, ready for sharing on social media.

### Meme Creator Controls
- Choose an Image: Opens your device's photo gallery, where you can select any of your photos as the photo for your meme
- Camera icon: Opens your device's camera, where you can shoot a new photo for use in your meme
- Share icon: Opens your device's Activity Controller, where you can add your created meme as a photo in your device's gallery
- Tap Top: Allows the upper text to be editable
- Tap Bottom: Allows the lower text to be editable
- Cancel: Returns to the Sent Memes view without creating a meme

## Planned Updates
- Icons will be added to the Table and Collection items in Sent Memes
- A label will appear when the table/collection is empty, prompting to create a new meme
- Constraints will be updated for newer devices, such that the meme text is not positioned outside of the photo
- Text size can be toggled in Meme Creator
- Persistence will be added to allow the Sent Memes state to be saved, even after app closure
- A delete function will be added to remove created memes from Sent Memes
