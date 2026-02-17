Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51D36C5A3
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338784; cv=none; b=NvRcWVzTq/JvNtOfpq9CTrEuohIwkJbCmReHW3TGHCGE23YhsS9NnqEdNfvo2niYa9iWQ/zWuNToRBNSA17WwTxSSG+H/cEK5KoWTgBr7QP4nIkVsIeXfXXGQLNH9SU53tOiMgVMhDSX8V8yYNckCwREQJN4YWg67YFxQR2g+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338784; c=relaxed/simple;
	bh=mdmcziCoRpgyg9zO51dBap2J4LSnmobyR/x9hWAq4dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTvcPmmKg0EpKzTuZw7PgOlFrT9EEp2AgKSKP0qYXFKpR2mhNWCm0xXHatxZNSvSzX7jdey5SE6yaVpKVeI4xQN2paqAxJxIMLjOQArTEiQTjZTMk2cK2WuM9kzBBG3L2041y7vu3iU96ZWaEBFEXbnFjU0j6UUTIHdFb6p7JYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcBFk2+L; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcBFk2+L"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b785801c93so10632952eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 06:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338782; x=1771943582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZHTM5NPkQvEF5N7LqWps4z6IgbuwQj41G4RJmHg34w=;
        b=EcBFk2+LyupHvWzM8hck5SFstKBVLtaRqv0V4tO6BgzX8ESP6vPBmPxDIx7hMhNQlm
         b9aSrsSQNdZOmn0TcweVgOiLtktVKNH7bwRUWrMUqd2AT0SBXaalXnBeMrzjVaVtf97C
         yhLuwLn42rNT/1t5zKPyB1wlP0aDCkTU7GL8HQ9eoZ7CpX8Uv4CwfOtXkIxDVkQI2bme
         hXSQddHimVltkykL9V5pA37RBXhOowIRUOKS95ut/B5abEx+Cs1czmhyKYbvDWvWc8Yo
         9F3UzTOhFZBW7fHihWajrRsPjOpFe+9VgoXDoPiIvvp+u1neiT9y8syYSRuA8jOsjw4z
         EnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338782; x=1771943582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZHTM5NPkQvEF5N7LqWps4z6IgbuwQj41G4RJmHg34w=;
        b=PaDLEZps6zaqVjzI2R0s0lBtV8I4xo2J94BCqEWh6ITKwcy6U1VQ6rQTBzATr1HOyn
         1UNpZ61h9NwTbYtgSv8adPdrUupyzvtt/KX4g86QaqO085SlPFuu9vQblrkmhK0RgENG
         QEXqAUa5eGynVgA7mlA8S3j5zMa0vqlVAMhRf/WMU8o99lwX78/j5Lm3XqvApyr92LXo
         UswsuJZs2rrVWFO23Cw25Wbye3mc51EmdNR4HP7+HUQdSwrZSUTR24kvBfZ2t3GuoWn1
         hXsKo+mlweosJ+xswklDH5cl4JZ0IZJ6+NrSpVrsj58uxrOqat5KaZ6WrAQ4qXL4JtEz
         JX5g==
X-Gm-Message-State: AOJu0YzXtVqUvUDUmN/XruvzsTNcd8TcBQ39AYCmJZrvxldIwu4yDp27
	OOW8m7J+1BuNfwscSYDYuDSxreyojPjgwzGfYhhmYw+BoZBYaO8hy/Yd
X-Gm-Gg: AZuq6aLyz5K5JzYHOHmIA88Z59gwxevfjUwnTJNrsrLaST7fo3/q73A75EztuJ0awBh
	jwgsp/8t0s4at+8c8Tg5bPYDgCYieyTsEbMvjc9xkqqB2hW+eFuYv4IYWgqXguEfbiEsvH8sA+j
	elGn+jEkOdUVJ0RBplOR1GFg4gns7dlyJivGLnjHkma7Hwx1vOVT7iWw+Yykx2AS8NdKfCbclKu
	onSV1GIIyg3WNu18uQWziZCClYC5gY5C1meujywKPDb2tuvTpRDn3/BiG5xn1hSwYFCk7vVf/aQ
	bBGMaXtfMogog0c8CmaarO1nLaNrm/imho1V/pVjrfieHBaQiHsHA9WDKbnJjuCykuVEZphJMtm
	VGyLJwpmiGC3RZZHsv37xccbIH7igVflVuLaYp0J3WjP4H9c6uXivEsUVtC9l3WUJBzoc9fSVau
	mhiqEcLNZ5D5XrYcXm5ISzTcaQeO9Kfw==
X-Received: by 2002:a05:7301:7c01:b0:2b8:6a22:6d52 with SMTP id 5a478bee46e88-2bac97cd49emr3809733eec.33.1771338781902;
        Tue, 17 Feb 2026 06:33:01 -0800 (PST)
Received: from osabio.. ([2804:14d:80a0:804a:d4a3:32a3:b3e9:7fde])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb582bebsm13656469eec.15.2026.02.17.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 06:33:01 -0800 (PST)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gabrielsousa230@gmail.com
Subject: [PATCH v3 2/2] iio: light: zopt2201: use lock guards
Date: Tue, 17 Feb 2026 11:31:57 -0300
Message-ID: <20260217143157.132799-3-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217143157.132799-1-gabrielsousa230@gmail.com>
References: <20260217143157.132799-1-gabrielsousa230@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() to handle the mutex lock instead of
manually locking and unlocking it.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
 drivers/iio/light/zopt2201.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index 3192aa72a0fb..05a79ee1752a 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -185,10 +185,10 @@ static int zopt2201_read(struct zopt2201_data *data, u8 reg)
 	u8 buf[3];
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = zopt2201_enable_mode(data, reg == ZOPT2201_UVB_DATA);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	while (tries--) {
 		unsigned long t = zopt2201_resolution[data->res].us;
@@ -199,30 +199,25 @@ static int zopt2201_read(struct zopt2201_data *data, u8 reg)
 			msleep(t / 1000);
 		ret = i2c_smbus_read_byte_data(client, ZOPT2201_MAIN_STATUS);
 		if (ret < 0)
-			goto fail;
+			return ret;
 		if (ret & ZOPT2201_MAIN_STATUS_DRDY)
 			break;
 	}
 
 	if (tries < 0) {
 		ret = -ETIMEDOUT;
-		goto fail;
+		return ret;
 	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, reg, sizeof(buf), buf);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	ret = i2c_smbus_write_byte_data(client, ZOPT2201_MAIN_CTRL, 0x00);
 	if (ret < 0)
-		goto fail;
-	mutex_unlock(&data->lock);
+		return ret;
 
 	return get_unaligned_le24(&buf[0]);
-
-fail:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static const struct iio_chan_spec zopt2201_channels[] = {
@@ -323,9 +318,9 @@ static int zopt2201_write_resolution(struct zopt2201_data *data,
 
 	for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
 		if (val2 == zopt2201_resolution[i].us) {
-			mutex_lock(&data->lock);
-			ret = zopt2201_set_resolution(data, i);
-			mutex_unlock(&data->lock);
+			scoped_guard(mutex, &data->lock) {
+				ret = zopt2201_set_resolution(data, i);
+			}
 			return ret;
 		}
 
@@ -350,16 +345,12 @@ static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
 	if (ret < 0)
-		goto unlock;
-
-	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
+		return ret;
 
-unlock:
-	mutex_unlock(&data->lock);
-	return ret;
+	return zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
 }
 
 static int zopt2201_write_scale_als(struct zopt2201_data *data,
-- 
2.43.0

