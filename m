Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54947D92C
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506781; cv=none; b=CvWsu+Vaq3OBMf3tZKL8oDrJBftHjwn/UMyrYHBQ7Az1VISMcdRcfXxEP58h8a2VwyN4jfxebYbg9NbX+4XGrkdnFDDhrQLBnW93D+Wse0ZVa6Z1JvwMxdBRxHPOMLI/lxcsGgQfti9pCLybCY84eKQhTEkvlRNr8/R9jF4X/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506781; c=relaxed/simple;
	bh=+qC0YWfflnYInnRf+X6ZznWVvUClte/iMms9DO3MvUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6fAQURrbycGNz9iNr0WjQiMSeflMgvekZVDqg96hVkuvfo28UeKbZgp+TCuWQvGhbPoXhr2FCIcFN5KBLHnupclyzppUfSe63Gr8EXuTBdXiK1CnxNHrfrNmjU56ia0xrGtvf/Ln7TIUlvw36xu1yB08envb8U4KwVU57syfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbWO5vVY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbWO5vVY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac357c55so37470625e9.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506777; x=1781111577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Be/cBTIY2UtthPWGW4sFFao6/kg9emmQLSnpfKTVvo=;
        b=lbWO5vVYP2V4Ay2irakVMuijVxwj5iJ7M8Qt4XRJ0AKjUykOsgeL5ozwQCpdRPxDKR
         2fr9kqiCL38rISCuSvXXegLkbEBSqH1UAzbUxUHNiXz0VVwfHGiHoq0RAuGf96VrfSsS
         Cd9URbrfUVYO6gDd1UwMWnxTpyGiTwfq8c2eCXlm94Th0v4DBBq44bgvSoSi5vA/Evcl
         0yek/+odUmP10utg/RlKf5x/XUnMTrDXes9Ia0pDr4O7P9zd86ZAFiVKBh3rZ5XCEeSF
         4yuDCZsCUuf3ozPh55kc4c6BZhz/YeLmZq6IAbL/kJO2gnyghic7E4npuBvGQRqlJ65g
         Guqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506777; x=1781111577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Be/cBTIY2UtthPWGW4sFFao6/kg9emmQLSnpfKTVvo=;
        b=iuq7yPJDgI7mRQLwnKEHUfX/OPdiWnpLcqymM/BU90E2u3Prd9YXM5sxuAWBdmxavJ
         vLWQozmbrPKjAif7wfTeu7rfiCs1BHuHArIc9CWPNu+rlg21zbh0eQy4zcaKan4YrnyT
         YI6MXmF1lqZiMnA29UHeVyi7uvAuTSCM6FKhkwcLJnAdTxBRziQjj18u6FDrEAuhFkff
         wBYuN+3mh9EZ3Ve2N8zkiNUPhed9XKG/yH+cjZAckZtepmJh+BGfaWIvgoFsAgB0Z4ZI
         Ew0ClKYm/lyYbGMgzB2tXGvAyFnAcZwluZez0CGO/ypinztoxMQ33pYvTKr8q9RResim
         8hQA==
X-Gm-Message-State: AOJu0YyTwrwjgM0MrsGDOD8+oG6NASJ1QMhGEFGOPL+R5qaWNKyxHZCE
	LWDUeY3o3nXgbg+yA95Z3/p8mmnAS+ALbRLeMe0MVx5hu+bnA6XEv060
X-Gm-Gg: Acq92OEXgoC+Z1sda41jmjOFicG1DOET8fnhT4beQgTkH0iElb+0I50uAE7J5PHIoji
	wH3N++W7hb+oimt7LSSk67BiQ93DBYsUqQJtIyc/15BGftBDM7MdyRq5yjeyAIigfpc5IN+zgrX
	wX2jMUt69LzyHet4qtVvcFDQxeNs2ha5PIa1nTsegPrK0OgoZC3YquVRWmlX8ComSv7q6uLRnoL
	EJVxhBAdrB4aZNoEguuNj0/5Gj/fuNE2J+BzbMARBim6jNebp2X/6VpFwI9fwE7psRf+cNQUJDK
	l65y+CdxJCtsabZzHZcc2X76hV1xxEH21sn08ccGTZDeLfH24UnAnONaVaH7VSFl6cGqj4O3M6Y
	wCln0cY+938Z2BTtTBuz4MXb50IyFWQNdVJNo+XnKMmkGTjuu3yze6mB9GdB9SxEDgx7mMlgIfI
	5f08aSOLhv291pRXONWvAUvc2LD387xPbEUmrlaORD7btfoy2joj+e5sai92t0Z7eI/85yK5p5K
	t9VeyBNPAfD+Hhsxp812me7YWDCA3BEiBKQ8j2MVAC/V/quXqaxRFm/UrUx0WthSy28CgC42y9G
	lLWc9bn0GMZO1aSsBvjWFdanx7sbqPhvk/slCLU7Mc/5cqDTE24=
X-Received: by 2002:a05:600c:4ec6:b0:490:b8e2:6380 with SMTP id 5b1f17b1804b1-490b8e264c9mr57333915e9.12.1780506777445;
        Wed, 03 Jun 2026 10:12:57 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:57 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:56 +0200
Subject: [PATCH v5 5/8] iio: light: opt3001: prefer dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-5-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=3528;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=+qC0YWfflnYInnRf+X6ZznWVvUClte/iMms9DO3MvUo=;
 b=OBv0spHsQfLwlI2kP+v23eUvLAlrzl19aHcpZ38EvdsT6kH7OSlrKhAMKSkQPSaULkwHrdBNz
 GJ+d6+XltfqCk318cpX6bLm06sV7yCIoCoNVGAV/g6ZFrCtJeY8dL96
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Switch driver to use dev_err_probe() to unify error messages generated
in *_probe() and probe path functions.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 56 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 777a54753b0c..fa799edd6a9c 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -706,21 +706,17 @@ static int opt3001_read_id(struct opt3001 *opt)
 	int ret;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_MANUFACTURER_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_MANUFACTURER_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_MANUFACTURER_ID);
 
 	manufacturer[0] = ret >> 8;
 	manufacturer[1] = ret & 0xff;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_DEVICE_ID);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_DEVICE_ID);
 
 	device_id = ret;
 
@@ -738,11 +734,9 @@ static int opt3001_configure(struct opt3001 *opt)
 	u16 reg;
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	reg = ret;
 
@@ -766,28 +760,22 @@ static int opt3001_configure(struct opt3001 *opt)
 	reg &= ~OPT3001_CONFIGURATION_FC_MASK;
 
 	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-	if (ret < 0) {
-		dev_err(dev, "failed to write register %02x\n",
-			OPT3001_CONFIGURATION);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to write register %02x\n",
+				     OPT3001_CONFIGURATION);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_LOW_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_LOW_LIMIT);
 
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
 	ret = i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
-	if (ret < 0) {
-		dev_err(dev, "failed to read register %02x\n",
-			OPT3001_HIGH_LIMIT);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read register %02x\n",
+				     OPT3001_HIGH_LIMIT);
 
 	opt->high_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->high_thresh_exp = OPT3001_REG_EXPONENT(ret);
@@ -894,10 +882,10 @@ static int opt3001_probe(struct i2c_client *client)
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
 					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   "opt3001", iio);
-		if (ret) {
-			dev_err(dev, "failed to request IRQ #%d\n", irq);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request IRQ #%d\n",
+					     irq);
 		opt->use_irq = true;
 	} else {
 		dev_dbg(dev, "enabling interrupt-less operation\n");

-- 
2.54.0

