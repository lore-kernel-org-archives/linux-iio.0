Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213875;
	b=Uh6jCWzsej3Prb42pOmy/NpUv7Pr+LQmVDcW6bMRJ4Qx5y22XKrYjtSDwe7eMgdDQRU9
	 yu+wYk6O9xM8bSr323lL5PvKzUm50NM6rBcdWk+du54Nk8Z6Am+FXm42W6zAJ5+5V0fkf
	 nMRK+L6EU6znC2HfP9NzJxMkVxPKh4W1w9J+4ztpmbBw8CTdXFdMF21Ctsv+cHidtUNSN
	 CjwSLnihEyy6dPqGt/m7qfKPBNpdjDuCsbRwqmeyncAJqlz5fBME0ulUezp6vc9eAlDHU
	 4ou34C26sW2iSw+j2NW0IHUFaUr7YgEliNZWllGKad6Dlck+Z9kCwAw2VWAYNi96jwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2t//9uJx4ZB6YPMhb8XACeHYVkuv35YUrcSuSX+JzC8=;
	b=sUMArlO6KnyBUxBf1DxcDJu3BryZjNYcEQLeh9xIMPFW2+jqSg/hf2e/vYcVh3m6Nqor
	 UkanEJWZqF4Wuckty4Wbf1JjIKrvPyDligLt3OCE/56zTA/vl9KP1sDHfezzgspMRRiul
	 1jcytUOYw+Tkhy+HEmKIG2ChU5oiFJ37r25GXEccBDfQD7jAKx1Tzd1SwARYhTnGTJprM
	 /1nRaa9sxPe+xfZVPoBw3nSiJeBZK4JDI0gL5C7dYYIsv+1hRBSrWs69vsux8taiLn8Mb
	 kkA76qzZ4PGiSB3dZyScgCOyfOnw+vfAqHXYjXlGoPjsP6Emgx++Dv8iKwkYN/xj2Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bm0G1mlB;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4ED606EE89
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 08:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4ED606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bm0G1mlB
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a05b210703so218012b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 00:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794213874; x=1794818674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2t//9uJx4ZB6YPMhb8XACeHYVkuv35YUrcSuSX+JzC8=;
        b=Bm0G1mlBg36VOlOKbaYtfvd7iz02XxXqEqyu3Yu3B0ZwafhpkmREZyzSIhQzXTMAyj
         H0bvBX+5pXaS350DSa5D9S/ESPF34LYyUWYSPPOWK2foyW/e8ckSvao9odPEB3S/BiJz
         gWxL4Bc+vP8DmSNBuDj5ckTDkLsCX5/4xYbzNY/IRybLyYMCVon/8fQVRRZ6vWrlODtP
         x1bdQVfsSuo7A6leT8sQsGOEOYp+DWByFkqgRNB6XkznZwClvjFWoym6/2IAODONtI7U
         W8nMCgzaW8AERLPQAAAx5h9KPPeXfaR2Hp67Bs9S22684hEKAIIuynvvYb8fdcfbNNtn
         TA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213874; x=1794818674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2t//9uJx4ZB6YPMhb8XACeHYVkuv35YUrcSuSX+JzC8=;
        b=YPA9KQcxGt8834ULw9Ba6tBdJkuE3Lm5YCRln/gm6+77Orjs+RKEWBjRtCh6mYUgXO
         7aVGRENgquG++Q/gWdvd+6oYmdmPlqd2t2YnpF7yMzEb7YZw+gdQcKTFDsJmlV3Gxa8+
         SKtUsC2b56xffR3DXJBcl53BmBEcBoQy8DWvKK7sfQlgwrI+KgRt2rVb8J3v/Vr3EiVn
         yDiXXcAr5+u/gKg48qOr8b8Iu0GuqIoTrIMp6Kmjx3u7VN5zhDVvBPVkv195gYFzN1xG
         2DJIuE3LAAeqGX9aj4NMFXRgydYG7/QvmMnMv7JkLUakVKTCV4Pih6MIZZyzcuS/sANH
         fhYA==
X-Forwarded-Encrypted: i=1; AL+hErGyASlf9TuuuTCp7ZlHNcZp5dU46v3Y9xQ18pEH7Y3fmm0GEbZyw0TSIRnRZPxuglLyRhSh6kwwVaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/E9Qp6Zs9+zSg6ItpDXl40JxjBog7DLRHjarFZofJDtkiA6rjs
	QbuPAMIh7YI21yXKlpw7pHjG0a82xvG5PtRL74iaVYXk/R12IuXpFqnM
X-Gm-Gg: AYBFou2Iz74dB2058SUa0W6HaecdbDtrzlBaK/BLSCPE4osM1M3sphWA0+8zYQkdYvH
	oQ4TJo4vXi5ULcU+oMFbe2xeaVq4pUPfaqKwRiZ36cs7rC3m3v9E1ZvorsOE4iI5qZbQc1lP+ux
	WRfdXJNJUjz+xfoUapsxQEWT+ZYye+YDy6f3YHtVXR7cbR6kF9MvplxzrwMISI5ZTlt76VxREUl
	/9TmuGI56sL8rvE/Et6YLDPYwLu5Ck+Q66jXOVTwC/uNa4BXruV0Y092tzLqZPyjR/LZAVFK8/6
	8SXm0J3v1WaphHa7r35kt1mU+7O3ciGcVeF/NsUDHCYsYk7AT9hANQlZ9e5qLrDD2jhqr15BOTv
	fuhvUx23Z1URR+3XNto8V5guaj0TzPoz2FRUuEMnBRS99XfG2F+d1yE/LUR+/Q4XOBXAcQr6SkS
	rACHpHPXK8pa5HY9kxXmPw1JjKJkx+mvYHrLuPli1JekJjd1nJ1YzLGxYFZwNIno/QWvWVJPj3j
	07w6e/pkXC64N/71zOkGBhJ9iSk0RJaQsrwHZRm3ipqizSJ/s5toD7zHqt6vD03Luo6tr75VMV6
	wuxYWy7uqlBKkKrN6q/Z814Ku7PmGsO3tM+XnlXxf3zuok3Ifl+I8G/xMDPZeLe2i1NW8oLF3JZ
	5Ql8RDIfg+Zwy2yXij3NXYo79h9jNJt+cTHAJDQnCIXDD
X-Received: by 2002:a05:6a20:e212:b0:3dd:a009:3182 with SMTP id adf61e73a8af0-3eed408b25bmr3360834637.42.1794213874193;
        Mon, 09 Nov 2026 00:44:34 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96816fc6sm1413751a12.5.2026.11.09.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:44:33 -0800 (PST)
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
Subject: [PATCH v4 1/2] counter: ti-eqep: Fix runtime PM leak on probe failure
Date: Mon,  9 Nov 2026 15:43:41 +0700
Message-ID: <20261109084342.51865-2-phucduc.bui@gmail.com>
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

From: Stepan Ionichev <sozdayvek@gmail.com>

ti_eqep_probe() enables runtime PM and takes a usage reference manually,
then returns directly via dev_err_probe() if devm_clk_get_enabled()
fails, leaking both.

Manual cleanup via goto would mix managed and unmanaged resources,
which leads to the wrong release order. Instead, use
devm_pm_runtime_enable() and pm_runtime_resume_and_get() with a devm
action for the put, so every probe error path unwinds in the correct
reverse order. As a side effect, a runtime resume failure now aborts
the probe instead of being ignored.

ti_eqep_remove() no longer needs to touch runtime PM. While at it,
report counter_add() failures with dev_err_probe().

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
[phuc: reworded commit message]
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

v4:
 - Reword commit message of patch as suggested by Andy

 drivers/counter/ti-eqep.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 0dda3f2b14c7..2326515d5585 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -491,6 +491,11 @@ static const struct regmap_config ti_eqep_regmap16_config = {
 	.max_register = QCPRDLAT,
 };
 
+static void ti_eqep_pm_put(void *dev)
+{
+	pm_runtime_put_sync(dev);
+}
+
 static int ti_eqep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -543,19 +548,25 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	 * parent PWMSS bus driver. On AM17xx, this comes from the PSC power
 	 * domain.
 	 */
-	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
+	err = devm_pm_runtime_enable(dev);
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
+
+	err = devm_add_action_or_reset(dev, ti_eqep_pm_put, dev);
+	if (err)
+		return err;
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
 
 	err = counter_add(counter);
-	if (err < 0) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to add counter\n");
 
 	return 0;
 }
@@ -563,11 +574,8 @@ static int ti_eqep_probe(struct platform_device *pdev)
 static void ti_eqep_remove(struct platform_device *pdev)
 {
 	struct counter_device *counter = platform_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
 
 	counter_unregister(counter);
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
 }
 
 static const struct of_device_id ti_eqep_of_match[] = {
-- 
2.43.0

