Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FE2F069D
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504405; cv=none; b=LW7W1ZXJXxqmvBRsz8xDGy1ZADqpWTkG5gfupz1fvsFwqUZmfr6r7LmeEFfr5WH7dEUksciPM0zr4NqmEPZs32A6PdMsRaovnQ1xkxzsTI4/DwzQTM+/tS9ncbQvgUotFl4mXwbn9WF9bg6OVcCdL147V6+lYuaA3Yf79ChqOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504405; c=relaxed/simple;
	bh=3QQmY5CvKjA1E5rLrX7dDBxYJh7qOARmrpAafvS7J+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwEkjwXyo9mpMmg7m+q0E+7asbhOc66RdsXORIm1vYX2e6P/OO1GBn45UmqD/G9LfQ568lr0Vikm/ApJORhdwVLCpQm/PTFEDA3NUygrMa6cyoqeTRUZdc4B/qpI0wSxx5gOiY61G6NdV//7w0SVLVyyEUgY/0HqGhawV2QrbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db0+Hzbg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db0+Hzbg"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so5190006a12.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773504401; x=1774109201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgo0ap3z9r3Z/5/BkWKWT8DoiYsa3x1eda5HahP1HP4=;
        b=Db0+HzbgF5GmjcmoHiXDGdO1My9I5q8mAL5FCQvV2Jd3BVIOVbLSiFOcfpFyU2yzYw
         mo8H2DQOoLvr6rrjQjReAHmE9FAzMJm5ox9zv2goWBEc1W8DvzIGJYiBnTEu2M0Cz5h3
         ZJMV0ox8iXPBV193iDFW9Mju7rck5JZzIUQ5f/iX5An7GNiatM9Ml76t+SeU3CVTZHrq
         81kzhcQfIIrQxRacSjoehq6d5X3f879xNRumQtMK9m/2dPaDvn81qT+hiuwLXUGSifaI
         bR+3KF0pdr3Ws2rXvkK/22Wvw3VsYlhldy0S+cmpcNvyuKrXKm74a48YFh0IbDkxXkew
         PlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773504401; x=1774109201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jgo0ap3z9r3Z/5/BkWKWT8DoiYsa3x1eda5HahP1HP4=;
        b=oNoNDmo2U6x8oKOEXO7nCqeZeMXqqh0y2C6MukzmyH8V9Ann1gfosKhGd46HgU7L6S
         A40k3b3dLlGHfLpeH0LEBwThM4/XgACgegwqN+vc2WWn5S/Gse7cGMZ0afCxiBpsaLSf
         Mx5DUy9Wlg7j3fqxwhYE1ud4lUqGQzyzmD+pahusBpOZ+hw28kf110t7jglMFWSMvdOz
         3llkACyy2eZ+M8TQn/JKERNDGzAHSp2HofXilxlS6B3wN+IO0NM3b6/9ho0NKj0uVmRQ
         nVW9iGGqFF9nJzBqtpT3aZIKTTElZGrD/ZTZWRLt/hb/RbvXL9TonifQu4UOZrf7Prfr
         74fQ==
X-Gm-Message-State: AOJu0YxNIA8g++BDwW+p2NKsfzLlwTwUGomaxYFk5vJXwoc9ehSGRF6B
	c7erMNQEgbPDFaHNQUYqeiPU4N1MxOV5c8iR6BkOY5svkxoAumqnIJBD
X-Gm-Gg: ATEYQzwMCudA5/mZvllT4AiLZ7O1B++JzwE5JG032zJMptxwl2cN0qi5oyaXK2Hg81p
	dwEp4d/MYZr1xcmxdpj4a4qDDY7mngLwcebBB9HtLJe22rknysMZsf1tZjIpJ7FOcMlO/GI7ikm
	YnC9Kz/+2wT4IGiLsyFGkvMUE1NfiVus2Lyuo3rnUuAC1FjxKJuPlCy++zrOvVNjCqczu4MywLS
	fiQKehCJ89VnvXg6r7lUoLB2KFOVvFAQNVUu6s9mRNrxKPRSqSpqo+t5qPTbKvf/vuIiFS7RFON
	4KDQ7nDnTtZsz71oGxdcbNLNIKAoeMhuPQzkBzNhvWhKjEHSnq1oCBm40bbFAYjDjjmr3Hf7VFW
	0fK6sXZF7do26NXy/tNmNFJeUw+fE3wuOvvuBfkdHqqEPq3F2TEgWAZNQgwcrMxhzkalbWb8m97
	5shBxo/5ARVkmbz/FzyGttPa5rjg==
X-Received: by 2002:a17:906:dc90:b0:b97:6a80:38b6 with SMTP id a640c23a62f3a-b976a803ab3mr374400466b.13.1773504400837;
        Sat, 14 Mar 2026 09:06:40 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b978b8625d3sm151722366b.52.2026.03.14.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:06:40 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sat, 14 Mar 2026 18:06:32 +0200
Subject: [PATCH v3 3/6] iio: light: vcnl4000: replace mutex_init with
 devm_mutex_init
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-vcnl4000-regulators-v3-3-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Replace mutex_init used across driver with its device-managed
counterpart, so all assigned mutexes get destroyed.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 939ff2d65105..0ee307fc5ab7 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -356,6 +356,8 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 
 static int vcnl4200_init(struct vcnl4000_data *data)
 {
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 	int ret, id;
 	u16 regval;
 
@@ -400,8 +402,14 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	}
 	data->al_scale = data->chip_spec->ulux_step;
 	data->ps_scale = 16;
-	mutex_init(&data->vcnl4200_al.lock);
-	mutex_init(&data->vcnl4200_ps.lock);
+
+	ret = devm_mutex_init(dev, &data->vcnl4200_al.lock);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_mutex_init(dev, &data->vcnl4200_ps.lock);
+	if (ret < 0)
+		return ret;
 
 	/* Use 16 bits proximity sensor readings */
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
@@ -1985,6 +1993,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
+	struct device *dev = &client->dev;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
@@ -1997,7 +2006,9 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
-	mutex_init(&data->vcnl4000_lock);
+	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
+	if (ret < 0)
+		return ret;
 
 	ret = data->chip_spec->init(data);
 	if (ret < 0)

-- 
2.53.0

