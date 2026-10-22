Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682351;
	b=FsO85DMZXueoLc/TA5gRiIrQE5is6SJ4iI7/sXs+p1bWvG6Q8TIjkPGOQ2E7h6qv+r5x
	 ubquT/PKpV6AaYlTACT3fe/B2b2r4t48Lvi3eBsQ8Ff3WtwAmS5LNcnNdYSmpn7VTN/eD
	 tKUaNwv7bSL4OOwCW6dPldHgTvjZpInRW268zjE8r2Yj5sRV6GYuDeSv5UlNijrLm79QB
	 Bf1gOXuRIZkoZ65RZOanhB4yhBK+4DfyvP0w2DCdjXrHeKLFiAh2vJpQis6YWY4zD0wv2
	 k82gJ9YaNpym+qoIf1/0bjfYieEBfEUeoTHU9JychEQR4TCwLSZvubqH0aB9rxDwDbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682351;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XeYeuHW2ROs8z63PamAF7/Z5t0LYjZHf+QlIp4GkasQ=;
	b=HOMEqCF3PnCqGixRg0RmWRactXrc+NyedfDWKRKkkfrvgxqJsZ464VVsRFolJsDy1sNa
	 rG29hp82KGb6dU1yEvCxFSbUWEhXt4IFT7CaivR8Co/wK+GGYolGzCbv1QH6yHf2tEUtU
	 lsPYro1UR7jP1dUrbonoMFJpmwbasGQ5uZgaf63BLbIx0cgdvG+ivp0VssjNJftj5MT7c
	 AZn78bQC6fmchUoPqMgjdQBOHEtZXlSBcLzqB2DKOEGUaLXtcYOw5FydX3feBk+4uc2g7
	 6Wmosdw/jyM5QWP6x6LcamntzQcWhB6jLKtyClXgI0f68s/uZKyzft8WsoWFRURPOfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYBAX83e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D9606CC73;
	Thu, 22 Oct 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYBAX83e
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682351;
	b=c9IZJdnWhDKN95QBNZlzMW99BJ9EUWNlxFiAE6y5vLhzoDzvUwHvmKkYVDX9f6/h3dbw
	 2WpDHEfkmd0+o/A/rTkJ+m6YNlLVN2qxRxQlpq4gThKvI/pR8J/Jdisnh07O/ygl0OGwO
	 b4GeC+SgYqlCywzpk334qQNfCwYlpP1tSyfUoiG2Wg+BVyQgrRrwRK9mSrfQ6czWhgp4i
	 al1JvvVlfW5sf4jvPqnw+C1toTyULf7lUEEpswU3j9gMbgxKEZkljQCJ1rQzdy5zobBA5
	 Xj/fPM7fF0hMVIMqJEFLymKHhVCUa2xjOrrcaiiDuQJilVeSYcgAonZKp9LeL2qCxPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682351;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XeYeuHW2ROs8z63PamAF7/Z5t0LYjZHf+QlIp4GkasQ=;
	b=TUaC9JydlWI4Jl84IgKCZqvpAY/n8eekV6lz0IxMEOuYKv+tUuuLBmYotr4bSrHLZps7
	 OaOwoGyhkjC+alC+cOZL//jQgfZf70DjL6I52xgNDWYOnXSKSGMNt1LwiFqPOK8VEKjj7
	 999jm4adV3rB5neDf5goQDGqZ5YlKCPNe2T1qIS6QefGRlVxyJXMFm5NM8+xWWhWskv2V
	 ynsuch+aKqzA3adnEyYIVIGX3TjMceDwpYXJ6KQPHfEKEkIioV60xN/52YNOEGD10AFgR
	 K43RaO0wyF36RMkUHBn4l0zqqAb7VRK0XnCK3GsFEZiEDAyRBh4UcK6Fn2ins8qyNXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C237F1F031E4;
	Thu, 22 Oct 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682351;
	bh=XeYeuHW2ROs8z63PamAF7/Z5t0LYjZHf+QlIp4GkasQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NYBAX83evJEstw7ApFOpVq2XvQqSyNdpZsWezR1phO3Z+tNHHDgkUO3tlAgwoYnG4
	 giPa4nVCImQcvb2c0pCJ7cqJyGNo8/MRa1Njc8oXmA9UfxMN+8xxzJ38pu8nTIs6B/
	 VF+GGcrM27y/aNrpxIJF6L96Tnw951t0qeCVWPJDwzDbDrqAWz7j3hRSRX2jjOrTLW
	 5hDO4w2r3JzhsRc0GybrRGdxSOGycGXQKodBv0FC3SIxXgljtjp4BWNyfNLMSnd+tw
	 yU3Dy78yQ8Bpbl1LsuazSissQynuYF3BkAf4EqzmOmqvjcCPwdpN7sv8c3Utfauof9
	 jGWqlH2IBnthw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8DA2641E5A;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:19:03 -0300
Subject: [PATCH v2 05/10] iio: frequency: ad9910: move channel indexes into
 a shared header
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-ad9910-backend-support-v2-5-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=4373;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=x6NMO+HwBMwaNr1Y6ukLdwzGO76H8amSFklxVgJRt5o=;
 b=RY7ZuoYgghx0fHm+9xcyD5cZQ7KOqVeFqS1v/fNRORDaW9GdAukFEEkBq5CXOA4U4RNz5nk4h
 Ck7OCTLSUhCDJFZsyNlCXKjsMWm9UCKsjZjNGhNVSPQp4qJowTmP56F
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The channel indexes are used as channel identifiers in IIO backend
operations, such as enabling a parallel data port destination or
selecting a profile. Move them, along with the data destination
definitions, into a shared header, so that the frontend and backend
drivers agree on those identifiers.

No functional change.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS                    |  1 +
 drivers/iio/frequency/ad9910.c | 35 ++-------------------------------
 drivers/iio/frequency/ad9910.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 351ec0bca477..64aa7b539ca3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1735,6 +1735,7 @@ F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backend.yaml
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
 F:	Documentation/iio/ad9910.rst
 F:	drivers/iio/frequency/ad9910.c
+F:	drivers/iio/frequency/ad9910.h
 
 ANALOG DEVICES INC MAX22007 DRIVER
 M:	Janani Sunil <janani.sunil@analog.com>
diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 8bc24d0b7442..dc13986dff3d 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -33,6 +33,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include "ad9910.h"
+
 /* Register addresses */
 #define AD9910_REG_CFR1			0x00
 #define AD9910_REG_CFR2			0x01
@@ -194,11 +196,6 @@
 #define AD9910_RAM_ENABLED(st)		\
 	FIELD_GET(AD9910_CFR1_RAM_ENABLE_MSK, (st)->reg[AD9910_REG_CFR1].val32)
 
-#define AD9910_DEST_FREQUENCY		0
-#define AD9910_DEST_PHASE		1
-#define AD9910_DEST_AMPLITUDE		2
-#define AD9910_DEST_POLAR		3
-
 /* PLL constants */
 #define AD9910_PLL_MIN_N		12
 #define AD9910_PLL_MAX_N		127
@@ -302,34 +299,6 @@ struct ad9910_ram_fw {
 	__be32 words[] __counted_by_be(wcount);
 } __packed;
 
-enum {
-	AD9910_CHAN_IDX_PHY,
-	AD9910_CHAN_IDX_PROFILE_0,
-	AD9910_CHAN_IDX_PROFILE_1,
-	AD9910_CHAN_IDX_PROFILE_2,
-	AD9910_CHAN_IDX_PROFILE_3,
-	AD9910_CHAN_IDX_PROFILE_4,
-	AD9910_CHAN_IDX_PROFILE_5,
-	AD9910_CHAN_IDX_PROFILE_6,
-	AD9910_CHAN_IDX_PROFILE_7,
-	AD9910_CHAN_IDX_PARALLEL_AMP,
-	AD9910_CHAN_IDX_PARALLEL_PHASE,
-	AD9910_CHAN_IDX_PARALLEL_FREQ,
-	AD9910_CHAN_IDX_PARALLEL_POLAR_AMP,
-	AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE,
-	AD9910_CHAN_IDX_DRG_FREQ,
-	AD9910_CHAN_IDX_DRG_PHASE,
-	AD9910_CHAN_IDX_DRG_AMP,
-	AD9910_CHAN_IDX_DRG_FREQ_RAMP_UP,
-	AD9910_CHAN_IDX_DRG_FREQ_RAMP_DOWN,
-	AD9910_CHAN_IDX_DRG_PHASE_RAMP_UP,
-	AD9910_CHAN_IDX_DRG_PHASE_RAMP_DOWN,
-	AD9910_CHAN_IDX_DRG_AMP_RAMP_UP,
-	AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN,
-	AD9910_CHAN_IDX_RAM,
-	AD9910_CHAN_IDX_OSK,
-};
-
 enum {
 	AD9910_POWERDOWN,
 	AD9910_DWELL_EN,
diff --git a/drivers/iio/frequency/ad9910.h b/drivers/iio/frequency/ad9910.h
new file mode 100644
index 000000000000..6452a8678ed9
--- /dev/null
+++ b/drivers/iio/frequency/ad9910.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AD9910 SPI DDS (Direct Digital Synthesizer) driver
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#ifndef IIO_FREQUENCY_AD9910_H_
+#define IIO_FREQUENCY_AD9910_H_
+
+#define AD9910_DEST_FREQUENCY		0
+#define AD9910_DEST_PHASE		1
+#define AD9910_DEST_AMPLITUDE		2
+#define AD9910_DEST_POLAR		3
+
+enum ad9910_channel_idx {
+	AD9910_CHAN_IDX_PHY,
+	AD9910_CHAN_IDX_PROFILE_0,
+	AD9910_CHAN_IDX_PROFILE_1,
+	AD9910_CHAN_IDX_PROFILE_2,
+	AD9910_CHAN_IDX_PROFILE_3,
+	AD9910_CHAN_IDX_PROFILE_4,
+	AD9910_CHAN_IDX_PROFILE_5,
+	AD9910_CHAN_IDX_PROFILE_6,
+	AD9910_CHAN_IDX_PROFILE_7,
+	AD9910_CHAN_IDX_PARALLEL_AMP,
+	AD9910_CHAN_IDX_PARALLEL_PHASE,
+	AD9910_CHAN_IDX_PARALLEL_FREQ,
+	AD9910_CHAN_IDX_PARALLEL_POLAR_AMP,
+	AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE,
+	AD9910_CHAN_IDX_DRG_FREQ,
+	AD9910_CHAN_IDX_DRG_PHASE,
+	AD9910_CHAN_IDX_DRG_AMP,
+	AD9910_CHAN_IDX_DRG_FREQ_RAMP_UP,
+	AD9910_CHAN_IDX_DRG_FREQ_RAMP_DOWN,
+	AD9910_CHAN_IDX_DRG_PHASE_RAMP_UP,
+	AD9910_CHAN_IDX_DRG_PHASE_RAMP_DOWN,
+	AD9910_CHAN_IDX_DRG_AMP_RAMP_UP,
+	AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN,
+	AD9910_CHAN_IDX_RAM,
+	AD9910_CHAN_IDX_OSK,
+};
+
+#endif /* IIO_FREQUENCY_AD9910_H_ */

-- 
2.43.0


