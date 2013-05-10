Return-Path: <j.anaszewski@samsung.com>
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, matteo.dameno@st.com, carmine.iascone@st.com,
 kyungmin.park@samsung.com, s.nawrocki@samsung.com,
 Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [NEW DRIVER] LPS331AP barometer sensor driver
Date: Fri, 10 May 2013 11:09:24 +0200
Message-id: <1368176965-23190-1-git-send-email-j.anaszewski@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

This is a driver for LPS331AP barometer device.
It was tested with Samsung Exynos4x12 PQ/M0 board.

The device exposes two interrupt pins, but the driver uses only one optional
interrupt source. It needs to be stressed that only configuration with INT2
interrupt source could have been tested due to the available PCB layout.

Output data from the device can be read in two ways - on demand and by
initiating IIO events for the device. The former mode allows for power
saving as it instructs the device to do a 'one shot' measurement and return
to the power down mode, whereas the latter enables cyclic measurements
with the period managed through the 'odr' attribute, where possible settings
are: 40ms, 80ms, 143ms and 1000ms. The value has to be given in miliseconds.
Every integer value is accepted - the driver will round it to the nearest
bottom 'odr' setting.

Whereas 'one shot' mode can be used without enabled interrupts, by using
read_raw callback, the cyclic measurements can be enabled only when there
is at least one interrupt source available. The cyclic measurement mode
is activated by enabling one of the two events. In this mode it is also
possible to read the output data through the read_raw callback - the driver
returns periodically cached data then, not being forced to initiate
'one shot' mode, and making the read operation almost immediate.
Read pressures and temperatures output can be converted in units of
measurement by dividing them respectively through in_pressure_scale
and in_temp_scale. Temperature values must then be added by the constant
float in_temp_offset expressed as Celsius degrees.

Thanks,
Jacek Anaszewski

Jacek Anaszewski (1):
  iio: lps331ap: Add new driver for the device

 .../devicetree/bindings/iio/barometer/lps331ap.txt |   40 +
 drivers/iio/Kconfig                                |    1 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/barometer/Kconfig                      |   12 +
 drivers/iio/barometer/Makefile                     |    7 +
 drivers/iio/barometer/lps331ap.c                   | 1252 ++++++++++++++++++++
 6 files changed, 1313 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/barometer/lps331ap.txt
 create mode 100644 drivers/iio/barometer/Kconfig
 create mode 100644 drivers/iio/barometer/Makefile
 create mode 100644 drivers/iio/barometer/lps331ap.c

-- 
1.7.5.4
