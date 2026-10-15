Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25284334AA
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094321; cv=none; b=FwEa3uSB6rwCrZMMe6T/rgDlIhzyPcsTbzAUfOCBUERo8aFqso6LpRKkUEV1DVYXIRwDSVOMZJL3LHFhKUlRbclze8Jy7SLUQ1X0M3GqGIRygxFpM0WSPRMNnmXpVNSm7zvLzPNZMxhOypSEBIE5yceMelDB1hObXaH0r4a6Yeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094321; c=relaxed/simple;
	bh=oi0NFD2sxeVLggbxOBd/VjtlvLSmQTyJFOiBqgC2sGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lrMdEiqiPaaqqeDB/2+1zWwlcd5ucfCozBt8q/QnxafWhI9D6NTTTZ5kwkvYn+/rNcR2lx5ZuQSVyHputOVqtmtNX4Q7ltbApLiCkVR/NUG3lMiEBKCHjmHuM40egRcPPcsUH1abG0FzcWb/UAv/YSkNZ4QLLp/oACWPqD2FOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaJRLXO/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaJRLXO/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so24780555e9.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792094317; x=1792699117; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=krDwWoIc/Tok4StKGZ30+wtmqm7bSRyzfVvLkgkAXg4=;
        b=qaJRLXO/UvLfXNY/+XrQWSpbG7sdbbliL3y4T7f3rYf9kITvBJalo3up79Tvz4ITyW
         J8frvaU+gyVduwI2UHwF/DhjXZzbtQ7YtXp1dUadUhKF/qmspQWWvgJHxXCufyhzCpCa
         BoyhJkscne/Bge7xgcizF5Rmi97Y3x6O7MeoF08DivLKF+5NUkP4zRPruRqm3lFhgYTO
         b+RJd0v1Q/vz6w0VE0ZKSPsZfFCv9URB+6gq4Te7kU4bTa+lXr38FQ7TGwtqsQXjTEBi
         at+42C14v/m8VvasMUo7J6zSmCTaG/1s14P/FapaVfbIIk7tQ7qKYohIpDCBw8QBos6M
         ePRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094317; x=1792699117;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=krDwWoIc/Tok4StKGZ30+wtmqm7bSRyzfVvLkgkAXg4=;
        b=B65/w/k3JkQfOE5ijHsEAw1CbxXxMWJPStjGcHTqJ+t6jXIqmP9WT4x3bBaDOnKxxN
         AI6bK3/0QfbKBT2C8P1kD2GNJ69heMl+1BsL6zPZPSRg+ITJ4t4vinoaOdFuSOYrlNfH
         NrEZJ5wCh3S0+J2TXFRm55O6hkPN80Xo+2e1cNaXjXIe/Z8p7MDoa0NhW7IFgXzdJekX
         iCpnkiWA75kWKK+ilhDNh7f+K6yfUt7OgC0vlcE7pIId2IgwTULwwvYftcJn02X4ibkb
         0WCEi9HG8ova55qWNahPRQE7Y/XhnKjypb7l0fZopOWQEi71KXYdORwn167w6dC65Xwz
         CF4g==
X-Gm-Message-State: AFq9FYK7svgc24BiKZXWtDUa7nVB622Y2f8xIt8GPPhcz1pZKfeSAlSN
	x7PjR3TXFiS+8mdzCvXzP5BppBWc24/fOwX08BR6kPpIzbSHk/AzBpWY
X-Gm-Gg: AYBFou0DmS6H7r1+RutrrOn/OoNr4U9X49TL07xTYEQIIc+kjDkIfEGYq1JGbZogEBW
	c9UbSlgYkflXHS2+GzZHQyIUTtUr5Veu1CixILgBNNZL6HeoNKR88JL+tybvVImZDTxLQcsmUqA
	FeRlVYuWyQr7SR4WuRWJQzzXcT863YIeBvnNj017JnfdfmQI50CIHme9z103/D7PJ6JT6tGL6fT
	iFzrxLsy/W6rxDNKudHLun0L7YaNtTxUYjHc7Z3pYKj02KqyhuRszzB4mYdJCd+ztaooND9yvJo
	nUFPrClh8+YM8/LHHXByCy8TdlryB98cSpT2LEtUboUy47+SoJCWEQzM6Xh2/q0kH5eIaV6/RHX
	KXdzSZVV8iEstGbcjmrwR7DD6K45C63f/uokYOKDSs8g0Jy5+qFUELt1Zq8s/uI7Rc34U8X+GWX
	dcG8x+DbJdT40MVbG9KXz3T/XZcixZp6bWIRahd8oShuL8ol+pWdnk76lyrPiY6+h/AD40/+OCt
	tL/+E1X7XScN+Dn5LI1fl/o4IIzUBe7gcqB5eWTtbynDm8vI7ge0rIA5qTJuxo1qSOtoMc1hUBE
	kV+VnWhSk0lSCbWqDAgg2eGT5TBgZqjOuTSTFIZWXsK6UPu24K8kXSB4wQH1r4MuY4qicQMz0iM
	QMKsgmdZjCVdsNZ3lvDCxFXnmFVSUlhFSRyE=
X-Received: by 2002:a05:600c:4e4a:b0:4a1:ac66:6ac8 with SMTP id 5b1f17b1804b1-4a1c7fa065fmr11679165e9.4.1792094316874;
        Thu, 15 Oct 2026 12:58:36 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503862sm166375f8f.46.2026.10.15.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 12:58:36 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 15 Oct 2026 21:58:35 +0200
Subject: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ6CMBAAv0L27JpuoaKe/Ifh0NICm1ggrTYa0
 r9bOXucSWY2iC6wi3CtNgguceRlLiAPFfSTnkeHbAuDFPJEggj9+qqFEjjwG6lRum2tkvJioBR
 rcEXvt3tXeOL4XMJnnyf62f+fREg4KGWEpfpsXHMbvebHsV88dDnnL0Ln0/2mAAAA
X-Change-ID: 20261011-mpu3050-fix-145a77d5229b
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dingisoul <dingiso.kernel@gmail.com>, stable@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792094316; l=3915;
 i=joshua.crofts1@gmail.com; s=20261015; h=from:subject:message-id;
 bh=oi0NFD2sxeVLggbxOBd/VjtlvLSmQTyJFOiBqgC2sGw=;
 b=Z4KruJHYUtO7JqxO7hB8a8rCHcUK7BTCPb2J4xJNlIyIT0R3zvqV2nMdEqKRoBJjEsykJ9esK
 JPo7XAOv3n+B401Hv8tDAQGRL8HVvUBtEC3nRDywsoN/1QuM6dgWbNx
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The mpu3050_trigger_probe() function registers a trigger but
mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
to clean it up, causing a use-after-free bug.

Add the missing iio_trigger_unregister() function. Additionally, change
the mpu3050_trigger_probe() function to assign trig only after it is
registered successfully to prevent a null pointer dereference using a
local struct iio_trigger.

Reported-by: Dingisoul <dingiso.kernel@gmail.com>
Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- Add a local struct iio_trigger and assign it to the data struct only
  after a successful IRQ request to prevent a null pointer deref as
  pointed out by Sashiko
- Link to v1: https://lore.kernel.org/r/20261011-mpu3050-fix-v1-1-f55b0d138be4@gmail.com
---
 drivers/iio/gyro/mpu3050-core.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011c63..a887b65c0d18 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1051,14 +1051,14 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 	struct device *dev = mpu3050->dev;
+	struct iio_trigger *trig;
 	unsigned long irq_trig;
 	int ret;
 
-	mpu3050->trig = devm_iio_trigger_alloc(&indio_dev->dev,
-					       "%s-dev%d",
-					       indio_dev->name,
-					       iio_device_id(indio_dev));
-	if (!mpu3050->trig)
+	trig = devm_iio_trigger_alloc(&indio_dev->dev, "%s-dev%d",
+				      indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
 		return -ENOMEM;
 
 	/* Check if IRQ is open drain */
@@ -1115,30 +1115,29 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 				   mpu3050_irq_handler,
 				   mpu3050_irq_thread,
 				   irq_trig,
-				   mpu3050->trig->name,
-				   mpu3050->trig);
+				   trig->name,
+				   trig);
 	if (ret) {
 		dev_err(dev, "can't get IRQ %d, error %d\n", irq, ret);
 		return ret;
 	}
 
+	trig->dev.parent = dev;
+	trig->ops = &mpu3050_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
+
+	ret = iio_trigger_register(trig);
+	if (ret) {
+		free_irq(irq, trig);
+		return ret;
+	}
+
+	mpu3050->trig = trig;
 	mpu3050->irq = irq;
-	mpu3050->trig->dev.parent = dev;
-	mpu3050->trig->ops = &mpu3050_trigger_ops;
-	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
 
-	ret = iio_trigger_register(mpu3050->trig);
-	if (ret)
-		goto err_iio_trigger;
-
-	indio_dev->trig = iio_trigger_get(mpu3050->trig);
+	indio_dev->trig = iio_trigger_get(trig);
 
 	return 0;
-
-err_iio_trigger:
-	free_irq(mpu3050->irq, mpu3050->trig);
-
-	return ret;
 }
 
 int mpu3050_common_probe(struct device *dev,
@@ -1260,7 +1259,9 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	if (irq)
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
+	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);
 err_power_down:
@@ -1278,6 +1279,8 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	if (mpu3050->trig)
+		iio_trigger_unregister(mpu3050->trig);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);

---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261011-mpu3050-fix-145a77d5229b

Best regards,
-- 
Joshua Crofts

