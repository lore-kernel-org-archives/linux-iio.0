Return-Path: <SRS0=PzOY=CQ=googlemail.com=chf.fritz@kernel.org>
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] iio: Add Intersil isl76683 light sensor support
Date: Sun, 19 Nov 2017 00:20:27 +0100
Message-Id: <1511047230-7021-1-git-send-email-chf.fritz@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds initial support for isl76683 light sensor.

Changes since v1:
 - introduce dt property suffix -kilo-ohms
 - rename optinal dt property to isil,external-resistor-kilo-ohms
 - purge dynamic buffer in favour of simple static 16 byte IIO_LE
 - use iio_device_claim/release_direct_mode() instead of flag variable
 - return with IRQ_HANDLED in all cases in isl76683_trigger_handler()
 - simplify return in isl76683_set_config
 - rename isl76683_read_lux() to isl76683_get_sensordata()
 - use IIO_CHAN_INFO_SCALE instead of IIO_CHAN_INFO_HARDWAREGAIN
 - rename macro ISL76683_REG_SENSOR_L/M to ISL76683_REG_SENSOR_LSB/MSB
 - rename marcro ISL76683_CHANNEL_2 to ISL76683_CHANNEL
 - use GENMASK for ISL76683_PHOTOD_MASK

Christoph Fritz (3):
  iio: light: Add support for Intersil isl76683 sensor
  dt-bindings: iio: add Intersil isl76683 light sensor bindings
  iio: light: isl76683 add way to adjust irq threshold

 .../ABI/testing/sysfs-bus-iio-light-isl76683       |  17 +
 .../devicetree/bindings/iio/light/isl76683.txt     |  26 +
 .../devicetree/bindings/property-units.txt         |   1 +
 drivers/iio/light/Kconfig                          |  12 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/isl76683.c                       | 714 +++++++++++++++++++++
 6 files changed, 771 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-isl76683
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl76683.txt
 create mode 100644 drivers/iio/light/isl76683.c

-- 
2.1.4
