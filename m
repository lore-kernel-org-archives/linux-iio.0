Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>, James Hartley
	<james.hartley@imgtec.com>, <phani.movva@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 0/5] IIO: cc10001 assorted fixes
Date: Thu, 7 May 2015 18:22:16 -0300
Message-ID: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Here's a series containing four fixes and an enhancement for Cosmic
Circuit's Auxiliary ADC CC10001 driver. These were found while testing
the driver on IMG Pistachio SoC Bring-Up board.

The first four patches are fixes, and are meant for v4.1-rc3. The last
patch is not really a fix, so it can be posponed for v4.2.

Patch 1: Fix an issue related to a mismatch between the scan index
and the channel number in buffer capture mode.

Patch 2: Fix incorrect use of the power down register.

Patch 3: Fix incorrect handling of the value returned by
regulator_get_voltage().

Patch 4: Add a 1-us delay after setting channel number and before
starting conversion.

Patch 5: Introduce a "shared" ADC notion, so the power-up is done
at probe time if the ADC is in use by remote CPUs not running Linux.

This patchset is based on v4.1-rc2. Naidu is busy this week, so I'm
helping him by submitting these.

Naidu Tellapati (5):
  iio: adc: cc10001: Fix the channel number mapping
  iio: adc: cc10001: Fix incorrect use of power-up/power-down register
  iio: adc: cc10001: Fix regulator_get_voltage() return value check
  iio: adc: cc10001: Add delay before setting START bit
  iio: adc: cc10001: Power-up the ADC at probe time when used remotely

 drivers/iio/adc/cc10001_adc.c | 80 ++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 27 deletions(-)

-- 
2.3.3
