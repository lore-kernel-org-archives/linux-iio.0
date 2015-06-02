Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
Date: Mon, 1 Jun 2015 21:35:17 -0700
Message-ID: <CAKzfze8qX0WEKmHgBKKVvw-=mzFOUVSQnOXXxjUPdm=BafoYqA@mail.gmail.com>
Subject: IIO_GESTURE proposal
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan,

So I am currently planning on implementing a driver for the Avago
APDS-9960 that has the typical ALS, RGBC, and proximity sensor
components. But this part has a gesture function that uses 4 IR
photodiodes aligned in a grid of UP-DOWN-LEFT-RIGHT that detect IR
light reflection off an object, and in turn reports back the direction
a hand or similar would make over the sensor.

Now the data that is reported back is the intensity of each of the 4
LEDs (UPLR) which then userspace can compute the velocity, and
direction of the gesture. My question should some thing like this be
using 4 IIO_INTENSITY channels or just one 32-bit value and new type
of IIO_GESTURE?

Datasheet -> https://cdn.sparkfun.com/datasheets/Sensors/Proximity/apds9960.pdf


Thanks,

Matt Ranostay
