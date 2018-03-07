Return-Path: <SRS0=cM/H=F5=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 6 Mar 2018 21:43:47 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by
 IIO_DEVICE_ATTR
Message-ID: <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a
tiny change in the name definition. This extra macro does not improve
the readability and also creates some checkpatch errors.

This patch fixes the checkpatch.pl errors:

staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) not
decimal permissions
staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) not
decimal permissions
staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) not
decimal permissions
staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) not
decimal permissions

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
 drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index c44eb577dc35..275e8dfff836 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
 		ade7753_read_16bit,
 		NULL,
 		ADE7753_PERIOD);
-static IIO_DEV_ATTR_CH_OFF(1, 0644,
-		ade7753_read_8bit,
-		ade7753_write_8bit,
-		ADE7753_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, 0644,
-		ade7753_read_8bit,
-		ade7753_write_8bit,
-		ADE7753_CH2OS);
+
+static IIO_DEVICE_ATTR(choff_1, 0644,
+			ade7753_read_8bit,
+			ade7753_write_8bit,
+			ADE7753_CH1OS);
+
+static IIO_DEVICE_ATTR(choff_2, 0644,
+			ade7753_read_8bit,
+			ade7753_write_8bit,
+			ADE7753_CH2OS);
 
 static int ade7753_set_irq(struct device *dev, bool enable)
 {
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 1decb2b8afab..c078b770fa53 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_APGAIN);
-static IIO_DEV_ATTR_CH_OFF(1, 0644,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, 0644,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_CH2OS);
+
+static IIO_DEVICE_ATTR(choff_1, 0644,
+			ade7759_read_8bit,
+			ade7759_write_8bit,
+			ADE7759_CH1OS);
+
+static IIO_DEVICE_ATTR(choff_2, 0644,
+			ade7759_read_8bit,
+			ade7759_write_8bit,
+			ADE7759_CH2OS);
 
 static int ade7759_set_irq(struct device *dev, bool enable)
 {
-- 
2.16.2
