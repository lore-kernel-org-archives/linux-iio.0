Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627309;
	b=hwW/ow+g7suTBe9hmKimz+keoWQkwA2SwqM7TxTOqliZ0DASEVcRDhSkUfFAEpKP/65l
	 DW/7kB1Fg5j5mCuL3V+qm7mKshLc6SLz1EDLfHhlRudD6ao+E4Xl3SR1BhTzKGdRxQi/Z
	 +AwXbBC74koA5p8fNYrowm4GM5AY0WFPaU301J3zqUD8IhKwSlL0jcHsm41qDfq9/Eo5x
	 TQuqGpOv2NWyW/YXddYFE0km/Se9m0c8mWIRn95Lt6/kCP5q9txS+L5iAMoKGTCDR8dPQ
	 JIKw2U9tb+xIrsMjdBP2U9p+UGSu2J6EtYk/NJxEiti3LiHsAqiCbyAOOP6swoO6DTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=blXYgQJJBizz/bz/KIQMetOyL/YCHKq3pY30hwAK25M=;
	b=kINduYA2ddNu1G5gPzkgyGLs2k7tEl8Bdv3yw60bjA39tMNBW0q+msO5uFgCkj2Z+GyV
	 Igkg+sxdM+KmK2jXtqFzwDL/6a+mxpb2xWtb+Or9v3BbqWuR+wBo2pAOeqLIecxHa3HpC
	 DX7LQBlJKmTDvydO471I+LzApT94ZMU7IORv9M2S2I5RxFnYw6VLp0M/sOAlBXyM7oe01
	 XvhnyiWzmbeptFBDcnX9/U42NckyrLjS5uKsLVFL2Rcqx+VIE16VwTN5D+KWuPRCkfANF
	 Rk3H/pL/RMear5SScCE4gzkiBjJ8fUFcE32wETt1VXRyfg5h5ZPswRuvvI5HWb98wLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NelsS96C;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56692606A338
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56692606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NelsS96C
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35f1f76ea84so1851520eec.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627307; x=1793232107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=blXYgQJJBizz/bz/KIQMetOyL/YCHKq3pY30hwAK25M=;
        b=NelsS96C6bj2mZywfkxDxSnUjkXtFur6XMZuZtSmnKGE9qGz208ajyJZwN/WEP8Obs
         anrHJKyf7UmvRRRzyIo46WLiZPaea20IsdzILDfOpEAFyprvGcC7Yyr7ub5QupGdFQN/
         Yrzx/SaJtWDcDapVW1fZIa+/KRsnLYGwgvRj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627307; x=1793232107;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blXYgQJJBizz/bz/KIQMetOyL/YCHKq3pY30hwAK25M=;
        b=XKko0wHYHl9MkfUDRQyKrafEvWwiNowrEEorhv5iGJFP2vjqSve3F9rNtLRMsSU01n
         z2cbXmN08/iOZAxJ1ueBNc88xBdY/PmlRGSEmJGDm4+ZvPYBy6Oy9yR2ff8lq7Uzr1cl
         q+Mluskr0yyN9W4kJQ2Bd4vHbTtDbon9ddxS9Vfx4pPVI1luxOeEbj+rpMoQZfTlqJYB
         QJZ0/tMzCakEScIuSzLSYiOTACRGGv9GGVc+y4pzWQg1hGxff2dfEax0ivV7a+gN1XJv
         FfrrPSpTwTw8KYngzplMlYVc2hZ0tfDk4Y1MLCgNNPgd0KNufqRxq5J2Y7pBOX3XdSBa
         dxDg==
X-Forwarded-Encrypted: i=1; AKwUvBzkMWshnUOFPsVxeFBfvCKj5ZwekjDN/918L70JyBxInoin2ybP+8OoyvKpay3Cg6F7lmx96zdr+qI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnjtspoQmCVgyhUGDwcmClxEzQa8bF60qeT8lujjrzc7Ct4Sro
	Y7aOp4PQTiQ2dC+grGpyYkzepppHywjSKx+3XfzWBYhg9DzIUBWl7Ny1PVBoCEKZ0w==
X-Gm-Gg: AYBFou1dSvegIjAKPNP0kjbKlgSdVtUulNo3ikzSQKi7JaWE6ziCfc4sdjzRX2XZS4M
	1cdTotWPNjVazHLGFitX9it148/WJLYQFP4mSeF6l73ZTo8qUAT0PSRN3Hlc99NebugUdMEEELV
	Hm4KE6DETUSPKw0yy6m6qUDZHthQ56TSNhLzfVq0nbYpBcLjUhv6MnfSca1+0eJnoIedJSXwz4P
	Z/2RL5mj+mK2llmAhfz/EdAWBZAciSUb5eVfW7AlCWpA5mdhr6fqoPq9+QLkV0ylSfjY63E7dDn
	UBqUZ8emAVmaw6t3ulohF0gWLYy8p5WH2fOJITVaCa+6NmUrMzjoRlwMsyDhyV6OvytED6S4wXq
	TbpOqgUQjMApi4emyblAg1iKQUK/IhtYYnObRHmAPvI6OcK/FpXb3ZP0O9Ar4SkhqV3d0cJsbRw
	Dod9Z8uB/7vWjypTUJ21TBK1fil7gXOxDz+JjqTa4NCxhUTcHAYdfz32/TOs8cBkViUmuEgPfp5
	4oaXE2XmBGFqBNi3UEcoOFVNVw7AL2DUY/mqaodsmOwutZTXOj3BaDDHZbc3DChagrRyPLqcFBZ
	o8+3bxUCv75wWZXIC2U=
X-Received: by 2002:a05:7301:e2e:b0:368:8d1d:2a81 with SMTP id 5a478bee46e88-3688d1d2d90mr1563701eec.24.1792627307305;
        Wed, 21 Oct 2026 17:01:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36740cc848fsm10851892eec.13.2026.10.21.17.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:46 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/17] iio: light: rpr0521: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:16 -0700
Message-ID: <20261021165858.v2.15.I31ffc98637199185bab952631d880c1d38d64b7c@changeid>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021235818.3059519-1-briannorris@chromium.org>
References: <20261021235818.3059519-1-briannorris@chromium.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver propagates the return value of pm_runtime_put_autosuspend(),
which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Simplify some conditional logic

 drivers/iio/light/rpr0521.c | 57 ++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7d82efc31f3a..6305d7a9c282 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -357,32 +357,31 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	 * Note: If either measurement is re-enabled before _suspend(),
 	 * both stay enabled until _suspend().
 	 */
-	if (on)
-		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
+	if (!on) {
+		pm_runtime_put_autosuspend(&data->client->dev);
+
+		return 0;
+	}
+
+	ret = pm_runtime_resume_and_get(&data->client->dev);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: rpr0521_set_power_state for %d, ret %d\n",
-			on, ret);
+		dev_err(&data->client->dev, "Failed to resume: %d\n", ret);
 		return ret;
 	}
 
-	if (on) {
-		/* If _resume() was not called, enable measurement now. */
-		if (data->als_ps_need_en) {
-			ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
-			if (ret)
-				return ret;
-			data->als_ps_need_en = false;
-		}
+	/* If _resume() was not called, enable measurement now. */
+	if (data->als_ps_need_en) {
+		ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
+		if (ret)
+			return ret;
+		data->als_ps_need_en = false;
+	}
 
-		if (data->pxs_ps_need_en) {
-			ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
-			if (ret)
-				return ret;
-			data->pxs_ps_need_en = false;
-		}
+	if (data->pxs_ps_need_en) {
+		ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
+		if (ret)
+			return ret;
+		data->pxs_ps_need_en = false;
 	}
 #endif
 	return 0;
@@ -545,17 +544,14 @@ static int rpr0521_buffer_preenable(struct iio_dev *indio_dev)
 
 static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct rpr0521_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->lock);
-	err = rpr0521_set_power_state(data, false,
-		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));
+	rpr0521_set_power_state(data, false,
+				RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK);
 	mutex_unlock(&data->lock);
-	if (err)
-		dev_err(&data->client->dev, "_buffer_postdisable fail\n");
 
-	return err;
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops = {
@@ -718,12 +714,7 @@ static int rpr0521_read_info_raw(struct rpr0521_data *data,
 	ret = regmap_bulk_read(data->regmap,
 			       rpr0521_data_reg[chan->address].address,
 			       &raw_data, sizeof(raw_data));
-	if (ret < 0) {
-		rpr0521_set_power_state(data, false, device_mask);
-		return ret;
-	}
-
-	ret = rpr0521_set_power_state(data, false, device_mask);
+	rpr0521_set_power_state(data, false, device_mask);
 	if (ret < 0)
 		return ret;
 
-- 
2.56.0.218.g1ec904b173-goog

