Return-Path: <SRS0=Kdk2=ET=intel.com=fengguang.wu@kernel.org>
Date: Thu, 25 Jan 2018 02:53:42 +0800
From: kbuild test robot <lkp@intel.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: kbuild-all@01.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [RFC PATCH] Staging: iio: ade7758: __ade7758_spi_write_reg_8() can
 be static
Message-ID: <20180124185342.GA40461@xian>
References: <1516654973-6434-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516654973-6434-1-git-send-email-shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


Fixes: c1960999e575 ("Staging: iio: ade7758: Expand buf_lock to cover both buffer")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ade7758_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 7f8f8c4..5794ebb 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -25,7 +25,7 @@
 #include "ade7758.h"
 
 /* Unlocked version of ade7758_spi_write_reg_8 function */
-int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
+static int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7758_state *st = iio_priv(indio_dev);
@@ -101,7 +101,7 @@ static int ade7758_spi_write_reg_24(struct device *dev, u8 reg_address,
 }
 
 /* Unlocked version of ade7758_spi_read_reg_16 function */
-int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
+static int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7758_state *st = iio_priv(indio_dev);
