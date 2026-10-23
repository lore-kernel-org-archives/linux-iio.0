Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783632;
	b=E6h0x8EeAdN18sjLmH5S8tw691Um0ZDgT1pA7x6t27E4U2dd1xEBwtxiZEZcXbn6QiWS
	 HBXJBYwZl2PJxWH6iPX/2dQ48Iv5wbku3lHKmEgPxBlQaXDsXYv3nrUNdKDOvNqZaR950
	 CYWIG/p3aXEqxrbvj+NcoyAnBrPvHdq5axnZEdmNQBatupololI0lfzOZiiJsChxilrtY
	 /BAdPaMh92fOTbjVSPQSgm9pGIkvOxSxoEklO4JUTVnhFcAWOmGsgOfQrupKTFXe1dtQy
	 hY/WkHUZrTtgp0MtA4QG2xR3hTXlgYoZokXZlZSaqAT0tmXSdLEEUuRX/2fN81ORtRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g6rmNa9AYOjauN4oIXe0gZXsbGVfjVi9QkEhajXiP/0=;
	b=5sVzBiYKdjd4bsyadvOmy0OIRkKWSG4ksYQzDh5g1kFkbBwud4KyXc/+0fFldIra0ZAw
	 RXHgrxww4dd2DCdwQfqCkmFk2LCwwcSFCmA5V4nN7guUHAFyroBh8r8VOGPB5rDhm0WxX
	 6eFP7WVIzeayCq+WdHAcj5NM4tkgY9Devy9kcqofEC3ULh00FyhLk4V7omNcPbl9ptfqh
	 n6JrJa6HBqGxh5bigbp8FS52FmsgOMvTRP8hJGx2yUnB9jXO6FoK9dxYlsxIuOrQj77UE
	 wh2KnPjYOM06x4QXr8ZEX81Ivqku4rmLGJU8fvCBp1dB6Np1SqatK56Bw2iI4Hv+24Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tCt2j2hl;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7D606A31B
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 19:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D7D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tCt2j2hl
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so1230337eec.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792783631; x=1793388431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g6rmNa9AYOjauN4oIXe0gZXsbGVfjVi9QkEhajXiP/0=;
        b=tCt2j2hlfGnkTRfFQ7XZ9x/LcQ2+0OS5IuaIt1ATWN0XZoEd/GopdftOpTSPvswGjc
         pzbz2/JQEI+vqVPCZ8uIcY7wg9KQnEYda7aB+VGDTmnZO7s+o/gTKyQ8260XXHczkeAn
         I1UuvugbDyvbb3YWTvLYTMcl/kmu9tZD07To/3Dl/En1jwGUa8bJJZdeSEmbjHtUQhzk
         SemIPCGYCOm1SuX+lBSX0e5qMlZEgk1xmOy8pbyaqcKmRFCEGqsJu2xeOwx2c0doprG1
         YSb6Gs4nWoIMuvfb0Hl88h92D5pZ5ZNQ0s6LniXaSjh1cpF03GVHIXk5H+6/gyBlvlnM
         wryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783631; x=1793388431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g6rmNa9AYOjauN4oIXe0gZXsbGVfjVi9QkEhajXiP/0=;
        b=h7ZyIIQsX1vSfX2XgfYfdSTrMT+wHH2UuJ5q/NHaRsOv/ypOjaDjf/gBAQ7dZpa7Fp
         9bG3SyLpEGa4mc1U+qDoRL3LBhUm5JJnV0h2tLIwnKhrJFag/bYmtllLeKsqBMqKeUda
         cRksl5qt6xtx/wEehEPxAnK4Kp2xHriC+bE/FUiG+A+/ya4Bw/XOq1R9Hxs/7gwUGdBY
         HS0qeQPXYL1jgBpZTGyPcY1cdq0VCrOZsUT3CsOYXxYgXyP5E6ShckvH/a5fbyK/5jPz
         udfSBKqzcNbf7oZvjsJfQZPNTgP0qa/hQ/iImq15bJzCuS7EFFUDaJqguOMjy6A5hF8y
         NJgw==
X-Forwarded-Encrypted: i=1; AKwUvByXF3mIUxqDQD60xhVmoQLsh7VrLlLi7AgVuX0Zb6jvv0/amLJ7P+9B6OciOgXkCAeJ4XTlW7630gM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrYaVJQKtIjnMsq/xGnJuNj4aYH6cbAd4eC6dBZHjBscTCy4Rj
	zawU56QnPMePuP3h9lbhh9y8HnpwpORc0QVodcnfKUpL0bG6PeYF2R2l
X-Gm-Gg: AYBFou27PklTxpIJ0jvahYbIJVl9J7cAzGCLgJ7/4x3jp/jbomwZ9x8oAZP9uUFu2nw
	1j61WkKc3q2h26VCUl5q/p0tYDXg92Gdz4/Nsa8T6uWt+1CR9WDgq2lLuIA7iD/GqECr9kRhrEV
	VIdzzXpTF53n1QbT81wKDwEaI+XnqGOXkb36XO7Y3Fu6mUFD5baIm0P4qZze/mrRLKOcSKEDj3H
	qBY6J4dbDU/OThwmpYEyVmXVnrOlR+hV4gn8A/Imhh+etk+dDvvp036h5AdIPIYWQd8CX2E08ZB
	RBhBJIqX3nVFnbdsp8MufEeKqtZcZR9w6Lg1Kw9wZdKS63E93DkQTZNobQY5x+Q16Il1e3AODFY
	g2cQfCGNgNunvlwVLuIJ3Y21HhYosCASJgC46coHOpgUc4qKxRPxMGYJMKEdzwM4tHJMYDbzoWX
	7nn0Q8zCcOWGRkzzZjrL/FSewF38//lpJAPx1TY8a4j77Y/dmHEz4knfhPBYumhEPypdJ4RTNMK
	Tm1GJJyJMxdbR0JBjToCNRc4DlxZRgL4Gb7cHnCezcwzoburu8RDwzMoK23Hqd2tFbfDzCr4jk8
	MiFHPcXmho68OR6Z1IKN8hPu8oCef4JbCHvNL6NX4RwlOgt9O/13saR0evMKKMKi68fzTBVU4Ds
	mfe0DGxtrsEQqVnBh6OzONChn3qcHh4GiTw==
X-Received: by 2002:a05:693c:415b:10b0:368:c6b9:d3c0 with SMTP id 5a478bee46e88-369e85080a0mr426019eec.28.1792783631115;
        Fri, 23 Oct 2026 12:27:11 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d54a86sm242560eec.7.2026.10.23.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:27:10 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2] iio: proximity: sx9324: fix out-of-bounds read of scan period table
Date: Sat, 24 Oct 2026 00:56:51 +0530
Message-ID: <20261023192700.221344-1-kapoorarnav43@gmail.com>
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

The scan period of the SX9324 is selected by the 5 bit wide
SX9324_REG_GNRL_CTRL0_SCANPERIOD field, so it has 32 possible values.
sx9324_scan_period_table[] however only has 16 entries, it was copied
over from the SX9310 driver where the field is only 4 bits wide.

sx9324_wait_for_sample() indexes the table with the raw field value, so
all the codes from 16 to 31 read past the end of the array. The default
value of the register is SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS (0x16,
i.e. 22), so the out-of-bounds read happens with the default
configuration of the device. It is only avoided when the device has an
interrupt line, as the wait is only done in the polling case.

The value read is then used as the duration of an msleep() call, so the
sensor is polled with a completely random delay.

Fill the table with the scan periods of all 32 codes, which are the
periods documented for the corresponding sx9324_samp_freq_table[]
entries, and add a static assertion to keep both tables in sync.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Format sx9324_scan_period_table[] with a power-of-two number of entries
  (8) per line and the register value range as a comment at the end of
  each line, so the table is indexed and a typo is easy to find (Andy)
- Put the static_assert() on a single line (Andy)
- Add Fixes tag and Cc stable
- Rebase on fixes-togreg

v1: https://lore.kernel.org/all/20261021225417.626946-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have SX9324 hardware.

 drivers/iio/proximity/sx9324.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 255a36976ac4..43266a21bf2e 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -279,11 +279,20 @@ static const struct {
 	{ 0, 250000 },  /* 11111: 4 s */
 };
 
+/*
+ * The scan period of the SX9324 is selected by the 5 bit wide
+ * SX9324_REG_GNRL_CTRL0_SCANPERIOD field. The values below are the scan
+ * periods in ms of the corresponding sx9324_samp_freq_table[] entries.
+ */
 static const unsigned int sx9324_scan_period_table[] = {
-	2,   15,  30,  45,   60,   90,	 120,  200,
-	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
+	1, 2, 4, 6, 8, 10, 14, 18,			/* 0x00 - 0x07 */
+	22, 26, 30, 34, 38, 42, 46, 50,			/* 0x08 - 0x0f */
+	56, 62, 68, 74, 80, 90, 100, 200,		/* 0x10 - 0x17 */
+	300, 400, 600, 800, 1000, 2000, 3000, 4000,	/* 0x18 - 0x1f */
 };
 
+static_assert(ARRAY_SIZE(sx9324_scan_period_table) == ARRAY_SIZE(sx9324_samp_freq_table));
+
 static const struct regmap_range sx9324_writable_reg_ranges[] = {
 	/*
 	 * To set COMPSTAT for compensation, even if datasheet says register is

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

