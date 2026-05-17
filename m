Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10A364933
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034098; cv=none; b=FSRCp8ZnP6/evQcI00OrkSecg1IuCvmFDdj1ry0/2sBioMpaVngAnhf39qZ64IPiZEjfwSe86yDJAs3Y7Du9PF1p2ZhgtzsLCOOmwx1kuFmfpXxXnJ0UHUAZ/6RsIbYA7h0k67kWE8GJUuzASO66wsTB3NDVGxhC/g+orsFTTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034098; c=relaxed/simple;
	bh=hQ/rVVhIPkk7pPHac/pDnIhXRjBlYPw7rVFREviEY6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PBAVBWQYebOTYBiIsAGfOd/ogZ/GsWfOfHv3pmxxJW1Qne0rbjHP8CzngbVf0l1IuRONKf7w/tbGF6bWzzs0mtM8esUouLZmX6zpNx5JvGSVgK71+UcpC7Jb1Vd1n0DbneZeKjxgk78SrKphXZEErjIYmCZGrCYvaAKU/X5XCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smgWc+P2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smgWc+P2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so2424105e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779034095; x=1779638895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmA31C4zCBuHUyR5/JDkmFyRbtrkEf1aMpi+puaLur8=;
        b=smgWc+P2ttkEBAsankScA8k+PHZxnAl82fMmb7Sfw3ym/ofEDp/BNlZ99cAO1nkgHK
         TNofGlESuR6+T3xz6aalee6mYA/h4fnDQDD2QkUMPeRfFl7mR9e9EYLdqYGsS33kWd5k
         vlPxBblI5jeIkLjlxIsBtWDJ8/9EzlVqHghOSm8apBbq++aQlIuaMPLC0wAxQBXBXBta
         IXCZdk13ImXokuNBPr04a70g1DhBWDAaIIP+KXZPMhNvlf71+OpTRyskpJ/qBFnAMtUS
         Pe8r7/rZ4HRY/i5ut+FCovz/aImCDlLIiU94MMdibHj3V48WZY7CCL8ZqPICTtga2p9p
         fIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779034095; x=1779638895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmA31C4zCBuHUyR5/JDkmFyRbtrkEf1aMpi+puaLur8=;
        b=H9sn8afTdtiHJNI8j19QClMo/+pxBUYgDMuMtnSI7d9sI7xeEFVwdEtMpMat5fOMXx
         MVkZeDLVmKonPCTGkjwsfbQuzsPB1unwKw7SOKdbkTZMSpsRQoiA24/G3dY89V+CS8CF
         9F+Td+KGJAyravbzfKH51u5CzEodDh515Z9LeifOhcZ5nBdBknnhdy4gIP5AJO295Jh3
         sHUOoqo3Zu8433LP0MKePMJ7q2tjRdJiySZuj8V3Qc8N77PiIfB7il5pZwrUgp8H/yfg
         ib/tAkGYGBesIS6OCvO1Bq2gNXcRrB7FxITH3X3gVXgGuPZXTGG2Ggoy9aO9f1UUYs7l
         5ecA==
X-Forwarded-Encrypted: i=1; AFNElJ/kWjpmTjQCZg+9at/QKGTDz7ryuf18p7u+QPdNSBcvcYXndTPQ1iSUecJkeq6ODAn3UI7sblhPUQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HjYjcUQvP8kOolyQ1aem0Tv3VYCyFOJfkRbvfSd+gvNAEq3D
	UoLVWC1KHeYR/mcZFyBnS+LL6/SPbnROYeAG1mRSM5CzbzNvrlmvZJdn
X-Gm-Gg: Acq92OF87Km//ol/IySYZzJoRcOWDZFwe/D9I1xN4Gxn11bAOM1ylF6P6pQ9KMMmXbO
	RaN/j4oSbKiMBDtVeJVLHymg9CoECz76vFL6gM3yVzUYkr+ZQM5QH+HZNJIyLAaQ0dPoFdN/bcO
	a8Qfgvzsae9DsbZHeJEdRdvGyMEhsc0hJrqqrhkrRy/QKLOWqMm1NQSfDB9J5QNSEVHnwc9K/hz
	YX1gX8viXXBJQkU85FrukdlbIfq22xz3cM8NrnXtru3072e8YCbxBOT2jspkW9YTV1lcFsHjshG
	+GZu2VQ1Hrov6Uw5BhVvx3Ths5iiOlrJ8iKHB+33z4KPw5JpsxcMseO41VRpOZ8mEeQQnGNETsS
	U1tpIA8NZapkFqoXbNSCA/yezhALWPn5WVEtwAfR5T14KKkozWmvAkFiyFy8/cbS/3uiE8B8+fY
	P/na4gnxPRR4cOjpQl0TupnVIsa6myk/bc0NcSFr9cwaCx
X-Received: by 2002:a05:600c:4704:b0:489:1ca4:c999 with SMTP id 5b1f17b1804b1-48fe66550aamr78753665e9.8.1779034095426;
        Sun, 17 May 2026 09:08:15 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf81970sm83892645e9.8.2026.05.17.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:08:14 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: mazziesaccount@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error paths
Date: Sun, 17 May 2026 21:08:01 +0500
Message-Id: <20260517160801.269-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bm1390_trigger_handler() has three error returns:

	if (ret || !status)
		return IRQ_NONE;          /* status read failed */
	...
	if (ret) {
		dev_warn(...);
		return IRQ_NONE;          /* pressure read failed */
	}
	...
	if (ret) {
		dev_warn(...);
		return IRQ_HANDLED;       /* temp read failed */
	}

None of them call iio_trigger_notify_done(). The success path at the
end does, so on a single transient regmap or pressure-read error the
trigger never sees its use_count decremented, and the
!atomic_read(&trig->use_count) guard in iio_trigger_poll_chained()
drops every subsequent dispatch for that trigger. The buffered-data
flow stays wedged until the trigger is detached.

The IRQ_HANDLED return on the temperature path additionally leaves
the temp branch's last partial state in &data->buf.temp without
pushing the sample, which is the existing intended behaviour; only
the missing notify_done() needs fixing.

Funnel all returns through a single 'done' label that calls
iio_trigger_notify_done() before returning the saved irqreturn_t.

Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 08146ca0f..c18352399 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *idev = pf->indio_dev;
 	struct bm1390_data *data = iio_priv(idev);
+	irqreturn_t result = IRQ_HANDLED;
 	int ret, status;
 
 	/* DRDY is acked by reading status reg */
 	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
-	if (ret || !status)
-		return IRQ_NONE;
+	if (ret || !status) {
+		result = IRQ_NONE;
+		goto done;
+	}
 
 	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
 
@@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 		ret = bm1390_pressure_read(data, &data->buf.pressure);
 		if (ret) {
 			dev_warn(data->dev, "sample read failed %d\n", ret);
-			return IRQ_NONE;
+			result = IRQ_NONE;
+			goto done;
 		}
 	}
 
@@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 				       &data->buf.temp, sizeof(data->buf.temp));
 		if (ret) {
 			dev_warn(data->dev, "temp read failed %d\n", ret);
-			return IRQ_HANDLED;
+			goto done;
 		}
 	}
 
 	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
 				    data->timestamp);
+done:
 	iio_trigger_notify_done(idev->trig);
 
-	return IRQ_HANDLED;
+	return result;
 }
 
 /* Get timestamps and wake the thread if we need to read data */
-- 
2.43.0

