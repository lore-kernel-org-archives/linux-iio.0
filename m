Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
Date: Thu, 9 Jul 2015 10:23:56 -0700
Message-ID: <CAKzfze8sGEyU9DgDR4y2p3=5d+9024WgqgVw5fsv4b2XY1HH1g@mail.gmail.com>
Subject: Multiple IIO_THRESHOLD events
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

I am currently working on temperature sensor that has multiple trip
points, and was wondering what would be the correct way to tie this to
one channel if several events may have the same IIO_EV_DIR_*
direction.

low temp trippoint - > IIO_EV_DIR_FALLING
high temp trippoint -> IIO_EV_DIR_RISING
critical temp trippoint ->  ?

Would it make sensor to add functionality to allow iio_event_spec to
have an .index field so multiple IIO_EV_DIR_RISING could be parsed
into sysfs entries?


Thanks,

Matt
