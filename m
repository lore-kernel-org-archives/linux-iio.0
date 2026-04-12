Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E6316195
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986696; cv=none; b=rhgNo6wpTFeAef0BzweIIDnUjj6qGrVmcEzyxJfI2sqqp1NuLB1jOume3XEaS3c+YNLDNaQnD6mEhFzmTSOgFPzHc7KenywraUgXaXxPB2z0hqbouSuaBjXNCyvW3icq3zttcfRJSx2t474oubt2i4T0GU5MHYaStP3Lyg2j/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986696; c=relaxed/simple;
	bh=Juv0lIWR9wA6yoOWU3gG2P1D+1KNFZdtqGDVgjvY1J4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejLq+HnAejNcDWRdyBjjeE+0qwyrTCN3N1fd3KGcmGVKQiPCZCzjG356jAmix7SBbc4JqgnOyEN6J8Kt/EkECbwqzxijaL5SS6oQa3XIiTagChABtvR8Jq/NN49C+Yn/be7RGx9E9AHPHvO12irNnU4lNMZlPhHBBBxvCujeoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EllSDqXd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EllSDqXd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a655cfab5so3063904b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775986694; x=1776591494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl0CTLPyHKFF3qqDEVLryzjQaV8YhrkXRYbnO1xmfn4=;
        b=EllSDqXdag3bE+6OTJHWWaLouSU+As/2um0AN9UJGBAU+fQxI+bINKNjJgfp543ltR
         rO6qtfhFvXBFGdaIrkw63SZT9KX8xAOx4HB6etEQChCIh98dajeEH1D+5Yr3jvb+FJE1
         ihucFDDVqz+GQMifuogygm8ClH8+bbzNtW7CrGyoQ8zJPYFwRreHfdbK/eF3g0YPMPPR
         ve7vSXSna5A0P0K0uzx67qY1tfW3YxaexJvTtvvlZawvV4KaUZ33AnFUUVUqMpVhtnZ/
         cBAZOElyQtQx3caS5vdie2++FoEs2y3MInMR1SM0n024SFN05/rLMEf5c0fMZ4q4fs2J
         BkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775986694; x=1776591494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gl0CTLPyHKFF3qqDEVLryzjQaV8YhrkXRYbnO1xmfn4=;
        b=WbsBkVwhr91i7YQ0FCS4mnaof2hHZhD3abHm3TRG1tkkXXm5+NBjER4DMqLN2cPyRU
         cwpzPCLxpbpvmWHWH0NsCE5MQW7mK0ObWflADSQWjsuVmdkw+AayEftjwY2fhRMhoKku
         6NbZcHcvV3Uqr9TEgDET6P0wnBrj8kzRnSq7B/6v2/thhgyU8zXAokUc8Grd+bZiOvM2
         s1JplGD2qxbGdJZRe6WSDD3r10g8FTthe1NiN88sxf+r7MxQ4Lp9tG8rw4i5DzLfRYOq
         7JiY5uq54CDD5OE9fj92hWFFzxmrX/RVIz/o0nK5Vbb1NJ3OWUPxWCp8T1acfl2FR3hL
         NWcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eiZLTsR99djSxZQKMb5a2zljrx+ly3SY8dXnnAdFHkkLw9Bmq43b9KiOQ2Wu3aSqPJZUKxqKfAJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxXtI9mXk22SAasU65UBRGVE14BJRXj61g/kRBUCT67PyHZYP
	w2JzvcAR4o5vEav7wrTJ9yiywGNaTPCFuyMQTWBvtja6rx6OOTXdwyCY
X-Gm-Gg: AeBDiesYkybcaMOhd+5Lelk0eg1fNAklwfS9DpgL99TX6h/gbe9FaO8Fo59xsjypjLD
	eDXBZ0zRIUc/Y3sPur9UwxV9pIs9J16zNGCPlV5ICcVVjAL9JK29jpl3VsKJX2ERYnbuvGSTQe5
	Tyhfk2Lkm20SuvsL3H5lX5hNUknSfK6lqRXo7233UPp8JKDUhBUUv9ym52mrBwsxmC7CYDCbi24
	N/jqolzQMXChCoMJS9nBJgTBxBETht1ZuxFJR6FixYxR3Wt1ww2ZL9h3Q2tKW9+XHK63a+bWs8c
	X8r5cCzCuIu1GLHi4uj6JBVqI8Ztq/GMm9S+Ppz9gj7+hompx3NImxa5JY85MyLufHmTl6wkK0j
	iAZeR/PT+mLcrcgbVNlOvwwkFzjYVy5S29AXMAdTk6q9Zzbjzwx7PdyQC6WP+naRFQbbQKk+NMB
	hBxh1MCMkfOBaOMlahi+EB1Ki6bVrmOOBhlpPTqOWNtOy7j2Ss8/US0dXnaK/56Qc27xgnVy33
X-Received: by 2002:a05:6a00:39a8:b0:829:86a5:d30a with SMTP id d2e1a72fcca58-82f0c2194f6mr9647773b3a.16.1775986694142;
        Sun, 12 Apr 2026 02:38:14 -0700 (PDT)
Received: from debian.ari ([152.56.156.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm7885038b3a.24.2026.04.12.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 02:38:13 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v8 2/5] iio: adc: ad799x: use local device pointer in probe
Date: Sun, 12 Apr 2026 15:07:36 +0530
Message-Id: <20260412093739.17116-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260412093739.17116-1-architanant5@gmail.com>
References: <20260412093739.17116-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a local device pointer 'dev' in ad799x_probe() and use it
throughout the function instead of accessing &client->dev repeatedly.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index f37f1fda2dc4..bf0575585a59 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -783,6 +783,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 
 static int ad799x_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	int ret;
 	int extra_config = 0;
@@ -791,7 +792,7 @@ static int ad799x_probe(struct i2c_client *client)
 	const struct ad799x_chip_info *chip_info =
 		&ad799x_chip_info_tbl[id->driver_data];
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -807,7 +808,7 @@ static int ad799x_probe(struct i2c_client *client)
 
 	/* TODO: Add pdata options for filtering and bit delay */
 
-	st->reg = devm_regulator_get(&client->dev, "vcc");
+	st->reg = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(st->reg))
 		return PTR_ERR(st->reg);
 	ret = regulator_enable(st->reg);
@@ -816,17 +817,17 @@ static int ad799x_probe(struct i2c_client *client)
 
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
-		st->vref = devm_regulator_get_optional(&client->dev, "vref");
+		st->vref = devm_regulator_get_optional(dev, "vref");
 		ret = PTR_ERR_OR_ZERO(st->vref);
 		if (ret) {
 			if (ret != -ENODEV)
 				goto error_disable_reg;
 			st->vref = NULL;
-			dev_info(&client->dev, "Using VCC reference voltage\n");
+			dev_info(dev, "Using VCC reference voltage\n");
 		}
 
 		if (st->vref) {
-			dev_info(&client->dev, "Using external reference voltage\n");
+			dev_info(dev, "Using external reference voltage\n");
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
@@ -853,7 +854,7 @@ static int ad799x_probe(struct i2c_client *client)
 		goto error_disable_vref;
 
 	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(&client->dev,
+		ret = devm_request_threaded_irq(dev,
 						client->irq,
 						NULL,
 						ad799x_event_handler,
-- 
2.39.5

