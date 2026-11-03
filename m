Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717584;
	b=oYNqLJctAqGICd/WqJqfiJ8AJejL0lE4qorxiZSlVy7Xg3Xe9ClHeRDrvgA+L4FKziJ5
	 RgjQHocSytg65OQngFq/Rhnnaq8+kmqRryzmM0+qwTb7fm9bx/34aI8z476IvCz9l0tGw
	 1N6AmVZkS4+jfjTKzsIHgpwwJmY9SmUJETNoImWbI44VOYwDlp9dAglcHd4yb4uj0xzo/
	 hqc8rtleI3nh8N7Avl2ed4JuidtISwBswq6aiOM96+kErBZ+FiZ3jZqYVOnQG0vqzopDy
	 eNXonia6fUmCjTOXTWu0Za/qcstjWDGZZistRo+QvfwIfyCg4viwaUvTfXmBENWGeXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717584;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XeYeuHW2ROs8z63PamAF7/Z5t0LYjZHf+QlIp4GkasQ=;
	b=VmJfdp5Vp16UEahxku6Tt15nRxSwkAhONcvKZdeUeUoQDNnFVE8oqVPNgR40TPoMQvij
	 L6mYR/+JfA5ZeOMgNNRJqtimOHMUVVGJ903Ub7xirutvu+aC4qfrAJjieHpUIGwRhRM2+
	 zA8wbWIzWN9BYZ7J/4AGu6lSkVPS4LCXnIwy1ptrrDZeDmZdfgoHZXMDEofjWtGEX36gT
	 YMRiqJPUR9WrthOURvwXvd1H2pudP5F/8QTsQNt2YHFqX6JKj0ThyalleoiX0TirYwbwG
	 Icd8G6H0pUd798XJNMTi+nTIvvtVTRE19N3Yz7inBP7v9DsHWyjDp/lbk9MXe0usOSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BFr4/yct";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187896082BCE;
	Tue,  3 Nov 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFr4/yct
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717583;
	b=Vt5vgzOgUidt4JbWaZcCz/clZujxwkPrV1Pad2AhSpMR1CHR8TsaYxtb+9uVaSZaLuMX
	 6iMC9HhMm3o9qLx5eooot4EPsBja3ko5RmldowBx4iu0ufy9r7WO7nOZLf09j3YrMljIa
	 KdnfyV266mEe68uhICVg9lzmQ1WSOapEkkrKFq19psgrv4tATUtgZYFqJU2HDxEZkyQiA
	 GAjmgJQqqxoggiIdFzLw/gy8b6CjHG1GPUNhxg37XAoUFFdmrhMLsUST2zagShHmrzgqR
	 B4CrX8yJjMQjKXLD8Gk9Ctnio11RLDUudWP70n8YT+nrua1MHhcajW58R9f2M3lukSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717583;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XeYeuHW2ROs8z63PamAF7/Z5t0LYjZHf+QlIp4GkasQ=;
	b=o0wbu55c4SUcyxpcE7ct9t7wcXv0gpJTbkOfVYjoTkehYHTynYqS20zwtY3iAyexKQbe
	 4xrTHWzBxzGgz4n9Tmq6XumF4bXsJI1V7e8+rLYFlVkMnkq8t2pWNr6Q5XkpW/Prc5EZU
	 N53rZKZXo/kR03d43y9+AkeLGBIAzBhkRcDzWSMvIaWs+TNz4TtjvNYd/V+U8vxQ6qxky
	 Nx6JCoCNJtlWwVM02MlBGqM1pP7V1X4vbP1ZirhE4G24mUecAAv1jZQBqDhKhKw6/A/MI
	 0jfTEBwHa+/rWCLQOslt0PEq02IlLxEpdYIfBj8yn+FgELm+d+/UuIC7p8EIe+BHTcQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 113EB1F00A16;
	Tue,  3 Nov 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717583;
	bh=XeYeuHW2ROs8z63PamAF7/Z5t0LYjZHf+QlIp4GkasQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BFr4/yctpoHtZ12wpGwpayWjRRgrj4USciE8hO7ox3a5l3aydG4DoBrrslFYg/u2J
	 OgiLnnqP9+BkoyPwpl2whZJnl6t9aEEye/ykPGv2gXUmhsHHdOw0tmb3uYZvs+i/6r
	 OQKjQcKj4njHVP+1OLc0I3eUEHtqNJrJb9qHIBWPyQDrQmZlS/+WXn5a6hLhVnpo2d
	 hUjivjEDdc5o13Wu7yb6NVQI50ZZXRrXT67lUcQyQJCtgJ4FWk3bxp4ps8LHK0yc2K
	 USe7KM1iST9iXxlHnHvZd11JCKITfJrmYAjOFHha4rieKrN/9yNzGLYQaFpNAQmk13
	 rD/TZcQ6YOKHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 929C4469AE;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:53:01 -0300
Subject: [PATCH v3 05/10] iio: frequency: ad9910: move channel indexes into
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
Message-Id: <20261103-ad9910-backend-support-v3-5-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=4373;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=x6NMO+HwBMwaNr1Y6ukLdwzGO76H8amSFklxVgJRt5o=;
 b=6GQANRHDSKSzRVRY5K9fM4xK3ktmpmUSy4CUtWNCgAgI+YBCd2CQ6cFc/7li9GDOiNgt8h0KJ
 fqsB1vQ55I/CgsVaqpFuI1kfvqO2Ij93Xf/I1HxmJtmt3QndcNlhaT3
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


