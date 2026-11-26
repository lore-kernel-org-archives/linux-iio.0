Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671068;
	b=x2TV0A3gJljNF98t1/DIFpjkAEH98mvxsV3N8ksygAjXtrktqL42FJRNXfrBpKM9ejxQ
	 tonbe81rxc1fVTspuGNDXh0tQ82rbw3IyuE7dQiMYhZMJVURN1lwQaEw/XWaZoduLwXWE
	 EHkKAf57QbftolU3yQqxDsbWUEpdCeylr7BXF1vT5dCzfMeltZBOPWnJX7m3bWmXQDmuI
	 Bz57nUbIJHug6Gt3JqcTsTMMHPLxIrkuVr3QdpE5Y6RGg+nbK13FMCL0u4520XJTczBc2
	 UBTI71FOvwTG+8JIB33cQWvbpe0kL0fRzvsnhuNfBJuIIuYdB78g/B09D4Vs3Wh7sKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DopjhGvgf0EPox8pL3puwsu/vrZw1+vCbZ4ma8Rqqjk=;
	b=Sw4jK5fonRxHJ2JhMycJCJIUrz41enneSpNROmWwtYRZepTbcWOD8UQASzILQRtI4AZ+
	 bgXFIbjZL4ghHQNWCZOjfu4PLczdQmKQzuBQE36c7bP60QxBHH5s7Mcw8/QoDsHkhjx8D
	 2Bdol7a1XTvFYXomgl7AW4SYN2t44+yPg6LV3a3JhYSKVH/E+PvE5789UiXtlLGbUBTnY
	 hrfpojZjfPh4kxTOAZXBPJA9fG0mzI6TLeqbjWgZe6xdZ4OxulipE2Li1r2uNeUpcchuJ
	 sLfPsWUbMz8swLF6j+GR6Ss6gUQu9+23B5L2HsqSN3rNw7bwkYDqRO4+HGwPOvcBk0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSxGmgBS;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BDA606A31C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8BDA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSxGmgBS
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb9f760337so3755128a12.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 21:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671067; x=1796275867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DopjhGvgf0EPox8pL3puwsu/vrZw1+vCbZ4ma8Rqqjk=;
        b=TSxGmgBS7tAK5KwBvjtC92RpCduXLlx7yAvlVl2tJ7dimTa4UkxhFx/4eSABqj00iF
         jhxH8rt+9SVuLkSs7K5e4q7Y37V2gpEWPdaNQuI2uOPh/fHLp8hI1mt+p9AI61kFRbRJ
         YgsG01W2ado9xv2OvTYBXSQM0MA/la6p6bkZcrjZSVVQ2FIb5nFlWEL6FQjCitR+1KES
         HatFjAKdjt61dur1gLVB382veL+vYNQ5xzkdJwwImFa/kcMHbOjOa5XsLDUeGj/xOfAm
         Ck41kDme38xU/qhBo+6gjqSSbPLPTEKdsTJ7yP0q8OjhbIDcg4ViLUPD+D2YNCUkikE0
         8FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671067; x=1796275867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DopjhGvgf0EPox8pL3puwsu/vrZw1+vCbZ4ma8Rqqjk=;
        b=Pdb6NTs7LHuW9KyheUv0P0NeFtgE9CJjRpQptOhTO3U9tvlMGWNNRF6AUGZJRamHS3
         17uKAyF1bLjx6QomeYvvIsjp7q0BdN3feZRrrqlmBk4O/bEwzmJKHp8oApzmke2lEn0t
         2VeZm/xi47KNd+yPLSdJLT5TaNZnbm+ISqURiClT0C+IggqhLYZPNzrMe69xoLtasA2Y
         MwGiTSmWjMRIith8hUbyTW54LAtDaVpJdzF3HaneB9+XGuZfoZcbRX8Ql0Qt6LaFuEeY
         h8q7zhbfIUvrUBoDQ6zyIopgkpCCdBEHqmMDNMRUCrtulOOg/fEJHYov+uKiWYNdWtdw
         F2/w==
X-Forwarded-Encrypted: i=1; AL+hErFUbehWW/oqZCfnfniMlHz6zq0mDFecBiVCdkftuaK6vkQrzStY/2uv98nuD8rhUESlWRhMBWq144Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V0DIJC8qqEc2A+1S4hS0TRrAo6ztXp/1yOwqi1aVi1AveC1DI
	gcAIOZNuLlqOnP8Qn4jjOCdkl5udgefKFotk7kLFLDuDKsW80QgBi+gc
X-Gm-Gg: AZFdTZcDIYTcZxc+rDbOg59U5rVfHqhpN7m39/ZmfMpAQASKM2qO1JyLsy7ahMi678M
	DdfohitLx2Q/0EoLITPyM0X12mZFTNnoV85j9XoLwXDEhYPRh167QEu2MBm9Xi1UqKqZQtBV5x6
	zUmBIQRDW2o1gCMp1ZRx94Osn7qxHfxJRyXqgQAS8ppPMCOmc+0NClQH0CKRMiRig8kN7jRw4KX
	G35UOZHNRYel7j03gbxOKBIUiEEFxSNE9GHW0FalarKEBV6qZmW5njnQKh9m1+u2Aym9W5X9T7H
	Rgiytu78SWOdRTwnCShymX2wkZWi3xSdBJTu8c7WHv2xhb7uPJZJMzdR9KbIs6XRAHHo8oHLVHT
	W25aA7v6lbi2zRvumO0RXelk3JYtcx0X1ivBasB67hFWEO/yYKMhGH+eMdhrz/xbk9gYRLxvQGU
	n6RvuYue9W3ZZ0RSzipXU+I7eKalubT/AU085jjqd4/t7oI+CkKDbPGfVERVVCf7RctC6Tgpc/q
	S/PaF3bNqtKcWMkajMNXyn7CRL/xPk9ogLVgE3U86zo43g69S/YHxiZrXzC9cGjMlWVt8yNcPRT
	ncVLDo8q/+luPX4FIv6QjZ+0gpOO6nZflynDtAcnJRFkGjtyu9oYb/EkTTkosuj9Qv7fTP2Ist8
	KJmyBbIyJmJTtsv4LhH9+6KOUTsYAtcu9xmrogQvP15VR5H8JvfM2x9v3B4oi/0ce5wpmPSvar8
	4KPRmjguKQhlvCy81eEDS3mSwLJPxR+kR+kgjBL2l5of+5
X-Received: by 2002:a17:90b:3d4d:b0:3b1:6689:a016 with SMTP id 98e67ed59e1d1-3b41c9082famr13103265a91.16.1795671067074;
        Wed, 25 Nov 2026 21:31:07 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm33700520a91.7.2026.11.25.21.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:31:06 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Wang Shuaijie <wangshuaijie@awinic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 2/4] iio: proximity: aw96103: use the default configuration without firmware
Date: Thu, 26 Nov 2026 11:00:26 +0530
Message-ID: <20261126053033.603086-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126053033.603086-1-kapoorarnav43@gmail.com>
References: <20261126053033.603086-1-kapoorarnav43@gmail.com>
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

aw96103_cfg_update() falls back to the built-in register defaults when
the aw96103_0.bin configuration file cannot be used, but not when it is
missing: then it only logs "No firmware." and returns. In that case the
chip is never configured, the channel scan and the interrupts are never
enabled (aw96103_channel_scan_start()), and no channel is marked as
used, so the device registers but never reports an event.

Load the defaults when the file is missing as well, as the comment in
aw96103_cfg_update() describes.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 1fd0ceaf2a05..504e92ab9b07 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -589,12 +589,13 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
 	struct aw96103 *aw96103 = data;
 	int ret, i;
 
-	if (!fw || !fw->data) {
-		dev_err(aw96103->dev, "No firmware.\n");
-		return;
+	if (fw && fw->data) {
+		ret = aw96103_cfg_all_loaded(fw, aw96103);
+	} else {
+		release_firmware(fw);
+		dev_warn(aw96103->dev, "No firmware, using the default configuration\n");
+		ret = -ENOENT;
 	}
-
-	ret = aw96103_cfg_all_loaded(fw, aw96103);
 	/*
 	 * If loading the register configuration file fails,
 	 * load the default register configuration in the driver to
-- 
2.53.0

