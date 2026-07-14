Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FC363C79
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031952; cv=none; b=O6lrS4JskFQeAqlQtC0y1UQKxhJEt9tftmcvLrAI6IGWeovftVVjloplgvShkg9LBEhgPnIMcYVP8yokIae4lgbaGzDKPzTbX6OyY7gY33O+27avT+IXyIfimgEcGTG/3LadRtYDgud0eBgO3iUFQawZrejCYq/3k7b/GXDKwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031952; c=relaxed/simple;
	bh=w4qxSQGk7fzSq6g6qT5Ue168v39VGDi2EKxh4gPJ+Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryqroFexXT1gQVsjisqiqaR9TKP7JUMj8tHVwfuFcPwHeumjxNmTCUnduIM6GaL73wLyTTEOVNQPbRCfbjr43hWLKtyN2c/A62esLLe0otdRNhSN1NxA9Kll4NrAehT7rNnyX1ZA+GwIMkgLDdvNSkt6HTi0cCBt40ZMK81w2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChdTAjNg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChdTAjNg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2588997a91.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784031939; x=1784636739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLfqNoji3127yzfgFPJ9n7LDdCqLOwjK/A4IjNX9fIA=;
        b=ChdTAjNg/SkQsGsyBYjDIvoN2uH+Wq2GyhXx+2UY+sUtTvMKs9Y5oPcYGn/NnxFqsA
         xerfDGMis9sMgkXAxaumQ4/zt3m/GZZ/KHyWcBezTkaEJKET9UuEJTffFsdcQJyD6q1m
         8vyogzP0aNeuOnZaKZ2HT8E1nFBfTkdjIhTxJ8i13LNT2GmTU5cOKeU5iviSvybiIIfn
         b0LqLO5Xyt6CGYWb6rN/Hf8+3Xjytb4dslbnS5riO4w5FJutoWA8gBiqlDdiNSEZBY58
         60PIkeJsmWOjiMq6mtIgTSNdqy8P4tKaezlGORMNa8BD5yeU7svXZy9BMizU1LMjF5zl
         DU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031939; x=1784636739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLfqNoji3127yzfgFPJ9n7LDdCqLOwjK/A4IjNX9fIA=;
        b=nfMF9U6S5nmbJ98jf6lgM5PS5im2xDDoL5FTBxPufHZGrgr1CEYFR0NlNTymsUxJc3
         JvOhiFT+wnZeBcn0DyhzFFNb2ogsZWsj+fvunB/ltHgdXdtyo6EyXZs3FBPiQlN9V9P8
         qEGlbgOhqigWcY+P9peL5ZD3RsXPOnLPPF7fdnshcjEIFo1KAdRs34gLdpU4d0SW/naw
         +wtEaXY9Xuee2/1MRKG5U6Yj7Q0TaN0/nznweZKgM6GaihrrQ7MZDjmdWpGVLqw6/pYm
         2VA4SMANJlNOFPtmUq/f+rlJF1z1JiwYtDX3p22ekxX5wDe29/OJE9mmiAJQ8mwZGoo/
         ZwFw==
X-Forwarded-Encrypted: i=1; AHgh+Ronyti+8nlblAY/ezwESfEdyndOau18Nxx1UzmP/nxVajJ6377+VngUOsw+rjkWI3UPLMfkIQHU6Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP76jqLQUcqeFjR8xhs3MTNKST9j6/oPv/GFPWPTYXUEJ1odQR
	gF2Y0GcGA42gCM6Y+2g5mVgCnB6gdVH2HxwzyHK0wYngrMAa0bosA1IR
X-Gm-Gg: AfdE7cl5LN4WySQvwydTO1D9TT6E8golHqWCDN6ASyLibXhZKAd9jyNPKLSh+qYhgnO
	8bbMn0cHi7hL1ZFsTzKwPvlqbpfJHLNMlPEYNtGlahZhP7DL6CCoDBzqbP9MpifGEU3pEzYeNA5
	1UVwmtp53cEBmm8zPrWfD8TTG8KgJoJ+UPPVJRh9BQZTspMgVwlMs0rPvfjv3MKD03sYyyJmzN9
	1nU3NRf3bA73fQTjMtW0Y0Xv0iCK4wg5Ae9Xawps0mFq8RGnTuhgVIwsHrIfqY27BwDRbZEwPNM
	OBnm/f3AmwKOs/dW9m6ENarwQ0+kg7/RW0jXSbSI+KDdPUVGZGC9lE3koirsxwb48oo+x4r5Jxy
	DAdeiOnZdjaexkNqiQONoKYEtvCM6CHImbl7GHBntu/spPYpsErvZqqSV6Ni16rZZYL5R5aE62s
	EX5F0t6kv+PZMj9FpLIG3YNCaSh6DoBI6+9oXRKStAK6w=
X-Received: by 2002:a17:90b:134b:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-38e17dce582mr3201315a91.19.1784031939181;
        Tue, 14 Jul 2026 05:25:39 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm96163178eec.1.2026.07.14.05.25.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:25:38 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH 3/3] iio: accel: kxsd9: use dev_err_probe()
Date: Tue, 14 Jul 2026 17:55:23 +0530
Message-ID: <20260714122520.3201-8-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714122520.3201-5-birenpandya@gmail.com>
References: <20260714122520.3201-5-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modernize the error paths in kxsd9_common_probe() by using
dev_err_probe() instead of dev_err() when handling failures from
regulators and buffer setup.

This simplifies the error handling and properly suppresses annoying
and unnecessary log spam during -EPROBE_DEFER cases when regulators
are not yet available during boot.

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 680d43135e617..ffbefd4576dd2 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -433,10 +433,9 @@ int kxsd9_common_probe(struct device *dev,
 	ret = devm_regulator_bulk_get(dev,
 				      ARRAY_SIZE(st->regs),
 				      st->regs);
-	if (ret) {
-		dev_err(dev, "Cannot get regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot get regulators\n");
+
 	/* Default scaling */
 	st->scale = KXSD9_CTRL_C_FS_2G;
 
@@ -447,13 +446,15 @@ int kxsd9_common_probe(struct device *dev,
 					 kxsd9_trigger_handler,
 					 &kxsd9_buffer_setup_ops);
 	if (ret) {
-		dev_err(dev, "triggered buffer setup failed\n");
+		dev_err_probe(dev, ret, "triggered buffer setup failed\n");
 		goto err_power_down;
 	}
 
 	ret = iio_device_register(indio_dev);
-	if (ret)
+	if (ret) {
+		dev_err_probe(dev, ret, "device register failed\n");
 		goto err_cleanup_buffer;
+	}
 
 	dev_set_drvdata(dev, indio_dev);
 
-- 
2.50.1 (Apple Git-155)

