Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050625;
	b=QZFVXV3I8eG9sQKErY+iXAlbaBdum1KRtLoRUrsxzCAveBR2fxclsSpvhUii2vIn5WeA
	 bfc3gWvHkR4YQq2+Z2gwjRf8OxxShog2OdJveMBRaddamek6dh5D4oftloS0sF2q9D59J
	 KBkZGBsqUWiU3kOnKCojJ9N6kxLBkFqSMYTT1LKq+1KMg8ag/EVX2+4H1caDlrnfFIdo+
	 oQWKTrXNILmJSwK5J8LrAACHyGD14BqUVgnCWRFJ11YEmGV5DFnfFdjCQAeJ3FErwx+7E
	 dzkG6mBoOSpXLiIc/L+PRXoEmwBCD/gb59w8wXxEB8HT+gFqqXIVMwUGDyiVtmMTWAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/0W/4lKj/J2zPqNBQg91EquUaRPlk97qFci9V9oBx8w=;
	b=acyAPcGUhxhTsYqZlpA5uUiavFwsV79g5uj9kfsR37NfaqjqFQrMrycuKsb1hPdTgwP9
	 lC6/howI1I6FbMJbAKsfI1Dni44Oscm0zOm/5s6aA8IV39N53AyJL71pVgtJgjAzqme1K
	 Cm2pOrCA6Z8dq9SZG50ZbZBaRckiVe8P/eRPyk7MDqBujf8OTZIdko+36A+KyGRRPZfiw
	 w8F2iArcIrc+QQtoTQA7OfujeyOrXVWgBVhEaNB/kC35gUcgJWcqe9WS3AMFCdbaa7LlJ
	 aFLo8fDZ/06RhU22cP0MOi3RXiwc8ybYGK9GyVpprbsHyQo6Q1P5Ync2z0nQzikNNBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0227+Lls;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74B606A326
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 11:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F74B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0227+Lls
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2426140eec.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794050624; x=1794655424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0W/4lKj/J2zPqNBQg91EquUaRPlk97qFci9V9oBx8w=;
        b=0227+LlsxOvzIpnh/Gcj+C4MzzH5637G9DBK0EEXHrRCto+SHrej+3Z+yiD2BmZo67
         kfUFDXZJr940wHsohlF0FvmvEJzw5OkAGxx68hTOQMbNtd7x/ieumm079A9aF8KZaP6X
         Qd4ZoH3PWfFzOE+9XTo7hPFEiNVesXhzVFlSVnNpI4+XLbD1hgn9J6uyBQbtpkTanUL3
         HqiGKyPpYvYhWQ0xhsB3nRknJTSq1Kd+M1vzlpkNB5f6A2lICFK0txGLbCd2p2rQciRD
         Ut+7hTEf1NOWMEra/a5V7UJSiNXNUV9RvZN9klbHSG47IR9TIO8Q8YDDyMm+FkqFpR/9
         1j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794050624; x=1794655424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0W/4lKj/J2zPqNBQg91EquUaRPlk97qFci9V9oBx8w=;
        b=FM1stSxHwLBVwapz5eJ0ccL59g2ycz27roy3/0OsxCdp5c8iWRQmX+WjaRt6H4O1QA
         0flDyL2hqfGzrj1yUsGm7gMgVKGCQHEPc3rYRGTYkZ1X+a/DlxwSGFXRU1Ny7XM3FKWe
         N5dIDQJ4OCQeeceL0NsWgKLM+lyrkV0Dpp24EYnNALc/iJ8vSKCWfXBfTOEIKSYmedLt
         Ih+xC1YcYH2wkEG5AXjnnB5Q5B8XCQYmsyfHsByicOwDgsHfWAxhQTFscWIHvuaAoHu/
         A1oMXbPRX3DTGxE43oqDCaxrOyToiEKXGcAfZYwhCEqXUYVoj0CPxLuFkcegtYxwoME5
         ebaA==
X-Forwarded-Encrypted: i=1; AL+hErE1zZ91VkolcLzELF3+j1C8eh3YqreSczKcpMD7/BZBmJBS9c7j8eXH4pcZW4i+t/uFqNjDlsIxWjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8n7btMuvWPxisFWq4McuOCtvcQ/9DCLUKLeHsNLnAdox7W1FtF
	DCsW9ho95MwTMIrdmXq/LX0vjBgYa8uAfEp86fbR7UTzRyCss6NCl3pB
X-Gm-Gg: AYBFou1RJDCaS/ySGUIwmY3CwAJCGhGQeBlbdEVyhBTWKbCjsCOMte/Ky2npOa/uOXz
	AxFdKzyR2x6B9oe11z1i6qxdMpXV2rWytuTOGRwFSbquOFA/UOibIcMdSzydxgshjE4ND3jDFd0
	Gf7c7eohxIk+cZh6qd0vp1JsU4H/9He4esSVpk0C2amsqYnhBz1q/9Gb6OeD4ftsSHqAbi3y6TI
	4z7ZRH9K2xObUSN50cyoVvFMSSUzgwcrvAdlWSSl8I0qfAEBz02Pn0D6chUYdNgubdHoypSeKnk
	52rrvxoUfiVTrVRFgKysZAvPequAZvCAXJvIRH5m+/dTcqbzeTY87EaFWIFOVWyxzEHeZkHdVTU
	yT0lSfcWLtkENv4rLM+DbGBuvd1ZBh6T2/lWDz+7+oAW/1OWj74hS5IvYNS6P3lBXJ7AjNty3B9
	c5PgtPlu9DWyaONXmTOWABMA/VreNNm14oylsZn2qJGTGPjxchhjg/Sok8EnBnU4ifMegTWT92b
	YElPPMQUnQgEC5AqmdE5ZfSuZ5KLqGshe0SEdu5O6AmuUXIyuFp2UeqVOo8dnFqK8UNMsE5TZGg
	xQO8u1hi/x5lbDrCP+t8L3k7LJBIUhoTAfB5gnAB1REk9UJB6gYxbYf2DdTDE4Ex6TSM4+aMj+/
	/XMpUuFWDZMITkc1WoIqeV+5KymMhzxQxZ3R0Z/ULkf7ym91smVSILISmdmtZCPjneppRNM/6Vy
	u7rlMgq2M0oJ0BMdv9eaIrFQrHtXvqB2/Tkb9+CMGsMQ==
X-Received: by 2002:a05:7301:dc2:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-36f76023a6amr7778507eec.22.1794050624010;
        Sat, 07 Nov 2026 03:23:44 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm31210345eec.3.2026.11.07.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:23:43 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [RFC PATCH] iio: proximity: sx9360: fix hardware gain encoding
Date: Sat,  7 Nov 2026 16:53:34 +0530
Message-ID: <20261107112335.444813-1-kapoorarnav43@gmail.com>
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

The sx9360 PROX_CTRL0 gain handling was copied from the original sx9324
driver and has the same bugs that commit 108e4d4de2b5
("iio:proximity:sx9324: Fix hardware gain read/write") fixed there:

  - The gain field holds ilog2(<gain>) + 1, with 0 reserved, so a gain
    of 1 is 0x1 and a gain of 8 is 0x4. read_gain() and write_gain()
    use ilog2(<gain>) instead, so every gain is off by one: writing 1
    programs the reserved code 0 and writing 8 programs a gain of 4.
  - SX9360_REG_PROX_CTRL0_GAIN_1 is 0x80, which sets the reserved bit 7
    and leaves the gain field at the reserved code 0, instead of
    0x1 << 3.

Use the same encoding as sx9324: add one when writing, subtract one when
reading, return -EINVAL for the reserved and out-of-range codes, and
build the default with FIELD_PREP_CONST(). Use BIT() for the read value,
as Andy suggested for the same code in 2022.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
RFC because I don't have the SX9360 datasheet. The only public copy I
found (the one linked at the top of sx9360.c) is a short excerpt of the
SX9324 datasheet without the register map, so this follows the sx9324
fix by analogy: the sx9360 gain code is a copy of the pre-fix sx9324
code, with the same mask, the same 0x80 default and the same missing +1.
Gwendal, Stephen: could you confirm that SX9360 PROX_CTRL0 uses the same
gain encoding as SX9324 (bits 5:3, ilog2(gain) + 1, 0 reserved, bit 7
reserved)?

Xiaohui Zhang posted the same change in June 2022 ("iio:proximity:sx9360:
Fix hardware gain read/write"); it had build errors and a dead-code
read path and was not respun. The read path here uses the corrected
check from the sx9324 read_gain() fix I sent on 2026-11-04.

Applies on top of my series "iio: proximity: sx9310/sx9360: reject
unsupported hardware gain values":
https://lore.kernel.org/all/20261107111710.442318-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have SX9360 hardware.

 drivers/iio/proximity/sx9360.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index c6e5b3e557bb..01a4a94219ec 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -67,7 +67,9 @@
 #define SX9360_REG_PROX_CTRL0_PHR	0x40
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
-#define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9360_REG_PROX_CTRL0_GAIN_RSVD		0x0
+#define SX9360_REG_PROX_CTRL0_GAIN_1		0x1
+#define SX9360_REG_PROX_CTRL0_GAIN_8		0x4
 #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
@@ -291,7 +293,12 @@ static int sx9360_read_gain(struct sx_common_data *data,
 	if (ret)
 		return ret;
 
-	*val = 1 << FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
+	    regval > SX9360_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
+	*val = BIT(regval - 1);
 
 	return IIO_VAL_INT;
 }
@@ -628,7 +635,7 @@ static int sx9360_write_gain(struct sx_common_data *data,
 	if (val <= 0 || val > 8 || !is_power_of_2(val))
 		return -EINVAL;
 
-	gain = ilog2(val);
+	gain = ilog2(val) + 1;
 	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
 	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
 
@@ -676,9 +683,11 @@ static const struct sx_common_reg_default sx9360_default_regs[] = {
 	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
 		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phm" },
 
-	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHR,
+		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phr" },
-	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHM,
+		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phm" },
 	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K, "prox_ctrl1" },
 	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |

base-commit: 509224d37ff169a02f388ab6e525d5517fb570dc
-- 
2.53.0

