import Foundation

enum SamplePlaces {
    static let all: [Place] = [
        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "Широк Сокак",
            description: "Најпознатото шеталиште во Битола, со архитектура, кафулиња и жив градски амбиент.",
            address: "Широк Сокак, Битола",
            category: "Градска знаменитост",
            latitude: 41.0305,
            longitude: 21.3332,
            imageURL: "https://bitolacityguide.com/wp-content/uploads/2024/05/siroksokaknova2025-2048x1366.jpg"
        ),
        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "Саат Кула",
            description: "Еден од најпрепознатливите симболи на Битола, сместен во централното градско подрачје.",
            address: "Центар, Битола",
            category: "Историска знаменитост",
            latitude: 41.0299,
            longitude: 21.3348,
            imageURL: "https://bitolacityguide.com/wp-content/uploads/2024/04/backimgwide.jpg"
        ),
        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            name: "Хераклеја Линкестис",
            description: "Антички археолошки локалитет познат по мозаиците, театарот и богатото културно наследство.",
            address: "Хераклеја, Битола",
            category: "Археолошки локалитет",
            latitude: 41.0117,
            longitude: 21.3429,
            imageURL: "https://3.bp.blogspot.com/-jsu5hCUgnAA/Vy5mKOvFquI/AAAAAAAABcE/_y8zYxhba3gJ1lP3NMkfUFYsQg1taxL5wCPcB/s1600/heraclea-lyncestis-bitola-0132.jpg"
        ),
        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            name: "Музеј Битола",
            description: "Музејска поставка сместена во објектот на старата воена академија, со материјали од историјата на градот.",
            address: "Климент Охридски, Битола",
            category: "Музеј",
            latitude: 41.0308,
            longitude: 21.3308,
            imageURL: "https://bitolacityguide.com/wp-content/uploads/2024/05/Screenshot-2025-05-26-152249.png"
        ),
        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            name: "Плоштад Магнолија",
            description: "Централна градска точка веднаш до Широк Сокак и Саат Кулата.",
            address: "Плоштад Магнолија, Битола",
            category: "Плоштад",
            latitude: 41.0300,
            longitude: 21.3341,
            imageURL: "https://questmacedonia.com/wp-content/uploads/2017/02/bitola-magnolija-1-770x450.jpg"
        ),
        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
            name: "Градски парк",
            description: "Зелена зона за прошетка и одмор во близина на центарот на Битола.",
            address: "Градски парк, Битола",
            category: "Парк",
            latitude: 41.0267,
            longitude: 21.3297,
            imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbZte0yXEc5-tHSP3vFuYSkXEGHGU9VEUb5UorSEHxLCxltb55x3W9_4Bt&s=10"
        ),
        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000007")!,
            name: "Belvedere",
            description: "Популарен ресторан во центарот на Битола со разновидна храна и пријатна атмосфера.",
            address: "Центар, Битола",
            category: "Ресторан",
            latitude: 41.03038,
            longitude: 21.33530,
            imageURL: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/c2/10/fb/belvedere.jpg?w=600&h=-1&s=1"
        ),

        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000008")!,
            name: "Lounge Bar Manaki",
            description: "Познат lounge bar и ресторан во центарот на Битола, погоден за кафе, храна и вечерно излегување.",
            address: "Рузвелтова 17, Битола",
            category: "Ресторан и бар",
            latitude: 41.030284,
            longitude: 21.337061,
            imageURL: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/88/3a/b8/lounge-bar-manaki.jpg?w=600&h=600&s=1"
        ),

        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000009")!,
            name: "Pizza Metro",
            description: "Популарна пицерија на Широк Сокак која нуди пици, сендвичи и други јадења.",
            address: "Широк Сокак 18, Битола",
            category: "Пицерија",
            latitude: 41.030227,
            longitude: 21.334223,
            imageURL: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/4f/06/07/pizza-metro.jpg?w=1200&h=1200&s=1"
        ),

        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000010")!,
            name: "Cafe Pajton",
            description: "Познато битолско кафуле на Широк Сокак, идеално за кафе и дружење во центарот на градот.",
            address: "Широк Сокак 87, Битола",
            category: "Кафуле",
            latitude: 41.02758,
            longitude: 21.33645,
            imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcKFf7wm_0iyGeoxRzabElq1didaDxjBpUR1XJPzCHdzGWV5QUcApqDeAM&s=10"
        ),

        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000011")!,
            name: "Barista Coffee Shop",
            description: "Кафуле во центарот на Битола познато по кафе, пијалаци и релаксирана атмосфера.",
            address: "Маршал Тито 56, Битола",
            category: "Кафуле",
            latitude: 41.028487,
            longitude: 21.335806,
            imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPTesEkp-IfiR_yC2zL8wV6aAaKM24MlQiKFROYrq93VS5fHcCQnc_KDRE&s=10"
        ),

        Place(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000015")!,
            name: "Зоолошка градина Битола",
            description: "Зоолошката градина во Битола е едно од познатите места за посета и прошетка, особено за семејства со деца.",
            address: "Тумбе Кафе, Битола",
            category: "Зоолошка градина",
            latitude: 41.0146,
            longitude: 21.3415,
            imageURL: "https://upload.wikimedia.org/wikipedia/commons/7/74/ЗООБитола.JPG?utm_source=en.wikipedia.org&utm_campaign=index&utm_content=original"
        ),

    ]
}
