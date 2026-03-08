Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB49395258
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994571; cv=none; b=e3C18/oA3BDssNESpoS4smt8/CJeuLSqhLmE9tQ1vnxfuXoLd61iV118vF5syJ6J48JKPT8Nfwxq1pgmP2RAqWyYZALMqdivsS67/AqvVOpyao5kFgBjn+cKgVIgTL8fGUHQ5Mc/lKt6FuFkmVrIGmBZuh9bpmLEXPUaa8IWmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994571; c=relaxed/simple;
	bh=BQnVbQ9ersD61+l0gwcAba/zQHB4QluCjuUn9yCCo9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AA3q2zJ71yH1eUkLl0lwVycc7mrVGpODcUw6eDfKdsS6AVkRfveF2jyFhARkAB/SrhmlZPkdwCkfb9x6F4hfAeLr2ADk4Ck68tZBVdTYJusZU0w4bs+fjn4qlKyG4mlRSSd+F/qSO4lXwHGr6/Ma4EclBzdrEXWqf9f61jK0KPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTtCJB4o; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTtCJB4o"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c739d32b72cso1507198a12.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772994569; x=1773599369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDDYVfwTcHwETY+/IJx0R9zBp6IerNE/zKCBDDgp4AY=;
        b=fTtCJB4oJBYuv3RenWo3j8blKJGhBiyPe85LO7L4w/roG6ogjdrwxw0kkzqMt3A8FH
         6YErfl1hRJy4ur41FDE5cUjoFVkF/Ss0Gep1EK8q70VYL3cSrL0MdywRVm2wA8K6UfjX
         Gb/b0FA+hj3hsMXVGgKhZ3kEeIkXIIvg9qMvykpIGJ/wPZNqzOywWJ1BRH4iIhMFmgHI
         mrENz4OxATrA9/xfu6EnSNbVm3qt5c4jOprM4ccvPv9/uRZJ5FdOWeqQFDSwf9M5Z/I9
         a7q1uNPSH+zIniEbCiOZ4o02wTXTqGh0ruRJZGwg2u01vv8NFHS8DCPy8EJMF5MdPwUp
         kyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772994569; x=1773599369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDDYVfwTcHwETY+/IJx0R9zBp6IerNE/zKCBDDgp4AY=;
        b=wanFTSqXmbxGQTINybCjkZpg9FOJ/WSnYV15ZMNn7PP8GchEKBucbHqINR7BSg4aht
         1ntsP9MDpfplgRYaMqyqvDghFsRCLp2bUxk3yV8qu4PobcH5ZxBL4z3C7DYkzW+QR8K9
         nMavTWWCFBsLbyTH5XHOif+7SmB2pKf7GJ6TUX8hW+HGL9WwoaV5QXddRGO8/GRsSy7U
         LUFpti/H4SbPbGHJ1C/J9mEDo5gzD3i0x5jMdi1z7jf0zgxZG7bhvBT5xkrNjewzNVwW
         NAvOPTFD3Z/HtoE78+sexN5liDCMQ/ad2VEv2jq41oFTFQfLsw607XdAJ8gZY2hFTGvK
         aS0g==
X-Forwarded-Encrypted: i=1; AJvYcCW36TASjSJhxRqZrrMhOx1kf3ANTkxsAACj2DohuHu1Fv/13ajeTetDvahJPah/rslPz7UsrZ2Bmag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdonBXLh/VqESvPAAscZrAQlEFsYrZAtuqIQH6+2G1gn8Hc7qj
	IPi3+JcxrFVBfI2kfEmfWWnjogheTCQpgCK+HtjzPZXq29T36PJGLSoZ
X-Gm-Gg: ATEYQzwsOHoLMrd9RWV2yQoDf5q1GnpzBJPev3jgRitzk5PJw/zEW7K7G/sXUG4sikz
	Xi8SgE28sO+UZgYf4F+0dUnSNgR2MW1BhlTu8GWeyDM5FRZAl5khEMjWu/rMl89Qb7jvjCvkbYg
	mYBD7Mr0y5vWmUytVx4Snn1zw1UE24px0njmpX7a2mjtsbqrvwzRXHKK9fffIU4kYEHiDvwILMx
	HrwG/joOoZWVPQQTiIIBrH9t41uLK70/edCcUqjqa5eyFIwPFjIxQT/Dsi9cQ6ahxMLgYjv/XUD
	+SkhVxEkN+sQeO6g628i29RXGLSWctAfTlezt7mIc2IBbGa3nNHS0a/4ATnMhiY118JWViycjoE
	1JCHNBj7iQH3CWFXs/0saqf6wD5PValFoCbBNiuxPa83a4wbyoxWVmABiZhTTAT62HGKS4AqPyB
	xDDu3xBPeagLo332OdJi2gNXNjV48OFtYOURtTKfbe
X-Received: by 2002:a17:903:40cf:b0:2a9:5db8:d651 with SMTP id d9443c01a7336-2ae823b349dmr85149985ad.25.1772994568741;
        Sun, 08 Mar 2026 11:29:28 -0700 (PDT)
Received: from debian.ari ([152.58.179.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783dbsm89006965ad.42.2026.03.08.11.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:29:28 -0700 (PDT)
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
Subject: [PATCH v4 4/4] iio: adc: ad799x: use devm_iio_device_register and drop remove
Date: Sun,  8 Mar 2026 23:58:11 +0530
Message-Id: <20260308182811.33471-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260308182811.33471-1-architanant5@gmail.com>
References: <20260308182811.33471-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to use the device-managed versions of
iio_device_register(), iio_triggered_buffer_setup(), and
devm_mutex_init().

By moving these remaining resources to the devm framework, the
driver no longer requires manual cleanup. This allows for the removal
of all remaining goto labels in ad799x_probe() and the complete
deletion of the ad799x_remove() function.

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index f5ef6ff97c89..89ac0d393366 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -861,7 +861,7 @@ static int ad799x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
 		return ret;
@@ -876,30 +876,14 @@ static int ad799x_probe(struct i2c_client *client)
 						client->name,
 						indio_dev);
 		if (ret)
-			goto error_cleanup_ring;
+			return ret;
 	}
 
-	mutex_init(&st->lock);
-
-	ret = iio_device_register(indio_dev);
+	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
-		goto error_cleanup_ring;
-
-	return 0;
-
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static void ad799x_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
+		return ret;
 
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ad799x_suspend(struct device *dev)
@@ -969,7 +953,6 @@ static struct i2c_driver ad799x_driver = {
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
 	.probe = ad799x_probe,
-	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
-- 
2.39.5

