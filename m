Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3BF12E1E9
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456824; cv=none; b=Mk9/+AXvfc+Tt0t8UJZ284DDX2jRQJeRyigEXs61klVpLqqlvL+/orAiNgaXKO8irndpSlK8wvU1e+HG3Kq/vKOaN6mxWCxt0dCZGXeS4VFAMLDR/gvWaIwMxV+nbt2KG/NuplFcxwNWvXK9z9Cre2engsIlMfy+NXeajMiJ3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456824; c=relaxed/simple;
	bh=pUizvyGgrbVh0ydayA9+/BD4CmqGKVV3YpQdMRdjHZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oeZB9l3ZrIjC/GeSqBceRUuKsp1YYd3DcfxThDZzNxS0PDUw9o9+5kVj4xlpkpefeArdSIVA2kB2fRdE50Zdl6rnTltR3wZ65c2WIcNgxrQXaBG4MIxOo3m9yV0NwsUojajY0JJwwNfV1ZkhEeV5w0cb0/b6TCUuMVWXhq2xUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+PGTZVU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+PGTZVU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2479335a91.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 05:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772456823; x=1773061623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmA9gHa9RdR5TU2BtZuAJxtVJP+tTGO3ZPbWbacgMoU=;
        b=R+PGTZVUA7JbdHRysP+2JoXHE/0ycwp6I5a6VDUBUr/+vJ0WTJbQGjLnM/NrVCqZ25
         7DHZb7zXlzqbqxj3s0oj5ojiZUtJsMBXuRCdOicRy/YYj8WGbudWAZJVUDPs/BFWLDU0
         VdZQ+072DZQ6pBw61QvV7Rc/lze5Z9FILqMVmd4GKns1ZuIKS3G613RXQpG4T+ImGJ9v
         voxDWv7+jqhE8MFLaV/rf3UC2CL6dCzAXWccLVHQ7aUmjHtS/eZyvcAMlYrf3enMk/Ph
         RFjzFASphB2UPOaJN471rBvqgre7OeQUL39eojyFQH5nwJ5NvVM92hj/n+Gkq2A4EgGN
         tRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456823; x=1773061623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmA9gHa9RdR5TU2BtZuAJxtVJP+tTGO3ZPbWbacgMoU=;
        b=e5U1ZeGjSTtnFqc4odO2CSh9ZKT+xApAGdvqxLq6kXRaPGkna3eLu3Elk97G9KuNRg
         61TVqlo43y9XLaiIgRG/ftbLm9gDBggJ1ToevsC7Nz+RYYTzxNaQDmwoyHQ6gwBxcq15
         JIRCrUJ0qoCgaDVlDkyzFH6Y6dyNx3EvHDrX6arCsgDTK/kqF1cukPjaNPx/JMziXiVF
         E2NVw6FkgyJaleC7ATpap+4whwy79t3zN3Ds2BOV6+ANJ/xrO/6CPLc6fR/EPOCHr9iy
         zirgHUfh5yyCTH77udZuwZSk0YFMuCEHwT1IXftouD/t87GWQERJCAYL9CYdj/sDgcvE
         f+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXPED1NL2/oGaKElc/MCglCVfNPZ3kSVu1eTmkpdod7zf7JieSEpD1xJvLUysXONvJO/EEKUkUPLwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUs6M2EPmxjnrHluNoO28V3e3tduOSgnhBJWCuTOLxn/LzwpYh
	MFgsXAjjBdjVMk0f2EIekPPQnJ4QVaiBuUeRoaYqqNfGrzft8ocvWaB9
X-Gm-Gg: ATEYQzyT9E88a64+SyOt0oeN0CjW9UZPfNGRpHVWKf4RJfTOoHltXOQCYVZhG+UQ8QP
	xN9p7+5o1NYbUlq0n23TT5g7L7COi7gpRQ8QO7/sUHmNDLjjfu3dnk4UUWfZNpsX67Zr7L+uF9j
	RhhXUNClQw2z9QYhVdpPKMerO+V2Cn5czCZRRE/mbn9uSjvpUkouXKhE9boQPeR7bwckM3LJAfQ
	4hrmlKIWP+/tj9NHTSKxH4OpywsaG01eoTmdxKFUe20pTfXTC+DonzkVzLc/tZUSQOUrhkvuM7F
	elb2JRz0PO33Ww9bw7FrYGaJ3o3M8YtAodfm9GIs9dMwRc+jGCBCO8SIMscUXHZnikSkYMXe9zu
	eD+EDTys+6Txah+Lmwuex/HNsIWshHScuTl4kapHUL9Ogpr1qBz2r9rM0oLAV55AfDgyFgw4j1w
	fOz4buz/5sF4nazAg4tcaxuB5xxge8lhxe56uppkHKEw==
X-Received: by 2002:a17:90b:524b:b0:354:999f:1b22 with SMTP id 98e67ed59e1d1-35965cf519bmr8851182a91.32.1772456822897;
        Mon, 02 Mar 2026 05:07:02 -0800 (PST)
Received: from debian.ari ([152.58.176.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597b448e38sm7444585a91.5.2026.03.02.05.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:07:02 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 3/4] iio: adc: ad799x: use devm_add_action_or_reset for regulators
Date: Mon,  2 Mar 2026 18:36:31 +0530
Message-Id: <20260302130632.29144-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302130632.29144-1-architanant5@gmail.com>
References: <20260302130632.29144-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the manual regulator_disable() handling to use
devm_add_action_or_reset(). This guarantees that the regulators are
disabled in the correct reverse order of allocation during device
teardown or probe failure.

This removes the need to manually disable the regulators in the
remove() function.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 35e0589428d0..1a96b5417ecf 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -781,6 +781,13 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 };
 
+static void ad799x_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int ad799x_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -818,6 +825,10 @@ static int ad799x_probe(struct i2c_client *client)
 		goto error_disable_reg;
 	st->vcc_uv = ret;
 
+	ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
 		st->vref = devm_regulator_get_optional(&client->dev, "vref");
@@ -840,6 +851,11 @@ static int ad799x_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto error_disable_vref;
 			st->vref_uv = ret;
+
+			ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable,
+							st->vref);
+			if (ret)
+				goto error_disable_reg;
 		}
 	}
 
@@ -901,9 +917,6 @@ static void ad799x_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
 }
 
 static int ad799x_suspend(struct device *dev)
-- 
2.39.5

