Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH] iio: mma8452 driver
Date: Fri,  2 May 2014 10:51:34 +0200
Message-Id: <1399020695-29822-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Hi,

I'm resending the Freescale Freescale MMA8452 accelerometer
driver, comments here:
http://permalink.gmane.org/gmane.linux.kernel.iio/10899

I only fixed the use of ARRAY_SIZE()

remaining items/comments are

(1) new reads cannot be explicitly triggered

in case a new measurement can or has to be triggered, there IS
some wait time (which can be rather long)

in case where we simply wait for the next measurement, there MAY BE
some wait time

so in both cases there can be wait time

I think the current approach it closer to the behaviour where
measurements are triggered explicitly

there is no concept of rate limit or measurement cache in IIO and
no guarantee how long a measurement will take (besides that it should
somehow be linked to sampling frequency)

(2) make sampling frequency an attribute of a dataready trigger?

the sampling frequency also affects read_raw() interaction, so I'd rather
keep it as it is


thanks, p.

Peter Meerwald (1):
  iio: Add Freescale MMA8452Q 3-axis accelerometer driver

 drivers/iio/accel/Kconfig   |  12 ++
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/mma8452.c | 439 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 452 insertions(+)
 create mode 100644 drivers/iio/accel/mma8452.c

-- 
1.9.1
