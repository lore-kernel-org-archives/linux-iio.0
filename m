Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7843E48C;
	Wed, 29 Jul 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313634; cv=none; b=PRnsMV/34QXfhwKWkKb9y23SLVovfb81K2pz62BEgOGd9ad/kfZBKVohfCAA5AmJjCMz5gZAmT+Scx8vr84wfgosqvvfEb+L0beemoNkjQLMZy3dAJX6TuBG4UKpMHIJpuWI7aj+6w41PEdExYbH1H9ATa3F/9B5asFgZTQ2Dok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313634; c=relaxed/simple;
	bh=GnpoeWWyoi53tGhcbxZX3hA2WNGG+br0KLaY6p1Xoxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RyTtSGKZO0ZO0qo+TeEEpWrmPdsOi57/1x2HNKxIS+ZmZAb3TyP3+wayzL3vcO6Mrds8SyDZ0DOU5s9Jsh5a4yCrRT6arV/N3yWjXQufRSQws/fzvH1O9ywCvq14ZT+nD9jYTkXg/OL/zy573eckU5CaJ847sYCuHfBXqOZdM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUS+bQBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUS+bQBk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B601C2BD04;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785313629;
	bh=GnpoeWWyoi53tGhcbxZX3hA2WNGG+br0KLaY6p1Xoxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XUS+bQBkVXQogd0vgJDRt5785aEKcN2daZ3FOLfdDc7a2UTuNCfes1oy3eB42c+ur
	 Zg0q0r19VNy32hNL7E9yNfofsp7e6pCDxbp0/QBdLse3o/LKUo+IQSSRTNVycsyfxl
	 h6lbTRUIe9P+tu1kXMJleY7qUlknwDGFU1cC9UpSGs4mjqqQtUS79/td4gPwNmkhox
	 YN3VcTu6Se73AqpGl5PaoHLxdcSMPhdcoetCFP7IuQ2Skg6LtLukScWSF5DlpL8Sqj
	 BdDpya3X9OGrjiMANS3/nwGhngoP0o7Mg4lVsOQTzyDOH7GvJYjPdbmvfdPA3hX1QT
	 thb/uP44RjPzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B9EC54F51;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Jul 2026 09:25:42 +0100
Subject: [PATCH v10 15/17] iio: frequency: ad9910: show channel priority in
 debugfs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-ad9910-iio-driver-v10-15-aa1f6167729e@analog.com>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
In-Reply-To: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785313627; l=6434;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=QyGDK/HwGxDveHlNVC3ffDCDt9k7xvriXc7r+n8Cppw=;
 b=UHZue2FEDqR4wJpDSyNVI5gIN4+D+GGfxhF23RRCPadhytqXk0wTBvLGlGY2tJba8GmmYbjRb
 Bxns9t4wOV6DsQyjVSyB/g0yl5PoMkDN8A6Oxraw8/zCCAG61/8wRzC
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Expose frequency_source, phase_source and amplitude_source attributes in
debugfs. Those indicate from which channel the specific DDS parameter is
being sourced by returning its label. The implementation follows the
priority table found in the datasheet.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 149 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index e1aacb191730..bfbc2ac5434f 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/seq_file.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -193,6 +194,11 @@
 #define AD9910_RAM_ENABLED(st)		\
 	FIELD_GET(AD9910_CFR1_RAM_ENABLE_MSK, (st)->reg[AD9910_REG_CFR1].val32)
 
+#define AD9910_DEST_FREQUENCY		0
+#define AD9910_DEST_PHASE		1
+#define AD9910_DEST_AMPLITUDE		2
+#define AD9910_DEST_POLAR		3
+
 /* PLL constants */
 #define AD9910_PLL_MIN_N		12
 #define AD9910_PLL_MAX_N		127
@@ -2067,6 +2073,141 @@ static int ad9910_setup(struct device *dev, struct ad9910_state *st,
 	return ad9910_io_update(st);
 }
 
+static inline const char *ad9910_frequency_source_get(struct ad9910_state *st)
+{
+	bool ram_en, mode_en;
+
+	guard(mutex)(&st->lock);
+
+	/* RAM enabled and data destination is frequency */
+	ram_en = AD9910_RAM_ENABLED(st);
+	if (ram_en && AD9910_DEST_FREQUENCY ==
+		      FIELD_GET(AD9910_CFR1_RAM_PLAYBACK_DEST_MSK,
+				st->reg[AD9910_REG_CFR1].val32))
+		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
+
+	/* DRG enabled and data destination is frequency */
+	mode_en = FIELD_GET(AD9910_CFR2_DRG_ENABLE_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en && AD9910_DEST_FREQUENCY ==
+		       FIELD_GET(AD9910_CFR2_DRG_DEST_MSK,
+				 st->reg[AD9910_REG_CFR2].val32))
+		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_FREQ];
+
+	/* FTW: RAM enabled and data destination is phase, amplitude, or polar */
+	if (ram_en)
+		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
+
+	/* single tone profiles */
+	return ad9910_channel_str[AD9910_CHAN_IDX_PROFILE_0 + st->profile];
+}
+
+static int ad9910_frequency_source_show(struct seq_file *s, void *ignored)
+{
+	seq_printf(s, "%s\n", ad9910_frequency_source_get(s->private));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ad9910_frequency_source);
+
+static inline const char *ad9910_phase_source_get(struct ad9910_state *st)
+{
+	bool ram_en, mode_en;
+	u32 destination;
+
+	guard(mutex)(&st->lock);
+
+	/* RAM enabled and data destination is phase or polar  */
+	ram_en = AD9910_RAM_ENABLED(st);
+	if (ram_en) {
+		destination = FIELD_GET(AD9910_CFR1_RAM_PLAYBACK_DEST_MSK,
+					st->reg[AD9910_REG_CFR1].val32);
+		if (destination == AD9910_DEST_PHASE ||
+		    destination == AD9910_DEST_POLAR)
+			return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
+	}
+
+	/* DRG enabled and data destination is phase */
+	mode_en = FIELD_GET(AD9910_CFR2_DRG_ENABLE_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en && AD9910_DEST_PHASE ==
+		       FIELD_GET(AD9910_CFR2_DRG_DEST_MSK,
+				 st->reg[AD9910_REG_CFR2].val32))
+		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_PHASE];
+
+	/* POW: RAM enabled and data destination is frequency or amplitude */
+	if (ram_en)
+		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
+
+	/* single tone profiles */
+	return ad9910_channel_str[AD9910_CHAN_IDX_PROFILE_0 + st->profile];
+}
+
+static int ad9910_phase_source_show(struct seq_file *s, void *ignored)
+{
+	seq_printf(s, "%s\n", ad9910_phase_source_get(s->private));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ad9910_phase_source);
+
+static inline const char *ad9910_amplitude_source_get(struct ad9910_state *st)
+{
+	bool ram_en, mode_en;
+	u32 destination;
+
+	guard(mutex)(&st->lock);
+
+	/* OSK enabled */
+	mode_en = FIELD_GET(AD9910_CFR1_OSK_ENABLE_MSK,
+			    st->reg[AD9910_REG_CFR1].val32);
+	if (mode_en)
+		return ad9910_channel_str[AD9910_CHAN_IDX_OSK];
+
+	/* RAM enabled and data destination is amplitude or polar */
+	ram_en = AD9910_RAM_ENABLED(st);
+	if (ram_en) {
+		destination = FIELD_GET(AD9910_CFR1_RAM_PLAYBACK_DEST_MSK,
+					st->reg[AD9910_REG_CFR1].val32);
+		if (destination == AD9910_DEST_AMPLITUDE ||
+		    destination == AD9910_DEST_POLAR)
+			return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
+	}
+
+	/* DRG enabled and data destination is amplitude */
+	mode_en = FIELD_GET(AD9910_CFR2_DRG_ENABLE_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en && AD9910_DEST_AMPLITUDE ==
+		       FIELD_GET(AD9910_CFR2_DRG_DEST_MSK,
+				 st->reg[AD9910_REG_CFR2].val32))
+		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_AMP];
+
+	/* only way to control amplitude at this point is through OSK */
+	if (ram_en)
+		return ad9910_channel_str[AD9910_CHAN_IDX_OSK];
+
+	/* single tone profiles */
+	return ad9910_channel_str[AD9910_CHAN_IDX_PROFILE_0 + st->profile];
+}
+
+static int ad9910_amplitude_source_show(struct seq_file *s, void *ignored)
+{
+	seq_printf(s, "%s\n", ad9910_amplitude_source_get(s->private));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ad9910_amplitude_source);
+
+static inline void ad9910_debugfs_init(struct ad9910_state *st,
+				       struct iio_dev *indio_dev)
+{
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+
+	debugfs_create_file("frequency_source", 0400, d, st,
+			    &ad9910_frequency_source_fops);
+	debugfs_create_file("phase_source", 0400, d, st,
+			    &ad9910_phase_source_fops);
+	debugfs_create_file("amplitude_source", 0400, d, st,
+			    &ad9910_amplitude_source_fops);
+}
+
 static int ad9910_probe(struct spi_device *spi)
 {
 	static const char * const supplies[] = {
@@ -2170,7 +2311,13 @@ static int ad9910_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret,
 				     "failed to add ram upload unregister action\n");
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ad9910_debugfs_init(st, indio_dev);
+
+	return 0;
 }
 
 static const struct spi_device_id ad9910_id[] = {

-- 
2.43.0


