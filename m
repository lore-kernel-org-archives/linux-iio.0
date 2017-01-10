Return-Path: <SRS0=X4eh=YY=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v4 0/2] add support to STM LSM6DS3-LSM6DSM 6-axis Mems sensor
Date: Tue, 10 Jan 2017 22:55:17 +0100
Message-Id: <20170110215519.960-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Changes since v3:
- use I2C protocol instead of SMBus commands
- allow reading of the scale/sampling frequency whilst buffered operation is
  on going
- move st_lsm6dsx_hw allocation/initialization in st_lsm6dsx_probe() in order
  to avoid code duplication
- introduce enum st_lsm6dsx_hw_id to be used as I2C/SPI driver_data instead of
  the device name (string)
- improve code documentation

Changes since v2:
- improve code documentation
- improve code readability
- use spi_write() instead of spi_sync_transfer() in st_lsm6dsx_spi_write()
- use SMBus commands instead of I2C protocol
- use fifo_lock mutex to prevent concurrent access to hw FIFO instead of
  disabling/enabling irq line in st_lsm6dsx_flush_fifo()
- rename ring occurrences in buffer ones

Changes since v1:
- add sw fifo support
- drop trigger dependency
- use iio_claim_direct_mode() routine instead of grabbing the mutex directly
- use more unique prefix for all defines
- use info_mask_shared_by_all element for sampling_frequency
- use devm_iio_* routines
- use of_match_ptr instead of access directly to of_match_table
- fix device tree binding
- rename st_lsm6dsx_dev in st_lsm6dsx_hw
- cosmetics

Lorenzo Bianconi (2):
  iio: imu: add support to lsm6dsx driver
  Documentation: dt: iio: add st_lsm6dsx sensor device binding

 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  24 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   2 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |  23 +
 drivers/iio/imu/st_lsm6dsx/Makefile                |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            | 142 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 455 ++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 673 +++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        | 101 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        | 118 ++++
 10 files changed, 1544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Kconfig
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Makefile
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c

-- 
2.9.3
