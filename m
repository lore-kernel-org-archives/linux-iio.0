Return-Path: <error27@gmail.com>
Date: Wed, 29 Jun 2011 21:22:21 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, Barry Song <barry.song@analog.com>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: [smatch stuff] iio: writing past the end of the array in
 adis16201_read_ring_data()
Message-ID: <20110629182220.GH14591@shale.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Smatch complains that there is a write past the end of the array in
adis16201_read_ring_data().  I don't know the code well enough to
fix it myself.

drivers/staging/iio/accel/adis16201_ring.c +42
	adis16201_read_ring_data(19) error: buffer overflow 'st->tx' 14 <= 14
drivers/staging/iio/accel/adis16201_ring.c +44
	adis16201_read_ring_data(21) error: buffer overflow 'st->tx' 14 <= 15

    36          for (i = 0; i <= ADIS16201_OUTPUTS; i++) {
                                 ^^^^^^^^^^^^^^^^^
	ADIS16201_OUTPUTS is 7.

    37                  xfers[i].bits_per_word = 8;
    38                  xfers[i].cs_change = 1;
    39                  xfers[i].len = 2;
    40                  xfers[i].delay_usecs = 20;
    41                  xfers[i].tx_buf = st->tx + 2 * i;
    42                  st->tx[2 * i] = ADIS16201_READ_REG(ADIS16201_SUPPLY_OUT +
                        ^^^^^^^^^^^^^
	tx has 14 elements.  7 * 2 is one past the end of the array.

    43                                                     2 * i);
    44                  st->tx[2 * i + 1] = 0;
                        ^^^^^^^^^^^^^^^^^
	We're two spaces past the end of the array here.

    45                  if (i >= 1)
    46                          xfers[i].rx_buf = rx + 2 * (i - 1);
    47                  spi_message_add_tail(&xfers[i], &msg);
    48          }

regards,
dan carpenter
