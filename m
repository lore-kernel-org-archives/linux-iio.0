Return-Path: <SRS0=UmI9=HK=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Sat, 21 Apr 2018 08:55:08 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Syne <john3909@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] stagging:iio:meter: Add iio_chan_spec
Message-ID: <957b06793a65e0209dc794489b0ae815071b0992.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds iio_chan_spec struct. Additionally, the channel adds the
support for handling AIGAIN, BIGAIN, CIGAIN, NIGAIN, AVGAIN, BVGAIN, and
CVGAIN.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 029c3bf42d4d..2fbb2570ba54 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -22,6 +22,48 @@
 #include "meter.h"
 #include "ade7854.h"
 
+#define PHASEA "phaseA"
+#define PHASEB "phaseB"
+#define PHASEC "phaseC"
+#define NEUTRAL "neutral"
+
+#define ADE7854_CHANNEL(_type, _name, _mask, _reg) {			\
+	.type = _type,							\
+	.indexed = 1,							\
+	.channel = 0,							\
+	.extend_name = _name,						\
+	.info_mask_separate = _mask,					\
+	.address = _reg,						\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = -1,						\
+}
+
+static const struct iio_chan_spec ade7854_channels[] = {
+	/* Current */
+	ADE7854_CHANNEL(IIO_CURRENT, PHASEA,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_AIGAIN),
+	ADE7854_CHANNEL(IIO_CURRENT, PHASEB,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_BIGAIN),
+	ADE7854_CHANNEL(IIO_CURRENT, PHASEC,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_CIGAIN),
+	ADE7854_CHANNEL(IIO_CURRENT, NEUTRAL,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_NIGAIN),
+	/* Voltage */
+	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEA,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_AVGAIN),
+	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEB,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_BVGAIN),
+	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEC,
+			BIT(IIO_CHAN_INFO_SCALE),
+			ADE7854_CVGAIN),
+};
+
 static ssize_t ade7854_read_8bit(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
-- 
2.17.0
