Return-Path: <shrirang.bagul@canonical.com>
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	denis.ciocca@st.com,
	tiberiu.a.breana@intel.com,
	lorenzo.bianconi83@gmail.com,
	linus.walleij@linaro.org,
	gregor.boirie@parrot.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH 0/3] iio: st_sensors: Support ACPI probe for st_sensors
Date: Thu, 24 Nov 2016 13:33:42 +0800
Message-Id: <20161124053345.11254-1-shrirang.bagul@canonical.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

These patches are based on available work in iio git repository
(git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git) "testing"
branch.

Compatible strings don't exist on ACPI based systems. This patchset adds
probe support by reading ACPI unique identifiers from platform bios for
st_pressure and st_accel sensor drivers. Some of these sensors are present
on Dell IoT gateways.

Thanks,
Shrirang

Shrirang Bagul (3):
  iio: st_sensors: match sensors using ACPI handle
  iio: st_accel: Support sensor i2c probe using acpi
  iio: st_pressure: Support i2c probe using acpi

 drivers/iio/accel/st_accel.h                   | 18 +++++++
 drivers/iio/accel/st_accel_i2c.c               | 73 +++++++++++++++++---------
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 20 +++++++
 drivers/iio/pressure/st_pressure.h             |  8 +++
 drivers/iio/pressure/st_pressure_i2c.c         | 51 +++++++++++++-----
 include/linux/iio/common/st_sensors_i2c.h      |  9 ++++
 6 files changed, 142 insertions(+), 37 deletions(-)

-- 
2.9.3
