Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696243148D0
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738521; cv=none; b=UJ0PVfN2eRDx0J/zlGY8iuXnPwOGSvY5q4H2luHLMoSazDJX9G5x+dmpySDooGBJgcK0Djyrmean/OOMqULk6HyPNavYFXFugI+Lo6rRZoI+B70kd7+Jfrs3fh8lmB/adjqKX3KeXkztLH5MlgRh72XMdFgDDQvWxif2jwBFVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738521; c=relaxed/simple;
	bh=puVzQVVivVatnMzmHhQf7aghQyv1Ohkpm6fvRgahEf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmprqxsaS0oSfPcuX2vo4jIM72RS2zKIHtERojGYzUppmVOmy1teVClhOnkFMvHN83mdKUHQoGCaNs9+XWTfwhkWXZhL8Mz+J78RmaRF9Jpp/5rrmFdpc9Vw4ILY/2w1w69pOSP4k+4VJ2YyuunICj0KdmXjOEK9BMcNfSZofVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKgbLoZa; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKgbLoZa"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1277e072e2dso4667595c88.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 11:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772738518; x=1773343318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTfBwtx85kwVzzZ3HjdtefR3fnbTNSxXGk3ctCXP+Og=;
        b=UKgbLoZa1qLiM5v4KbLZrQeQWRp6IgTQNxIGdDhp5WTOl9r03jVJKw6jT4nshM8GQ+
         ycxvs5sdpkKIAnjyi+Y8f4/YgYwFhtVkPLcRxTaGz0erJ+T0qFRcDwdg9/q80TUuF7ym
         6YjaBe3Xahe0E6zvidOVukAwMdn60gyVprScVop2ahMZX0Ihj3FxPN5T+3OtG7BE9ySP
         9ppWbB4FPTnIBIKvKPGs8wFZ3w1kRByat9b/LO3orm8/QDnqkqpelo6qIXNYGmOU+pmr
         3JFt4g/ksvSFmYruHl5sAjXYVzIHVFHzvQRzr+uGjnT7k5AK6/mRJh6990ynGo4tB9JX
         l7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772738518; x=1773343318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fTfBwtx85kwVzzZ3HjdtefR3fnbTNSxXGk3ctCXP+Og=;
        b=WSLm0C1qzbnC/j5Uyhq7gTCLzQrDkxqOH/xhxUV339FOa79ev87IbbYwjdkQtUQ1xq
         gn5z4SYh/gWkL36c/9ZHeh5e2pU5AhS547vhgZqwHK2uXUzxW5xjExI0K1ySBv8UgpYx
         FM+YY6JA+TEIZVT+ON995SMxrSJX1l+Xi4Ch14cDksEYrAcRSAwBrA6nI6awQcDfmAtW
         D7JNh/DaatMZ4zBcqoRrUMjiIOVHPbK2v48R2IGWM4brNnIWM+kvog/AbZ8rfOZ8zPv1
         +cj3ouwz5PvLULdblhf9cRSJdJnYjbTq6av6XjRld4EkIvY1sXXj3vQd92dOe3qzNkZB
         KKdA==
X-Forwarded-Encrypted: i=1; AJvYcCWBXpnr5U0Oap9wGmvTZVbNOuRg/jdaoJ4DkHXP79hS/nRsqNReU4LT/Mw/qZI/pbH5HNS/M0e6qEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJdvhuu0OcxwsWRAPUcuLyzcDISQLhfwjN8R4uNjS/X8SsCqb4
	uQ6UEcph2Muc23cSahkrRrbh4kBAXKL8wPKXCzwK3KFeD6LqbT0C/jYw
X-Gm-Gg: ATEYQzz4wT5nAtFFyDcB1AxTEoydv+z4qDk3kXeVVd17Ovyhpi86D5ZT1fv+rWi2zct
	I9ol9QxIHQhoHj5PKFF9l8ktn4V26tGk9EkemIgyjZoWzn9gCl+PvFUIiQvfQz61HNsJ51DERUV
	m/ZcQyin0gzIh64wDQs99I8n8PEzb0VW+PMuKH10t4W7+CMb1NIL6EgKxawJTU6hkMQAFcWKBrK
	FR8gtJ5r7ynwK6J1qWb5tmJHKHyQOBlqIEZSmjZ/JoOWLaBG26nLPzcEwEwzvQz8DG0rHtu6wKV
	v+fjZRN+SQn4b4YFl4C7jlA6QeqfQgi/KZDFO/L+tWNqFsthLYDMxZKuz34qk4Xpsy0ygZPWZ0Z
	yf1EdDTO7iOHQwLTeIvVT76ZRaWG6ZT6yo9sw2KFDNO93raYDYH9F2Ydp4rvTXMOJEozqxEvYSV
	7bkvlVBRXYmQNk4x0JbZy3VhMDiiJ8eWOsx2myYTRLoFBf4j1fzinL6pWB0/qLJ3Fw641M4VUPT
	xgLPsvbg6S9wuo=
X-Received: by 2002:a05:7022:2208:b0:123:3c65:d724 with SMTP id a92af1059eb24-128bc030d6fmr1068015c88.25.1772738518437;
        Thu, 05 Mar 2026 11:21:58 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7788:d145:a740:ca06])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10800980eec.14.2026.03.05.11.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:21:57 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 05 Mar 2026 11:21:53 -0800
Subject: [PATCH v3 2/6] iio: adc: ti-ads7950: do not clobber gpio state in
 ti_ads7950_get()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ti-ads7950-facelift-v3-2-a23fdd1a079e@gmail.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-94184

GPIO state was inadvertently overwritten by the result of spi_sync(),
resulting in ti_ads7950_get() only returning 0 as GPIO state (or error).

Fix this by introducing a separate variable to hold the state.

Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index b8cc39fc39fb..cdc624889559 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -427,13 +427,15 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
 static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct ti_ads7950_state *st = gpiochip_get_data(chip);
+	bool state;
 	int ret;
 
 	mutex_lock(&st->slock);
 
 	/* If set as output, return the output */
 	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
-		ret = (st->cmd_settings_bitmask & BIT(offset)) ? 1 : 0;
+		state = st->cmd_settings_bitmask & BIT(offset);
+		ret = 0;
 		goto out;
 	}
 
@@ -444,7 +446,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		goto out;
 
-	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
+	state = (st->single_rx >> 12) & BIT(offset);
 
 	/* Revert back to original settings */
 	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
@@ -456,7 +458,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
 out:
 	mutex_unlock(&st->slock);
 
-	return ret;
+	return ret ?: state;
 }
 
 static int ti_ads7950_get_direction(struct gpio_chip *chip,

-- 
2.53.0.473.g4a7958ca14-goog

