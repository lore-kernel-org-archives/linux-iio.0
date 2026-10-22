Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677985;
	b=Zwk+Vemvy3lUAZsL5LeXWenSxZprTAygu3dkJSGguTDLLpgdkt2FVfN+j5NAc5cXWggI
	 rnh5Q1TNRd1TVb+lgmBcMkeEQFnAqeFnsauXJzuVpPuM3kNOhitiO+CAjxXCTOPEcxLt/
	 RzIxzgfwOGVCfiMKyc565c9Ha9efvU3b0/8Rz/5PLUx2mLom2lfw6Bhmi/aEENQyBZzSZ
	 H4RjwZfYB9Ha71FAS1affxSpw/Krvg+bS8xa2dmxf5ZukstmDkhZ6krPy6S6RLYCwCDOw
	 ydM17EVsKeRAit75epfpgyUf/ZofPRMFyCx3DXJriky+xC7rNeQ0VH0wVdfgSPB2Jkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t3RexKatP1kjoAD+7UX1aOwf4BjKeEG2GX7OI7aVWc0=;
	b=kXuVr73HzN6OZHWiv9MbKuzQrICXOQaQnYjRKV4hxTiBgwIjix2T3E7b5uG/XLCNZkmK
	 Cm30jW0Yy1yurzYcQLf01+gthUl6bwKXmLaSRYA03HvReF+KT1XVqHmTDoH2OGl7xcmng
	 IeO1KZfKg0ou3/QHnyvL37jHwyannM3lYgSc4Bnt97oJyK8KAKA+0591Mes1JpiEa1Apw
	 xcI6CP3POSgRKFadS4wxIf0Djvkaf6bGBrOq3/vTtveVg+yQCTR+9AwYoQy+A8W2UAh+j
	 KAzUHZrst+EDg1DDdP/SAU2EXZYY/lfWqRyC8v56VwEzg/qMoMDbAZZcZG1CNga9cOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I73p09gQ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21338606A31B
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 14:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21338606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I73p09gQ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33fb4680717so4561642eec.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792677984; x=1793282784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t3RexKatP1kjoAD+7UX1aOwf4BjKeEG2GX7OI7aVWc0=;
        b=I73p09gQ/KJIuHA6CQVeOcWZU5MX4hhQyxC5umZbySnjBIbHOxucJkBoMaL5uH/JnD
         uugF2MYQWLR+kYmSjvfHBBMPvJgSTTpFyxsGQc88dOKTxpZf3eINmeEVODJhLWSkqNv8
         PTCLvp4Bg5Hsln9m38+/a4u3zyUMcVPFEe7f6L574dfDUY9Oh78vRkO0NCcvQdUZbbjA
         tTb+zORfip5y2Yd7VR5t5CSMo0Y77GX7ImGJ48KkcY6ExMR/Wz0NP8Z5WpVVRrhfS6/J
         kDYJKEq5+9XYtB7so9OV90V6c5AjXLVDblkl9+zXzkNSS2jTP5HxeI1a/yt6KtszH3mQ
         SV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677984; x=1793282784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3RexKatP1kjoAD+7UX1aOwf4BjKeEG2GX7OI7aVWc0=;
        b=OYMEptzHqHwUr0I1xfZJPRmcxYfG0S3qGinN3V+Hl5iKV94ALPPMD/ssQPbI1Z+Itd
         br1XiUadgdDihe8vwkNXrtRlfJyHPfd9vcugn6F7wFS71tTtU9UhUMhB4fv12nCHl3b9
         iU7V9n1q7Ij3mQmDSbeaM+HAX2y2QIG7fm53kBtn2NiFBns2CLlSWQRy1ty2wdzcsGXf
         L6RQ9431FMH0VSgo63p5FLMTeDWFX/3tl37JsQQjXHRNcXws7XXOQ/XrqVK+NI2ana+t
         /8aQ2WysGA++IamBc6LmOyegjFTmQ1ax4v2KQg1RatEj/mGMybT2MDSAjwWtU9Dd6D/i
         5VqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWDAPDSwOFCeMQsEKeSwOzwX0piBABG/5iKtDK5oO6Akkusqc2RQ1Gv8QEpwW1Lb67vu729UkveyQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeY2318Rzjxxp32KGhDFH3zthxgY6Zo4grkFJD4gDP/0ebxhzy
	lieaSfEQ+2KB2qv94TEaDkIeeYsWdyDN3wG8vPHqXlb1Kp+RRnDqThlK
X-Gm-Gg: AYBFou1uf5IhTPeSZxdUNucjWrbnlBCQI6hmYELOst1sjQ4mgKskQuiuiBJk9ipwT3X
	kltTX6ZUDWuAAEKcfye85u6yXbVWZI561IAzmOlVRXi4dWDgdgbPMAaz9bxXjOuj/4cGqWigP8R
	g2mRvM5EcHJqoWpcrOeODXne54QI5xOqyjn2SIh8e4oEr5TY3t1DpGKit2VMaUgkMMDHBkGw66I
	EP8LPWBcB7Alll1ruKLcWztmEHAMMR+C/rPrbV0XB/rWzgRIjBDzjEyE9hgLAcRW/IqRlwSL9PP
	tY8oAOhbxEGvyiTcXK73uF9CR2mCBCln/Nk463PhK1uzusBn/6pIGnmmqZKaNvQTv7v1oYHNSrQ
	aMOAuRq8rLbWyQZgXAo0LH/8TJtf6hF+hdDMLrrfXHqU30hn82NQZ2cq8Irvvj6mHwg/jnsWjTO
	QO1E6kX86M8OW6MOLrYGnKN5Z1XYK7Z200wMUCrSTO25//9OIFBYtvm7vMOYo8BN7Zbau1PVU3r
	zwFg0pLs8euzdDuBk040occ/Vj3j9pjPlOqJvG4NSktpIysLkXX3nUfxO51HBCWrGnryC0LVals
	1MRai4d0Z2NK4rsDpbizCOijHxGoT6hY5vOHrGbTe7WEgr/1XaCTE52/37VcfpaKiAaupbMVpKb
	QsGroUs+qzgw=
X-Received: by 2002:a05:693c:810e:b0:367:941:c253 with SMTP id 5a478bee46e88-3674c93b096mr7616489eec.11.1792677983998;
        Thu, 22 Oct 2026 07:06:23 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ee5eesm14960559eec.8.2026.10.22.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:06:23 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Thu, 22 Oct 2026 19:36:13 +0530
Message-ID: <20261022140615.30710-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
channel specs and lets ams_init_module() fill them for the AMS node and
each of its children, without telling it how much room is left.

For the PL-SYSMON node, ams_get_ext_chan() appends one channel per
"channel@N" child after the 10 fixed PL channels. The binding allows
reg values 20..50, so a PL node can have up to 31 such children, i.e.
up to 41 PL channels, while only 31 are budgeted for it. Together with
the 13 PS and 7 AMS control channels, this writes past the end of the
buffer. Since the modules are filled in device tree order, the fixed
channel blocks copied after the PL node can overflow as well.

ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
far out of bounds.

Pass the remaining capacity down to ams_init_module() and
ams_get_ext_chan() and fail with -ENOSPC when a module does not fit,
instead of writing past the buffer. Also reject reg values below 20, as
the binding requires.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Fix the truncated subject line (Andy)
- Drop the paragraph about an earlier report, I could not find that
  thread again to reference it properly
- Pass the remaining capacity as unsigned int and drop the casts (Andy)
- Keep the ams_get_ext_chan() call on one line (Andy)
- Rebase on fixes-togreg
- Drop the bouncing @xilinx.com and @huawei.com addresses from Cc

v1: https://lore.kernel.org/all/20261021225356.625288-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have ZynqMP hardware.

 drivers/iio/adc/xilinx-ams.c | 54 ++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 158e6133abf5..7f0f7778d6aa 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -144,7 +144,14 @@
 #define AMS_PL_CSTS_ACCESS_MASK		BIT(1)
 
 #define AMS_PL_MAX_FIXED_CHANNEL	10
-#define AMS_PL_MAX_EXT_CHANNEL		20
+/*
+ * The external PL channels are addressed by their channel number. The
+ * binding allows the range from AMS_PL_EXT_CHANNEL_MIN to
+ * AMS_PL_EXT_CHANNEL_MAX. AMS_PL_EXT_CHANNEL_MIN maps onto the first
+ * ams_pl_channels[] entry, AMS_PL_EXT_CHANNEL_MAX onto the last one.
+ */
+#define AMS_PL_EXT_CHANNEL_MIN		20
+#define AMS_PL_EXT_CHANNEL_MAX		50
 
 #define AMS_INIT_POLL_TIME_US		200
 #define AMS_INIT_TIMEOUT_US		10000
@@ -1142,20 +1149,31 @@ static const struct iio_chan_spec ams_ctrl_channels[] = {
 };
 
 static int ams_get_ext_chan(struct fwnode_handle *chan_node,
-			    struct iio_chan_spec *channels, int num_channels)
+			    struct iio_chan_spec *channels, int num_channels,
+			    unsigned int max_channels)
 {
 	struct iio_chan_spec *chan;
-	struct fwnode_handle *child;
 	unsigned int reg, ext_chan;
 	int ret;
 
-	fwnode_for_each_child_node(chan_node, child) {
+	fwnode_for_each_child_node_scoped(chan_node, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
+		if (ret)
+			continue;
+
+		/*
+		 * Anything outside of the range of channel numbers allowed
+		 * by the binding is not a valid channel.
+		 */
+		if (reg < AMS_PL_EXT_CHANNEL_MIN ||
+		    reg > AMS_PL_EXT_CHANNEL_MAX)
 			continue;
 
+		if (num_channels >= max_channels)
+			return -ENOSPC;
+
 		chan = &channels[num_channels];
-		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
+		ext_chan = reg - AMS_PL_EXT_CHANNEL_MIN;
 		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
 
 		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
@@ -1183,7 +1201,8 @@ static void ams_iounmap_pl(void *data)
 
 static int ams_init_module(struct iio_dev *indio_dev,
 			   struct fwnode_handle *fwnode,
-			   struct iio_chan_spec *channels)
+			   struct iio_chan_spec *channels,
+			   unsigned int max_channels)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct ams *ams = iio_priv(indio_dev);
@@ -1191,6 +1210,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 	int ret;
 
 	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
+		if (max_channels < ARRAY_SIZE(ams_ps_channels))
+			return -ENOSPC;
+
 		ams->ps_base = fwnode_iomap(fwnode, 0);
 		if (!ams->ps_base)
 			return -ENXIO;
@@ -1202,6 +1224,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
 		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
+		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
+			return -ENOSPC;
+
 		ams->pl_base = fwnode_iomap(fwnode, 0);
 		if (!ams->pl_base)
 			return -ENXIO;
@@ -1213,9 +1238,14 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		/* Copy only first 10 fix channels */
 		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
 		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
-		num_channels = ams_get_ext_chan(fwnode, channels,
-						num_channels);
+		ret = ams_get_ext_chan(fwnode, channels, num_channels, max_channels);
+		if (ret < 0)
+			return ret;
+		num_channels = ret;
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
+		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
+			return -ENOSPC;
+
 		/* add AMS channels to iio device channels */
 		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
 		num_channels += ARRAY_SIZE(ams_ctrl_channels);
@@ -1245,7 +1275,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	if (fwnode_device_is_available(fwnode)) {
-		ret = ams_init_module(indio_dev, fwnode, ams_channels);
+		ret = ams_init_module(indio_dev, fwnode, ams_channels, ams_size);
 		if (ret < 0)
 			return ret;
 
@@ -1253,7 +1283,9 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	}
 
 	device_for_each_child_node_scoped(dev, child) {
-		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		ret = ams_init_module(indio_dev, child,
+				      ams_channels + num_channels,
+				      ams_size - num_channels);
 		if (ret < 0)
 			return ret;
 

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

