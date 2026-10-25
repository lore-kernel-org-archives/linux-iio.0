Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966372;
	b=ltjoy2pC7xgSrxxKzTq25h9B0AftCvYVv4Ml30AHbV8Y5Av6iTamfis0IPGVUhbtTwCB
	 xVIcxJd1uyVueaAvTkF5Q8mWxO4nSrIU2dx8beMmKkyxvGacYLb2KxhIpYsWwe1GM5wLU
	 p+QUbLtVKr4L4ckeNXW5YoS4ZLoJLdN16a3efhengnXlVt9F26tfQgMvc4wOehD9znQCL
	 NWSpn+nLGya9UIoshiCVa821CrpKLyntuSgjZbS79CF8errDm7BDvnMLtzgXjGaW8e0Vp
	 gMOmv3P3+a/FNauu2rXhjkln40pmdkpVdtLPvNozh2JvWAoDeqhzfQhv6jSxjJRux0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8qE5yHTBSvCqq9ep0eRR6fh7pY27XkCysxDq9OCORyA=;
	b=2MGQvRkLGLanyaBQYzQDHzX/QI8mB6d9tkv8Mw0JyYltOIVULnvERDA+tbqmiBlMkAQ4
	 HxOx+XuXhcERyMedAHzGYllKIRGMkmTtjxAkTIZ4MxrhL3wH0IjoDFC0+e8lwWCMOtgZo
	 QY4n/D34LQTH2FjRRUJq089UAtHxcKwUMf1KPzrz1PfI55IcyQxCTi3Fh3JVoTAx/q3QU
	 HmbFOhiYQtBzrrMHT+hTFT6xDHhvp0e7Z1tUXBOAUtw9vFEP+ELk7ozoGAQoVVg7e+yyK
	 n6qIkLo1Svy5X2CXnU3Fa7QoLyCjUdRLbea3aQ/kspElm0Hbbv/6ELs93u+sr7D97Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eEFRLhzb;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AE606A31B
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 22:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3AE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eEFRLhzb
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3550c917fd3so3658706eec.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792966371; x=1793571171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qE5yHTBSvCqq9ep0eRR6fh7pY27XkCysxDq9OCORyA=;
        b=eEFRLhzbc7gMz7bX05skDFKPkhF9qncMCXVts+Wc+K5PxFQnElI6DtyZuKddt8qE+O
         WjtB4knNGDdEKJ4zEFSY+O1FYJiWAGjDSrdZbeHQjNU+IjNCGaw2Uq02d5y3lbjZZNry
         c9I90PmWGonztfN122vZ+P8GQET8vlkLO7VFBWjnPr/Y+8yTgRdO5cMC/Nm/poGtPa7S
         AqxtVM7x3vtIAt5h/Ved8AegC6RwI+a8dETIY+VCZarLjXFWjSb16HOvYeRJx9sEfdtQ
         UNHk6JC7PDPon56slL8cq0/cEv/bAPTzTxUDA+JCHEbIuvjR2DZir3cbPZA0YnJdSDRw
         ggnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792966371; x=1793571171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qE5yHTBSvCqq9ep0eRR6fh7pY27XkCysxDq9OCORyA=;
        b=DVmdntdgZeOrJCGqyp97Lm4EsN2T4n/b79J2hJ70u5IuR0snuIM4Mn3Nygl32BF0xM
         hfYOy3UBLnPIsiaqNg4ydPXV3uPOi8QxPQx92PMyEXzuONoaxNgykEGVE7s2v31jnT9N
         vdp+W9S6qwiBhZBvyuj9kaOa/oI1Vh94Tr3kP5rDWMGPBMTIsLndl/M4UpUkyDo/loxq
         aLkCAmluqLTZVHGI+VY3y7ioUxCSV5EGzYs/NacyR4uU9A0A/VWLcP7zij3SxJPRbPSu
         WdnOYP39k4ZyG0ndEr172oGR0QltGb1oP5OZxDqo/3fVKsot8W29yzzwioltSW00dBhs
         PLqw==
X-Forwarded-Encrypted: i=1; AKwUvByLKEp0o7MRrIYAYMCJhhsz8b9z+lHrj8n3jr78IjXoxnnE2uMMVO1tS2ZCVLOFWeu51NK871wiUKw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5yDZAs3FpAekdSPsv4RSCsCFklSVkRDC0Cx3yk/Twc1vsOYUJ
	i/EFBWRWRtH9HpVrbmx8rW1Bcd296olTP1ggJrJ9PM+YKfIGFNaCxEP0
X-Gm-Gg: AYBFou3ZFlr0y0FwjCsjYM2aoq+51I2PfY5K7NFABBEJP0ElpCTO/YwUAR9p4yOvAx2
	nYHVeXKDccyJgIGorg9sBH48YqINZANdxGDYFjWOo1IpaYu+jLeCqPNLoUvsIHpdbrsDRPwEF3Y
	6Zr19mbbnPRYqA49I5Vo22bxivU6ACeNbUmdAFSemDQoyFK7iIWxa8CEolrFeog1Uw7AIUcZ7j5
	3btIc8Yss7d6fe0XnjusF3zyo375LqwPzLzUu0V6xf0F4cwjqkYaH7Fgvv9bbSlwiOn/KqhiUMt
	Bkv4uZoQJVaQI/peoTkZQ/tThe8Wd3mv6keu8qOlN634psAhc7o5EydmWgDJG5sBM/cDUifyTX0
	rZTKxeYh2xZz2X71zEM1NYRd2+avczxpSF174tz9HGMXNtznk80X/hW5yiQD9b28pT8mXJ487IP
	aS+yjULAoVFxhHzWEoBrtAXrzf/Ya6pR4sVTdz60lCjqyhaLfcAPjEPqIh1M6adBpFmeyRKE01X
	EPDTXViMEyZLl3cJN1vYr+ivVK8iLlCrjlvUrFoGtjDof85d63ezrLpC05VsU/ho3/oBIlC6LLT
	PnFPnN9TdVpU/7jUQSL09DzQM+bA+qWLeWxlhGTfOhwA5vlv0JX+8s5X2DsWwp8IjhrXJIAGJsX
	WceH31jd7ccI=
X-Received: by 2002:a05:693c:87d9:20b0:369:987f:d15e with SMTP id 5a478bee46e88-369e8336389mr8021940eec.2.1792966371114;
        Sun, 25 Oct 2026 15:12:51 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f27d5bf8sm16525779eec.4.2026.10.25.15.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:12:50 -0700 (PDT)
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
Subject: [PATCH v2] iio: proximity: sx9360: fix sampling frequency write and available range
Date: Mon, 26 Oct 2026 03:42:38 +0530
Message-ID: <20261025221241.19596-1-kapoorarnav43@gmail.com>
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
Changes in v2:
- Rename period to period_ticks and say in the comment what a tick is (Andy)
- Rename freq_uhz to freq_uHz and use MICROHZ_PER_HZ instead of MICRO (Andy)
- Add a blank line before guard() (Andy)

Converting sx9360_samp_freq_interval[] to a plain int array is left for
a separate cleanup.

Compile-tested only (W=1); I don't have SX9360 hardware.

v1: https://lore.kernel.org/all/20261024180149.144609-1-kapoorarnav43@gmail.com/

 drivers/iio/proximity/sx9360.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index ed83d809ecf5..2a9b37df8f62 100644
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
@@ -383,11 +386,25 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
 static int sx9360_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int reg;
+	unsigned int period_ticks;
+	u64 freq_uHz;
 	__be16 buf;
 
-	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
-	buf = cpu_to_be16(reg);
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	freq_uHz = (u64)val * MICROHZ_PER_HZ + val2;
+	if (!freq_uHz)
+		return -EINVAL;
+
+	/* The register holds the scan period in ticks of 8192 FOSC cycles. */
+	period_ticks = DIV64_U64_ROUND_CLOSEST((u64)SX9360_FOSC_HZ * MICROHZ_PER_HZ,
+					       freq_uHz * 8192);
+	if (!period_ticks || period_ticks > SX9360_REG_GNRL_SCANPERIOD_MAX)
+		return -EINVAL;
+
+	buf = cpu_to_be16(period_ticks);
+
 	guard(mutex)(&data->mutex);
 
 	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

