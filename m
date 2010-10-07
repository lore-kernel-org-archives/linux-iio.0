Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: staging: iio: iio_ring_rip_outer return immediately if rip_lots returns <= 0
Date: Thu, 7 Oct 2010 12:41:29 +0200
Message-ID: <1286448090-4792-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


The last two days I was casing a bug related sw ringbuffer usage.
Reading from an empty buffer caused my system to crash anytime later in
all kinds of fashions. The crash happened at a time where no iio related
function calls where going on.

It appears that on my nommu development system freeing memory twice can
lead to such bugs. And the fact that it does error right away made debugging
this issue a pain.

iio_ring_rip_outer() calls rb->access.rip_lots() which defaults in the
sw ring buffer case to iio_rip_sw_rb().

iio_rip_sw_rb() returns 0 and frees the local buffer:

	if (initial_write_p == initial_read_p) /* No new data available.*/
or
	if (unlikely(initial_read_p == NULL)) /* No data here as yet */

However iio_ring_rip_outer() only checks for  copied/retured  < 0.
It then carries on copies 0 bytes to user and frees the buffer again.
