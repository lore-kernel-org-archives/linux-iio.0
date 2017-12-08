Return-Path: <SRS0=G+O7=DE=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Javier Martinez
 Canillas" <javier@osg.samsung.com>
Subject: [PATCH v1 0/7] iio: adc: ina2xx: Rework CNVR alignment, fix busy loops
Date: Fri, 8 Dec 2017 18:41:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <8e8ef11e-37df-44f3-b4a4-06e995924ca8@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

Currently, the INA2xx driver may end up causing 100% load on a single core
and fully loading the I2C bus, which is caused by two different issues:

The code uses a udelay to bridge the gab between two subsequent samples.
As the sampling interval may be up to 16 seconds, the CPU is busy
waiting most of the time.

The second issue manifests when using the (default) "synchronous" mode.
The code polls for a set conversion ready flag, but fails to align the
sampling interval to the raising flag. The polling interval is
(rightfully) slighly shorter than the sampling interval, so after some
samples the sampling thread is continously polling.

The patch series fixes both issues:
Patch 1 and 2 are just some small cosmetic changes.

Patch 3 removes an unnecessary read. According to the datasheet, the
CNVR flag is only cleared by reading the power register, but is cleared
by reading any of the measurement registers, thus the dummy read can
be skipped. This behaviour has been confirmed by TI technical support.

Patch 4 replaces the udelay with usleep_range.

Patch 5 reworks the delay logic. Previously the IIO timestamp clock was
used to capture entry and exit times of the work function. The
timestamp clock is user selectable and may be non-monotonic. Also,
any time spent outside the work function is not accounted for.

Patch 6 moves the timestap capture to the end of the conversion ready
status poll.

Patch 7 addresses the alignment issue. Every time an unset flag is seen
on poll loop entry, the reference timestamp is readjusted.

Both old and fixed behaviour has been verified using a logic analyzer.
In synchrounous mode, every few samples a double read of the status
register can be observed, showing the raising status flag, the other
samples are evenly spaced at sampling intervals inbetween.


Stefan Brüns (7):
  iio: adc: ina2xx: Remove bogus cast for data argument
  iio: adc: ina2xx: Clarify size requirement for data buffer
  iio: adc: ina2xx: Remove unneeded dummy read to clear CNVR flag
  iio: adc: ina2xx: Do not udelay for several seconds
  iio: adc: ina2xx: Use a monotonic clock for delay calculation
  iio: adc: ina2xx: Align timestamp with conversion ready flag
  iio: adc: ina2xx: Actually align the loop with the conversion ready
    flag

 drivers/iio/adc/ina2xx-adc.c | 104 ++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 45 deletions(-)

-- 
2.15.1
