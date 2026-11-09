Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213883;
	b=a0ZVs5WD3WpKDhQEm/8AXr26s3ARi9CYxuttJx7T7vczPNBXA26ZZK8PQ/8rjKHcGwe6
	 eV8Rr5LsjHYmPJOzzklNVMX5hijS735f3oxIZz/fVtac9avw+ef5GEazE4I4kSf6yBicK
	 XPL/n18HnYrLvMsXd6MBkaSCbiu06tj89+mP/qlv4z0KczGC370pYfiUh+PGTtBZF5qiI
	 9JXMdrUiHpQJ/pHpaf9kwRroYJYfh1Ki0qumBZKEoyAGQl3GRmgvmkJrqET5VOtf0SkHb
	 b3yBRDhtHGZpVi2nphDDCwmbcLa2KVmBTfwC0N8BnDTmF7QUkCJKqW9HZADbeY9mLbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cg2C9sgT2sD7yDisbnfHPJYeRJKqZMharkjHKRD6Qk0=;
	b=cUt9xGuMmmxt4chpxTNUOQ+chlR6xR55udTRiq75czVUzB6MQVyi5MbmXXk/1NqfWsOk
	 x1fvefHiTY0qcF+wd2AYGKUrJT9TxMVgyHNfjgRfbXH7reDY0xF12h6RcesCFQURYM5dR
	 Dc97pHKimKOGJ4eEHUPIUGZVGTDsm72d8pxptTMnpjIKFhcqJ6Lq5RoCLr4Y2XyNsYrjo
	 m0BOp3D2eId/F0TJVqH3yB4/rShgzInoIFBjLTtE+lBcgJhAocJte3dRf2HGXMQw+ULuU
	 tusdG6vp4Hop7jSqmn1KDsAy5NEOQ9GUrdBb+mv8rVnlRW7w/vRpwzVzrKCrT+mUKpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kk0+41Ii;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA3606D80B
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 08:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECDA3606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kk0+41Ii
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b5efadd183so242324b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 00:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794213882; x=1794818682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cg2C9sgT2sD7yDisbnfHPJYeRJKqZMharkjHKRD6Qk0=;
        b=Kk0+41IiZ86WrtBrM2QWCnZtHtfihQTO7xbJBbL13BkGagpW//D2ACTv8mpEqVsMkK
         JwsNfWvvenG5VWdl2R0/sRetLSSb9nqfoMfIdwrX5zsGV1R1AgTo3VIz8B8rCvF/hevA
         kT25mQY3Z2sX2AMh0olrTtIrlEuKA39NdF85jfMtkjgiPYt3Ym7nlXuslrIxCTJhiyXs
         k10MdfywZ8tcE3kgKhZYbOD00L+N9hchSGxE2hIlVtX4Jx6kt/eWCs9TEU+1rX/EXzTc
         o7Sn8OeAK6bpcZJgvz2fOyNFyrvXeuEFEE5e1/z5cMT4HlEw+pAr+yKthVb+ljvy7IZZ
         YANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213882; x=1794818682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cg2C9sgT2sD7yDisbnfHPJYeRJKqZMharkjHKRD6Qk0=;
        b=xrkzoEPB9K1UWy78ZdD1K0tSceTsRsxi1ek4SI9czC3GOxI+qFKqA78vBdiAw7AbuK
         OZIpjP/cUt3Vy95FOhcjUZsXrHL6WSI7j7h+B4dIOMAljILQixSzgfg+Vr7I3bKmyc+L
         OVmfT+So/G2vew3pOsZY6mWzXiiP7XVYRSUM68sAWXCW5paCxgJLUCZSL8XV8yekgtOA
         ZJBlpqBpV7xhlAsCiVepMl0m+A1xUdTIdwwpDuHAZ3GW3zVzRyu5T3G6NcmyQqEeRANH
         lJnY+DRMsqhEvGjXOzOK9fNzzbh4pjdavfKSR4/stz1X+n0gBqyeA7f7uuMH+AKJMl0t
         JaQQ==
X-Forwarded-Encrypted: i=1; AL+hErFfokB8MbAUVWX/RDMUnFrTHVtuMyEn6ioLUBzMbwom2OBsfpIi851Q6N9Gb/LAOt05WqKPKH4tIOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z85FH1siZC11K2Rog7qEqtsMc9TcYOQjcbo4kTvDt4P2bI6f+vj
	kflEDHiPfkfkJtBtkzFxGmz+GAckquzgdZPCwALIE2FwTziJ6qjbprAdI0At9A==
X-Gm-Gg: AYBFou3dxw9CdY9HLwAI4lepvDwK8dkkTFGmumPO6Gu77J7W8NHRwaZtvHDC/mzGvwY
	ZnCq5L7foT62FEW3dfiI7+86naQ/fnr65+ER5di5lwxYEeqbsXYS4Z6tLzNqcpuU8Vl5q2vCd1D
	8QhA4liflYh5qiurP17+8jbWbxFaSkcbhqfHwpBpAXZXPLo5DkaWpgc06/2ojXOv7xHIqiURd/h
	Afe80xubdc61Al/wfSjNWLDng9weDLKxSP+VX0z8ZeEAkJ/hBUXtya66OcYBGHVlMY5nFHPHA60
	6zoqN/RMc/M+icTWEXpoEVXsOtAx64TNHujPM5BnbZpXtTyTOPlG2wfc2K/FzbrkExXgQhJbEoM
	XL7bjtfHA4vhburKWMwjdedogs9FBgGshyiJQ2Pv+7IxYgetwdkNt3T64YN6WglfdsSGMmMPsyf
	QG5ruHu0BLyO69DRzrSwRjTjh6aWNH19AA4TXv5jOzu5EvN/cd+MJekfjk8ur50NEW3NSufRL1S
	lA1U9aE+icOq3OYCHTuANywhQeFFhXPV00H+k4n81gog++JlaLm2fgV3BV3q80wgRBOdkTiCDBQ
	nfpQx+ml9g61KJVcPQj23S0ZoNDEEMqcs/LGaBzI42oyBniqAUGCOP8Qw8U+PuaiKq0N91nJBDC
	TfoZhmTYMhLRbD/5ghs6Y2j1fmc2N0eb70+zGcdm9QbSz
X-Received: by 2002:a05:6a21:488b:b0:3e1:3734:63e0 with SMTP id adf61e73a8af0-3eed3a51361mr1937124637.41.1794213882243;
        Mon, 09 Nov 2026 00:44:42 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96816fc6sm1413751a12.5.2026.11.09.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:44:39 -0800 (PST)
From: phucduc.bui@gmail.com
To: wbg@kernel.org,
	andriy.shevchenko@intel.com,
	David Lechner <david@lechnology.com>
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	phucduc.bui@gmail.com,
	sozdayvek@gmail.com
Subject: [PATCH v4 2/2] counter: ti-eqep: Use devm_counter_add()
Date: Mon,  9 Nov 2026 15:43:42 +0700
Message-ID: <20261109084342.51865-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109084342.51865-1-phucduc.bui@gmail.com>
References: <20261109084342.51865-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

Use devm_counter_add() instead of counter_add() to automatically
unregister the counter when the device is removed or probe fails.

This makes ti_eqep_remove() unnecessary, so remove it.

Suggested-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/counter/ti-eqep.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 2326515d5585..1c26008846a0 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -564,20 +564,13 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
 
-	err = counter_add(counter);
+	err = devm_counter_add(dev, counter);
 	if (err < 0)
 		return dev_err_probe(dev, err, "failed to add counter\n");
 
 	return 0;
 }
 
-static void ti_eqep_remove(struct platform_device *pdev)
-{
-	struct counter_device *counter = platform_get_drvdata(pdev);
-
-	counter_unregister(counter);
-}
-
 static const struct of_device_id ti_eqep_of_match[] = {
 	{ .compatible = "ti,am3352-eqep", },
 	{ .compatible = "ti,am62-eqep", },
@@ -587,7 +580,6 @@ MODULE_DEVICE_TABLE(of, ti_eqep_of_match);
 
 static struct platform_driver ti_eqep_driver = {
 	.probe = ti_eqep_probe,
-	.remove = ti_eqep_remove,
 	.driver = {
 		.name = "ti-eqep-cnt",
 		.of_match_table = ti_eqep_of_match,
-- 
2.43.0

