Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED448CD50
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635118; cv=none; b=dXOLxIL2sVWXeZkrBCcFnO/mNbjHsCUCnJtTPJxZ2bLeGIq987gBtOeUxr/UzMJzOnmh3L94QdUH6tiLNu3yotlSvIU0gJNO5RmVV7LnuLkJA3ojN+pT4/A3UYEA0IBwgegR4g1M1lHCDyuzeJKQRIf5yNC79IWly3VSzG5MGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635118; c=relaxed/simple;
	bh=6/z9IRV5ZQn/Frw7BWoJwC2CimqWWJl4hMDciS+A1D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjCM5CEcm4nCmR2ZvD/MTZZNxLQ5LqSjZQj4qQLYxSryjECsIDH7z2n2hwACmphDfV2oaMwRGjG5yTw972g9X4F/ZGjclhJS/1/kE0cTKDD3D0m7KVlYXiuwqcZXg6yYsj+PIi+VFRqc8RxTvgPiiCaQKYG0wwkJ2udABEsc9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVhUKz6t; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVhUKz6t"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1410460a12.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635116; x=1787239916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRy+t8tNDkimDr+BoBwwY6yvO7nk9mVt02bQsB0YYA8=;
        b=iVhUKz6todDkgwKQ4DI2oErKKRfJTpIoP2RDQpIlDVZg+orUa6PUB4kcHcEbCB5166
         Zi/YS6Rmi2mhyx5QB6uuHBhaWcH8xq9W0aDq1WwrLYruAqKsuTHLy1r4AdulR8Ph6gX3
         qiDgMZbZkEzIPcuT4CHSpMtF/z/EbHu6s7FXu+qLZt7BJ7aCKTC/EoAFjcpxOqvQa7oz
         tuyMYPUdU+P4NS0vqj9Dfes4YMTe21gfpjur1DQ97vH1+CN4KUylXPRlZxNf3DrXBhVa
         KH/WdB6/mXrW4jhf8NDQbGCOgpIpm1cGZxZZ2+a55szB35Ibwu+Kri92EPToAfhsY28t
         fzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635116; x=1787239916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRy+t8tNDkimDr+BoBwwY6yvO7nk9mVt02bQsB0YYA8=;
        b=eBgLtO/vD8csnt+CQdIbaVOYO8MqRCFrDxQEaO3ecNMDmX7UuQtAZ176DA7RxA0ket
         EBUJnOnHwRF2Xp9beAkr1rdN49dCTLfI10yO4+Q0fXwCGmtUF5DWQpjtYRy0oD7rxtgf
         NAYNljMhvxcP4/z1WHeOqdmtvqqyUfxKiLe1THiteRWxjo845VqOS8tOl3n6NciHrEeX
         CPnvGRAwZAgkolEFB54Oqv0X3jHv+u3E6sFhi0R+jxlWmGNqOqILMljBEd5jGRDqd/FL
         1famY6tC2E9uI/WHfQiXKFgl5TEH0RA2TeNTWcp0hA29/NPgfFnYfogHwUFRb8PUm1LR
         Uh5w==
X-Forwarded-Encrypted: i=1; AHgh+Rq5edNhNxunoyR8zvkwJx3A1gqDiQ6sANwNEoGIN0fqaUEbl1z6oj23ljTvMwlpGxqwQcOWjLrDDR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkf6GWxOzJw8+14K99TcqO1f81X2mOXXkQ10NnKxEv3XHVHefQ
	YMu9oAQQgIC08ShetNAZhz+7zZ993/gbvFFKw0grhPgoi3MMXRAHm/wS
X-Gm-Gg: AR+sD12PfqS+7UHq+hchUMo8Nez3r9j+7cVP3tT3kRhsEEd4qYLPSxA5lXL4mnCk6MI
	MyQCh/jAMW5siMGtheUt9JydEFch/r+U+1fLEXMI7DrzK/Rj+osgOmm/tmYjxWMtNQwBgq3ODtR
	XytBZhR1fK6LewfbFdZv17ym0dhLpGEe6VtUy+ixLkZe2cTehjrpM0NDoqsQiUzpM5HHZm5Opat
	XZICEZNsy8vb7Wbbph056ue/zRHRQ1OEY3lCZqpi7DBMxqignKkE876mVUn9w6AQn7Fi/SmMg1t
	Yjgoe3g/KxXaZm7IF4RQwsHP6i1yby3AKyePVSTQX2Zu2L2mPxE9uZl/26cOFb3YZt+qPuM11Qm
	2m6GhBlIFvTUxBKb40jHtSP28XJt7gZP6khMhEczwFyazOHrUrnh7xrfRhXOkPswzxwcSXgRoB8
	XEiVSukiZNaXpPMb5hW0/WLRtVMb89ylz7DQg9xS1VG64zwIH+irC8PKmsvDofkLnJkPvIFjWFI
	KWwRbS9kMTz+IbphoeY6GdF7PxRpUUQyO2EYowecm4pslldTpqJQp8Td2afaQ==
X-Received: by 2002:a05:6a20:2589:b0:3bf:7bf7:7913 with SMTP id adf61e73a8af0-3cc5503a34bmr8643790637.14.1786635115961;
        Thu, 13 Aug 2026 08:31:55 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec082943fsm7960604eec.29.2026.08.13.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:31:55 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH v2 3/5] iio: humidity: hts221: Allow unknown whoami for DT fallback
Date: Thu, 13 Aug 2026 23:31:27 +0800
Message-ID: <20260813153129.12423-4-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WHOAMI check currently returns -ENODEV when the chip ID is not
0xbc. That rejects Device Tree fallback compatibles.

Keep failing if the WHOAMI register cannot be read. On an unexpected
ID, log it and continue so OF fallback matching can work.

Use dev_err_probe() for the read-failure path.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 76a391f421f5..b73c26aae9ec 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -136,19 +136,15 @@ static const struct iio_chan_spec hts221_channels[] = {
 
 static int hts221_check_whoami(struct hts221_hw *hw)
 {
+	struct device *dev = hw->dev;
 	int err, data;
 
 	err = regmap_read(hw->regmap, HTS221_REG_WHOAMI_ADDR, &data);
-	if (err < 0) {
-		dev_err(hw->dev, "failed to read whoami register\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to read whoami register\n");
 
-	if (data != HTS221_REG_WHOAMI_VAL) {
-		dev_err(hw->dev, "wrong whoami {%02x vs %02x}\n",
-			data, HTS221_REG_WHOAMI_VAL);
-		return -ENODEV;
-	}
+	if (data != HTS221_REG_WHOAMI_VAL)
+		dev_info(dev, "unexpected whoami 0x%02x, continuing\n", data);
 
 	return 0;
 }
-- 
2.47.3

