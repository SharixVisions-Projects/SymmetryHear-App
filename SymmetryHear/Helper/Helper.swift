
import Foundation
import UIKit

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UILabel {

    @IBInspectable var borderWidth2: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius2: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor2: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UIView {

    @IBInspectable var borderWidth1: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius1: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor1: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

func roundCorner(button:UIButton)
{
    button.layer.cornerRadius = button.frame.size.height/2
    button.clipsToBounds = true
}

func roundCorneView(view:UIView)
{
    view.layer.cornerRadius = view.frame.size.height/2
    view.clipsToBounds = true
}

func roundCorneLabel(label:UILabel)
{
    label.layer.cornerRadius = label.frame.size.height/2
    label.clipsToBounds = true
}

struct Profiles: Codable,Equatable {
    var name: String
    var DOB : Date 
    var Gender: String
    var Occupation: String
    var Enviornment:String
    var Lowfreq:String
    var HighFreq:String
        
}

var currency = ""

func formatAmount(_ amount: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    
    // Convert amount to a number
    if let number = formatter.number(from: amount) {
        return formatter.string(from: number) ?? amount
    } else {
        // If conversion fails, assume there's no dot and add two zeros after it
        let amountWithDot = amount + ".00"
        return formatter.string(from: formatter.number(from: amountWithDot)!) ?? amountWithDot
    }
}

extension UIViewController
{
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}




let dailyQuotes = [
    "Successful people are not gifted; they just work hard, then succeed on purpose. —G.K. Nielson",
    "Success isn't always about greatness. It's about consistency. Consistent hard work leads to success. Greatness will come. —Dwayne Johnson",
    "The only thing standing between you and outrageous success is continuous progress. —Dan Waldschmidt",
    "I never dreamt of success. I worked for it. —Estée Lauder",
    "Success seems to be connected with action. Successful people keep moving. They make mistakes, but they don't quit. —Conrad Hilton",
    "Success in business requires training and discipline and hard work. But if you're not frightened by these things, the opportunities are just as great today as they ever were. —David Rockefeller",
    "Character cannot be developed in ease and quiet. Only through experience of trial and suffering can the soul be strengthened, vision cleared, ambition inspired and success achieved. —Helen Keller",
    "I've come to believe that each of us has a personal calling that's as unique as a fingerprint and that the best way to succeed is to discover what you love and then find a way to offer it to others in the form of service, working hard and also allowing the energy of the universe to lead you. —Oprah Winfrey",
    "Success is the sum of small efforts, repeated day in and day out. —Robert Collier",
    "The most certain way to succeed is always to try just one more time. —Thomas Edison",
    "Success is no accident. It is hard work, perseverance, learning, studying, sacrifice and most of all, love of what you are doing or learning to do. —Pelé",
    "Talent is nothing without persistence. —Dean Crawford",
    "Persistence is the twin sister of excellence. One is a matter of quality; the other, a matter of time. —Marabel Morgan",
    "You never know what's around the corner. It could be everything. Or it could be nothing. You keep putting one foot in front of the other, and then one day you look back and you've climbed a mountain. —Tom Hiddleston",
    "A little more persistence, a little more effort and what seemed hopeless failure may turn to glorious success. —Elbert Hubbard",
    "Most of the important things in the world have been accomplished by people who have kept on trying when there seemed to be no hope at all. —Dale Carnegie",
    "Perseverance is the hard work you do after you get tired of doing the hard work you already did. —Newt Gingrich",
    "It does not matter how slowly you go so long as you do not stop. —Confucius",
    "Continuous effort—not strength or intelligence—is the key to unlocking our potential. —Winston Churchill",
    "If you get tired, learn to rest, not to quit. —Banksy",
    "Perseverance is not a long race; it is many short races one after the other. —Walter Elliot",
    "Motivation will almost always beat mere talent. —Norman Ralph Augustine",
    "Let me tell you the secret that has led me to my goals: my strength lies solely in my tenacity. —Louis Pasteur",
    "Dreams are lovely. But they are dreams. Fleeting, ephemeral, pretty. But dreams do not come true just because you dream them. It's hard work that makes things happen. It's hard work that makes things happen. —Shonda Rhimes",
    "You may encounter many defeats, but you must not be defeated. In fact, it may be necessary to encounter the defeated, so you can know who you are, what you can rise from, how you can still come out of it. —Maya Angelou",
    "Obstacles can't stop you. Problems can't stop you. Most of all, other people can't stop you. Only you can stop you. —Jeffrey Gitomer",
    "Always do your best. What you plant now, you will harvest later. —Og Mandino",
    "Instead of looking at the past, I put myself ahead 20 years and try to look at what I need to do now in order to get there then. —Diana Ross",
    "Without hustle, talent will only carry you so far. —Gary Vaynerchuk",
    "Start where you are. Use what you have. Do what you can. —Arthur Ashe",
    "You miss 100% of the shots you don't take. —Wayne Gretzky",
    "Setting goals is the first step in turning the invisible into the visible. —Tony Robbins",
    "Discipline is choosing between what you want now and what you want most. —Augusta F. Kantra",
    "Plans are only good intentions unless they immediately degenerate into hard work. —Peter Drucker",
    "The way to get started is to quit talking and begin doing. —Walt Disney",
    "Do not whine. Do not complain. Work harder. —Joan Didion",
    "Developing a good work ethic is key. Apply yourself at whatever you do, whether you're a janitor or taking your first summer job, because that work ethic will be reflected in everything you do in life. —Tyler Perry",
    "The future depends on what you do today. —Mahatma Gandhi",
    "Work harder than you think you did yesterday. —Alex Elle",
    "All growth depends upon activity. There is no development physically or intellectually without effort, and effort means work. —Calvin Coolidge",
    "Nothing ever comes to one, that is worth having, except as a result of hard work. —Booker T. Washington",
    "If you work really hard, and you're kind, amazing things will happen. —Conan O'Brien",
    "Opportunities are usually disguised as hard work, so most people don't recognize them. —Ann Landers",
    "There will be obstacles. There will be doubters. There will be mistakes. But with hard work, there are no limits. —Michael Phelps",
    "You're not obligated to win. You're obligated to keep trying to do the best you can every day. —Marian Wright Edelman",
    "I'm a great believer in luck, and I find the harder I work the more I have of it. —Thomas Jefferson",
    "I do not know anyone who has got to the top without hard work. That is the recipe. It will not always get you to the top, but should get you pretty near. —Margaret Thatcher",
    "When you live for a strong purpose, then hard work isn't an option. It's a necessity. —Steve Pavlina",
    "It's not about money or connections. It's the willingness to outwork and outlearn everyone. —Mark Cuban",
    "Always go with the choice that scares you the most, because that's the one that is going to require the most from you. —Caroline Myss",
    "Happiness is the real sense of fulfillment that comes from hard work. —Joseph Roland Barbera",
    "This is the real secret of life—to be completely engaged with what you are doing in the here and now. Instead of calling it work, realize it is play. —Alan Wilson Watts",
    "Don't settle for average. Bring your best to the moment. Then, whether it fails or succeeds, at least you know you gave all you had. We need to live the best that's in us. —Angela Bassett",
    "The only thing that overcomes hard luck is hard work. —Harry Golden",
    "A man can make what he wants of himself if he truly believes that he must be ready for hard work and many heartbreaks. —Thurgood Marshall",
    "If people knew how hard I worked to get my mastery, it wouldn't seem so wonderful after all. —Michelangelo",
    "Before you start some work, always ask yourself three questions - Why am I doing it, What the results might be and Will I be successful. Only when you think deeply and find satisfactory answers to these questions, go ahead. —Chanakya",
    "Do the best you can until you know better. Then when you know better, do better. —Maya Angelou",
    "Success is no accident. It is hard work, perseverance, learning, studying, sacrifice and most of all, love of what you are doing or learning to do. —Pelé",
    "I do not know anyone who has got to the top without hard work. That is the recipe. It will not always get you to the top, but should get you pretty near. —Margaret Thatcher",
    "Hard work spotlights the character of people: some turn up their sleeves, some turn up their noses, and some don’t turn up at all. —Sam Ewing",
    "The only thing standing between you and outrageous success is continuous progress you need discipline. —Dan Waldschmidt",
    "Talent is cheaper than table salt. What separates the talented individual from the successful one is a lot of hard work. —Stephen King",
    "Hard work is a prison sentence only if it does not have meaning. Once it does, it becomes the kind of thing that makes you grab your wife around the waist and dance a jig. —Malcolm Gladwell",
    "The fight is won or lost far away from witnesses — behind the lines, in the gym, and out there on the road, long before I dance under those lights. —Muhammad Ali",
    "Most of the important things in the world have been accomplished by people who have kept on trying when there seemed to be no hope at all. —Dale Carnegie",
    "The only place where success comes before work is in the dictionary. —Vidal Sassoon",
    "Doing the best at this moment puts you in the best place for the next moment. —Oprah Winfrey",
    "You can’t have a million-dollar dream with a minimum-wage work ethic. —Stephen C. Hogan",
    "The difference between the impossible and the possible lies in a person's determination. —Tommy Lasorda",
    "Winners embrace hard work. They love the discipline of it, the trade-off they're making to win. Losers, on the other hand, see it as punishment. And that's the difference. —Lou Holtz",
    "Without hard work, nothing grows but weeds. —Gordon B. Hinckley",
    "Work hard in silence, let your success be your noise. —Frank Ocean",
    "If you want to make an easy job seem mighty hard, just keep putting off doing it. —Olin Miller",
    "What you don’t sweat out when you’re young will turn into tears when you’re old. —Japanese Proverb",
    "There is no traffic jam along the extra mile. —Roger Staubach",
    "Things may come to those who wait, but only the things left by those who hustle. —Abraham Lincoln",
    "To achieve greatness, start where you are, use what you have, do what you can. —Arthur Ashe",
    "You have to fight to reach your dream. You have to sacrifice and work hard for it. —Lionel Messi",
    "Don't wish it were easier. Wish you were better. —Jim Rohn",
    "You just can't beat the person who never gives up. —Babe Ruth"
]

struct Item {
    let title: String
    let details: String
    var isExpanded: Bool
}

var items: [Item] = [
      Item(title: "Understanding Hearing:", details:
            "How the Ear Works: A breakdown of the three main parts of the ear—outer, middle, and inner ear—and how sound is processed. Include animations or diagrams to show how sound waves travel through the ear, converting to signals the brain can understand. Frequency and Hearing Ranges: Explain what frequency means in terms of sound (measured in Hertz) and how humans typically hear sounds between 20 Hz and 20,000 Hz. Provide an interactive tool to let users experience different.", isExpanded: false),
      Item(title: "Common Hearing Issues:", details:
            "Hearing Loss Types: Educate users on the different types of hearing loss (conductive, sensorineural, and mixed), along with their causes and treatments. Tinnitus: A section about what tinnitus is (ringing in the ears), its causes, and tips to manage it. Age-Related Hearing Decline: How hearing naturally declines with age and what steps can be taken to slow down the process. Noise-Induced Hearing Loss: Describe how exposure to loud sounds can cause permanent damage and offer advice on.", isExpanded: false),
      Item(title: "Hearing Protection Tips:", details:
           "Protecting Your Ears in Noisy Environments: Suggest practical measures such as wearing earplugs or noise-cancelling headphones when exposed to loud environments. Volume Guidelines for Safe Listening: Explain safe listening levels for headphones (below 85 dB) and provide tools or warnings when users exceed this threshold. Routine Hearing Checks: Encourage users to regularly test their hearing, monitor changes over time, and consult a hearing specialist if necessary.", isExpanded: false)
     
  ]
