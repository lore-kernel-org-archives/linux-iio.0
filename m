Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC resolvers] How to handle fault conditions..
Date: Fri, 20 May 2011 10:41:56 +0100
Message-Id: <1305884517-11168-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

The attached patch is a trivial bit of code cleanup to give us a clean
starting point for a discussion of suitable interface for resolvers.
(I was having a dull afternoon yesterday so thought I'd take a look
at a corner of IIO I didn't really know anything about ;)

Anyhow, we have some 'unusual' interrupt sources on these and
without knowing their use cases I'm not sure how we want to handle them.

They are:

1) LOS Loss of signal
 * A low voltage threshold applying to either quadrature signal.
 * Disconnected pin
 * Clipping is occuring.
 * config parity error occured.
2) DOS Degradation of signal
 * High voltage theshold on either signal is exceeded,
 * Missmatch between the quadrature signals by more than some threshold.
3) LOT Loss of tracking.
 * Internal error signal on the tracker is greater than some threshold.
 * Input exeeds max tracking rate.

So we kind of have:

in0_or_in1_thresh_rising, in0_or_in1_thresh_falling 

in1-in0_mag_rising

+ that loss of tracking one which is going to need a new type..
+ clipping of signal and those disconnected errors.
For this last one I wonder if we want it to go through the
event system at all, or whether we should have some out of
band sysfs attributes like the fault ones in hwmon?

Whave do people think?  No rush on this obviously, just thought
I'd get the ball rolling!

onathan Cameron (1):
  staging:iio:resolver:ad2s1210 general driver cleanup.

 drivers/staging/iio/resolver/ad2s1210.c |  856 ++++++++++++++-----------------
 1 files changed, 399 insertions(+), 457 deletions(-)

-- 
1.7.3.4
