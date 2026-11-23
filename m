Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452803;
	b=s213g5Qr8PLojS1nDi7NwrlImlV9AE1mO7mgMQaUTbTJf1hp29Na+BhZJQZ6mnp9QEs0
	 eMleuH/Uz42gJOXlH+xcIprWsiH6lMjamK13CIyJz35XSgMo0sBQLxzWffYCgHdBomgqG
	 dEVyhDBLW254jk6Fr2bCJBJLhYYWZCUGanTYCiQmFLr1Q4nUkpnylv3ndEt3RfGhO3284
	 r2EMQNxPaaVPvui9M4SCGQn9uOFOkLlqg4Z8i1iz6dEEONTRXc6S+eoZbCqhWjgso9awh
	 Y2/+GbezHUBOloYMEHrJ1w0iy1cAYOdSUgcbS9G96gD0sGgZapyWrlcXO0gId/rxvSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sFe5nxwzMHr62FTOB7ETEsALfWA9QNj3sEz73U795Ac=;
	b=uWOfXP1LYL+qbMsxFjT8azh37a+cB8Y6+QMe5djLGDb//pcYJ07qe3yJX7eR/aRNdSPv
	 spwnh4xzUP6XKd3/orqA4HtYATfdhwu5isclj2JCQIaA9zgOTeNM14hMk1G1UdYIA9lGu
	 UOEe8lVWJ4drRzXZ+qk6MoUNrcmMW3SSsGsyKTXebkuvCQj4aFWCMDxuqdf+kuZllRODr
	 vWN4nlEEOOQDEoqx4JRF/LeAHJOIU7RWlLcMNE2coYkv8LSKGMjuc2TwQ32DhFnbY98N2
	 BAg0APkV99o4J5KfYdFxINnQZyzhgx8Uk2R0TvAiajouN+SPQ8qLdP7YGOCMmmxvghA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=winse7d6;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F6606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 16:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D40F6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=winse7d6
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-38564b4b017so3761267eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452802; x=1796057602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFe5nxwzMHr62FTOB7ETEsALfWA9QNj3sEz73U795Ac=;
        b=winse7d6xiGkgHSxpya+j8IjkyoRt+uXJtwxdBmtXVWMtTir8GBAUhXLik1zVQRLon
         pCONUNL5b9nO2D17cF+DcCktNsmKUIYyYzaf4tak/NNBY2NNxXZTEA2OtSZXd83YVQex
         b9A5o5cniXBeaaKUVDGd7h2ppQD/neLS1g4kVeXddUsm+P/x4QVQAe9q30teh2lRMpcD
         Ljd0FDrlSReJMLwacpTTTWpVLv1biP2Rnq7iFHpx/UlcoCxBLOIjUDf2jNrKao/Ue+hy
         xkRZTXYhL0pmY4U8vb9b07H9n9h9YopopqOCksXxdciYG1UfWXpNpccHst/EOlMK+OZx
         sJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452802; x=1796057602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFe5nxwzMHr62FTOB7ETEsALfWA9QNj3sEz73U795Ac=;
        b=kIpUMKNDUHc7QIsnxPlFaoNbvDMN1E53hkvbzc6MKIDf5KHeCyJvuVa/CDoOLBbpH4
         bUhY2YfeZ3dqrN4SQLG0etS30f7AWQn6BjrdCMUNj+ADRrp3GVBA41DjV/SiQmNVvg5R
         G/GJUg8UDwVrWD4waD0U9I+i+DDNeOxZWRWjGU+X8F0ZRqEVvOwBMefI11lRQYE8kyIO
         Fri/xOLTT34srNU2jOCi0O82Ct6yR8I2UR5xeJOcmJBQJfS0kxXxogwTlkD0/Or69s8t
         AWOiBm16rZCxZEJETMnNnkHDJNJa9oPw7KmoydpLNsIKilvKmS0Zsxioo0cBnbrmXfii
         ELmQ==
X-Forwarded-Encrypted: i=1; AL+hErE0ujwkOKLbbMEsUUrKo8C1zKrQ2p+6kBd6ygLkX7nk2eY+lA1BhXo01K5y0W9UIwih34SmrpTnU5E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HPqXN7UlsJZkY+SXrs/A6hw6hHN7nfmKuhHDsBf0l8A7vsWXf
	44ngpLJYJNVeDZ6awkNWbrggAuIuFBe+/+2TF1prG36gIeFkfz68GDIo
X-Gm-Gg: AZFdTZeeDWbvQ4rJXgxDYQKCjMQtAJDkZ2srdMT6EMvIhOijNvFDt7KgP/3SVQChl2R
	Z/Rpl5hLD07p4YFl0ljeECyePqBK2jpw8a+bEGo9bWnw5ZYUYo0d/48WF5akYoV1pFhc4X9Gkgn
	cDKVYr57F+Gd/zuReM0FWvpa/zqnmvwniCqK8Fx7pZD17eowc6nZ9SDcZiC7Dd4rXE/vUL8uQOQ
	5JQNAqLUw8xkXQm7BMJMQXD578e96MkpRYJi52QMTQsSmGc0l6w98oE2hQ2VPMpYDVh1DMR2DfJ
	SsTOUIuKRhOiduP8QdDNVtPxAqdUVlYFNfke3vwG28lcCEZD184VVLPcq/0YTYK+03TMczHLskT
	gFLvS04DjNVM7cf3+aBZ7jCfTru88hJc0ZNEHgcpc7GrhfsNiq0/rCWHsmR7LFimcKJ0HlhDOMt
	DlUpVd5CAUH+EMCH3e4vjs9d2K7aM+h06sqB+8Li4Ekfrokg9xKQEJdcGf3N2gE53VaZlhTqjHu
	LmIRaL2sC8n/wx5XE0e6au96gIIuDf9m36nFYpOyFXnPMUyFHnu19LoMIGAdlQTN27wXiZbilvK
	evAGgSMIWj04Qoxs2u/4KfJ0yVzUZnw5OzgxJb6IT/Nx+e6d5osGLsTXGTpLbeIVYuJ4FUTRkOu
	g5gZJ6Z/wzpkqCdySw16GMVZIHbYfJIgHxmV8Sqvk/imrYkJrVe8CSjXV6VgmEer7eBY1Vzq6rz
	TgwuuSZfbkYCoCp9yZ4/fKAd/qFoubXID8PhEcrW9F+w==
X-Received: by 2002:a05:7301:6482:b0:386:b39a:883d with SMTP id 5a478bee46e88-386b39a8d30mr3055139eec.0.1795452801834;
        Mon, 23 Nov 2026 08:53:21 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm47196668eec.5.2026.11.23.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:53:21 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 4/5] iio: proximity: hx9023s: reject out-of-range threshold values
Date: Mon, 23 Nov 2026 22:22:50 +0530
Message-ID: <20261123165255.239490-5-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123165255.239490-1-kapoorarnav43@gmail.com>
References: <20261123165255.239490-1-kapoorarnav43@gmail.com>
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

The proximity thresholds are 10-bit register fields in units of 32.
hx9023s_set_thres_near() and hx9023s_set_thres_far() mask val / 32 with
GENMASK(9, 0) instead of checking it, so a value out of range is
silently written as a different threshold: 32768 becomes 0, the most
sensitive threshold, and -32 becomes 1023 * 32 = 32736, the least
sensitive one.

Return -EINVAL for negative values and values above 32767, the largest
value that still maps to the field.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 5b43dc9b112e..1545b4ed2ead 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -441,10 +441,14 @@ static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
 
 static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
 {
-	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	__le16 val_le16;
 	unsigned int reg;
 
-	data->ch_data[ch].thres.near = ((val / 32) & GENMASK(9, 0)) * 32;
+	if (val < 0 || val / 32 > GENMASK(9, 0))
+		return -EINVAL;
+
+	val_le16 = cpu_to_le16(val / 32);
+	data->ch_data[ch].thres.near = val / 32 * 32;
 	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
 		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * 2);
 
@@ -453,10 +457,14 @@ static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
 
 static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int val)
 {
-	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	__le16 val_le16;
 	unsigned int reg;
 
-	data->ch_data[ch].thres.far = ((val / 32) & GENMASK(9, 0)) * 32;
+	if (val < 0 || val / 32 > GENMASK(9, 0))
+		return -EINVAL;
+
+	val_le16 = cpu_to_le16(val / 32);
+	data->ch_data[ch].thres.far = val / 32 * 32;
 	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
 		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * 2);
 
-- 
2.53.0

