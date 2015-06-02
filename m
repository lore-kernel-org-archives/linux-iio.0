Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42025 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbbFBS2p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2015 14:28:45 -0400
Message-ID: <556DF5D8.9080000@kernel.org>
Date: Tue, 02 Jun 2015 19:28:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: IIO_GESTURE proposal
References: <CAKzfze8qX0WEKmHgBKKVvw-=mzFOUVSQnOXXxjUPdm=BafoYqA@mail.gmail.com>
In-Reply-To: <CAKzfze8qX0WEKmHgBKKVvw-=mzFOUVSQnOXXxjUPdm=BafoYqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/15 05:35, Matt Ranostay wrote:
> Jonathan,
> 
> So I am currently planning on implementing a driver for the Avago
> APDS-9960 that has the typical ALS, RGBC, and proximity sensor
> components. But this part has a gesture function that uses 4 IR
> photodiodes aligned in a grid of UP-DOWN-LEFT-RIGHT that detect IR
> light reflection off an object, and in turn reports back the direction
> a hand or similar would make over the sensor.
> 
> Now the data that is reported back is the intensity of each of the 4
> LEDs (UPLR) which then userspace can compute the velocity, and
> direction of the gesture. My question should some thing like this be
> using 4 IIO_INTENSITY channels or just one 32-bit value and new type
> of IIO_GESTURE?
Interesting device.

Anyhow, my immediate reaction is that the single 32 bit value is effectively
device specific whereas breaking it up into 4 values makes it more generic.
(just wait for the predictable 8 led version to offer extra LEDs on the diagonals)

The question that follows is how to make their relative positions / sensitive directions
apparent to userspace?  

I'd go for sensitive direction as the optics of different sensors may give very different
correspondences.

So we 'could' do it with modifiers but how do we make them generic enough?
How about a a sensitive_direction type infomask element that gives an approximate
pointing vector? (using the read_raw_multi)

Other suggestion welcome as I have only been considering this whilst navigating Dublin
airport and a few beers waiting for the plane.

Jonathan
> 
> Datasheet -> https://cdn.sparkfun.com/datasheets/Sensors/Proximity/apds9960.pdf
> 
> 
> Thanks,
> 
> Matt Ranostay
> 

