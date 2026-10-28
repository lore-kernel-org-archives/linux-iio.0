Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225100;
	b=S5GrZhqy4Y3NyUp2Mvfx7LVKCpNpPPFW/rgtPCjI4V4wkxZtr81OjTFHZzSLsXIo1iWd
	 fWLuoXJ8n7KbEDHFuO4b9RGCSn2PZjwlhle12fM4XFY/KbwYLiNcFFFB1b9YtJjmHTpU3
	 xUfc0a56nb7FAQlwjLQDtPVPKRS/Bpa5CGaHWnZi92e+mcoIBYd14rzvDdt/nWcWYypYn
	 4fSuinEB57UoPmkHBPAy/L9RSbl4MM8+E5rZqGahKU+FVJc4LSoXyCqvqQmcmUnELOWEn
	 H43ct4EPetorzrGkJA5L4vuHLvD05Sdy9wxXfTqw9eCGp3UJC3t0dJp5lH5XIaDwwFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4gxQPKSvEmSqDf84R9LxS0bcPwImZgfZyHhD9RqXDRo=;
	b=eafqZwAyubSLa4x6C/ELqK6EIk519tlS8ABBCLEGWKLFMOMkvoOXdo2OYkPh/SU7AUxN
	 Kyk/uvFEiaxmv4enzBD9tTEytUXdv9kQlYO158qM2mOXG6qqaFuZ5yX+s8HHdQ2gSlz+h
	 5nY8EKhY5yJvCBAbJGrl0q2m9cWpInq1bcB5PnngC6RXq06S8NYmjxRbUq1nb/pHOLG1M
	 9aF1srE8JoEuMPIyqO/sMNIMeIPk3MvyBBviQmQfIbYRsBfQRbW63OEiybqdZOzqQmJXo
	 iNeS439FfjhF4QQbsdE/v+7iWNNZV+7ro/TYg+24qCfNtbpXrz9TXXM7JrKOa5Lm64g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rm3qbBUR;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B7606A31D
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 22:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 162B7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rm3qbBUR
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a1947498bso64784eec.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793225099; x=1793829899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gxQPKSvEmSqDf84R9LxS0bcPwImZgfZyHhD9RqXDRo=;
        b=Rm3qbBURqJbZcJ/YuZjXYKrilJzPN5B9V+GzEqpK/YgXjMVIXuWAOHKwYdVdw9F6bV
         XGIs/k7dgoJ7Ld9igM/zOEfLrPQDuJliSaC5pkV2xRaTXaSjH5aiKFvBWFsbOfJtnGTI
         MjwXZbtpqyPI117p+VkO3VP4K8wZIky9PTzrlPfqUMHzMYUa3Z1AeoOeYnPXEwSMsyQk
         pOhTWyBDhd+tBn9eynQusL1ppG9ej+5HaxpSM6LWCVbvqzhzaYSjJEd97y4p8fn97AbN
         38dPS5PD68sNM3UTl8L+fh5J2D/gT4SBwGADtSTT2rTvERQY338jhOrlatyEJsfkOBvV
         oWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225099; x=1793829899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gxQPKSvEmSqDf84R9LxS0bcPwImZgfZyHhD9RqXDRo=;
        b=Dild3jOKP9KaUtCm+M+kNBIjzX9Sh/SJENAc0Cit90iDCO3QH5Mk2o9FQavGZL8QeO
         Q8XcWkVvI8Dkb5VGfalCQeQwXQCuSTFTe8Stpp2yN8t7I/SVUi0DVMOlLr4cZCqgVJEL
         eGyPUyFZgRB+oWCIKAY/JGGHxiV+JMZolO3W5mG0eLNpg7Ggg0+tHkF/IZoIPV+GZvBa
         BdDREgXHI0i6gF6NcnOI/73YpbwGsVH/90QbJSPecw1Ex6OWpacX15149c4aBk8IR17h
         jqHZG4dmv2fXLhC8RETG7BGqPBvA7W3UabLgVWJ+IdU1jQDbjvuyftbzgxbslGmlgipj
         uuLw==
X-Forwarded-Encrypted: i=1; AKwUvBzmePJhylrobmLvReh3WmsVmo4ukkoUJ9Tt2YnphihYJvtX1T45+3VL6nqcYxoQvYKEM+0Cynqt16A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/ZGNTj3GcNtLGxnguiOIsXO0zeOc902anJgcwJo6q5Eu0KRqN
	CnrjLyIDKp+w+ZjaXfOgWjBCXNpNAbf207D34uagSeUluDfDbjrjpyQw
X-Gm-Gg: AYBFou0obBARZEHSoZV41yZotbGs5I4r/trz541gQLLclg664dimWMovpu9mqWndv1o
	wtzNg/2g5/IHpJzqk4y2EVy+Yt4xKB0wFpk4SSQw4HvR7tX5wPUvTAPWUz8ogcGjtT9H2XqtioJ
	zSuZvuQYGpbpDuY4ngu9JE85h3rcmv+tgW4fYXqpfA/vnZzwMQhoWRt05YspYdVsgK0KXKQCY9y
	Po3CXNaNXj89TE+XsmsUjoy9hZhtP0y/2JcJNEWTa7txmp/zHyMGyoOX988QGwzPT4deD5gVfx+
	aB2JoB3PcgOLWby0brZlPS/JpzXiPCxzanxR0Jq6noj5jVpNB8CUe/phaThSnu/1cqgOK2gw6rU
	J6kIe3Lkgde+HtJXr3/UPjiV/bmkyEJxkknU3DXhnbMQz0Ad44FY4Z3xmGaoSjrb9CVBJXaIp9b
	/0+AGpoJq8FoxTHBQ6xHbC6vKGA7dn7kx0xSaKBQ/cxNUzGPsKD+cSROr2wgD8XTqXQs2IHGyXO
	ndog6/UUgAUiu8CosBev3S5TmkQw/j56I0ggo/A4B9keMHtqxwTfBdZv7bUffGs0bWmpfhLP8bp
	PsQK88AekKQ5CeG9d33iry/lnRCYPvuqa/JmL6TvmwHQyVFus6T2McHWyDo4CsF7nNH4r0gJe8r
	tf1k5MJAMVqKi9he9NHGZro2xoTB7B7eD1d55m3t4+Wp0Gk2m18yGe9q0wOq6TZQ+MDpitaPvKl
	kGva+RQOk9IMBypTmid/g7NnYqoOAqTIDHN24VbrU0cA==
X-Received: by 2002:a05:693c:8811:10b0:36a:8a6:6916 with SMTP id 5a478bee46e88-36a203cd278mr5102546eec.18.1793225099148;
        Wed, 28 Oct 2026 15:04:59 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390a812sm9924429eec.14.2026.10.28.15.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:04:58 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 1/3] iio: proximity: sx9310: keep the IRQ balanced across suspend and resume
Date: Thu, 29 Oct 2026 03:34:37 +0530
Message-ID: <20261028220444.70121-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028220444.70121-1-kapoorarnav43@gmail.com>
References: <20261028220444.70121-1-kapoorarnav43@gmail.com>
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

sx9310_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9310_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9310.c | 42 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..f824d00f1174 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -943,8 +943,6 @@ static int sx9310_suspend(struct device *dev)
 	u8 ctrl0;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
 			  &data->suspend_ctrl);
@@ -956,7 +954,29 @@ static int sx9310_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	return regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
+}
+
+static int sx9310_wake_up(struct sx_common_data *data)
+{
+	struct regmap *map = data->regmap;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+
+	ret = regmap_write(map, SX9310_REG_PAUSE, 1);
+	if (ret)
+		return ret;
+
+	return regmap_write(map, SX9310_REG_PROX_CTRL0, data->suspend_ctrl);
 }
 
 static int sx9310_resume(struct device *dev)
@@ -964,19 +984,13 @@ static int sx9310_resume(struct device *dev)
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
-		if (ret)
-			return ret;
+	ret = sx9310_wake_up(data);
 
-		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
-				   data->suspend_ctrl);
-		if (ret)
-			return ret;
-	}
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
 
-	enable_irq(data->client->irq);
-	return 0;
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
-- 
2.53.0

