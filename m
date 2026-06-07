Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717633C18E
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875923; cv=none; b=SK4U2bZPQ956NWsQRMrAJxHuw46UZTh2Pqe+CyyyjmgBR7BkoBvtKjY3BsuBSqByBjtJZCWR9IHoM/kO/kzKLuo/k766gR+2O02j0OWqBUm2VblcnxlxfoWB+BvpqgGGGr1b0QgL1O7crXE0uSwqMNnWRAPGDuE64RffN35pnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875923; c=relaxed/simple;
	bh=J+az5RicRenEneEDG27NK4Kvad9Qms6Iox6ODxzmpTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPpFQK8iuOYKw5yFoc+6lOoa5Zgd4Plt8xM8dtZD7X/C6/ddWEZbb5tSLns3dZoH6KagRVnlhIG/7z+Fbl9D/oal4ZhCrZLIhzeEviY1/9eV5XnujcaerMn1NL8/xB+IF9XrozgbBb88KaRLPeWRdTIp8n/sJlexCnIY0ese1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3LDUBy+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3LDUBy+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422524cb38so1130399b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780875921; x=1781480721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Moxyp6VJ7Jh2y4csvP0jcOZ0gGOtSLLwcv7kOefBRHI=;
        b=I3LDUBy+dwT5F4MV21F4/qE3Up91ZVyXpULmZ9tYyLoabjXA0hR9xHhQbv3Wt9jk3f
         97r8eP4h1e3KWIZbhLqmiYBicIKA89kbMEyVT7miwXqQh3guAxyWWS6KgW3lsriPoMS6
         yMErxXb0IgNL06qo5zIALfl1mOPoxflsmqq3XKBrNLLQHEJtCY2Vqtkcx26WzK2phKII
         3TUtNj/iAYttvecv6Ufm4RRlzztkISzsgcB6RID1ngXHhk9shh0SbU2kcDDSAyoVjq8F
         MDLlIMouS0Nw3ZYeTD8PT7P6Ccl9zqZ8NdJ9GhWHCA20Fx4lM8b5D772ua26jVduWWDq
         i2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780875921; x=1781480721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Moxyp6VJ7Jh2y4csvP0jcOZ0gGOtSLLwcv7kOefBRHI=;
        b=SnyVBagajZdHaQJgg77jFOqe1m0qtoj/ymkNuIo1CD/Yvt1UVwY8K5g5/WFytuqH6Z
         mRFlnIwZ8CXYXmjtDoCCoiWSnWUyUdYf7GKZFslwzHxaegJwy4byL11mbQs0d4VaPgfA
         WsjgnC89QNdIPtsvo61WcfcPEnR/ErQiYgbupEDA1jVyhxuAMhbzLEQm7AiLSahhPagi
         Lh4A5/XfXe7prqRiJlrPuDpVnaEWJVbzYvDDhvqVOeeze6StCRPu9NJDRJiRV3jejXzS
         Ei7J7kx2moixQwzVp2ZEj/ZFWgbe6b3tvaxomkLmpiV4uqds4VBaPJLbWtWbBOn1eSLk
         a59w==
X-Forwarded-Encrypted: i=1; AFNElJ+z9VmCRn72Yy2uJJEXoFt4Fm6gANS2o2umKgM3nbbzD6fveOKTyBVma/VY13p4lnAX+Zi5L5gdf1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv49A6wTH2nzo3tqZ+jSe5DQBgUv/UQyb/wt6ZGcOq2/Z3M9Ad
	dJnDFBHIGLPzUZJQ/bZbrbi1Bex3sL8jk44ZOSG2JBqKCLcvDKvk7NeX
X-Gm-Gg: Acq92OEtHtojh5/m2+3zRx07JJaInxa0fUdYAOk9kc10an+NtRCA/6abvxuvQwrzC2A
	TJkfybShG5lwIcGIo6MCeB9B4WN/RxZFaC5bt3+r9UZKRX1ThU2Hztl2XGImy56H7kAmlnhsfMb
	DvAH5vypJHegdV7PIh4e0PP/faWYRTNgKyYTEl8crYzdcQvxh0nwgHklc6n1pncxGC08EH/xA/1
	4zlXlV32g62wZ+Tg1B6uiVeEhGizP0Zr5fqHIIIpsSUrscE+TT3LrV1glYoCzn3PkIHOda/tD+j
	vKtV6UKAl6/iuapXnS+9JxMB4VBXnHQMb+lscWxGABzVDM0O8QeDWYOLIJ3Ah5CAsxjGx1ehowD
	+6kZgHe4q9kESuS3eFrLpqEBkSzz3ItJlHxadIaJzFfLMEZBr52vu2gLXfKqKc1t7g91PCiGJ6t
	RPq0oa2fIEus5/+P0kubqRkctPA6KyF5H+6WQWJsYAJkeIqWTJvvuKZpFwZzaqXIC2A7d1Bj6Fs
	OIlMtvEvDl+J1f1jjXoujxFS6VjPxe0rn0f3+M2FKvq7Kgh
X-Received: by 2002:a05:6a00:4390:b0:842:6a3b:60ea with SMTP id d2e1a72fcca58-842b0fbbb03mr13296464b3a.40.1780875921415;
        Sun, 07 Jun 2026 16:45:21 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm19257732b3a.44.2026.06.07.16.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 16:45:21 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH RFC v4 3/6] iio: osf: add protocol decoding
Date: Mon,  8 Jun 2026 08:43:40 +0900
Message-ID: <20260607234343.22109-4-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607234343.22109-1-kimjinseob88@gmail.com>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a FourCC-style wire magic comparison.

Document signed little-endian sample handling.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/osf_protocol.c | 4 +++-
 drivers/iio/opensensorfusion/osf_protocol.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/opensensorfusion/osf_protocol.c
index ed91d3dd5..5bee545f3 100644
--- a/drivers/iio/opensensorfusion/osf_protocol.c
+++ b/drivers/iio/opensensorfusion/osf_protocol.c
@@ -11,6 +11,7 @@
 
 #define OSF_CRC32_INIT		GENMASK(31, 0)
 #define OSF_CRC32_XOROUT	GENMASK(31, 0)
+#define OSF_FRAME_MAGIC		0x3046534f /* "OSF0" little-endian */
 
 static bool osf_sensor_type_valid(u16 sensor_type)
 {
@@ -38,7 +39,7 @@ int osf_protocol_decode_frame(const u8 *buf, size_t len,
 	if (len < OSF_FRAME_MIN_LEN)
 		return -EMSGSIZE;
 
-	if (buf[0] != 'O' || buf[1] != 'S' || buf[2] != 'F' || buf[3] != '0')
+	if (get_unaligned_le32(buf) != OSF_FRAME_MAGIC)
 		return -EPROTO;
 
 	major = buf[4];
@@ -136,6 +137,7 @@ int osf_protocol_sensor_sample_value(const struct osf_sensor_sample *sample,
 	if (index >= sample->channel_count)
 		return -ERANGE;
 
+	/* Samples are little-endian two's-complement signed values. */
 	*value = (s32)get_unaligned_le32(sample->samples + index * sizeof(s32));
 
 	return 0;
diff --git a/drivers/iio/opensensorfusion/osf_protocol.h b/drivers/iio/opensensorfusion/osf_protocol.h
index 4b6fb131a..c62c2c254 100644
--- a/drivers/iio/opensensorfusion/osf_protocol.h
+++ b/drivers/iio/opensensorfusion/osf_protocol.h
@@ -2,6 +2,7 @@
 #ifndef _OSF_PROTOCOL_H
 #define _OSF_PROTOCOL_H
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #define OSF_PROTOCOL_MAJOR		0
@@ -14,7 +15,7 @@
 #define OSF_DEVICE_STATUS_LEN		20
 #define OSF_CAP_REPORT_BASE_LEN		4
 #define OSF_CAP_SENSOR_ENTRY_LEN		20
-#define OSF_CAPABILITY_FLAGS_MASK	0x00000003U
+#define OSF_CAPABILITY_FLAGS_MASK	GENMASK(1, 0)
 
 enum osf_message_type {
 	OSF_MSG_SENSOR_SAMPLE		= 0x0001,
@@ -44,6 +45,7 @@ struct osf_frame {
 	u64 sequence;
 	u64 timestamp_us;
 	u32 flags;
+	/* payload points into the caller-owned frame buffer. */
 	const u8 *payload;
 	u32 crc;
 };
-- 
2.43.0

