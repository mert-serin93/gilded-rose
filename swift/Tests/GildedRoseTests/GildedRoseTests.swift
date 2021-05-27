import Foundation
import XCTest

@testable import GildedRose

class GildedRoseTests: XCTestCase {

    func testConjuredItem() {
        let items = [Item(name: "Conjured Mana Cake", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)

        var days = 2

        while days > 0 {
            app.updateQuality()
            days -= 1
        }

        // Conjured Items' double quality drop
        XCTAssertEqual(6, app.items[0].quality)
    }

    func testConjuredDoubleAfterSellIn() {
        let items = [Item(name: "Conjured Mana Cake", sellIn: 1, quality: 50)]
        let app = GildedRose(items: items)

        var days = 3

        while days > 0 {
            app.updateQuality()
            days -= 1
        }

        // Conjured Items' double quality drop should be 4 if sellIn less than zero
        XCTAssertEqual(40, app.items[0].quality)
    }

    // Aged brie's quality should increase when sellIn bigger than zero
    func testAgedBrie() {
        let items = [Item(name: "Aged Brie", sellIn: 10, quality: 5)]
        let app = GildedRose(items: items)

        var days = 3

        while days > 0 {
            app.updateQuality()
            days -= 1
        }


        XCTAssertEqual(8, app.items[0].quality)
    }

    //Quality can be maximum 50
    func testQualityMaxFifty() {
        let items = [Item(name: "Aged Brie", sellIn: 10, quality: 48)]
        let app = GildedRose(items: items)

        var days = 3

        while days > 0 {
            app.updateQuality()
            days -= 1
        }


        XCTAssertEqual(50, app.items[0].quality)
    }

    func testQualityDropsAfterConcert() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 10)]
        let app = GildedRose(items: items)

        var days = 5

        while days > 0 {
            app.updateQuality()
            days -= 1
        }


        //Until concert quality should increase days * 3 if it's less than 5 days
        XCTAssertEqual(25, app.items[0].quality)

        //Simulate after concert
        app.updateQuality()

        XCTAssertEqual(0, app.items[0].quality)
    }
}
