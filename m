Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA63D333E
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681598; cv=none; b=gEl8Yw4fHbGv6o6k63POll5i9j/addScB2eyZ8c923HqfQRKYWk4q4LP2GiFeGHkzE7U7A5FDhla56Ke8ss0JcIrNhq27rnx54Wg1gN6iwu0pkGSSVXiOfXHBW3tXP8Q+L+nQCYUc8kfAJaSDmQrM4Yz3y+WREnm4m+4P6KNF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681598; c=relaxed/simple;
	bh=vP7EEpgruq7jb0BDTrxCYCk5LMVt/Xx+6zryX3dg/1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Csy8JQ10z1oVMS/DNDK5HFL9p3gLJIpigf2oq2leL/P4V0iFqROtV4mRu61ROcdRdZoynJjeZ4V/HRGqVAAlZiT/jEOB67H9Ztpu8QfjUZg2rKTpk5xGzGk0xx22CVGar/DWZn+FZfMHK9mVdbmozkhDqKk5jb5q6tidWthNm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJDnGJXf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJDnGJXf"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so642674066b.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681595; x=1774286395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmQLMk8d0z4Tj8kbX0Ny9TubbIjksPecuXhm9eaS99k=;
        b=SJDnGJXfzi8qRYKf3vDwMKvlWKwA8HNL5i9G0uWBdeV1d5SNo2/8qOSQtJYLC4hBdN
         lEJ76yq3fG0+5Y1WmS4Q0IaS7j7kcWT8yG7KmnRQZClgbhcMSjC+9duNGUPCnheol9hf
         3map584Pa1QTQIY8kvBfsyRhCM/9EzCvmho7GRzNVs3oNPAQrWLY17vggqsUc/H5gssh
         rKEMg8M1gHzWHKvKYRvKiGz8wFX0gVYiL1XYqsDzLEoou64H2L0anIh3DzIRjq/x3hzT
         w6QjrR32Xm7DH0uZ1Yyrf9KQyenlwPs/Hw9WNx+QWUUdirJkHKaMDYAbS35hP3Lpm9i/
         Oxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681595; x=1774286395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kmQLMk8d0z4Tj8kbX0Ny9TubbIjksPecuXhm9eaS99k=;
        b=dE+ZYGYbpQBMEfy5gU3OxKntxFHwn7Ds3SecLMMtuAlTAndMeY1GYuwJa+6UF7y1PF
         n9l774Nww4UHNpAzRLvAXfT7/mUJxAWODAuwjCnD+EWHbX3VruEtNEWTeeLv05xSy1KV
         QBFS2PGsxAziNNW/m73POEUZ3eTjnWLLyIX2gIRENBx88PWoW5lac2hqtN7gaYxIb+qy
         4zXhXzZp4e0Q/WZDmZPzJ4RvPfvTBQaE5kaIBVosyhrD+zzloHYbtTOAH4os8QBSBLQM
         m9HfvRezDNJhGLRK5XI7bQ4nBZ4/ktVqydSOEU3cfE+4bOrtPV+SnLa0J+RejmL289do
         ar3Q==
X-Gm-Message-State: AOJu0Yz7U8rdYbGUdAMGbteKDe6W4PH6vpLwlqocatVzQ5YeHC8SH2hL
	Nq6iPyyi3vsXPnf6wl7LVrb3YbZ882T5v2U2MeF6EZaAXJrUy6suNxbD
X-Gm-Gg: ATEYQzyazMhSY74k9b0PFi2xmQjZopOR3za9P23Jvo/79wJuBom82JLMsQZT9THq10F
	nVvhjcCjHiqhhkCTFPS83T6n1zRUPN7MpryJr1/0U+YDj72CzPTlsQSzDJy2JqO/3UODrLlZ5hR
	gMOiPOkhSZiaLqIFJWD8crclbhZbnfyZlavZCYCAJRL4fenorq/vkdGLYBnKle+65HH+FNK4zy9
	3TPpqfXGSvDMzfTQlNahtXcB/DqUkq3x183kSEmcfX70pppKSCXyBy3RGGuStz4rZlFGv+9CFMH
	xr/zHn9uioxz9azX3FQ7t8ITXLghELUjN6y/S1xTdH+Pm+vQu9D1gtqrAcDEVYqc3+LcwLsztMi
	YIG5U054bZwupB8pQcQv653AGMbvsU/OxY8aONugQkYY/vMvfvec3Lb+Tvnu/guWWLP4iOdps91
	8VfwvoIrNsVp9fSQquhHbH9GQIi2zGrk//2m2l
X-Received: by 2002:a17:906:a14e:b0:b96:ed21:f47e with SMTP id a640c23a62f3a-b976506f1a1mr727876966b.25.1773681595238;
        Mon, 16 Mar 2026 10:19:55 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm505940266b.22.2026.03.16.10.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:19:54 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Mon, 16 Mar 2026 19:19:48 +0200
Subject: [PATCH v4 4/7] iio: light: vcnl4000: replace mutex_init with
 devm_mutex_init
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vcnl4000-regulators-v4-4-854fc2eaf54b@gmail.com>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
In-Reply-To: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 287ccd89cfb2..cd7e6ee42cc5 100644
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
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &data->vcnl4200_ps.lock);
+	if (ret)
+		return ret;
 
 	/* Use 16 bits proximity sensor readings */
 	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
@@ -1979,6 +1987,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -1993,7 +2002,9 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
-	mutex_init(&data->vcnl4000_lock);
+	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
+	if (ret)
+		return ret;
 
 	ret = data->chip_spec->init(data);
 	if (ret < 0)

-- 
2.53.0

