Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE033939D
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411267; cv=none; b=e1yFOSAFBafleDgQsJieODWIIHqAYjlLT8lkTG6yb2dnqGvxqkC8DCKCVZFI0Mak8q88cVhpRV42330GYq4Sot0ylnR6RRldk4QDAIjFdGWdZwnC6Rk4xEXrlZAhWRuT8IXNnsG4r2zT5XBnb+aVdS4+Ua1dS7RkqJMhEYXFf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411267; c=relaxed/simple;
	bh=rWt961+/bPNy2pjPJWDH0YmoShrimYI+QoADdAgJshQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdCyJweP9orTzuvDAkvuasOb6gWJrr3Og2l9N+DXsn4PaLREzNty7qnLUBWZaVYCTBjDnU8LZ7TkHTXwXdJUnHBrK2x545z708Kwm8rBuxd9VGfMVx7LtvHFXYqXh/mQj5nqdu9xBzyHKfZkxpR/dNvzg/0hXRk6uidurl2R+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEfG49LU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEfG49LU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-396750cfee6so1646423a91.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 21:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411265; x=1789016065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okUNsbtvmFFu+lzHe154k2LqoLzMT2rNsO7AkOEt1VY=;
        b=KEfG49LUwAsi6zjPCZl8Zn1N4K9veSXFws8+fb5nXmdu9usJqYbUNjb5HWAt8KeMwI
         VYyImWaHNwDL1W36FUjwC+z8KkENSf4b00nyKTDDz/X9iMa8bQ7DKWJni/rbZvmi82td
         PftRoMRciRtZyxxAk/mbQEPIm5o+jPnGF5UVUPnQQVYLz9jqibAt+Ta80Ifir7kntggo
         kTpj8gAnhvbYg6+h1Vjn6tzqbrJhc7cwXUfA+uswVWRnOJuRYT8BlGnwWLh1zX8uvtUz
         junZys2cP+u/eCy+Yc16D44cMhP+eHZn6j3ATPRd7BUoxdu9bQ54ereSYD1qfbhat/wn
         wvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411265; x=1789016065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okUNsbtvmFFu+lzHe154k2LqoLzMT2rNsO7AkOEt1VY=;
        b=gxe64zcKFG9xbikoONjScM2RNeSUEvh1pmQFP5VXg5U+RkFpumIm27fmzbxOE39vil
         SAJhtPCd5y859Nh0vk9hFIrUddT9+IE35KW66pHBUhf0YJ+uW480IEmT82ylv0cKyVgY
         TfOH2w5MavJ1YK9+UAu8lKDvU+ShJajTiqPU5Fk6D0D5rZt58J2gn8PixNiV8v8DDAwA
         Nz6daOZckCxUxRInYxpvSuxM0e/lu5+HwRpnh/JTHQspTWkUg7DE7GgwHI/7c8WFabFV
         7rFDMEiBIQupkIFOrvCfJ9DgEObMxRpdkmb/nZK/Oalo9o4xWZMSdL9SbSFm3gnhCMf3
         PnYQ==
X-Gm-Message-State: AFuF++k3iLEb5NI4E5gtCjAfYMwk5PI3JjmE+ne48DjnEvXQliNT5b43
	S8RFGV9JyIkMWHgnCH7zGKiDiUaO/L01FmRFcbhHI21wIGwd6zvMucio
X-Gm-Gg: AYBFou3JU7/XIneMQ+UVCKECdqRCM4Con5BuHNxeOmYu7J2D+mhRkXoVmaV33fwQ45B
	C5OsRQPgx785E1iahjfj0+4NJNNLUflrwVeqk+eo0eKgxLoW6FLOqG/5JorqDPt3QwbM+t1Vamy
	PRQZogglXosHP/qXL4moLxIRavZKuTh1Yp1bWxkkjNcrXEUvu37gYHFTU5M04ucIm4mHLjUZo9R
	2OPtHuS6jhnsxrX1GSdtuA6RvCqqV4AvXy3OUlD6smtAx3X/yQnzC64hfwV/Ilkh/dxZEW+ll4P
	rxs0UCXP14cODaWf3wbnugsPB5iN2d7abXmojLWuOfEB8fTXqvGmyh752J7E9jsTn6WcrV1UHrS
	/hIVdUih0wWKT4qb6WY92m4Ky14SqyY4RkI5xpgR6j9dStDP0S1Es2t0P1lX7MB5Ajo2I1+a54x
	McJkXvqUoddzuk1wXSGQOIu3wA14hT61OmtepDVsUxhi+WneCpzuO3PDqpqlfsHJp44A==
X-Received: by 2002:a17:90a:cf88:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39aee9b4d19mr11976636a91.4.1788411265508;
        Wed, 02 Sep 2026 21:54:25 -0700 (PDT)
Received: from [192.168.20.42] ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1cf6dsm2300801a91.3.2026.09.02.21.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:54:25 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Thu, 03 Sep 2026 14:53:48 +1000
Subject: [PATCH v3 3/5] iio: light: vcnl4000: refactor interrupt config
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vcnl4000-v3-3-5e69c2e715a8@jacques.com.au>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
In-Reply-To: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

Move interrupt configuration logic into helper functions
(vcnl4010_stop, vcnl4040_update_als_int, vcnl4040_update_ps_int).

This avoids code duplication and prepares for disabling interrupt duirng
cleanup. Also change the disable order for vcnl4010/4020 to clear
INT_CTRL before COMMAND to avoid spurious interrupts.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 79 ++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c5f34e748e1a..f77b219c46e4 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1299,6 +1299,17 @@ static bool vcnl4010_is_thr_enabled(struct vcnl4000_data *data)
 	return !!(ret & VCNL4010_INT_THR_EN);
 }
 
+static int vcnl4010_stop(struct vcnl4000_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
+}
+
 static int vcnl4010_read_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
@@ -1334,16 +1345,10 @@ static int vcnl4010_config_threshold_enable(struct vcnl4000_data *data)
 
 static int vcnl4010_config_threshold_disable(struct vcnl4000_data *data)
 {
-	int ret;
-
 	if (!vcnl4010_is_thr_enabled(data))
 		return 0;
 
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
-	if (ret < 0)
-		return ret;
-
-	return i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
+	return vcnl4010_stop(data);
 }
 
 static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool state)
@@ -1375,6 +1380,34 @@ static int vcnl4010_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int vcnl4040_update_als_int(struct vcnl4000_data *data, u16 mask, bool state)
+{
+	int ret, val;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
+	if (ret < 0)
+		return ret;
+
+	val = state ? (ret | mask) : (ret & ~mask);
+
+	data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
+	return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
+}
+
+static int vcnl4040_update_ps_int(struct vcnl4000_data *data, u16 mask, bool state)
+{
+	int ret, val;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	val = state ? (ret | mask) : (ret & ~mask);
+
+	data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
+}
+
 static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan,
 				      enum iio_event_type type,
@@ -1413,40 +1446,21 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 				       enum iio_event_direction dir,
 				       bool state)
 {
-	int ret;
-	u16 val, mask;
+	u16 mask;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
 	guard(mutex)(&data->vcnl4000_lock);
 
 	switch (chan->type) {
 	case IIO_LIGHT:
-		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
-		if (ret < 0)
-			return ret;
-
-		mask = VCNL4040_ALS_CONF_INT_EN;
-		if (state)
-			val = (ret | mask);
-		else
-			val = (ret & ~mask);
-
-		data->als_int = FIELD_GET(VCNL4040_ALS_CONF_INT_EN, val);
-		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
+		return vcnl4040_update_als_int(data, VCNL4040_ALS_CONF_INT_EN, state);
 	case IIO_PROXIMITY:
-		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
-		if (ret < 0)
-			return ret;
-
 		if (dir == IIO_EV_DIR_RISING)
 			mask = VCNL4040_PS_IF_AWAY;
 		else
 			mask = VCNL4040_PS_IF_CLOSE;
 
-		val = state ? (ret | mask) : (ret & ~mask);
-
-		data->ps_int = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, val);
-		return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
+		return vcnl4040_update_ps_int(data, mask, state);
 	default:
 		return -EINVAL;
 	}
@@ -1629,13 +1643,8 @@ static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
 static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
-	if (ret < 0)
-		return ret;
 
-	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
+	return vcnl4010_stop(data);
 }
 
 static const struct iio_buffer_setup_ops vcnl4010_buffer_ops = {

-- 
2.55.0

