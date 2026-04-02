Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6733DEF9
	for <linux-iio@vger.kernel.org>; Thu,  2 Apr 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143059; cv=none; b=iJ/e80k+EfovcMo1B4BRtPmbnJnmUMOQ0wDqvu/kYoPMkXFPMPInW6BL+IOnZ7LDV2lTYueBOX2h2fGvGWtwGxeaK+N1wz2sz+P7CoT6Xd4ugGGFhbNntMDHH+1N/We9O+M6Kk/Lore6rRHL6cZkImrM1t5alcKh8fhQNozq5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143059; c=relaxed/simple;
	bh=3kdxjSUeVf/FuGDAAytGCSHU0OdWoSD8W7W/mC21/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivVIxtrzOIHENjm5p63RxPKxVt0x0163ouJXcATaMo5A495As7nuuApPxrBH6yfkGutffGRnqOshPAWuOluc4I3efPwz0NyJVVtnLGVcaMxW+HncqknmuTccZxfY2Dsq3ZmmoFan6A3yLtMImbodn/UDfiQwhiZZMNKhYutHeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8g/HXzk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8g/HXzk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488971db0fdso392415e9.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Apr 2026 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775143056; x=1775747856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdvV3uoZ82XkebWsgkeF8rl2q6Pk7QwD6xIvmUVJSs0=;
        b=b8g/HXzkuW57S1g27j3U6XsBR6y73flgCWQbnHkJ0Y4u0qUlQsQujlm65dlJRI+Ite
         1ABQ9x2DlBfUkrzINqclmopelene2a/0YRr1XE6DfjkUsq4VNurw3ulnqqrUz8Y0ENJX
         Bgq1pL9kOvCrtndMdscTvJn/ZBpn8C5Gw0wdu4RsizAaiREtKTzTF8/Izck4vYwYn99i
         SVmu/AHfFAHPEJLN1QI8BRcnT3qxpdSSH7c/vPtm4Gh6rGjlTTmpvoK9VDRh72qRrHWq
         KBOMu2Ju5oxmnctdqzeFuSqSrRuUdw+bXh7ag1NlY1pPogHeSO5ci3Zeywfy9FK1vQw6
         rQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143056; x=1775747856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdvV3uoZ82XkebWsgkeF8rl2q6Pk7QwD6xIvmUVJSs0=;
        b=ZseJErs8cvRyN5L/bEXTvQFn3EffMwPKeqVM2Y6xbDloVFZtNM9mSzukkobTXsndhS
         E8rcXLeK/5vt6UVzaJrJflkKKeqV7X4MMn3ot8x09VH6LbBrbgtcV1IRbOPdIiIabtav
         f0YvYb3nY4FgaOHX2K5zn1aQItmJ0Nl3JiRcIadwBw8Go2LTsPNhREpXrSLed4oXXYfp
         Nx601TFG1tee5Cbeg+WAGy/EdEgloN4sGiKofjNTcMYTenhoqH9sShc8Hn585MkmIufW
         KgU+VO4EVhzY6rhWVdhLu7BQNzO5D4GQ7BbaUolmH5yk21/84MQqpqF4eXRwSgEymtyh
         mfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSLnHTooD1Qa1dnTG2BfyEDMnYz41ghghDxc8RoH3FIUjGhUbdb6AJobEdXfBFmxrogTRjhlECnRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHGp3d4zLFL3LpzmM610v+GMPev1eIPZuDpqDQp6sEVRF6u8Zj
	KE6fhJxyQnLKKcXhfgjea8eO5BOL3r4yWEdw5S8Decd01NICZL3tXk0o
X-Gm-Gg: ATEYQzwdQdLc/H1pOsD5rcpHHee5ZJWf9uv0ofwHkGN1XZ9UawuIwZwb4WVn8F2iAkC
	QhlrRupZMBi/XJefqhJquAvChdMt/9rMcatau1cm31uv9JiOEslYgM35ma/0CCNVqAu9KgfGr0S
	lBgUeQGznLAximb0VbfOlVOceoX0XnOghhQHpIb5Ltva1YCr9QKUI3ekqsPH7waBO+/9JTfHY/z
	qLx0e5syc07911YlU/AHjJGepuNYLlGR2tOpQNmfvGc+UcxM+9HET59JW9Dtii0n2n0n5kHECIU
	VL8GkOUb8VYkUtM21KR7Q0/afcVL4ImDM4jY32BAjSa4dkwFB9hTxZBxhQyiGBcP0Rm+VDx6Jsk
	qnAs3x8vIEgFtX5gic8Y1zygvIP4Q1AHRw+Rkmi4BArneOp/qbRt/VZmEBhAuthUEvc8+SqQd69
	NUknsfMhaXokJxWU8PF/Tsr7/313vTIqqvq4oOaFjzLXqt5LmjFU2E
X-Received: by 2002:a05:600c:c107:b0:487:59c:2bad with SMTP id 5b1f17b1804b1-488835954f3mr96635585e9.24.1775143055669;
        Thu, 02 Apr 2026 08:17:35 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm327405075e9.2.2026.04.02.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:17:34 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 2/2] iio: light: cm3323: use dev_err_probe() in probe path
Date: Thu,  2 Apr 2026 17:17:30 +0200
Message-ID: <20260402151730.18901-3-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402151730.18901-1-aldocontelk@gmail.com>
References: <20260402151730.18901-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_err() calls with dev_err_probe() in cm3323_init() and
cm3323_probe(). cm3323_init() is called by cm3323_probe() ,  so using
dev_err_probe() ensures that deferred probing is handled
correctly and simplifies error paths.

Remove the redundant error message in cm3323_probe().

Tested on a Raspberry Pi 3B using i2c-stub. The driver probes
successfully and successfully read integration_time after this change.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/cm3323.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 0fe61b8a7029..43c2929fc724 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -82,20 +82,18 @@ static int cm3323_init(struct iio_dev *indio_dev)
 	struct cm3323_data *data = iio_priv(indio_dev);
 
 	ret = i2c_smbus_read_word_data(data->client, CM3323_CMD_CONF);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_conf\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&data->client->dev, ret,
+				     "Error reading reg_conf\n");
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
 	data->reg_conf = ret;
 
 	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_conf\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&data->client->dev, ret,
+				     "Error writing reg_conf\n");
 
 	return 0;
 }
@@ -236,10 +234,9 @@ static int cm3323_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm3323_init(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "cm3323 chip init failed\n");
+	if (ret < 0)
 		return ret;
-	}
+
 
 	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
 	if (ret < 0)
-- 
2.53.0

