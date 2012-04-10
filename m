Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 10 Apr 2012 11:47:07 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: proximity sensor, input
Message-ID: <alpine.DEB.2.01.1204101115470.17667@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

I am wondering how to support proximity sensors; goal is to trigger some 
application event when an object comes close (in that sense, the proximity 
sensor is used like a button)

there are several places in the kernel doing similar things:
e.g. input/misc/gp2ap0002a00f.c
e.g. drivers/misc/bh1770glc.c
e.g. drivers/staging/iio/isl29018.c

iio seems to be most active and has IIO_PROXIMITY, but I do not see how 
the application is easily notified: iio collects merely collects the 
sensor data

drivers in misc just create some custom sysfs interface

input/misc has just one driver dealing with proximity

is there some advise where proximity driver support might best fit?

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
