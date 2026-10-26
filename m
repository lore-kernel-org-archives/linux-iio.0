Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976892;
	b=pRZGvYFwYgTHNVzQ7+ToZofw9O/VvyONVJtR9a9Xr9gN+hSKysYdd9RF6y2LzkC7WSeZ
	 5cE83DyrR8Jnf6ESvj2Q8CcXgq7fQix/KcorLjvYPUgTMfTmdw7eLC0itw510TYkCb7V3
	 7RHfFMBaq39JCiz47OnuXgormdUrfiof3GDZSqK0JFTZuPp0z2rWqEqMQ0mWRPPzN6/aA
	 pZ4sxoRNpzct2N5uHSl1SUaIPpem7ASwodfybBp0WuGxGiHYRBNhhwKghuiPnqHUDkvVw
	 F8Amgc66AVK2KPsmp2lW4aKObbT4SY4baqdyKomQsKpQvohHmip2Js8hsVogFD3JHJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qJ33R1EVU6MH9SRD6hm7TEvETYZbY7uD9VSlaJgbKzM=;
	b=Ku53Zlc7HBKrCjsVNNRJlJZFRzMPMXYTurDEVxJt72KItqVgbDlo3slCnSyG3Bau1W7c
	 pbT4g9ys4zbT8nKyaLxrElwylk/peaFIEqTpa6CfbPe6AHbxgV67qLLwQYorLx513McCm
	 s8wB3+5MG8c7x/SOdlhBaG9carLgmU7uSydfPIy32Awtv+eRAjEP6G0XxsVpkDo61I11r
	 Xyd/p29qjuG2WEMwDsH965XExiHS/+hnrcI1QYuJEHl0H/JY+fyIgF5kLUu0smuV4SFtr
	 yFHrHXrOSu4Ar71l0ROqk/EzAGNtn/Ns4zxzOHlbAmJLrmB7PgG3onHAY86XpXfelFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ns48Dv2m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940EE606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ns48Dv2m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6091F031E3;
	Mon, 26 Oct 2026 01:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792976892;
	bh=qJ33R1EVU6MH9SRD6hm7TEvETYZbY7uD9VSlaJgbKzM=;
	h=From:To:Cc:Subject:Date;
	b=ns48Dv2m19jtCv2TQ3HSNh4IQxAmYSwltDb5WgISZfPn71kPhiJTeyzz9CjaOrjdF
	 63Xye1KijLSzUf2jHB7+vuaiFCmwZ3SxV5sUwiSpw4M/dunvbaZFno7lH8dH37T4NR
	 1vK+T8zhEeM3jFyCbE4YoVceDzJnA/rRG0M/vpOICiLL3Z4aqddEpKqLz+bY32bxjS
	 f2mNutfGD5EnNmgPUPr2Hsk9l60Qdfxa3bK38p6WS63KgNe2xG06PAH9WjlHs1Y5pH
	 v4jTa2Lcr5Zp40I/RjoeH6ZlaCoAW6fJqIZt/R80KI+EMwZznGP/T0Zatjz21REhvJ
	 yQmsTc/TkxQIw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH] iio: light: pa12203001: Use guard() to simplify lock handling.
Date: Mon, 26 Oct 2026 01:08:03 +0000
Message-ID: <20261026010803.973666-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

It became apparent in reviewing [1] that the use of guard() would
remove some ugly error paths.

Link: https://lore.kernel.org/all/20261021165858.v2.14.I501510b542691f595de1e110cfe35632a5fa7768@changeid/ #[1]
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/pa12203001.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 3f5717fb1276..3056ce076239 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -160,36 +161,29 @@ static int pa12203001_runtime_resume_and_get(struct pa12203001_data *data, u8 ma
 	int ret;
 
 	if (mask & PA12203001_ALS_EN_MASK) {
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 		if (data->px_enabled) {
 			ret = pa12203001_als_enable(data,
 						    PA12203001_ALS_EN_MASK);
 			if (ret < 0)
-				goto err;
+				return ret;
 		} else {
 			data->als_needs_enable = true;
 		}
-		mutex_unlock(&data->lock);
 	}
 
 	if (mask & PA12203001_PX_EN_MASK) {
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 		if (data->als_enabled) {
 			ret = pa12203001_px_enable(data, PA12203001_PX_EN_MASK);
 			if (ret < 0)
-				goto err;
+				return ret;
 		} else {
 			data->px_needs_enable = true;
 		}
-		mutex_unlock(&data->lock);
 	}
 
 	return pm_runtime_resume_and_get(&data->client->dev);
-
-err:
-	mutex_unlock(&data->lock);
-	return ret;
-
 #endif
 	return 0;
 }
@@ -313,16 +307,12 @@ static int pa12203001_power_chip(struct iio_dev *indio_dev, u8 state)
 	struct pa12203001_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = pa12203001_als_enable(data, state);
 	if (ret < 0)
-		goto out;
-
-	ret = pa12203001_px_enable(data, state);
+		return ret;
 
-out:
-	mutex_unlock(&data->lock);
-	return ret;
+	return pa12203001_px_enable(data, state);
 }
 
 static int pa12203001_probe(struct i2c_client *client)
@@ -421,7 +411,7 @@ static int pa12203001_runtime_resume(struct device *dev)
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	if (data->als_needs_enable) {
 		pa12203001_als_enable(data, PA12203001_ALS_EN_MASK);
 		data->als_needs_enable = false;
@@ -430,7 +420,6 @@ static int pa12203001_runtime_resume(struct device *dev)
 		pa12203001_px_enable(data, PA12203001_PX_EN_MASK);
 		data->px_needs_enable = false;
 	}
-	mutex_unlock(&data->lock);
 
 	return 0;
 }
-- 
2.56.0

