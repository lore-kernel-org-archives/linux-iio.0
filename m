Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E129466AEF
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546198; cv=none; b=pfBIu7QbK3AAUyVAkcyqrv4Jzd14JhQ/H5um7/W+G+hULNySCqFPS8QWm0+61J9UtetjkPBjhovpSFlVBE5byOUofg+mBFiQE4NzsXMEb8s1DXBeCcSxZmfwIdT2mXhs2Ep9/i5mRCu2TJg+UYcRuBtfLn6NuCFaLHVzNYf8RR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546198; c=relaxed/simple;
	bh=K1jPbnIpn2vPrtvqzcNi7Vjb6hG0x04g8LVYMsnM6gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlJ9Os6EuDTt1xiQGDrc2+/U2di3muH7ONNfskHP1WxbC+2CxxK+J6f0zMVlxajICsn8jzZ71brRpJ7+BTegyOvwgzXbjK8pRz3rJ0rDn2eLxXxAml95I1mTjSiLRDasuCcML6NlONrMf/896pDI8c8O89ROc5+4GEB2MQv79ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZZQ53PU3; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZZQ53PU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546172; x=1789805372;
	bh=QCIfMsx6KjKXpnoxBI1XGkxGk4Y7Sik+nYV7bSHmLbY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZZQ53PU3kiySaayOLmyA8tfwYe5hQjIggQD1A8wYKzkd3PpD6YrA1kBaLeVRvFbui
	 lgaAXTC3LhAC+OYuRumC1xUjArgOSAhOL3UYR9d7DRCfSv2o+SAHpfl8tRsWf5TbZl
	 kRP0mvdT2pca1dl3YQcNVFCs3qRJa4FBsKwtEO2qFaDxkQkzDQljrD/6vD1yMh/zM/
	 3Av3gBQDFFIzYDxa9c+2SCk5z7zn9mt+khKRG5S3yBIhzuMgLMQ58zoK43VkOMcXsa
	 TGctV/6x0K2Mb+HXPc9yvqKUN60lz+pm0yfOpwkwrMQMsM369w1HCYCojRPeT/iSGK
	 Fnnb3DBAObH2w==
X-Pm-Submission-Id: 4hlBPQ5mGsz2ScPS
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:08:02 +0200
Subject: [PATCH v9 06/10] iio: accel: mma8452: Fix unintended comment
 indent
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-6-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=2166;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=K1jPbnIpn2vPrtvqzcNi7Vjb6hG0x04g8LVYMsnM6gY=;
 b=bmWELgMFJN5IP12tltf9Vblc4o5YDdxcqFoCmHGAV2ms0pCK9zHvrcW+vQOqLv5FmhWxhc0IY
 ZT92Utb2lw1AAa8uJ2TEWrelv8+p9UvxZuEgWYT+gEQ3u8tWoeHC0p7
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The extra space this block was indented with looks quite untraditional, and
does not align with the common style used in the kernel.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 72b4ab32775a..b70bc8638128 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -122,21 +122,21 @@ struct mma8452_data {
 	u8 data_cfg;
 };
 
- /**
-  * struct mma8452_event_regs - chip specific data related to events
-  * @ev_cfg:			event config register address
-  * @ev_cfg_ele:			latch bit in event config register
-  * @ev_cfg_chan_shift:		number of the bit to enable events in X
-  *				direction; in event config register
-  * @ev_src:			event source register address
-  * @ev_ths:			event threshold register address
-  * @ev_ths_mask:		mask for the threshold value
-  * @ev_count:			event count (period) register address
-  *
-  * Since not all chips supported by the driver support comparing high pass
-  * filtered data for events (interrupts), different interrupt sources are
-  * used for different chips and the relevant registers are included here.
-  */
+/**
+ * struct mma8452_event_regs - chip specific data related to events
+ * @ev_cfg:			event config register address
+ * @ev_cfg_ele:			latch bit in event config register
+ * @ev_cfg_chan_shift:		number of the bit to enable events in X
+ *				direction; in event config register
+ * @ev_src:			event source register address
+ * @ev_ths:			event threshold register address
+ * @ev_ths_mask:		mask for the threshold value
+ * @ev_count:			event count (period) register address
+ *
+ * Since not all chips supported by the driver support comparing high pass
+ * filtered data for events (interrupts), different interrupt sources are
+ * used for different chips and the relevant registers are included here.
+ */
 struct mma8452_event_regs {
 	u8 ev_cfg;
 	u8 ev_cfg_ele;

-- 
2.55.0

