Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847204;
	b=rjL3EgXklJhm70BpN/Q51RfnHmOl+FrO/jK2T9hUYmWJoIhaB1cij3EQzqxlCKEszBiS
	 4b2LF6PQ8CrBsSJjEp/N8Szd2tWEpcVqSHDeakMQgSrO3NDX8JGCrmfxkx0o9u7eeX1t5
	 tKiAyK9dvqzamBfrc2Va49WfnSM3FPlIgvxLEgxmkj1IOC/5Xqu4Pan+pblJzV2xMzIM+
	 ZYar8h89Utrmyi0OlSOZ8Aiq94XL7yTgpfCEqxKGwWPH6V4SjbRv6OH0z5mbqYCapSsHN
	 rsckhGN3HOiDgjdim/UmIzIWyPPw+FsPWWSt+0l2Z29BsqwT1K6YgLIiMXopXjwN0iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847204;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JMuSK9vIkostDBT0cs+TacIUX94JC4n4lqp0jJmQdKc=;
	b=MD4/NrL3i36DBB+Q38f6REiyi3yox0j7Xm38YdQ4ZQiJrivRxPzD7OyptRMp1sWqSPrx
	 XxSf9394Wk1fpsn9J3/WFi33sARTicQw4RsnuqepcueuWxO6Wk8TSnu59edm/3R8UtrTH
	 KsLi4Fe9aM4jrxl5q/ClyeX3I5sNhIiM32iC3x8lA0R173mZt7m4pzQhMX8BIuq/UZc+E
	 rT+Z7XdHvZCoKbj1IyZZJ0eNg9E/jHuyzsWzO2yyTlyYdAeAd43W0Y8LxI0XnFx7rp/Fx
	 4V5f0VTpM5dmXEGYc1uf9ebUSu5a/KaGbbJBGzvtGwGE5VmSNpWzT+vjTCCDMGU/kZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQNIFQIP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EC606A888;
	Mon, 16 Nov 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQNIFQIP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847203;
	b=P5ym79efaDkNHtDjRA1GrlDwmxOxSh0I0evNOxXtKdAo3xtR3sUIL2gGbT8ws8CBlhy2
	 ZKo/+4m2wdU21kmAauHBb4prZSygDt3fp/yuBnPXFSdnsFEcFT3xCAq3yfX05HcjLZ4hw
	 gMGT79xYs3vWjd5iQU6F/RfyrYAAk98N7X4DoOlH2nDpXigv6FjSzNcjV6i0iINodq45P
	 SohYCOubQUeiADSNjBYvJTNQzF/FuWTW74vMQ8flcvXcmvU4kO8J/Spf1lvYuairPAdS/
	 HthFPf36dZvI3d3W0JhqAEz+vUi8Hn9TMDval6J1ixfkL9R8eTu8VvC355X6LcFOW6g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847203;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JMuSK9vIkostDBT0cs+TacIUX94JC4n4lqp0jJmQdKc=;
	b=gUnSghi+ko3nIuWvpf1mAHQHd6JgOQhCVQOgXz07yRkB57LCJzpoRP1waVdpVpkv4bfZ
	 w5DE5QNcR2QlmGGKFXe1RlPJzLJ7kkz2MWK8HBArXyTBfWeh8aaZ4/fVfwsTLz7UETdRI
	 ER7jqvsOIJILcRtP4wEWigJl2NJjDv21xa3z79N3S+pP2vB2nMybKpqAc6qGLPT0pXDov
	 cnPpBk605RDvJMOsBMlfS9ORCPx99/LzZMVpSGP2HwJki+nSA7pEUTLa+wGqo42eJ/7/4
	 ychx0IWQd6yZB0lYfmoaW+AEKdCc2lmLX4DcYXQun/OgTyEJl7IuhIRlCdomiFuTd2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0DE8A1F000D3;
	Mon, 16 Nov 2026 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847203;
	bh=JMuSK9vIkostDBT0cs+TacIUX94JC4n4lqp0jJmQdKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IQNIFQIPIMYQ5hRsynr4yxPK0Kmy8c20bSdnd/TOsZ6m2fdMoTZ5n3/XnVuOuy8oC
	 8lBw9dK6Hmh7mBs9/O96Y1vuD1QTByA0pDMOW73VL+6ZGTQuuXjh1cNvn4qdmdfybl
	 1AThzkJRejISsXyjt+NRlR989QHdiGgtE9w8CyW6+vrr1+ka4E9HNPgA8stHkGyIfI
	 m3Ji4IZoMefW4STePIQJEHwggtbH6fyTS5ORL2kvXqpktY3BDOSxb8sweS/6LJNcZU
	 z4n+rUFW5AAiyQXe3Swg4IeXJXEAFAN7kYyfoOd0Ec49AqtFzNDHf8D6JV1JM5Sddi
	 hqkya7cQIkLcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 52ED74A532;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:39:59 +0000
Subject: [PATCH v4 07/12] iio: frequency: ad9910: move channel indexes into
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
Message-Id: <20261116-ad9910-backend-support-v4-7-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=4373;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=KXNvuS4ACswYjgu4ZLwpEWx56ptI1TUB+mqifMwO6XQ=;
 b=VYsztz8GnEwt+qs4x7tPCwiLkCLUH3OFTDK/TqC/P0K2ptoDhIjENKrzBADV3q8jy7g434CMr
 E1gWZvcIj+sDRJzXUQmgV9sQhKqAeJSmnwBAGbme2lZME2xGYOft2NB
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
index 1913532d96b3..dd6b512f9687 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1778,6 +1778,7 @@ F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backend.yaml
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
 F:	Documentation/iio/ad9910.rst
 F:	drivers/iio/frequency/ad9910.c
+F:	drivers/iio/frequency/ad9910.h
 
 ANALOG DEVICES INC MAX22007 DRIVER
 M:	Janani Sunil <janani.sunil@analog.com>
diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 680415b37b0d..d30ebdc0e0b0 100644
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


