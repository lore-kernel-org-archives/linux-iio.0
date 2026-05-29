Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792A3C4B81
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048751; cv=none; b=HyfZkjjKPZ43LNblEXawPADePnkYSVD+nLR7oWIiGgTH++QXxm3NFCmxsT+Ml5OMGzZbAGlqfr4W14Lbam8gMxaXVHKnVuKwEjR0ajUgr2SwD6jPwjTlrZ7ts6ytNmqWTYi8e+1ed1r0a6opqexQKQNZAQYolDrXA0px07/X8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048751; c=relaxed/simple;
	bh=zpk7WwA/HuQxQBjY/4PQ71+fGV/wQyHGZ3pc6imOA00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WvtvGT0Lt78voCrm8I145kNPjvzcaIHTEH5dgjgbZoYvflaYd9c6nEtCmtoMjpq+k+2bLe3pdZnyA77DW08HlNKUH8tGBbhcrIXh9uCw4J+L2r5+za8PCoDa89Smpt/nBwx0qiDgR8do+72DOem9QBTKfenAkMTpYeMkPzUaypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isjNXlU/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isjNXlU/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa5a77c07aso46529e87.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780048745; x=1780653545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foAANAeJfAfM/cw3YT3GPXeC07g5W781y+R6Ho2ugfc=;
        b=isjNXlU/TGPSgdI04B4Or74xg0Vbh8bhXZlWVHdpqiEMvZBwQurDkURgFIKvS8kK0v
         XmN6k/C6FErpbOmEizFgKAQd8bOXGr08bsRDW0UYhKi0LNMRpjbD9CuW2ovSJfaCLDR5
         k80hRIZRxHwFOu87wVmd2ekQBFrHzu3I+Uw2ZVGub6A4ZQne0/Ycqc+6gtJLyFAijlr+
         fa5H5mFxk8BGOwFHNxIxYY7cRSDC1VLTm9rtGbQTGfHgUQoqfjWTIrcmRDq0SI8Gac5u
         8e6oNyjlIl9eHyb/by0bCRjkkJrq2VB4tl15Fuq/GH25XPJjkypkXmwa06k2mQ8Ry5Ah
         wmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048745; x=1780653545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foAANAeJfAfM/cw3YT3GPXeC07g5W781y+R6Ho2ugfc=;
        b=c53YlNPPYkT8J9VEp54isrCarksM9DNK36oH/QwoJuadazT4VwTbYjSbBtZfS6HFRv
         Ogoc8CEoC//9qzaNBinRYQM3jZw+DqIH60FLO7xE58UXnhIxmyUzoixzc5d9NUzmeqjh
         9AvoS3VWBrfMGY6VLxFdziI9xp0VOoISwh1/FM6kcy/TCcXdte9FAtumTa1v6UWLgQQI
         9ZCcIXzBosWrMPKDfeDVzdMmhcO09A21zjosApDye3OnhYjnRXDoS/kTLy5434U1WM9B
         f9PZCCZS7fHco+dkNLc7NMsl/jDlhrSX+IvTLxQyzCqhT1gF/3a9ymmlSkUuLiHXESFY
         7GtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QCuICz024IvQz2dJK0Qd7AexWSGhiyZrFYHPaCXOZbtElFYOwFvaI8yTO2lzBiDEGNRLF7TckUWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGavecklLc8wLZbwGazyD8Lup+JKGmmoyyNiQQzwazV0V4iwhI
	ncrLaoXqLSuMDqSZlR+4ikhVMhy99HkGep+y6jgNt+wMplONm+mkYknLdEnceK2c
X-Gm-Gg: Acq92OE7hc2DtO1RMW0Qnb/1/TdpTKTkyCQWx6zWkkzC7PnPB4n9EpNz19DE7PIU+J1
	l9sW+zEo5+x51MQaLC28ULF7fpejMQfIa+eHaKCUFjLFbfTQIaLaGqQXfeAG6W0HXRvjeno4FP+
	aKlKYPsJJIDygx56hR6dTBBT+jIR6jnN9e5k69kkQorN8MTWvWqwr+zzmm0thXgGgkcBpWPbuWx
	AahogHQ5CGn06rKXDO/NteS+Gu5gnS/lcoRen+Pf3jlRrHEYYv0wdZVzNLa1MQ36wiXXr918x8X
	Y56gpoXCbfA1pnLjb5YPTHan5lZ2E0P5kztdE+ZUEb+4VvCKi0CkQEtu+xu2n1AKQYCOO0p2Ind
	7dLStUdb1tnzA7TSk98iOfqZGC0EZetrYhD5Xtv8QOZVrJLpEAs7O4MQz6T1n4aqp2Uf2ksaL05
	ESy3zxOjZNf/PQq2sMUHGHal8dIGbVCvgSDHqbX+So+1CBo/C/dyOjjAY=
X-Received: by 2002:a05:6512:1304:b0:5a4:f0:c4c4 with SMTP id 2adb3069b0e04-5aa594c1db9mr238224e87.7.1780048745098;
        Fri, 29 May 2026 02:59:05 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39659e2a8b2sm1309011fa.29.2026.05.29.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:59:04 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: wbg@kernel.org
Cc: m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v3] counter: ti-eqep: use devm for runtime PM to fix probe error path
Date: Fri, 29 May 2026 14:58:34 +0500
Message-Id: <20260529095834.2561-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ti_eqep_probe() enables runtime PM and takes a reference manually,
then returns directly via dev_err_probe() if devm_clk_get_enabled()
fails, leaking the runtime PM enable and usage count. v2 tried to
route that error through a manual cleanup label, but mixing a
devm-managed resource (the clock) with a manual pm_runtime unwind
is itself wrong: the devm clock release runs after the manual
unwind, in the wrong order.

Manage the runtime PM with devm instead: devm_pm_runtime_enable()
for the enable, pm_runtime_resume_and_get() with a devm action for
the get/put. Every probe error path then unwinds through devm in
the correct reverse order, and ti_eqep_remove() no longer has to
touch runtime PM.

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v3:
- Manage runtime PM with devm (devm_pm_runtime_enable plus a devm
  action for pm_runtime_put_sync); remove now-empty PM unwind from
  ti_eqep_remove() (Andy)
- Reword commit message: v2 mixed devm with manual unwind, fix is
  full devm conversion

v2: https://lore.kernel.org/all/20260525152137.7428-1-sozdayvek@gmail.com/
v1: https://lore.kernel.org/all/20260523184448.7609-1-sozdayvek@gmail.com/

 drivers/counter/ti-eqep.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d21c157e531a..b24c8a29201d 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -492,6 +492,11 @@ static const struct regmap_config ti_eqep_regmap16_config = {
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
@@ -544,19 +549,25 @@ static int ti_eqep_probe(struct platform_device *pdev)
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
+		return dev_err_probe(dev, err, "Failed to add counter\n");
 
 	return 0;
 }
@@ -564,11 +575,8 @@ static int ti_eqep_probe(struct platform_device *pdev)
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

