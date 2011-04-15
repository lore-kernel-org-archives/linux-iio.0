Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DA87A30.1010602@cam.ac.uk>
Date: Fri, 15 Apr 2011 18:02:40 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>, Greg KH <greg@kroah.com>
CC: linux-iio@vger.kernel.org,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jon Brenner <jbrenner@taosinc.com>
Subject: Re: [PATCH 0/8] staging:iio:mixed bag of fixes and cleanups.
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>


Hi Greg,

There are a lot of core changes it IIO building up, but
in the meantime various new drivers have arrived.

So, I would propose not merging this series
 [PATCH 0/8] staging:iio:mixed bag of fixes and cleanups.
 I'll do a fresh version of this including the changes to
 the new drivers.

Until after:

[PATCH V4]TAOS 258x: Device Driver
[PATCH 1/1] IIO: DAC: AD5446 add support for AD5541A devices
[PATCH 1/1] IIO: DAC: New driver for AD5791/AD5781 High Resolution Voltage Output DACs
[PATCH 1/3] IIO: GYRO: Add MACRO for gyro quadrature correction
(including the rest of that series)

Any new drivers people post from now on will have to be held
until some of the core changes are in or we will never get them
done. I propose doing those in chunks anyway so shouldn't be
too painful.  First set are currently out for review. I know
Michael is already working on top of my development tree
(poor guy is coping with me rebasing all the time ;)

Thanks for handling all our merge woes!

Jonathan
