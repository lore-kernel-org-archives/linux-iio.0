Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3A21D3F2
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171182; cv=none; b=TkcEKnGgZkQ+mWrShqJi2DjtMSX063IoUM8ZrQTS1fTadFL0Nu7OKBxN4imiYeiI0tdjzzZSR1/leOzpTspeM1SDI5pnLdn7HJLMe0m8PJ9lWqEDODU7X6cwAdlFOw9j+Rzb+ggiJNyKdxZCPtRPwP1esRt29aVdSoQylmvU2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171182; c=relaxed/simple;
	bh=oKNM+REI2hJr36BrtfD7xQkxrbh+hxTcT/mf9b+Xtuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwYlTNs7vrOifaMnnlQeSub390PJbz5RMyQEE1jlohcv/PPXAOxjfagR4Q52qFGHPlcLFV+QMFCIRQEjoxcNCT8Yt51dY9q4xfqooAtkLuhg4LlRLzNydSSwYOD9Oc3zXzssIYCr4S/PJFh7UawtircGr5tKOcWTejXCjesKtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaLHd+HS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaLHd+HS"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89464760408so34757426d6.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 18:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770171180; x=1770775980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz9Ddn+Ui2x0v3tU53PwxQ/IEt9Xt+KCvMbitscFCiI=;
        b=kaLHd+HSYsGjMQDqh5NZ8hFRp9EQUtlxKz5XLZNCno8To5i8l82u93YQnOEtum7OY6
         OE5o/B22vDfdJN4wnad1PAqyh7GEpCw4PRXt/PZS/I8pGXZQZAZWsxbScv12x70TXz1k
         /rCS263tt2Cayw9inNqz5KRxYFnyYr/2xD9mFpuAmFrP1SOoDL+NE+e5EK8soNQ8bSW0
         +eDWYqghNk8YQqmBRiw58hIl4c9Di9ldiKt0DU139C2/WF/L9QR6BAoX4rkFWS3C40Wa
         ss4i1UCBOtLZxpRxGGsWcPL01AO1+FOfp/BS2vqeAtCGylWZYiuWTdBwzD1fbhrRHL0V
         yuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770171180; x=1770775980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gz9Ddn+Ui2x0v3tU53PwxQ/IEt9Xt+KCvMbitscFCiI=;
        b=TfW5NQwkq+f5mIvXvdVpaRhIL8US3XgSvfwob6QNMDSTUImGXk5FxJxtUV78f+vPiQ
         eqVR9B5dyhm8f/N3W9HwtYKu0+5yIRHm/3+6HjmEqUV6nyl7m0okRAc1bm4ZhYSt3YOk
         LaXdYkYI4K0AINj227KoeNb9FgT6C21x35xiQ1WEsldA866z4qmwpCQGNybq0vlwUmzO
         YD9Rz43iGCrlEsiXjmgQFDJpDRIL9kgmwzmEOyc8cxwxrqLoXiALuFLojeUhFZiwG7AJ
         i1fx7U/ipgPAQALzbYhDz/enLM1qJfpbnBHD4wy/HrSgOo3v7ykiCJkDHuAq8JlQbygD
         DrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUfZ0kxLHPfP72jBBtn10sYcnvTvxwx02l4+Bdoy75s9vkmZJ9niyRTAlYhzuj+zBLCIqHadWk0xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Hh+u0FSZ+Eq7WtqCwZc8iJLt5jhp8Y9fJuB+nvefM1VxRNRB
	rl8GDeudc2i0OGL+ou5XGcLEExzTkBdhiT7/CrFycdPV0Bzl63lMGSSL
X-Gm-Gg: AZuq6aJ0O2vBepFcf1iun4QWFQZ2nHHVlNpvzE7LhpvyulbvG/4zOhYgqpyX60rQJMn
	V9CtPBY/ZLL2U9DsVfrmfBFPvOLWSXm/F9RjdQQjCFnglXjO2RcVhoIztQYQsuAKJVtp5/uroHz
	JC3kLjN42E3deVu/zAGhvhMb892mCvzA2wk1AZJ2JdJBmDjZ4gcU1vTXA0Nij+t27HuBkklKiGB
	4QzHdb1S/1q60sP2pYBUJaGNQOPQ1NIv3hYzhhK+L3+v3feL4di6loJfi961iGtdr+nXhTWxqlg
	j/0e0Oncpd6sOkQa9az0iMjApQnYuZDKbDQD/4kvPGSQSsyBTgv2VTVlTlM4kpfemc4Yi0j76Uy
	4xmWCgiBXjb3889iokBUCSxJdNx73SsrtHBpQJEhlxBYE3JucG/YWkgHFGLSe1gYzptlrkk8g5B
	duVR5GsdoYfLxjgA==
X-Received: by 2002:a05:6214:483:b0:894:2e1c:3a7 with SMTP id 6a1803df08f44-895221b104bmr23637516d6.31.1770171179564;
        Tue, 03 Feb 2026 18:12:59 -0800 (PST)
Received: from Mac.home ([76.64.58.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d255bfsm9333446d6.46.2026.02.03.18.12.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 18:12:59 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] iio: magnetometer: bmc150_magn: Used guard() for mutex protection
Date: Tue,  3 Feb 2026 21:12:41 -0500
Message-ID: <20260204021241.53891-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260204010529.48000-1-neelb2403@gmail.com>
References: <20260204010529.48000-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced the manual mutex lock/unlock calls using guard() to simplify
the error handling and reduce goto statement usage.

By using RAII-style cleanup, it ensures the mutex is always released
when exiting the function, regardless of the return path taken.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6a73f6e2f1f0..bd2706c2078d 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -794,32 +794,25 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
+
+	guard(mutex)(&data->mutex);
 
-	mutex_lock(&data->mutex);
 	if (state == data->dready_trigger_on)
-		goto err_unlock;
+		return 0;
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
 				 state << BMC150_MAGN_SHIFT_DRDY_EN);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	data->dready_trigger_on = state;
 
-	if (state) {
-		ret = bmc150_magn_reset_intr(data);
-		if (ret < 0)
-			goto err_unlock;
-	}
-	mutex_unlock(&data->mutex);
+	if (state)
+		return bmc150_magn_reset_intr(data);
 
 	return 0;
-
-err_unlock:
-	mutex_unlock(&data->mutex);
-	return ret;
 }
 
 static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
-- 
2.44.0

