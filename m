Return-Path: <violeta.menendez@codethink.co.uk>
Message-ID: <55F19B6D.7040205@codethink.co.uk>
Date: Thu, 10 Sep 2015 16:02:05 +0100
From: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
 Laurentiu Palcu <laurentiu.palcu@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-kernel@lists.codethink.co.uk
Subject: BMA250 support
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

I've been taking a look at the accelerometer drivers meaning to add some
features for the chip BMA250.

I've seen that this chip is supported by the bma180 driver [1], and that
there's another driver for bmc150 [2] that supports BMA250E. Looking at
the datasheets [3][4][5] I can't really understand why it is that way,
as BMA250 and BMA250E register map looks exactly the same except for the
FIFO memory, and BMA250 doesn't look similar to BMA180 to me.

After some research on the internet and talking to Ben Dooks (who is
guiding me through this) we couldn't arrive to a conclusion as to why
this is this way. Could anyone clarify this a bit more? Could it make
sense to move support of BMA250 to bmc180 driver?

Thank you for your help

[1] drivers/iio/accel/bma180.c
[2] drivers/iio/accel/bmc150-accel.c
[3]
http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/BST-BMA250-DS002-05.pdf
[4]
http://ae-bst.resource.bosch.com/media/products/dokumente/bma250e/BST-BMA250E-DS004-06.pdf
[5]
http://irtfweb.ifa.hawaii.edu/~tcs3/jumpman/jumppc/1107-BMA180/BMA180-DataSheet-v2.5.pdf

-- 
Violeta Menéndez González    http://www.codethink.co.uk/
Software Engineer            Codethink - Providing Genius
