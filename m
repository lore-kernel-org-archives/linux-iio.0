Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21472 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbcERPBh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 May 2016 11:01:37 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Ge Gao <ggao@invensense.com>, Peter Rosin <peda@axentia.se>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: [PATCH v2 0/7] iio: inv_mpu6050: Support i2c master and external readings
Date: Wed, 18 May 2016 18:00:47 +0300
Message-Id: <cover.1463582011.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series attempts to implement support for external readings in i2c master
mode. Previous version here:
    https://www.spinics.net/lists/linux-iio/msg24502.html

Patches 1 and 6 should be considered bugfixes.
Patches 2,3,4 add regmap support and are mostly unchanged from v2
Patch 5 adds i2c master support
Patch 6 adds external readings (which only works in i2c master mode)

It might make sense to wait for Peter Rosin's patches cleaning up i2c mux
locking before patch 5.

Notable differences since previous versions:
 * Prefer inv_mpu_ over inv_mpu6050_ prefix
 * Remove indirection for SLV4 register names
 * Use the registered vendor prefix 'invensense'
 * Rearrange samples for scan mask instead of validating

For i2c master:
 * Explicit read/write when caching addr
 * Support I2C_FUNC_SMBUS_BYTE (making i2cdetect work)
 * Handle xfer errors as reported in status registers

For external channels support:
 * Only enable i2c slaves when required
 * Also forward write_raw for external channels
 * Drop handling read_raw from EXT_SENS registers
 * List external channels by scan index
 * Allow external channels with arbitrary sizes

Crestez Dan Leonard (7):
  iio: inv_mpu6050: Do burst reads using spi/i2c directly
  iio: inv_mpu6050: Initial regcache support
  iio: inv_mpu6050: Only toggle DATA_RDY_EN in inv_reset_fifo
  iio: inv_mpu6050: Cache non-volatile bits of user_ctrl
  iio: inv_mpu6050: Add support for auxiliary I2C master
  iio: inv_mpu6050: Reformat sample for active scan mask
  iio: inv_mpu6050: Expose channels from slave sensors

 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 105 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 692 ++++++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   5 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          | 115 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         | 221 ++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   5 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  24 +-
 7 files changed, 1111 insertions(+), 56 deletions(-)

-- 
2.5.5

