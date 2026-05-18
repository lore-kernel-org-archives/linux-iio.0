Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BC382F03
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127889; cv=none; b=vFUEl0iqBjkCc/vhTLWQYZxCs7kHm47V+lsPAMcl+3F+3h7qUWXE3iG2JC6Drs3EAlRAPswUaQfXFx1m3UCDRZ6ZiyVimCgG3RQ2YNl/tTMOmhvRKN4vVrlxNIR8ShioOwZk3jUxIPdPgfOhaV2Sm3ihQJ7eD5JP9nV9pi6c+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127889; c=relaxed/simple;
	bh=zKR+EqacPdt0290Iim3CCXYJMGml3J82UJUJ42S9aQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ihsxikWRAA+pP1yLgfdHlOVb0Yfm0NWgEB2QocQz6Mvjo3IZ1svjnG6T919jeu2C23c/7chltOXFI1gqG52QFlSizfc51PskBKER6cxaa+WEnWTw4T9ORqHe046hYCj71FIn0uq4ETLtQcgSIlHL0RrbrGpTPrJA/qeEHV9nuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjC9ed6m; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjC9ed6m"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4462f8d2488so144628f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779127887; x=1779732687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGsfs0DFjcY+v4OH19XWVNeh3rO+tmY7PUU6YnQMlAY=;
        b=sjC9ed6ms88Z6rqmg2wBu4CpF2p7xInZRZrMsoRnGI2Zmjxkkcy1AxCCC0gE5dPERh
         wQ39uBhDwEEVs5Gn+HbwYI1HyV/wjtZj1GNwRokT77miIVtO5gYfB5IylCJACF+i6LZQ
         9ae7IyHwmatGy6y12cnIfVjvf7n36ad1y5RA/40InLiSimk+eGOge4RTngbIjgmHSHTp
         VKvSSiX9sgJx80u5zEkJkC2zKE302cDq1Vm5WfQI/AVQ/JwI/MLfl0houaxdj6KY9ly+
         HDQDrbXLGjz4OG3X7Merq5gWbmDNvhf/LlAq0lg3vJP9lh0JCqilyWBMZox1vTcOGEym
         eiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127887; x=1779732687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGsfs0DFjcY+v4OH19XWVNeh3rO+tmY7PUU6YnQMlAY=;
        b=oZR5Mh+kR3o6fVNkRgxPohv+f+h0GwYHVjl7FA1ynVMFdRMOC6+ZV1WPjjDjarHPaL
         y8cRMgLgUGMmIVDinQ7Ytyiw7poIuC6Zrs0jRRSnNgCUcPxFJA7XxYTjUJAhQgRhzdNq
         7dzopwKVvkz2/1C2vZkjP+Ab0z1HiTspI0f7RrdZU26MDeeyU4BJ4FUL/DDHIAr5J7w8
         AiT+NhLNrqACCICYl7nT4VLwl6dKL0detryw5lUQgCA7mFfpb9sLAwRLLgSj1FTMaJrf
         Qt2RKBNJIDO5zg+D8BGiU8G//3s2/yk5r49J22PGZ5jhWL1Ai5Usz94yOGBmew7Noz6q
         bP/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8XDxXOIpdLg6p/E5yk8bBUJJOX0JQKyto2y+TUQfD60ELl054vaNLxKTrYqAgFNZmYKaAjgx0JuJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/TQTjAn31KBo/wwhLRiBTLo5AsM5/Y0S7x2lIPdoamZFRocR
	KvcP/4dOE8b+Rc7+3lyvgk0Wxq6wS4CD0wvLD7TYzEzegshhx55Me3NN
X-Gm-Gg: Acq92OG2vkTgCkNArkOE2RMigo38FaR8xFGWgJCTagJbcalnQ6jbdZhEGSQERSUQ0aA
	Goty9e/x/5cKPNVMQnrb3eRYHm9AQwHUnweoaHnh1HIdxXcFhB+d1DOtF7jYA9AjTdb6x8Si6U4
	vbfJP0GnbdfYPrJ8OR7vYurr86fEICa6l2HNL4Shr6TtG4DOtOWyfu5jC/D1epIqjQGkSvqZhRP
	Sj4GbdYHjlDb9eMY9T+rEflPClvv6AwoA2gQhfnSOCY+FgAHkbu82plJ6w/wAM6C7M2OoYQ9tFR
	f1RJ5+duUMv8RHCJKvUoVUDYxKjp6AHimLyYTz4sQuwWsnmOUD56EqaaRP5QHpCHNNsMYHgHZid
	o00yKCK9TayaHOCsrsDmVIRXTAnAB3qHHOgNcztwMPnxZGiKWTJYW6DRHQHqs8xe7EjsXfkqjjX
	Y8cAbFLgmSnRp9mFxoxcjgxZPV6yK30m3I6718O/CoZbFg
X-Received: by 2002:a05:600c:1f8c:b0:488:abe9:86 with SMTP id 5b1f17b1804b1-48fe631817cmr115722685e9.7.1779127886455;
        Mon, 18 May 2026 11:11:26 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab7c5sm284281335e9.12.2026.05.18.11.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:11:26 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v3] iio: pressure: rohm-bm1390: harden trigger handler against transient errors
Date: Mon, 18 May 2026 23:11:10 +0500
Message-Id: <20260518181110.1467-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bm1390_trigger_handler() returns from three error paths without calling
iio_trigger_notify_done(). The success path at the end does, so on a
transient regmap or read failure the trigger's use_count is never
decremented and iio_trigger_poll_chained() drops subsequent dispatches
until the trigger is reattached.

This is not a fix for a reported bug, only hardening against hardware
or bus glitches; if a glitch is persistent the device is wedged and
needs an unbind anyway, which is left to the user.

Split the function so the inner helper returns bool with the data-read
outcome, and the outer IRQ handler calls iio_trigger_notify_done()
once and reports the result via IRQ_RETVAL().

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v3:
- Split into bm1390_handle_trigger() helper returning bool, with the IRQ
  wrapper calling iio_trigger_notify_done() once (Andy)
- Drop Fixes: and Cc: stable@; this is hardware-failure hardening, not
  a user-visible bug fix (Jonathan)
- Reframe the commit message accordingly

v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/
v2: https://lore.kernel.org/all/20260518094238.1986-1-sozdayvek@gmail.com/

 drivers/iio/pressure/rohm-bm1390.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 08146ca0f..007c1559f 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -621,17 +621,15 @@ static const struct iio_buffer_setup_ops bm1390_buffer_ops = {
 	.predisable = bm1390_buffer_predisable,
 };
 
-static irqreturn_t bm1390_trigger_handler(int irq, void *p)
+static bool bm1390_handle_trigger(struct iio_dev *idev)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *idev = pf->indio_dev;
 	struct bm1390_data *data = iio_priv(idev);
 	int ret, status;
 
 	/* DRDY is acked by reading status reg */
 	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
 	if (ret || !status)
-		return IRQ_NONE;
+		return false;
 
 	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
 
@@ -639,7 +637,7 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 		ret = bm1390_pressure_read(data, &data->buf.pressure);
 		if (ret) {
 			dev_warn(data->dev, "sample read failed %d\n", ret);
-			return IRQ_NONE;
+			return false;
 		}
 	}
 
@@ -648,15 +646,26 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 				       &data->buf.temp, sizeof(data->buf.temp));
 		if (ret) {
 			dev_warn(data->dev, "temp read failed %d\n", ret);
-			return IRQ_HANDLED;
+			return true;
 		}
 	}
 
 	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
 				    data->timestamp);
+
+	return true;
+}
+
+static irqreturn_t bm1390_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *idev = pf->indio_dev;
+	bool result;
+
+	result = bm1390_handle_trigger(idev);
 	iio_trigger_notify_done(idev->trig);
 
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(result);
 }
 
 /* Get timestamps and wake the thread if we need to read data */
-- 
2.43.0

