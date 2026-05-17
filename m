Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D93D1AA0;
	Sun, 17 May 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043097; cv=none; b=XEvNI6HKvjpy9LVHLDjTvQPw0uE9DBKhR7HyQuB68uHhl+FwIij2CSghAReX7MTVQJTKe+GIWQcgnBf8K4A/12xmXXCaHhrZ02Q4r/2648Rcu/3xTOPjr9w2r33eCubPLQzZB9eDvPGdtEsQGie9gm4upT9FrvkYsEiInxa7Agw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043097; c=relaxed/simple;
	bh=H83DBNbbCZW0bIb629FiJ4hdTDEDxOp35tsDNpj6CLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HM8AvKksnIIyCHUwR3HgRG0484c/ZP7z/G/7skElI42rySa6IIjYcrMjuH30rl+yyfxECkHl1Ney6HDwKDjpbABsvajJEQZV/5w/5PupcGvYO+JUR4pVGj5kORSH+6i2ZA74/cetDJBeNFvRegTz55hsJ5XFhlr12VHeP8P8Wuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTGZK0DU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTGZK0DU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEA7DC2BCF7;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043096;
	bh=H83DBNbbCZW0bIb629FiJ4hdTDEDxOp35tsDNpj6CLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fTGZK0DUcEkGLZvXRetq5UtUqxcL5//tirRIRwncRvrIv9Ikh2j1SLNnNumt5oHXF
	 nuMmqrHW5Ghv9vuMNU3G+K9BAXvoW5QlYFkn/XjqG4XvZTasJ+pA3dXdTlyxya+B+Z
	 +TCPEEYnnTSq0mNsiM5ggRqwnCbVuVHxrth8frN7QsV8CqjpY0AxAEFOsyh7c6S1Kc
	 ZhWaHdyhl3uf1NXBdJ6LE6YTgjBzlKkG25wijQIbA9Qwf58hJISGPRBepCvEoNHfka
	 ZB67fxzBGfdbsVK3v59kqXojMyaxkJCDlvQlIYgvljrWH+xhAmVMerG44VdOSd4ses
	 T13J82eIaMaMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F8DCD4F50;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 17 May 2026 19:37:55 +0100
Subject: [PATCH v5 11/13] iio: frequency: ad9910: show channel priority in
 debugfs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-ad9910-iio-driver-v5-11-31599c88314a@analog.com>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
In-Reply-To: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779043094; l=6698;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=YXB2Pe5UcxllzPIM4SqwqoK/3Q7QbKnTwc7le1YcLk8=;
 b=ZxTd/vhWZHPNWu7V9uedAgluD4SMUfm2YuHYr4IjGHLToRRIi8gr8wf/mKiwHknmd2BWGrgyP
 /qAOXRbzByKCFkZPidDeqFBA7DURGOkpToDpUkd04qr3GHxeF/9wR3R
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
 drivers/iio/frequency/ad9910.c | 148 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 91f28c7de68b..8c8e73f340f8 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -22,6 +22,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/seq_file.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -2116,6 +2117,146 @@ static int ad9910_setup(struct device *dev, struct ad9910_state *st,
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
+		return ad9910_channel_str[AD9910_CHAN_IDX_DRG];
+
+	/* Parallel data port enabled and data destination is frequency */
+	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en) /* TODO: get destination from backend once it is supported */
+		return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_PORT];
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
+		return ad9910_channel_str[AD9910_CHAN_IDX_DRG];
+
+	/* Parallel data port enabled and data destination is phase */
+	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en) /* TODO: get destination from backend once it is supported */
+		return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_PORT];
+
+	/* POW: RAM enabled and data destination is frequency, amplitude, or polar */
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
+		return ad9910_channel_str[AD9910_CHAN_IDX_DRG];
+
+	/* Parallel data port enabled and data destination is amplitude */
+	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+			    st->reg[AD9910_REG_CFR2].val32);
+	if (mode_en) /* TODO: get destination from backend once it is supported */
+		return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_PORT];
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
 static inline void ad9910_debugfs_init(struct ad9910_state *st,
 				       struct iio_dev *indio_dev)
 {
@@ -2131,6 +2272,13 @@ static inline void ad9910_debugfs_init(struct ad9910_state *st,
 
 	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
 	debugfs_create_symlink("ram_data", d, buf);
+
+	debugfs_create_file("frequency_source", 0400, d, st,
+			    &ad9910_frequency_source_fops);
+	debugfs_create_file("phase_source", 0400, d, st,
+			    &ad9910_phase_source_fops);
+	debugfs_create_file("amplitude_source", 0400, d, st,
+			    &ad9910_amplitude_source_fops);
 }
 
 static int ad9910_probe(struct spi_device *spi)

-- 
2.43.0


