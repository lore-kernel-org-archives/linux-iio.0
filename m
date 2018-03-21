Return-Path: <SRS0=Ao9w=GL=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 00/11] staging: iio: tsl2x7x: staging cleanups
Date: Wed, 21 Mar 2018 06:29:01 -0400
Message-Id: <20180321102912.5130-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Here is another set of staging cleanups for the tsl2x7x driver. The
driver is about ready to move out of staging. I want to test a few other
things first before submitting a patch to move the driver out of
staging.

High-level changes in this series:
- Interrupts and IIO events now work properly
. Split out interrupt and persistence variables into separate ALS and
  proximity variables to improve code readability.
- Simplify code, remove unnecessary code, and improve code readability.

# How to test the interrupts

cd /sys/bus/iio/devices/iio:device0

echo 0 > events/in_intensity0_thresh_falling_value
echo 512 > events/in_intensity0_thresh_rising_value
echo 1 > events/in_intensity0_thresh_rising_en

# proximity0 already has threshold range at [0,512]
echo 1 > events/in_proximity0_thresh_rising_en

Run iio_event_monitor tsl2772 and verify that events are sent properly.

Question: Should I use in_intensity0_thresh_either_en instead of
in_intensity0_thresh_{rising,falling}_en? The same goes for the
proximity0. This is the current contents of the events/ directory:

in_intensity0_thresh_either_period
in_intensity0_thresh_falling_en
in_intensity0_thresh_falling_value
in_intensity0_thresh_rising_en
in_intensity0_thresh_rising_value
in_proximity0_thresh_either_period
in_proximity0_thresh_falling_en
in_proximity0_thresh_falling_value
in_proximity0_thresh_rising_en
in_proximity0_thresh_rising_value

Brian Masney (11):
  staging: iio: tsl2x7x: remove unnecessary code
  staging: iio: tsl2x7x: correct interrupt handler trigger
  staging: iio: tsl2x7x: no need to clear interrupt flag when getting
    lux
  staging: iio: tsl2x7x: simplify tsl2x7x_prox_cal()
  staging: iio: tsl2x7x: split out als and prox interrupt settings
  staging: iio: tsl2x7x: make logging consistent and correct newlines
  staging: iio: tsl2x7x: split out als and prox persistence settings
  staging: iio: tsl2x7x: remove unused variables from tsl2x7x_get_lux()
  staging: iio: tsl2x7x: remove ch0 and ch1 variables from
    tsl2x7x_get_lux()
  staging: iio: tsl2x7x: put local variables in reverse Christmas tree
    order
  staging: iio: tsl2x7x: add copyright

 drivers/staging/iio/light/tsl2x7x.c | 300 ++++++++++--------------------------
 drivers/staging/iio/light/tsl2x7x.h |  16 +-
 2 files changed, 91 insertions(+), 225 deletions(-)

-- 
2.14.3
