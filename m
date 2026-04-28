Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D57441044;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382316; cv=none; b=QwZJJbU6N0It2fjPWIz9brNJGRvfH5dQZcUP0fqZNytOtRC9VcftfBmG2/wu21p0feMN1uj/b7dVKJrIVKDwXJJpCeVVTjWXUvkDRGb/rER3uoASjC7wc8TJH1xWyvXpf0iDyGGfe+hZyV7ZkiKygoCdf6ewC32f8NlMVfnZox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382316; c=relaxed/simple;
	bh=/CFQzyYD+JkOgXFRcQs68j0yNyskvw7AN4256x+Kuxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvHAPPij7Tkc15E2pBdDP/8rZ4Imf7sQLfY0IL72kv1eRY98Maeiz/+xQ+c+9GTY262REA78d2OteDeR6HwUgNZ4tvZ6nLf4GZPHbOw94siXHn0g1JhbCcYbFRtB5pt0dmm+qtOgFRDcroJsgqP4S/KAMENYqBST4vRMIwBLFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crOrL00q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crOrL00q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5361FC2BCB5;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382316;
	bh=/CFQzyYD+JkOgXFRcQs68j0yNyskvw7AN4256x+Kuxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=crOrL00qlWzBRjbv/PlQgPrY3/qjPjWXKhX61mb9j/9NM+uRuSNVMxr+6ityVBeng
	 gJSt1trf6NH1WqIpMm4jBMRabshMjAGhoVvsIPPRfoJJ5QVlM7W0C7j1t7m1qALzTg
	 wQeZCUGOLmNH9a985Fu0MJas8YYv2Kd6ZcXhxLLKeKn6ZZnDNOaJOYFRwUDRXRwp9Z
	 zrVVO2Hqejgv9Hpqj1K+ZbUiBy3XwrYKG2WYAR+RayVYt/1vCeTukDNc6oRnG3QTwK
	 FOlAQ7Pe/FKlIL87YpT3j8kirobBVvMv7wl4VP/fjoOsQb+P9iQ73rmoauROVeJhdb
	 kFhYgIS6IUSZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E16FF8868;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 28 Apr 2026 15:18:33 +0200
Subject: [PATCH v2 1/5] iio: light: si1133: prefer complex macros enclosed
 in parenthesis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-si1133-checkup-v2-1-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
In-Reply-To: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777382314; l=2461;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=6bHXuqv0VZRabyw8eBUBbiHAH0Nn4p7e0lWZDJyg1lI=;
 b=IzwXD3G+51okCPZMLIgA2Fpa3SsAVKs9HB3RTlK77OZLv1+9reJIi7zsnk3z2jhRx/kbJZ9+W
 Jqu3yc6pJC2DBGCu5FRBs6HKYqAwoYQD8nW4Yl70QM9kK8K2v5Ndn3w
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Enclose complex macros in parenthesis per checkpatch.pl error to
improve code style.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 44fa152dbd24c26c97cc778cbe641d92ecd56afa..52e4269dc35014b87b7c46a120e64723be716768 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -50,23 +50,23 @@
 #define SI1133_MAX_CMD_CTR		0xF
 
 #define SI1133_PARAM_REG_CHAN_LIST	0x01
-#define SI1133_PARAM_REG_ADCCONFIG(x)	((x) * 4) + 2
-#define SI1133_PARAM_REG_ADCSENS(x)	((x) * 4) + 3
-#define SI1133_PARAM_REG_ADCPOST(x)	((x) * 4) + 4
+#define SI1133_PARAM_REG_ADCCONFIG(x)	(((x) * 4) + 2)
+#define SI1133_PARAM_REG_ADCSENS(x)	(((x) * 4) + 3)
+#define SI1133_PARAM_REG_ADCPOST(x)	(((x) * 4) + 4)
 
 #define SI1133_ADCMUX_MASK 0x1F
 
-#define SI1133_ADCCONFIG_DECIM_RATE(x)	(x) << 5
+#define SI1133_ADCCONFIG_DECIM_RATE(x)	((x) << 5)
 
 #define SI1133_ADCSENS_SCALE_MASK 0x70
 #define SI1133_ADCSENS_SCALE_SHIFT 4
 #define SI1133_ADCSENS_HSIG_MASK BIT(7)
 #define SI1133_ADCSENS_HSIG_SHIFT 7
 #define SI1133_ADCSENS_HW_GAIN_MASK 0xF
-#define SI1133_ADCSENS_NB_MEAS(x)	fls(x) << SI1133_ADCSENS_SCALE_SHIFT
+#define SI1133_ADCSENS_NB_MEAS(x)	(fls(x) << SI1133_ADCSENS_SCALE_SHIFT)
 
 #define SI1133_ADCPOST_24BIT_EN BIT(6)
-#define SI1133_ADCPOST_POSTSHIFT_BITQTY(x) (x & GENMASK(2, 0)) << 3
+#define SI1133_ADCPOST_POSTSHIFT_BITQTY(x) (((x) & GENMASK(2, 0)) << 3)
 
 #define SI1133_PARAM_ADCMUX_SMALL_IR	0x0
 #define SI1133_PARAM_ADCMUX_MED_IR	0x1
@@ -87,15 +87,15 @@
 #define SI1133_CMD_MINSLEEP_US_HIGH	7500
 #define SI1133_CMD_TIMEOUT_MS		25
 #define SI1133_CMD_LUX_TIMEOUT_MS	5000
-#define SI1133_CMD_TIMEOUT_US		SI1133_CMD_TIMEOUT_MS * 1000
+#define SI1133_CMD_TIMEOUT_US		(SI1133_CMD_TIMEOUT_MS * 1000)
 
-#define SI1133_REG_HOSTOUT(x)		(x) + 0x13
+#define SI1133_REG_HOSTOUT(x)		((x) + 0x13)
 
 #define SI1133_MEASUREMENT_FREQUENCY 1250
 
 #define SI1133_X_ORDER_MASK            0x0070
 #define SI1133_Y_ORDER_MASK            0x0007
-#define si1133_get_x_order(m)          ((m) & SI1133_X_ORDER_MASK) >> 4
+#define si1133_get_x_order(m)          (((m) & SI1133_X_ORDER_MASK) >> 4)
 #define si1133_get_y_order(m)          ((m) & SI1133_Y_ORDER_MASK)
 
 #define SI1133_LUX_ADC_MASK		0xE

-- 
2.47.3


