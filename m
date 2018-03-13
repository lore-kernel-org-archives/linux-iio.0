Return-Path: <SRS0=lFjb=GD=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 13 Mar 2018 13:05:28 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging:iio:ad2s1210: Add channel for fclkin and
 fexcit
Message-ID: <335cf727d0583ccbe95f8bd97c282bf1fa210cae.1520956563.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The ad2s1210 does not contain any channel for the fclkin and fexcit. As
a result, it uses IIO_DEVICE_ATTR to expose this information. This patch
adds one channel for fclkin and another for fexcit. It also adds an enum
to easily address the correct channel.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 43 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..28c3fd439663 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -67,6 +67,11 @@ enum ad2s1210_mode {
 	MOD_RESERVED,
 };
 
+enum ad2s1210_frequency_channel {
+	FCLKIN = 0,
+	FEXCIT,
+};
+
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
 struct ad2s1210_state {
@@ -88,6 +93,30 @@ static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_CONFIG] = { 1, 0 },
 };
 
+static const struct iio_chan_spec ad2s1210_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.type = IIO_ANGL_VEL,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.type = IIO_CHAN_INFO_FREQUENCY,
+		.indexed = 1,
+		.channel = FCLKIN,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}, {
+		.type = IIO_CHAN_INFO_FREQUENCY,
+		.indexed = 1,
+		.channel = FEXCIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
 				     struct ad2s1210_state *st)
 {
@@ -552,20 +581,6 @@ static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_LOT_LOW_THRD);
 
-static const struct iio_chan_spec ad2s1210_channels[] = {
-	{
-		.type = IIO_ANGL,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}, {
-		.type = IIO_ANGL_VEL,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}
-};
-
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_fclkin.dev_attr.attr,
 	&iio_dev_attr_fexcit.dev_attr.attr,
-- 
2.16.2
