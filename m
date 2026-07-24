Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A55243951
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861894; cv=none; b=j/0uR8vvh+xxEU9/jFtyMHMQvqPw4hUhE4LVgxDifOKHXkae9igclAF7OYjhSjlBqQK2rDA/jnJLSOgAdoXjM0so1VdDxj2Lm4ud3kHFdiT3pUc5XBkQiH1rafhln4dI0Bolh0UEedaASoKCK2udtJYddHXkAlLbNqsYRSv1xR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861894; c=relaxed/simple;
	bh=IpPAljVZna2GbLL2Y8k1DRG+itPms1ADh7KF8HXdmRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElmS4kaB2bThOSRLLC3efVw1sVXYU8iE5XeGEc/GS222Qso0i4DkszV/ejesM3hcM4Ls1qhW+CMD78DTGzqGgSKDpW7ZV+5iMteWrabC4NZ4valmds7qvM1CEZoGA/2AXezr+Zpig9y7/Nvn9R5pLlH5Y2Y2WOoWzp/5o+MMqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0+txpKj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0+txpKj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so938699a91.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 19:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784861891; x=1785466691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jJ6SVkM/nnw7VHKjVbR9TTYrsOrnPuzi4ft7P8KEjgw=;
        b=W0+txpKjUnrLz8nCT+KRGfw/cxjnZqgGSbI4qAsryfMwyGPixdaAFh0JZ5PqhWm9o1
         JFKkX1e5z8K/2mY+7a/CbnmaibD0bjQ0tzW+PN2v76CxEnLU9Z/by4F4DR0F6Yl0JNT/
         4t/HGz0tPyjd8gjZZn4sNoZ2ZFAjJViOq1DaUluQAscJIHsugcjDJuljJ/Dmd+LM52Nk
         6dZmjg6C2TeSnHOYO1IyFZ+YOSpFFRPq3SphSpct6kvc/agvP4T/TIPI7DjgTTB94JPS
         Kf2P5p2Ah8BWDZaGjwmaAONB51Gdu0e/5PZ+oef7bQxJA9V+J3milrlvHTsGontocLWG
         MT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784861891; x=1785466691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jJ6SVkM/nnw7VHKjVbR9TTYrsOrnPuzi4ft7P8KEjgw=;
        b=HjvKQtUgE09aCQXjIQGnwFoullfrdXAKrUSW1XmclctY9I1LB41vay7hvmfpct9XGg
         HQzyjhC8X6xtKfVTqys00lr/IddcWLRgn2mWVHT8KRcDh9CUi6bMgqPHLLjWX5vXsIiX
         NpbgdQbuVJ6fX+h+kQLnkgKJ9q3TOf/agb960dGev4A25kmOsjJg/0fh+a9lcY8rvGJu
         pQVkg9e6Gw+zwAzUUGKOUx3iHdqQQDRhp8yRfbc8n/MeloydjG2wLcGQ3Tv6GYyiQjLb
         BP7QbH41iLeUoACU8nSSHzpnuOphEZ5OO0joxd3WXmzF4KcPlkNI9UkVdb8GS4HQKLHc
         Izzw==
X-Forwarded-Encrypted: i=1; AHgh+RokBLDVdfDtq+PvvDq7gWIdZkbRrYojopmzYDf5tA+eOMpDXGETBlfJHaiXiCWpj5RCjYwr0YqyG8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnkyd1qu6oxHQ8MW0jxLlcBeIPNA42AXsvSQ+hJsH42pQzd6G
	ggsz2Ot5m/UMo5+8IdMUHMjx+1SekCAzw8zEHW3vbr06e0e1vrX3wx6EWgZNc0E=
X-Gm-Gg: AR+sD12YckJpQHoDALAAMxh6YARz/yBJWwhi6qnW7EI8PBmmhlPjV7DYjiIk0wQvqb5
	6T5D6LuAeHjrlGU7iZdvZXsPQPv2klxfwQuuAyqn2Km9traVEZAUEmPXYZCnUVPeJs5A8P6q2h/
	8Hp+TrE5Vn50YyYgyaPofxhyHm7NWFCzWg0mcZveln4n57IQ7Hbz9OkNyZh70OVlmxmm0yU8xpk
	ND/w0ABQxF/NCk58CYZKn2EOcT1Y3oOF+UNREweraJOoL61ztqQGPs/XH6L5PJOW5sKDmMAHtTk
	jA1Okpy1/4RyD2DK04ddHvYaGTBryutTveUOMnvMa457Ga7tF+kx72B6hKI4bCRSbCPGpCa5/Lh
	4hgRLRr38a40IBATcEJ6Cpwvi7UHsYSwyZunKC5ca6eb6Bj6B4VmG0cAcxxHiKBqFvyuaRPu/ay
	OVBe+GxUniDYc7u4RhZw4GkoyllEY=
X-Received: by 2002:a17:90a:da8d:b0:38e:a52e:a3c9 with SMTP id 98e67ed59e1d1-38ec8404d0emr5419151a91.8.1784861890915;
        Thu, 23 Jul 2026 19:58:10 -0700 (PDT)
Received: from t-rex ([2401:4900:7b1c:a30e:8622:dbfc:dd30:d90d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a7738sm21145440c88.9.2026.07.23.19.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 19:58:10 -0700 (PDT)
From: kr494167@gmail.com
To: azpijr@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH] iio: light: apds9999: register standby action after enabling device
Date: Fri, 24 Jul 2026 08:28:02 +0530
Message-ID: <20260724025802.13499-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Surendra Singh Chouhan <kr494167@gmail.com>

apds9999_init() called devm_add_action_or_reset() at the start
of the function, before register configuration and before enabling the
device via APDS9999_MAIN_CTRL_LS_EN.

If register initialization failed during apds9999_init() (e.g. SMBus
write failures on LS_MEAS_RATE or LS_GAIN), devm_add_action_or_reset()
immediately triggered apds9999_standby(), writing to the control
register on a device that failed initialization and was never enabled.

Fix this by registering devm_add_action_or_reset() only after
APDS9999_MAIN_CTRL_LS_EN is successfully written to the control
register.

Fixes: 5f9363e52300 ("iio: light: add support for APDS9999 sensor")
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
 drivers/iio/light/apds9999.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
index 43fa9992c9c2..62620c4a2fbc 100644
--- a/drivers/iio/light/apds9999.c
+++ b/drivers/iio/light/apds9999.c
@@ -100,10 +100,6 @@ static int apds9999_init(struct apds9999_data *data)
 	u8 regval;
 	int ret;
 
-	ret = devm_add_action_or_reset(dev, apds9999_standby, client);
-	if (ret)
-		return ret;
-
 	guard(mutex)(&data->lock);
 
 	regval = FIELD_PREP(APDS9999_LS_RES_MASK, APDS9999_RES_18BIT) |
@@ -121,8 +117,12 @@ static int apds9999_init(struct apds9999_data *data)
 		return ret;
 	data->als_gain_idx = APDS9999_GAIN_3X;
 
-	return i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
-					 APDS9999_MAIN_CTRL_LS_EN);
+	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
+					APDS9999_MAIN_CTRL_LS_EN);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, apds9999_standby, client);
 }
 
 static int apds9999_read_channel(struct apds9999_data *data, u8 reg,
-- 
2.55.0

