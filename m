Return-Path: <SRS0=BOXG=BL=collabora.com=thierry.escande@kernel.org>
From: Thierry Escande <thierry.escande@collabora.com>
To: Benson Leung <bleung@chromium.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] platform/chrome: Support for cros_ec_accel_legacy driver
Date: Thu, 12 Oct 2017 19:33:20 +0200
Message-Id: <1507829604-16011-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-iio@vger.kernel.org>

Hi,

This series enables a driver for a legacy accelerometer driver used on
Chromebook devices with older EC firmware.

In addition to the cros_ec_accel_legacy driver, this series contains a
fix that registers the cros_ec_lpc driver on Chromebook devices that
does not have the GOOG0004 ACPI entry. In such case, the driver register
the device itself. This series also adds support to the cros_ec_lpc
driver for Glimmer based devices (Lenovo Yoga 11e).

The last patch is the code used to register this driver if the usual way
of registering the croc_ec sensors hub fails. In this case, the 2
accelerometers (base and lid) are registered using mfd_add_devices().
As there is work in progress to remove calls to mfd_add_devices() from
cros_ec_dev.c, this code is in a separate patch with the idea to make
that easier.

Changes in v4:
- Use correct bitmask for scale channel specification
- Use precomputed scale factor value

Changes in v3:
- Use kernel-doc notation for function headers
- Add more comment to sensor ID sysfs attribute documentation
- Restore accidentally deleted comment for IIO_CHAN_INFO_CALIBBIAS handling in
  iio_info write_raw() callback

Changes in v2:
- Reorganize code to avoid forward declarations
- Simplify capture buffer declaration (also helps to remove forward
  declarations)
- Make use of iio_push_to_buffers_with_timestamp() and let the
  framework handle timestamp copy into capture buffer
- Added missing sysfs attribute documentation
- Few cosmetic changes here and there


Enric Balletbo i Serra (1):
  platform/chrome: cros_ec_lpc: Register the driver if ACPI entry is
    missing.

Gwendal Grignou (1):
  platform/chrome: Add cros_ec_accel_legacy driver

Thierry Escande (2):
  platform/chrome: cros_ec_lpc: Add support for Google Glimmer
  platform/chrome: Register cros_ec_accel_legacy driver

 Documentation/ABI/testing/sysfs-bus-iio-cros-ec |  10 +
 drivers/iio/accel/Kconfig                       |  11 +
 drivers/iio/accel/Makefile                      |   2 +
 drivers/iio/accel/cros_ec_accel_legacy.c        | 425 ++++++++++++++++++++++++
 drivers/platform/chrome/cros_ec_dev.c           |  53 +++
 drivers/platform/chrome/cros_ec_lpc.c           |  41 ++-
 6 files changed, 541 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/cros_ec_accel_legacy.c

-- 
2.7.4
