Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243206;
	b=ekRamy+7uh0IQCJp9InQfVrJHGx8CLgjDdlVpelMWb1h0pFteHgJ+C7gH4jpUBpJDAfd
	 gGUIXYcrJ/biEgvcuPwSMnDDb6Q3fD529Dbj0+wsW8doXe/wqa5ZLiqlgeNQnSaFyuwqG
	 rrNW1h/Y33htoHTy90JI8xX39K5u6jKtOKgtbDGIzAqtRe7hjZO4ShP+ojhM7NO3JEcBR
	 rN2spHIlJGtF++WwbiSYG1LAl9JBYdfhdrju7gXq/TOm+NwDTb8D5ySC4nrZV0S+DnAf1
	 gW/RoaDxuof60V69PWkC9hVbWrubmgymL6NCEZf1YKjwGWX8BsAEgOb+i4t1Cg6VyLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CtPurh9nP5v6J/PdC9q4yr2Kpc3EGfiQcCFQ/T/qOS0=;
	b=A+QHKbObdsEV4F9Mutb+MrkpAVJqH4njfM3etNiuOHy/BvgfeUtdurMF3CdKm2HDIwsi
	 BMYF7nc01VHwLYPHP/dq+dt7Hi/LdWUZcbGhGjKaEOZywJ9HeRBCjHc2Xz1uP4UhX1Qot
	 9EE2sTtxsOAxTnwHUV11zXnv0a4Y0UAHWkUnhb3HuZqEe6SN1GdtcmRBNuaJMfHcPYkNA
	 INOmKFAjMXCc+6l39/wW+swGdnrCDlQx/DatxCZsOvIek7YX/vVT+297N3MfF6mm5vjou
	 y7xzIjnuy3PtOv5PoGihzQYHYUjKgT4eaYlM6Ysh1H2yueeUeTu8PfoPMdKKNsO6QVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rW2IJXry;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E52606A33A
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E52606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rW2IJXry
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so634687a91.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243205; x=1794848005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtPurh9nP5v6J/PdC9q4yr2Kpc3EGfiQcCFQ/T/qOS0=;
        b=rW2IJXryplljzSVpBK+vF6/UEzxH1mJzIXwF+fEmQU/u7lGfNxlmaEGN6VE4R4j6+7
         nKHZcW39AiqzCT6442SzW5qwBAOxD18QTcYBdT6Z/i7KhWipHBua4zCrpWvFk4RG2xDA
         Yje6RduYSFTNwQ0KkIH5PPZIoBOd87ucetPTUjwB3/qfsqkolZNZyA4Pzky7ZjI4n7/A
         k46Uf57deZBJ2WkI+27bgEji8QbksAe6cncYWQ4EpqawtZMZlu4uNA9pe4miriqsZowr
         6PN+qyv8UB2YpdZMcqiq2jDp/CCwNodM/2Gh4vTo6FV/ZhVuRcaHFISjWckEwzQI6A2S
         FCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243205; x=1794848005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtPurh9nP5v6J/PdC9q4yr2Kpc3EGfiQcCFQ/T/qOS0=;
        b=AuRtd7kQoZgGaYn24Lt2vRybbCH0TC0ZbNdDnuIddLLr5LSgykSdfG7lBOLbtM6e5+
         gFx0kQK7u4QB7yUgX34fmetChHw5KdRRb+SEGHeguqLDaCetncNF1pE/gyR0kQVWeU+6
         bHCzJHZz6mWppJuWuMj8eYGcwpy7E+neWeaCsaOgHojrVpBHjPdGJhsSaaJMoz2zrCet
         T5kz8odGmZuYlEtVQAyx7lHX7jQJ5AIOPGL7wIWGydrFgmEODwhHndIZK/DBDn8EqCyY
         lDfKI9gtKbGzZezljJArbloTATgaYz5uVjZ7TkjbiK0zEwJbPdtsrQyQ2aTt8Y3vZhqI
         G9eA==
X-Forwarded-Encrypted: i=1; AL+hErHFmRTmewtGTDQLl8Dvvhg3dKD3W0tz04uSS/u5GgA5HC+RBX0NTUdZ15FZ0TtJg/ftTgswbs/d/Jc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9StADChVPFYJqAuZa7ZfnDWw/CVmd8iZj7a4G2DfmxUkjaJIgu
	mLLZup2dX5othafiJgibXB+gJ5NkiTrDijyefpl/T9hibE7COQGzOzXR
X-Gm-Gg: AYBFou1hOjhSWkYoIAqTEOMv12sN2ElwtdwDUETw9wLEXU+7GIV0fbdUDlpn1q5Xf/w
	j0ls03t3k8rNj+cfm7VVL0+OaiXXHgibHhB6IdUv8q1ilfNUW64uNkGwKVp41ow6gaxMS2pHEyd
	FgRaMEAQZ+4lErRS3YzJNJx1B5/FjJqRUszKax7NHECTELfolJ4K97HrzoE3R8oq4fDNt2dP5co
	fnp4gljjG0vYdNM7NM0D+GksDoGO8oZ/vgRMsz2cn6vjhv4Qxxo/ZG1GPxqZp5ED3VpVHfBUlYl
	t0e7KkuVGh/pT03e4TrfXJpenZe4y6IBn1mtspJw1AXYTqb0UI73/dC+jfAEizYs0/HcQbhmcq5
	y9C3dWrFFKTxov8D8dVsTVwEuXuVYfP77clQk+WtCOy6du/kGywmo8ZSvNEZ/WL1CrovebZ0ehi
	qUh7WNTYNtMruKZqJrBvo0jzNSskKKjqhnIc+SrvNP9KDStFOezGBYPlIBTRbHEe0q8ZlHRyjAt
	mVZ+JDH+/VqhUC0P1oovAoGDj7aWN86ZGh5Vpr7RjmChCHNONDkjm9UPeCJWYIViLL0n+tsJPo9
	aMUeWc5RRDMm4D38YylXXM6qeD9/IXdzeLhHwSQHBAyXzHNnyMgo3GFrg+lE9O/X7a9GbTEI8ZH
	KT51o3jsIFsc8EBcjMXpXdy39Aw==
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3b166a5fb0bmr262595a91.0.1794243205071;
        Mon, 09 Nov 2026 08:53:25 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm6455688a91.4.2026.11.09.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:53:24 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 03/11] iio: adc: ti-ads1015: use local device pointer in probe
Date: Mon,  9 Nov 2026 22:21:31 +0530
Message-Id: <20261109165139.30803-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165139.30803-1-architanant5@gmail.com>
References: <20261109165139.30803-1-architanant5@gmail.com>
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

Introduce a local device pointer 'dev' in ads1015_probe()
to avoid accessing &client->dev repeatedly.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 3c2f27f41093c..af3ba6b75c410 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -966,6 +966,7 @@ static void ads1015_power_down(void *p)
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
 	int ret;
@@ -975,7 +976,7 @@ static int ads1015_probe(struct i2c_client *client)
 	if (!chip)
 		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1022,7 +1023,7 @@ static int ads1015_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
 	if (ret < 0) {
@@ -1058,7 +1059,7 @@ static int ads1015_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ads1015_event_handler,
 						irq_trig | IRQF_ONESHOT,
 						client->name, indio_dev);
@@ -1070,22 +1071,22 @@ static int ads1015_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, ads1015_power_down, data);
+	ret = devm_add_action_or_reset(dev, ads1015_power_down, data);
 	if (ret)
 		return ret;
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
-	ret = devm_pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ads1015_runtime_suspend(struct device *dev)
-- 
2.39.5

