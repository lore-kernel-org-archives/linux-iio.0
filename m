Return-Path: <malas@tcoe.iitm.ac.in>
From: "malas" <malas@tcoe.iitm.ac.in>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: ad7793 adc rcv userspace test - passed succesfully
Date: Mon, 29 Aug 2011 11:09:28 +0530
Message-Id: <20110829053753.M60985@tcoe.iitm.ac.in>
In-Reply-To: <4E551DEF.4030805@cam.ac.uk>
References: <20110824081952.M29386@tcoe.iitm.ac.in> <4E54B9D0.20903@cam.ac.uk> <20110824084734.M61257@tcoe.iitm.ac.in> <4E551DEF.4030805@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-ID: <linux-iio@vger.kernel.org>


Dear Jonathan Cameron,

I last reported that after creating device node and opening it, read() call was failing.
I got to fix this.

The reason was this:
4 functions are exported from ad7793 module to iio-ring module as ring setup ops:
namely: 
        .preenable = &ad7793_ring_preenable,
	.postenable = &iio_triggered_ring_postenable,
	.predisable = &iio_triggered_ring_predisable,
	.postdisable = &ad7793_ring_postdisable,

In the iio-ring modules "iio_store_ring_enable" function is invoked from user app,which
inturn invokes the func "ad7793_ring_preenable" and subsequently driver's postenable
function.

The "iio_triggered_ring_postenable" function then attaches the poll function to the ring
trigger soft interrupt.

Since continuous mode was set and enabled the configured GPIO interrupt for capturing
data ready signal (in ad7793_ring_preenable) as interrupt, iio_trigger_poll() invoked on
interrupt (from drivers data rdy interrupt handler) failed to raise soft interrupt and
as a consequence driver's ad7793_trigger_handler() was not invoked when data ready.

I patched as follows in ad7793.c:

1. Moved irq enabling from ad7793_ring_preenable to ad7793_ring_postenable
2. Defined ad7793_ring_setup_ops ".postenable" as  ad7793_ring_postenable
3. In ad7793_ring_postenable, invoked &iio_triggered_ring_postenable and then enabled
the data ready signalling GPIO interrupt.

Then, from user app after opening the device, Poll() for rcv data presence was
successful and  read() call returned non-zero size . Could print the data from ring buffer.

Sincere thanks to you and Michael for guiding me through.

Take care.

regards
Mala
