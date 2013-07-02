Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18952 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514Ab3GBKNm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 06:13:42 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MPB00HY70DJ3GC0@mailout1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 02 Jul 2013 19:13:36 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, s.nawrocki@samsun.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH 0/2] Fix erroneous pressure scaling for the lps331ap driver
Date: Tue, 02 Jul 2013 12:13:21 +0200
Message-id: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series fixes pressure scale value calculation and modifies the
way how the temperature scale value is calculated, for clarity
and consistency reasons. Below the detailed explanation
for the fix is provided.

Because of the IIO_VAL_INT_PLUS_NANO value returned by the
read_raw callback for the IIO_CHAN_INFO_SCALE mask case
the returned scale value has to be expressed in nanopascal
units. The scale value is used then for obtaining pressure
value in kilopascal units. Currently this value is 2441410,
whereas it should be 24414.

1. Scaling of exemplary read_raw value:

exemplary read raw result: 4067471
buggy_scale: 0.002441410 => 2441410 * 10^-9
buggy_pressure: 4067471 * 0.002441410 = 
9930.4
According to the documentation file
Documentation/ABI/testing/sysfs-bus-iio the scaled pressure
value is expressed in kilopascals, so the result should
be interpreted as 9930.4 kPa

2. Scaling of the device output value according to the data sheet

In order to get the result in mbars according to the device
data sheet the output value has to be divided by 4096 (LSB/mbar)

pressure [mbar] = 4067471 / 4096 = 993.0349

Given that 1 bar = 10^5 Pa the result in pascal units is
993.0349 * 10^-3 * 10^5 Pa = 993.0349 * 10^2 Pa = 993 hPa =>
99.3 kPa

whereas 4067471 * 0.002441410 (the buggy_scale value) = 9930.4,
which when considered as a result in kilopascals is not true
according to the above reasoning.

3. Proposed fix

The proposed fix introduces following constants:

ST_PRESS_LSB_PER_MBAR (4096.0) - LSB/mbar

ST_PRESS_KPASCAL_NANO_SCALE (100000000 / ST_PRESS_LSB_PER_MBAR) -
actual scale factor to be returned by in_pressure_scale which after
performing division gives the value 24414.
in_pressure_scale returns 0.000024414 after applying nano scale.

The final result in kilopascal units can be obtained as follows:

in_pressure_raw * in_pressure_scale = 
= 4067471 * 24414 * 10^-9 = 4.067471 * 10^6 * 2.4414 * 10^4 * 10^-9 =
= 9.930 * 10^1 = 99.3 kPa => 993 hPa (same as the pressure result
obtained in the paragraph 2.)

Summarizing, the bug was in the ST_PRESS_MBAR_TO_KPASCAL macro
which performed multiplication instead of division.

The second patch applies similar operations for the temperature scale
calculaton. Previous implementation was correct but the modification
is made for consistency and clarity.

Thanks,
Jacek

Jacek Anaszewski (2):
  iio: lps331ap: Fix wrong in_pressure_scale output value
  iio: lps331ap: Modify in_temp_scale calculation way

 drivers/iio/pressure/st_pressure_core.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

-- 
1.7.5.4

