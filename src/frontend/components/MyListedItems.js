import { useState, useEffect } from "react";
import { ethers } from "ethers";
import { Row, Col, Card, Button } from "react-bootstrap";

export default function MyListedItems({ marketplace, nft, account}) {
    const [loading, setLoading] = useState(true);
    const [listedItems, setListedItems] = useState([]);
    const [soldItems, setSoldItems] = useState([]);

    const loadListedItems = async () => {
        const itemCount = await marketplace.itemCount();
        let listedItems = [];
        let soldItems = [];
        for (let indx = 1; indx <= itemCount; indx++) {
            const i = await marketplace.items(indx)
            if (i.seller.toLowerCase() === account) {
              // get uri url from nft contract
              const uri = await nft.tokenURI(i.tokenId)
              // use uri to fetch the nft metadata stored on ipfs 
              const response = await fetch(uri);
              const metadata = await response.json();
              // get total price of item (item price + fee)
              const totalPrice = await marketplace.getTotalPrice(i.itemId);
              // define listed item object
              let item = {
                totalPrice,
                price: i.price,
                itemId: i.itemId,
                name: metadata.name,
                description: metadata.description,
                image: metadata.image
              }
              listedItems.push(item)
              // Add listed item to sold items array if sold
              if (i.sold) soldItems.push(item)
            }
          }
        setListedItems(listedItems);
        setSoldItems(soldItems);
        setLoading(false);
    }

    useEffect(() => {
        loadListedItems();
    }, []);

    return (
        <div className="felx justify-center">
            </div>
    );
}