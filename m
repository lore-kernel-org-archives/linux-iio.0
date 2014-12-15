Return-Path: <devendra.aaru@gmail.com>
From: Devendra Naga <devendra.aaru@gmail.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH 2/2] iio: meter: ade7759: fix build warnings with make randconfig
Date: Mon, 15 Dec 2014 06:46:46 -0500
Message-Id: <1418644006-5558-2-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1418644006-5558-1-git-send-email-devendra.aaru@gmail.com>
References: <1418644006-5558-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

fixes

drivers/staging/iio/meter/ade7759.c:224:6: warning: ‘val’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
drivers/staging/iio/meter/ade7759.c:309:6: warning: ‘val’ may be used
uninitialized in this function [-Wmaybe-uninitialized]

the fix is to check the return value of ade7759_spi_read_reg_16.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---

 hapens on next-20141215 with make randconfig. compile tested only on x86_64.

 drivers/staging/iio/meter/ade7759.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 7d21743..aa10042 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -218,9 +218,12 @@ static int ade7759_reset(struct device *dev)
 	int ret;
 	u16 val;
 
-	ade7759_spi_read_reg_16(dev,
+	ret = ade7759_spi_read_reg_16(dev,
 			ADE7759_MODE,
 			&val);
+	if (ret < 0)
+		return ret;
+
 	val |= 1 << 6; /* Software Chip Reset */
 	ret = ade7759_spi_write_reg_16(dev,
 			ADE7759_MODE,
@@ -301,11 +304,15 @@ error_ret:
 /* Power down the device */
 static int ade7759_stop_device(struct device *dev)
 {
+	int ret;
 	u16 val;
 
-	ade7759_spi_read_reg_16(dev,
+	ret = ade7759_spi_read_reg_16(dev,
 			ADE7759_MODE,
 			&val);
+	if (ret < 0)
+		return ret;
+
 	val |= 1 << 4;  /* AD converters can be turned off */
 
 	return ade7759_spi_write_reg_16(dev, ADE7759_MODE, val);
-- 
2.1.0
