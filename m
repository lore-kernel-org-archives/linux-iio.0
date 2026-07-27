Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC53C1085
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178173; cv=none; b=jpj8Ps9Tt75wRR1yHG90/y0NvRh/qYDt7sgkg6utf7C/EAPt4nBj/ZMSRRGN4WIwDe1Whj1+LdFf5l38xgi7JanuUIl8aIt1rFnx6/dYiEqyA6Qj8Yc5lLg+knShzG3Np4oOgToX9au5S+AoGuVSeoD2a1eAEL3uqCN331Sz8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178173; c=relaxed/simple;
	bh=6vqRk1gceBa61eUvhhQfxRSKA0M7u4YPXd7uMQup7og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nxc+UOV9iVgMZOKsXdOsBUeACzAh1xcx7xtXUE4j8I4yjMy1SHUnY2l+Kr5Lv3ONp6aETRY03o5eTzQ9720OiXebiIJDeVOkqRMIoSWsF+5iPE47OVqKjMOfCBbw+a8XwUA0Mu12nX9gl7hSFNDV5BUncYPjBRQCUm4cF+VgYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvHKvJYC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvHKvJYC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc97653887so35959745ad.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178168; x=1785782968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yk2QYp1+G37Ul7rQYxklBzkXZ/wb8jpNlgQXypDeBU=;
        b=PvHKvJYC+fZpl6INCD1/r2OGbkR8xJxL7mGobCmFeNBRmUOxiCqAYUuDtYK+O1qS4r
         0G5rzGEk53FVI1ej5Xzfg5WB9feRdGfcKiabuWF4VxlDnzVuxSgQJ2Gz8bZwrjmyYhf0
         orYyQGnLD1eXypg8NJOb5UO/zKCS9u0psPbZjHYX3Pzs8Uuv+14T2qjNyyo5bTrjyEK5
         VHvEZYAthvV50jFZmeiqORKvlOciByVsZTY6IyW45Pae2dTh3nHKoB+zVmDmvMV90VW2
         ItU344ZMKsAFDOZ18AH4aLld6NLLSOKdRNcJ4+Z24bER2u1bj+5mO20Kgrza9zEyIQ3N
         UFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178168; x=1785782968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yk2QYp1+G37Ul7rQYxklBzkXZ/wb8jpNlgQXypDeBU=;
        b=LvAemagJkPFfU5xl98UbE58hJdb1s7n6+W8jRH/kc4emR1eQ06umA9cJSmzQV65yvE
         5hQtl9kuWhIOkwPBxLzTOTHZxvUzS3QGMYjh/F5CQfrMBg9ljhbuN7KFCpMva+nPbUWr
         a5nNWQNj/yoOQNSE4i0P2wMtuNrF4tBgmfcQEGg+yMRk1cIc4DQZI7ubf1vcfDidzUGA
         F+Ec0rOez53Qgs2qZTWqXPUz6gZt0rtzUR65bVGalkja2zLMIylYFwWA+PGMiUKOVR74
         2ufaUYGkDheh8YriPqu7+N94kIc5mBYEphZeKN2gOWQpEQyRB4rlFJJS7QYlElV08zHF
         yDFw==
X-Forwarded-Encrypted: i=1; AHgh+RozJlOPVR1kCYo5HOQdL2CyYpTJb4sP13RQm+WYybY4jOjS+fcRxC2uqY3oZ9+EVJF1MXkhSCIPEXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1shlMGPYxk64UN7SyszuErUD04YYDlLQH13woKIjLcyukpmY2
	gvgWjUhjNjU72lZxbuv6+r04D/Q2MJ627xIvy28wvsZHfe+4lg8qC5/W
X-Gm-Gg: AR+sD139TitPSI6+EsXJX10d5/d0hwuDqLXx+1ize6R8jLNm29W8H2PBO/nzIze4Kd+
	qeYGFSe0zTXoylknbdOlCr1+d5IQwKYexdaVPo4bjYEDqhKypdXfy24PBj8EOgQnqfi5DrhdDkB
	wpXvkWMvrpHRf7xqE/zfhWt+bw+fmmlyTDSNZS27zld8rYDedY11GIUZf78exdDzxxraYnBur3e
	4JKXdVwHuOkJWzw51ufqc1ZYzXcYI3u7uLDj0k6ZBb901QuM9iZjzcj8U6vWbPIPMB9GsxDywzG
	00doD93UfYFo5109ILIAzkEZD6KOiS307LovdmI5lcACKLEV2542Z6V7fUQGbBdzcaGpZdiwZVv
	JtjSglkkG7pGDieCTZ94YDZKpcTotzk6PcrvyHavgAU+/qfjKAKZUz9E5PdHyrXua2rF4ZLkSMu
	ZfbRSWFWY=
X-Received: by 2002:a17:902:da82:b0:2c9:ae0b:61e3 with SMTP id d9443c01a7336-2cfde796aa9mr86688655ad.2.1785178168186;
        Mon, 27 Jul 2026 11:49:28 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:27 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 8/9] iio: light: tsl2583: remove conditional return with no effect
Date: Tue, 28 Jul 2026 03:47:45 +0900
Message-ID: <20260727184755.2055414-9-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has no
effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/tsl2583.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 06da145569f7..53fd423aa7ae 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -456,12 +456,8 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 
 	usleep_range(3000, 3500);
 
-	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
-					    TSL2583_CNTL_ADC_ENBL);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return tsl2583_set_power_state(chip,
+				       TSL2583_CNTL_PWR_ON | TSL2583_CNTL_ADC_ENBL);
 }
 
 /* Sysfs Interface Functions */
-- 
2.43.0

