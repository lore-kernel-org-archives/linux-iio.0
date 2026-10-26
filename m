Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009059;
	b=BeEz3rOrwq/nFwUlgdkH1fgRxiWYqJUrHem0KwGPPFMkUUaRn/1ielngHxas1Oo7u076
	 ASzuCCX7kvz57+CsQqpgBSnps+9Tx9HaxfpqKge+F3Vd6Go9Va2Q6hCe76wD1APqWB2gD
	 p1tGzJuF7fIrOvvJQ9LAPUwVNXlYyfYKQrqz1znsKQKKvDjWtlsBSwoVBfbLJ9h3I2T18
	 ZClIN1njQtE9/D8Hsv4Ip2Hm4adCwCEG0aYMtz9QYKAu8IZnDXlPfvgEw4v+XVUWNoXXk
	 /Zcz8JcZXazFUKypnta24wdQgTXrMyIalhXEoTU6O48R44IfTh81aGEDepp+vvoHjRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SUhKacUPcEfGkuCQUHnRDcpQnpQhPiml5zAmvcajhUw=;
	b=LpV2xJ+fp+NEtvtb4M9nbVsx8JcOWEhIvcUPLVs8C/nfXuEhY4s6l6cIDx1BU/i8ctIo
	 KQAx/ZKLgChrPV+ihMN/oCnRc3cHGP83Cd7CIZ2fAvZTYrliIlbWElGG5IiqsavI7ZueT
	 bb3NQVYxDcH6CsRtrdWGGQZjuEvZIbs81BLvKnRtgo5yDrsAT3HUW18U1mb89Q91KKDU7
	 Nes/M/06Cfvmp+iExsg8i0FlF+Fw5DdW5DLaZBCwCpd8/w4JftVhV1omDYms41EJlRp4i
	 a9FKQR3muXWtx2K7cjrBYssrjc5/JFdglh2n5TdbLhHZEDtPlLhmEfJPJ8TSPXDk+GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWNVRc4q;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACF606A336
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AACF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWNVRc4q
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so3401917c88.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009058; x=1793613858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUhKacUPcEfGkuCQUHnRDcpQnpQhPiml5zAmvcajhUw=;
        b=cWNVRc4qTggKC791E3iAer+uNn1BzzT7ShEeMYdtR0VdilgdzheLhP+XJr4GpyLVIc
         RQM53UFWaeEcNnT0sSW7Ane7LAkTegW6ghX0gS0zc05CRGWjUBfIfIoclrJLt9Yl28rX
         VX9ZooqhGVzVt1ASgB9bmo3W7yYkZqkCcDhuIT2vcx9kg2Wd7hUFMsWRJM5ewKv4C0rK
         MNip5c4uIr6kvkl9Sc/4aTJpNrKge/bSzZZEwBaBy6CFfhbJ70zLAJdY1RDy3K+Jc7LW
         WTQNY50Th4bJoyIvYyAfxsXalxFYvNM1fjsRCmaIOjBvhQFadpRPv2Ptozd4QiX2PVLo
         A1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009058; x=1793613858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUhKacUPcEfGkuCQUHnRDcpQnpQhPiml5zAmvcajhUw=;
        b=2pjN0kNHfiaWEfy+RaGLaCfen3wRBxHe2WHjtL+6VZPIDFNmWR5CzHbtQzsgsPc6jP
         xQSC7L5vLMZO19BwWXhJ68TgvlERS49f+PjQOsJIGRi57YYYzaDPXkGO4jaLmVr5kXwB
         B1CY66+tQ2KL5aaX6o8JqXRvTxfkrscyUL2z+XhGSR/DhRS2qp1V79CGYUwMxAUogGGs
         IV7fYBWnvMp89EpsFT85oUoZ8KnoxFdKk9fkAjD3A0W6OEJQCfdUVQTeZcsGHnVNVhAg
         Xo9ha6uO2/wTMSnKZppR9xu0A/HFJRBWtDRKXIb/T/wTx0KOZ70hNe0iuSh9GXu3+8mt
         lwZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzB10vHwqwrXGh7ngkYyxiuGm8i9iPGzijdZ6JJLI3Oj55WYJNTYKlzVeCrXQiFVmdb85gW/FWeUds=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl4x3w6bay3pG/Wl/qaOOccO7wfHLlxw1LSEefGFiOStg/dvzT
	j3RSyDFzcOnTnELCZA7h1XGxZHkxoSHk5fmFfLgm+FCKqLdjFvj/JtTYCsXf0abPYY4=
X-Gm-Gg: AYBFou3DLrh7tCVCvJn1Ha9tr0V0AC/pm4eUvYT8GTBo+kAVqqdSMr7u9+E071/K88Q
	mmLauoxEdsTX4fmBcEXtbt7k+tHhugZV7QpgPlS6Bc7Rp8xbxWoijB463A7Esi4tfz9EIUfArWk
	cfyBw24OjomItusnvrdK2XN/GurMSPBapvFOoKcpKo6qsnucY0BTP8xSaqpCdciISIZPtpt6aLH
	B5pHIaPSmEhib0Q620+jj+EDQOlE3QjlDeswhbe1pNgC7SpJBpH85ejKIZWTwHxOufFwNA9INnQ
	RSkrANMOY+lrEWBevijClWTSNiWntDVhkCfb4tB5bwXh9jLPONtCDZefdxlWfpetj3BZBM3Hcay
	eCaqRsqTo23cRTGJC/FJUjDL3fDdycqgAk1WfNIvme2jtMbEmGQ608NOvl/crPEWLu8lSjRTwPg
	dCj8KIS4O00uQBePdp9/2n9DaXIt2tpOlWZ9UMbJK1cF7qMJOY7FmB/kMQHuw0sgSd0FasIfEYJ
	VZRiBzRrNUJmeADIQq2fsHSrrkPOwEifmyG/H5FjyLynSFCzvDEDr8cd34ttfpz/NM5rUlMVSO4
	UetTnNY+0Q7t9+xOi0JJuWlhBOoHeKdU5N9Fw6vCacBuhD3V4WZvZyxQaCFXWoAxE7zRzCg3zLs
	417GezmUWXHCW
X-Received: by 2002:a05:7022:1102:b0:168:6ad8:e88c with SMTP id a92af1059eb24-19936d407e9mr9640122c88.39.1793009058020;
        Mon, 26 Oct 2026 03:04:18 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm23800633c88.14.2026.10.26.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:04:15 -0700 (PDT)
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
Subject: [PATCH] iio: proximity: sx9324: keep the IRQ balanced across suspend and resume
Date: Mon, 26 Oct 2026 15:34:05 +0530
Message-ID: <20261026100408.16874-1-kapoorarnav43@gmail.com>
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

sx9324_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9324_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
I'm sending the same fix for sx9310, sx9324 and sx9360 as separate
patches, as the Fixes tags differ.

Compile-tested only (W=1); I don't have SX9324 hardware and haven't
reproduced a failing suspend.

 drivers/iio/proximity/sx9324.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 255a36976ac4..ced415747a98 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1088,8 +1088,6 @@ static int sx9324_suspend(struct device *dev)
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
 	if (ret < 0)
@@ -1100,23 +1098,32 @@ static int sx9324_suspend(struct device *dev)
 
 
 	/* Disable all phases, send the device to sleep. */
-	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9324_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
-				       data->suspend_ctrl |
-				       SX9324_REG_GNRL_CTRL1_PAUSECTRL);
-		if (ret)
-			return ret;
-	}
+	scoped_guard(mutex, &data->mutex)
+		ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+				   data->suspend_ctrl |
+				   SX9324_REG_GNRL_CTRL1_PAUSECTRL);
 
-	enable_irq(data->client->irq);
-	return 0;
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

