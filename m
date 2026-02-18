Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856ED309F0B
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389475; cv=none; b=IlBquSivI3Nw7fIHIYkRa1vYMui6JgJ4751seSAdJ8BXJ/VhSm9Y9Xo5hotj66ognpO7v4vUR2RhpOX5ajIYTF6tbOEpopApBfCMkJ4dH3TxVK5W3RhF6jNH2JeYbInThyo8TkwCufMjDGx74sDxTYcoJRx+Crg9JeEGcFtHZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389475; c=relaxed/simple;
	bh=HG5dUjtQLyGDOrqZYT1xGDVernYckHNW2qOjzxl3Ng0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcfGaHArs2WihEsyYXVJ0urhL6jKYQAV9Qp+fWgzoDa3oolnASAs2IgGidoXWcADlYEfVwiLkUm7VvEe9Wu+Bg4x4Oeu8h4j33fE3Vez1H75jxmFSmDTqSXRtCECdok4wlj0572eXCXZdDe5QmPi/jzh613ZU9l94CiPmIHZWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxbrEhxW; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxbrEhxW"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ae222d978so4789457d50.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389473; x=1771994273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl2rFlkvNIGjA5rJqtvMWZSPwA1P4J9Q1kL1RvIl0Xc=;
        b=UxbrEhxW9gb66OjfYzhnxP2/24CnXQxeOthJyzmLyJJSEQuT44n29Jjno1V6EvIXYi
         yqcDgwXBJZm6/Wi056ycdplr3meHIHBvcvaVAznH0lOH9erH9D6e0Q21ABRSn6Q3MLo7
         K9z3VmRgOIeChORl5UP6JUheQCmGOZnjdgvQm+nET+6+HvIjElbfk5027zPGuHHjLP7F
         sxvOGBrex6CXjAIoLe98mHvFKDbEl7+LesZdprry/k5xcHEkq+uHjNkb2w5jsi4t2IWW
         hHmpd7xVFhzSojLJQP5cwEABKpeCJD4aLWLjopySgMKWPhQBgrRfcI8N1twVnVd6gE7x
         n5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389473; x=1771994273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wl2rFlkvNIGjA5rJqtvMWZSPwA1P4J9Q1kL1RvIl0Xc=;
        b=iuGJvatUO44aW014qJzdo/40B4uY8vS+eOd3Nwx0RvTbG0CvWDd6WaNJ9g6Moq9t7F
         bzPwacH7k83h7Sby9NaWnhToUbuCDEjchPxZebYjV2TsjXcaTsVHRtmlRSyHgwnUP4BR
         vijnKw+hKYy/EMmpfrJ9uszxGEmfTufWmEWpkAXpkiAFgZjwot9+REvpr0nE9AQrbkom
         ZWcXCniADQ2K2ZgPmeEs2ROscPFj7PF25MNJQfxwcxMW70m4/owWB9WVsXgJCmrGraSU
         Sne+gtJeCNiucppuFq5vcfY1VY9An/YTU6/GGoXqSm/XbaFtEL/zJl0zzdIqac7yQIMP
         PQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVlR892TY0dIMWFgUMudVbuhU7exSXUrrxKdxstRSl1UFIkkOv5IIOw5rnVp1vdtee62tniMSwZE7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8bysXfLyUU4zRG8HuDf7fkrQUPlUun6Q2QlTMTKqN5223TTP
	OLRaDwHufIyCOqtzG0lPR6FEkiZEGCwQgMf4xQ3sZiTIeGrsz9hrs/fL
X-Gm-Gg: AZuq6aJaCYPxn1GQKp3MaHFXrgeCdKDPGUMaZr9IjORqlHWDr1QByGCESZfTBslW+y/
	X//O+vuU96nzJuolvqupW87w6bhStxSCXs7Qi/1VPs6TK3wf4i6Oe+bT39fpF0s5a7lzdVeEJ0R
	E7hUNl5BFZqB+A+MXOAt2TwEaHJr0b8lr2qHreXawgYhKjn0trKyBG3ThxsJnxxUATb4uuM4XCz
	/xrFxruF8Jqsjnh85LsOpv34Lh2oyyGzy4vegvqKIilvkM+H0+6dAD+/p1KORzSkhapINtfzLty
	/u9kDa6m8gDEpvA4qDGtqee5E8D8dFFz4ZV4nhEj0kpW2Qb1egiu0Ih7lBp0moXkE/sk2LkK9Nb
	ZEVMiqlfaZXy4GaZjUgbQjYLZc2N48ublAA5JUOV12kph0SuitOA4RyoUCF3AZFdrwUR3bHLzMI
	B7quup9zzPgAD7JhIMhIHFQ9iNHR6FMVp0fg5NgLPsru5I3PKBQRf+BDoKEyQLB/f4+C3Rsx2jl
	+rLOaZzU6bjW1bPZRx6dlq/wkM9DEK1ZhHS2yQODrw=
X-Received: by 2002:a05:690e:1382:b0:64a:ef61:188d with SMTP id 956f58d0204a3-64c5557c9a4mr621442d50.11.1771389473414;
        Tue, 17 Feb 2026 20:37:53 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:53 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 7/9] iio: light: gp2ap020a00f: Explicitly use string literal for driver name
Date: Tue, 17 Feb 2026 22:37:26 -0600
Message-ID: <20260218043728.609659-8-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The driver name should be easily greppable and clearly spelled.
Replace a level of indirection and explicitly use string literal.

While at it, remove useless blank lines before module_*() and
MODULE_*() macros.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 54b5d1993035..d922cd4987ab 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -55,8 +55,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define GP2A_I2C_NAME "gp2ap020a00f"
-
 /* Registers */
 #define GP2AP020A00F_OP_REG	0x00 /* Basic operations */
 #define GP2AP020A00F_ALS_REG	0x01 /* ALS related settings */
@@ -1541,10 +1539,9 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id gp2ap020a00f_id[] = {
-	{ GP2A_I2C_NAME },
+	{ "gp2ap020a00f" },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
 static const struct of_device_id gp2ap020a00f_of_match[] = {
@@ -1555,14 +1552,13 @@ MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
 
 static struct i2c_driver gp2ap020a00f_driver = {
 	.driver = {
-		.name	= GP2A_I2C_NAME,
+		.name	= "gp2ap020a00f",
 		.of_match_table = gp2ap020a00f_of_match,
 	},
 	.probe		= gp2ap020a00f_probe,
 	.remove		= gp2ap020a00f_remove,
 	.id_table	= gp2ap020a00f_id,
 };
-
 module_i2c_driver(gp2ap020a00f_driver);
 
 MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
-- 
2.53.0

