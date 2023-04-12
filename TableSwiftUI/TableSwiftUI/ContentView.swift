//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Ferrell, Wesley A on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Vagabond", neighborhood: "Downtown", desc: "Vagabond is located just off campus on LBJ. It's located right next to another vintage retailer, Lovebuzz. Vagabond has been a San Marcos staple since David Marrs opened the store in 2001. It was the first vintage clothing store opened in San Marcos. Don't neglect to check out the pieces displayed on the walls. These staff picks are indeed for sale and are often rare or designer.", lat: 29.884990, long: -97.940160, imageName: "vagabond"),
    Item(name: "Lovebuzz", neighborhood: "Downtown", desc: "Lovebuzz is now the store that occupies the space left by Monkies when it closed its doors. Lovebuzz has a wide variety of vintage pieces.  Follow them on instagram @lovebuzztx to get a discount at check out! ", lat: 29.884840, long: -97.940110, imageName: "lovebuzz"),
    Item(name: "Old Soul", neighborhood: "Downtown", desc: "Old Soul is a vintage clothing outfitter located on LBJ, but a little farther down than Vagabond and Lovebuzz. This store has a cozy atmosphere and plays some killer music. The staff and owner are super friendly, so make sure to say hi! ", lat: 29.882770, long: -97.940150, imageName: "oldsoul"),
    Item(name: "Plato's Closet", neighborhood: "Off Hopkins", desc: "Plato's closet is a resale chain that recently opened up next to the now vacant Half-Priced Books. Plato's closet will buy your clothes off you for cash. Just bring in clean clothing you're looking to sell, and a buyer will go through them and buy what they like. They are focused on teen and young adult fashions.", lat: 29.879939, long: -97.919045, imageName: "plato"),
    Item(name: "Uptown Cheapskate", neighborhood: "Centex", desc: "Uptown Cheapskate is a resale chain that upcylces clothes from within the community. Just bring in fresh laundered clothes you're looking to sell and an associate will help you. They'll buy pieces off you for cash, in-store credit, or even consign if the item is from a luxury brand. ", lat: 29.8920887, long: -97.9189733, imageName: "uptown")
   ]
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let neighborhood: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }
    


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.884114, longitude: -97.928749), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))

    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            }
                            .frame(height: 300)
                            .padding(.bottom, -30)
            }
            .listStyle(PlainListStyle())
                   .navigationTitle("Vintage Outfitters")
        }

    }
}
struct DetailView: View {
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    }
       let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: 370)
               Text("Neighborhood: \(item.neighborhood)")
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
                   }
                    .navigationTitle(item.name)
                    Spacer()
           Map(coordinateRegion: $region, annotationItems: [item]) { item in
             MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                 Image(systemName: "mappin.circle.fill")
                     .foregroundColor(.red)
                     .font(.title)
                     .overlay(
                         Text(item.name)
                             .font(.subheadline)
                             .foregroundColor(.black)
                             .fixedSize(horizontal: true, vertical: false)
                             .offset(y: 25)
                     )
             }
         }
             .frame(height: 300)
             .padding(.bottom, -30)
        }
     }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
