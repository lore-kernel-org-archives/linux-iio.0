Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
Date: Wed, 26 Aug 2015 21:55:39 -0700
Message-ID: <CAKzfze8Qt99iUDyamy9bhxGHN3tJpMPVi6yMwe7zUfeF2YFO7Q@mail.gmail.com>
Subject: [RFC] Air quality sensor channel type
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan et all,

Shortly going to be working an i2c air quality sensor and noticed
there is no current IIO_* channel attribute for anything VOC (volatile
organic compound) or CO2 readings. The data that this sensor would
report back is the parts per million of particles, so my first thought
is something like IIO_VOCPPM.

Also which subdirectory would make sense in? Or a new one like drivers/iio/voc ?

MICS-VZ-89T I2C Datasheet:
* http://sgx.cdistore.com/datasheets/sgx/VZ-89-I2C-Specs.pdf


Thoughts? Comments?

Thanks,

Matt
