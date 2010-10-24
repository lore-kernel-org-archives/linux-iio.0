Return-Path: <Michael.Frysinger@analog.com>
From: Michael Frysinger <michael.frysinger@analog.com>
Reply-To: Michael Frysinger <michael.frysinger@analog.com>
To: <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [Device-drivers-devel] [PATCH 1/3] staging: iio: new adis16201 driver
Date: Sun, 24 Oct 2010 14:36:31 -0400
CC: Jonathan Cameron <jic23@cam.ac.uk>, Mike Frysinger <vapier@gentoo.org>,
	<linux-iio@vger.kernel.org>
References: <1287830963-18377-1-git-send-email-vapier@gentoo.org> <AANLkTinbc9-Vibzf1Vy1bZ1WcjerLEtMEfoqCteSfO3G@mail.gmail.com> <4CC479C0.9030607@cam.ac.uk>
In-Reply-To: <4CC479C0.9030607@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <201010241436.31971.michael.frysinger@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Sunday, October 24, 2010 14:24:00 Jonathan Cameron wrote:
> On 10/24/10 16:58, Mike Frysinger wrote:
> > On Sun, Oct 24, 2010 at 07:09, Jonathan Cameron wrote:
> >> On 10/23/10 21:32, Mike Frysinger wrote:
> >>> On Sat, Oct 23, 2010 at 13:52, Jonathan Cameron wrote:
> >>>> Please check these for building against staging next.  There have been
> >>>> a couple of cleanup and abi fix series merged since the tree you are
> >>>> working against (at least I'm guessing that's what causes...
> >>> 
> >>> testing against current mainline
> >> 
> >> Unfortunately that isn't where they are going to merge.  The change
> >> required won't be huge, but Greg isn't going to take them if they
> >> don't merge cleanly.
> > 
> > they merge cleanly, they just dont compile :p.  what tree exactly
> > contains these changes you're referring to ?
> 
> either linux-next or staging-next branch of
> http://git.kernel.org/?p=linux/kernel/git/gregkh/staging-next-2.6.git;a=sum
> mary
> 
> The all went in a few weeks back.
> 
> Personally I just work against Gregs staging-next tree.

btw, do you know of any issues off the top of your head of importing these
into 2.6.36 ?  i'm looking at importing these:

2a28f6c 2010-10-14 10:17:18 +0200 staging: iio: ad7476: fix !CONFIG_IIO_RING_BUFFER build issue reported by Randy 
Dunlap
1139df5 2010-10-12 10:30:51 +0200 staging: iio: adc: ad799x miscellaneous cleanups
668413e 2010-10-11 18:05:56 +0200 staging: iio: adc: ad7476 more list review feedback by Jonathan Cameron
349282d 2010-10-11 18:05:37 +0200 staging: iio: adc: ad7476 new SPI ADC driver
e58537c 2010-10-08 12:14:14 +0100 staging: iio: update example application.
1755b0a 2010-10-08 12:14:13 +0100 staging: iio: adc add numbers to naming of all adc channels as needed to 
associate events with them.
2f3cc66 2010-10-08 12:14:12 +0100 staging: iio: events update documentation to match new abi.
f9f0d35 2010-10-08 12:14:11 +0100 staging: iio: light remove empty light.h file
45dd3b3 2010-10-08 12:14:10 +0100 staging: iio: tsl2563 event attribute name updates
d750e37 2010-10-08 12:14:09 +0100 staging: iio: accel remove deprecated and misleading event macros.
fc5d0e4 2010-10-08 12:14:08 +0100 staging: iio: sca3000 event attribute name updates
c33680c 2010-10-08 12:14:07 +0100 staging: iio: lis3l02dq event attribute renames
4be2de4 2010-10-08 12:14:06 +0100 staging: iio: events move buffer codes so they do not clash with new scheme
da1d8b6 2010-10-08 12:14:05 +0100 staging: iio: tsl2563 move to new event numbering scheme and remove old 
definitions
deb02fc 2010-10-08 12:14:04 +0100 staging: iio: accel remove old event codes
de9fe32 2010-10-08 12:14:03 +0100 staging: iio: sca3000 move to new event code scheme and add combined orientations
18e69a9 2010-10-08 12:14:02 +0100 staging: iio: lis3l02dq move to new event code scheme
820e882 2010-10-08 12:14:01 +0100 staging: iio: adc events update to new numbering system
f4704d7 2010-10-08 12:14:00 +0100 staging: iio: events define macros for new event code system
9404287 2010-10-07 15:48:09 -0700 staging: iio: light: Adding driver for ISL29018 ALS
e968d09 2010-10-07 14:24:33 +0200 staging: iio: ring_generic: provide IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT
3ba2e49 2010-10-07 16:14:10 +0200 staging: iio: adc: ad799x drop in_precision in favor of new in_type
a7861ff 2010-10-07 13:10:21 +0100 staging: iio: max1363 fix bug due to scan_element directory move.
7aa3bae 2010-10-07 13:10:20 +0100 staging: iio: sca3000 fix bug due to scan_element directory move.
0986452 2010-10-07 13:10:19 +0100 staging: iio: timestamp_en naming typo fix.
ba65849 2010-10-06 17:49:02 +0200 staging: iio: adc: max1363: remove unused variable
d0a5304 2010-10-07 13:27:37 +0200 staging: iio: iio_ring_rip_outer return immediately if rip_lots returns <= 0
aecac19 2010-10-06 10:25:49 +0200 staging: iio: adc: ad799x: Address iio list feedback
e1517c0 2010-10-06 16:15:37 +0200 staging: iio: adc: max1363: prevent buffer overflow
858f1cc 2010-10-06 16:22:17 +0200 staging: iio: adc: ad799x: prevent buffer overflow
30b5309 2010-10-01 16:41:52 +0200 staging: iio: adc: Address mailing list feedback by Jonathan Cameron
985dbe7 2010-10-01 16:41:51 +0200 staging: iio: adc: Enable driver support for ad799x AD converters
0abd242 2010-09-26 01:11:09 +0200 staging: iio: whitespace cleanup
10ba8ea 2010-09-21 14:41:08 +0100 staging: iio: sysfs abi documentation. Add _type and _index attrs
3215e31 2010-09-21 14:41:07 +0100 staging: iio: remove deprecated form of scan_el attribute naming.
d16061b 2010-09-21 14:41:06 +0100 staging: iio: sca3000 add _index attribute registration
77b3d3f 2010-09-21 14:41:05 +0100 staging: iio: max1363 add _index attribute registration
67dd265 2010-09-21 14:41:04 +0100 staging: iio: adis16400 add _index attribute registration
de9b493 2010-09-21 14:41:03 +0100 staging: iio: adis16350 add _index attribute registration
4744374 2010-09-21 14:41:02 +0100 staging: iio: adis16300 add _index attribute registration
c045e44 2010-09-21 14:41:01 +0100 staging: iio: adis16260 add _index attribute registration
6d2174f 2010-09-21 14:41:00 +0100 staging: iio: adis16240 add _index attribute registration
49624fa 2010-09-21 14:40:59 +0100 staging: iio: adis16209 add _index attribute registration
13a091a 2010-09-21 14:40:58 +0100 staging: iio: lis3l02dq add _index attribute registration
fc89b38 2010-09-21 14:40:57 +0100 staging: iio: amend macros for SCAN_EL creation to add separate index attr
44f270d 2010-09-21 14:40:56 +0100 staging: iio: Remove unused bit_count from struct iio_scan_el
5df2145 2010-09-21 14:40:55 +0100 staging: iio: adis16400 add _type attributes for all scan elements
3b401a9 2010-09-21 14:40:54 +0100 staging: iio: adis16350 add _type attributes for all scan elements
88b76d1 2010-09-21 14:40:53 +0100 staging: iio: adis16300 add _type attributes for all scan elements
357f020 2010-09-21 14:40:52 +0100 staging: iio: adis16260 add _type attributes for all scan elements
ef26b83 2010-09-21 14:40:51 +0100 staging: iio: sca3000 add _type attributes for all scan elements
be3ebd1 2010-09-21 14:40:50 +0100 staging: iio: adis16240 add _type attributes for all scan elements
6a4429c 2010-09-21 14:40:49 +0100 staging: iio: adis16209 add _type attributes for all scan elements
8d9c636 2010-09-21 14:40:48 +0100 staging: iio: max1363 add _type attributes for all scan elements
6a36e61 2010-09-21 14:40:47 +0100 staging: iio: lis3l02dq add _type attributes for all scan elements
6267ea6 2010-09-09 17:40:11 +0200 staging: iio: sca3000 convert byte order of ring buffer data
b68d58a 2010-09-09 17:40:10 +0200 staging: iio: sca3000 fix sca3000_[show,store]_ring_bpse
3285aae 2010-09-08 22:02:17 -0700 staging: iio: ak8975: Add ak8975 magnetometer sensor
7223234 2010-09-08 22:02:16 -0700 staging: iio: Change GAIN macros to SCALE.
6cd5a9a 2010-09-01 15:40:23 +0200 staging/trivial: fix typos concerning "access"
853098b 2010-09-04 17:54:51 +0100 staging: iio: documentation - partial update to make more of it true.
04b7081 2010-09-04 17:54:50 +0100 staging: iio: lis3l02dqbuffersimple.c bring example up to date.
299475e 2010-09-04 17:54:49 +0100 staging: iio: remove odd structure definition.
9dbfb6f 2010-09-04 17:54:48 +0100 staging: iio: Make use of the convenient IIO_TRIGGER_NAME_ATTR macro
2d7770a 2010-09-04 17:54:47 +0100 staging: iio: Remove deprecated ATTR_TEMP in favour of ATTR_TEMP_RAW
99e5dc4 2010-09-04 17:54:46 +0100 staging: iio: Remove long dead function definitions from headers
c3e5d41 2010-09-04 17:54:45 +0100 staging: iio: unecessary header removal and kernel doc clean up
b6e5d69 2010-09-04 17:54:44 +0100 staging: iio: simplify logic in iio_interrupt_handler
b156cf7 2010-09-04 17:54:43 +0100 staging: iio: convert idr to ida as pointer never provided
11f05c7 2010-08-31 14:27:33 +0200 staging: iio: hmc5843 change ABI to comply with documentation
4f64b80 2010-08-31 11:32:55 +0200 staging: iio sync scale units
51a0a5b 2010-08-31 11:32:54 +0200 staging: iio sync drivers with current ABI
5770b8f 2010-08-31 11:32:53 +0200 staging: iio partial documentation update
bf32963 2010-08-31 11:32:52 +0200 staging: iio move scan_elements into ring buffer
07e6229 2010-08-31 11:32:51 +0200 staging: iio: lis3l02dq adjust lis3l02dq_configure_ring
ffcab07 2010-08-31 11:32:50 +0200 staging: iio rename ring attributes
213fd22 2010-08-10 07:37:33 +0200 Staging: iio: signedness bug
d1ae4da 2010-08-04 21:54:26 +0200 drivers/staging/iio: call mutex_unlock in error handling code
-mike
