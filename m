Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792864918;
	b=vsUt2LHRG6zo+8vw+pL8rYnZOYHSHx5x3Qy+HLxLHaSX4dE4lXUFOLb/y6QO0cgyWgMl
	 qwSKDGIFDoLT31zm2iRcJBdIcxnQh1WmcH0MIaNqyf8N6wBlh/GomixcBXDrSUHWu9SdQ
	 9yxEKpmWqK8L/D/kuGSu+LJS5J7kVLIJBFXEylIpQtOZ00tvhOP+BdmH+P7fnp7qwGbqX
	 A35QML3YVxYN85tMAlwj2z0rmWgeIrdARKA40GABM3bKAhes8R5m3qMLOBJjEhaBT3V+Z
	 TYUAWciTmSDVar/mvoHHyLLCnjRfIo9fOMdlHpZ4NYqarbqbK0s9G0c5E2PhTtTp2ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aucSs4M6EypPpZv9kMX/hXOBtI8X6mI9msD95/jWcCY=;
	b=IP/wC3SWe5oi4DD1/n0hzaYPeRa9iEJCRn5593qAlyBD3SPXEe0+lrcCK/jN5/4K+dY2
	 a5R63Zx6AHAbkJcQrfKglT0I7IgDpqRFSRIxdtg2PQlkJkRBHL6bq2R3jmrvYTkSgAY9I
	 mxjE4GH4b7EM13i0czApUmM+QwCvU0oPk0X//f8bVh/hiR5L6/xojSzCKwZf/ufBpuWN9
	 Ft+kwslW6kgGpQcuLktL6dfBTASMNcYnOQHzYh16LHO2Q99LHTvy4OMXnkplwqxUZNnJo
	 l7nat+HCPMM3uxxT0xUlOS6D04w3Z+iUvhK5V1gkuenQdXbwebmuYdNfeSEmhHjPxVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZUbm0Chs;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171D606A31B
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 18:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7171D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZUbm0Chs
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so2770550eec.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792864917; x=1793469717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aucSs4M6EypPpZv9kMX/hXOBtI8X6mI9msD95/jWcCY=;
        b=ZUbm0Chs9sK2DY6EH08oe+6eNZ3kcAtRBPWIzGjviXzO0r8qmh8K4NTeUTSymShQgq
         zyGAqD4jHQMcj91d7okNW/6RcRHyaDWtYddKANjJhWIoeLczeWn20K2XpO5etx2WD9Hp
         8776r/rEG+tXnTRXxLQ4+DPvDUxbWtUpZCTjWFcNIgWkd1XUY+r9VRV81AQVFTAMOzEH
         Q5L63h3wdBKTEOG8gQgaXN3x5x7/GSgzw2Nyds5pasRnMrB6Ndqj8EtKumPo6xiHHb+U
         AtJIwYrd3CZ5p/Pk+jJ1qn0E/Geq4Ags6JSx6gTc6PA5zoBo+uVlnxZ+z3KlOA78T/oX
         lI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792864917; x=1793469717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aucSs4M6EypPpZv9kMX/hXOBtI8X6mI9msD95/jWcCY=;
        b=SLlBGmeKkTz6yaztcrld+dKK6hAk+iDKh9cUcBaom3stttmYEShZcgOudnuszG84j4
         UAZD2bzqk2avufnil3lh9q4tfBSUEqMS6ce3w//K0phZ5yadCUSFTiExcp6kCKmoZsoR
         Xpjx/S679l54iSstInoM2ogWmw/imdaYFMnkwgHZtwm1ogWya2GqaduHaDuaIdDW+uTL
         zX1+uKTrIWVPpKHCDnJ5QNHurvfDog+PLN9i/W0CmtLe2tesq2+idANX7k8eOPAbS2WO
         JH6y1+T5rHoTRl+CO7ezFlEgDnbnh4Tlxam6b4UCdadmT+EAcmx4x0IfF9MeghvN+j11
         HzBA==
X-Forwarded-Encrypted: i=1; AKwUvByMfKElMbOY1kV5OdDWYgOShN+JDRBZbqocJnhBZGdecm0TwCFI0UJjXXsKPlxrHReCeVFIG0uqSdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBlnyN+tLzO60cDNZYdfVwY3WM2QqwqPkY+JYDy4TJgVu8cCvO
	oTTxD17FpdLJr+bz82XDuySB2hPwCDOZE5H06oo1PpPvbDTHtUq191jB
X-Gm-Gg: AYBFou18Az0VU/t8I8JOl7uvBFTm1mWH1ewUkiSMplBXVdBBxG+twAQxxc3CwkxXLA1
	DHg7wdOB6vVdpvjkHg7yAqnEOBnv2f1We5xQdPqjfAUqooxiF4POKn7o1Bi3PH9JVkTHHA0fTxI
	GN8fH+4oNoaLaf1GyGfv9SfVyZ2kyDHxM+IMj8RQKLUksEasA/yOw2uC++NWIlMqCCRvaK06Uwf
	N6kfcsrsN+HLD2jI3cgXnVA+E6SKrS8oO45iCZgKlim3So+jTevPuovklmNb82tZd4u4DfEOGaR
	RNFnpXzLODRZNSK84uSuebPA2H7ijbMGcMFUrz5jg24jEYQjfhdZ5/vCmx3yelOCweDJTCT7b5P
	XFRP/h/e5oN//EjqMJg0UGpv81KWn29Kg8bJk7LGCcfZpVUC8PQJUkHuPbh4OEmWIZhO5myt+w8
	IG1p5hsaXjCq05I1/jOuF3CB7DNO68+9Lzv94MUZIET3sZaMzxRMvPQpPpTddkec/HPQ137gFwL
	H6gq+BrQmXfcNeL+KGfECn9VKzp1UYLmceFXQPBRaygn0hAr19dy+iaox0D9UD0gcB0C1CH7T9t
	TeIQsbm7Ecl67Ar89rX5+uZCbGOEXDlv6JQkS/8/fozZEGXuIOs8f9CvcNaGhtlV0gfhVcibO0C
	yWOoyf3P/hMM=
X-Received: by 2002:a05:7301:5501:b0:367:68c:860d with SMTP id 5a478bee46e88-369e84a5128mr3927448eec.29.1792864917278;
        Sat, 24 Oct 2026 11:01:57 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm9065191eec.20.2026.10.24.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:01:56 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Sat, 24 Oct 2026 23:31:43 +0530
Message-ID: <20261024180149.144609-1-kapoorarnav43@gmail.com>
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

GNRL_CTRL1/2 hold the scan period in units of 8192 / FOSC, but
sx9360_set_samp_freq() computes freq * 8192 / FOSC and mis-scales val2,
which is in micro units. Any integer frequency then programs a period
of 0, and fractional parts above ~0.26 Hz overflow the int, writing
0x10 to GNRL_CTRL1 outside the SCANPERIOD field.

Compute FOSC / (freq * 8192), rounded to the closest value, and reject
frequencies outside the 1..2047 period range.

The available range doesn't match the limits in the comments next to it
either: 4 MHz / 8192 is 488.28125 Hz, not 448.28125 Hz,
4 MHz / (8192 * 2047) is 0.238535 Hz, and (max - min) / 2047 is
0.238419 Hz. Use those values.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Compile-tested only (W=1); I don't have SX9360 hardware. I round-tripped
the new conversion through the existing read formula in userspace, e.g.
9.765625 Hz -> period 50 (the 102 ms default) -> 9.765625 Hz.

 drivers/iio/proximity/sx9360.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index ed83d809ecf5..d076de19b9e7 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -14,10 +14,12 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 
@@ -43,6 +45,7 @@
 #define SX9360_REG_GNRL_CTRL1_SCANPERIOD_MASK GENMASK(2, 0)
 #define SX9360_REG_GNRL_CTRL2		0x12
 #define SX9360_REG_GNRL_CTRL2_PERIOD_102MS	0x32
+#define SX9360_REG_GNRL_SCANPERIOD_MAX		GENMASK(10, 0)
 #define SX9360_REG_GNRL_REG_2_PERIOD_MS(_r)	\
 	(((_r) * 8192) / (SX9360_FOSC_HZ / 1000))
 #define SX9360_REG_GNRL_FREQ_2_REG(_f)  (((_f) * 8192) / SX9360_FOSC_HZ)
@@ -182,9 +185,9 @@ static const struct {
 	int val;
 	int val2;
 } sx9360_samp_freq_interval[] = {
-	{ 0, 281250 },  /* 4MHz / (8192 * 2047) */
-	{ 0, 281250 },
-	{ 448, 281250 },  /* 4MHz / 8192 */
+	{ 0, 238535 },  /* 4MHz / (8192 * 2047) */
+	{ 0, 238419 },
+	{ 488, 281250 },  /* 4MHz / 8192 */
 };
 
 static const struct regmap_range sx9360_writable_reg_ranges[] = {
@@ -383,11 +386,24 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
 static int sx9360_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int reg;
+	unsigned int period;
+	u64 freq_uhz;
 	__be16 buf;
 
-	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
-	buf = cpu_to_be16(reg);
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	freq_uhz = (u64)val * MICRO + val2;
+	if (!freq_uhz)
+		return -EINVAL;
+
+	/* The register holds the scan period, in units of 8192 / FOSC. */
+	period = DIV64_U64_ROUND_CLOSEST((u64)SX9360_FOSC_HZ * MICRO,
+					 freq_uhz * 8192);
+	if (!period || period > SX9360_REG_GNRL_SCANPERIOD_MAX)
+		return -EINVAL;
+
+	buf = cpu_to_be16(period);
 	guard(mutex)(&data->mutex);
 
 	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

