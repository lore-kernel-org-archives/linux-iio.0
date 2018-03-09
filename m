Return-Path: <SRS0=rAUl=F7=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 9 Mar 2018 20:46:40 -0300
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
Subject: [PATCH 4/4] staging:iio:ad2s1210: Add comments/documentation
Message-ID: <813ae9b3a8d6d9b0e6d4d4b6dda7fe354375fc8d.1520638889.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The original code of AD2S1210 does not have documentation for structs
and register configurations; this difficult the code comprehension. This
patch adds structs documentation, briefly comments some register
settings and acronyms, and adds little explanations of some calculation
found in the code.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 32 ++++++++++++++++++++++++++++++++
 drivers/staging/iio/resolver/ad2s1210.h |  9 ++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..9bb8fd782f5a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -24,8 +24,10 @@
 
 #define DRV_NAME "ad2s1210"
 
+/* The default value of the control register on power-up */
 #define AD2S1210_DEF_CONTROL		0x7E
 
+/* Control Register Bit */
 #define AD2S1210_MSB_IS_HIGH		0x80
 #define AD2S1210_MSB_IS_LOW		0x7F
 #define AD2S1210_PHASE_LOCK_RANGE_44	0x20
@@ -39,14 +41,23 @@
 
 #define AD2S1210_REG_POSITION		0x80
 #define AD2S1210_REG_VELOCITY		0x82
+
+/* Loss of Signal (LOS) register address */
 #define AD2S1210_REG_LOS_THRD		0x88
+
+/* Degradation of Signal (DOS) register address */
 #define AD2S1210_REG_DOS_OVR_THRD	0x89
 #define AD2S1210_REG_DOS_MIS_THRD	0x8A
 #define AD2S1210_REG_DOS_RST_MAX_THRD	0x8B
 #define AD2S1210_REG_DOS_RST_MIN_THRD	0x8C
+
+/* Loss of Tracking (LOT) register address */
 #define AD2S1210_REG_LOT_HIGH_THRD	0x8D
 #define AD2S1210_REG_LOT_LOW_THRD	0x8E
+
+/* Excitation Frequency (EXCIT) register address */
 #define AD2S1210_REG_EXCIT_FREQ		0x91
+
 #define AD2S1210_REG_CONTROL		0x92
 #define AD2S1210_REG_SOFT_RESET		0xF0
 #define AD2S1210_REG_FAULT		0xFF
@@ -69,6 +80,20 @@ enum ad2s1210_mode {
 
 static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
 
+/**
+ * struct ad2s1210_state - device instance specific state.
+ * @pdata:		chip model specific constants, gpioin, etc
+ * @lock:		lock to ensure state is consistent
+ * @sdev:		the SPI device for this driver instance
+ * @fclkin:		frequency of clock input
+ * @fexcit:		excitation frequency
+ * @hysteresis:		cache of whether hysteresis is enabled
+ * @old_data:		cache of SPI communication after operation
+ * @resolution:		chip resolution could be 10/12/14/16-bit
+ * @mode:		indicates the operating mode
+ * @rx:			receive buffer
+ * @tx:			transmit buffer
+ */
 struct ad2s1210_state {
 	const struct ad2s1210_platform_data *pdata;
 	struct mutex lock;
@@ -82,6 +107,7 @@ struct ad2s1210_state {
 	u8 tx[2] ____cacheline_aligned;
 };
 
+/* Maps A0 and A1 inputs to the respective mode.  */
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
@@ -137,6 +163,11 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 	int ret;
 	unsigned char fcw;
 
+	/*
+	 * The fcw stands for frequency control word, which can be obtained
+	 * from:
+	 * fcw = (Excitation Frequency * 2^15) / fclkin
+	 */
 	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
 	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
 		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
@@ -158,6 +189,7 @@ static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
 	return ad2s1210_resolution_value[resolution];
 }
 
+/* Maps RES0 and RES1 inputs to the respective mode.  */
 static const int ad2s1210_res_pins[4][2] = {
 	{ 0, 0 }, {0, 1}, {1, 0}, {1, 1}
 };
diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
index e9b2147701fc..cbe21bca7638 100644
--- a/drivers/staging/iio/resolver/ad2s1210.h
+++ b/drivers/staging/iio/resolver/ad2s1210.h
@@ -1,5 +1,5 @@
 /*
- * ad2s1210.h plaform data for the ADI Resolver to Digital Converters:
+ * ad2s1210.h platform data for the ADI Resolver to Digital Converters:
  * AD2S1210
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
@@ -11,6 +11,13 @@
 #ifndef _AD2S1210_H
 #define _AD2S1210_H
 
+/**
+ * struct ad2s1210_platform_data - chip model
+ * @sample:	sample input used to clearing the fault register
+ * @a:		array of inputs (A0 and A1)
+ * @res:	array of resolution inputs (RES0 and RES1)
+ * @gpioin:	control the read operation
+ */
 struct ad2s1210_platform_data {
 	unsigned int		sample;
 	unsigned int		a[2];
-- 
2.16.2
