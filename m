Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C063033FB
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911666; cv=none; b=E5eDTl5p8cnMgHDpts+4REQjB75zmvmEN1SP5f48fiWi3R9FTatGwUKDb+wCO9YsQA76t/MPn6hVvxBb5ACt1rcBZy+RNpFm+meWeXvmab1pJNcZn7DCMCycQrCdL4ICJk7ViwVTtEyzFgr77JLlnAsiriv/ghYBq1KsbeoJTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911666; c=relaxed/simple;
	bh=Gtks24nGS2PEXvE4OeZrCnqjewElZhLxVQVatXzmG30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m7gCqJ3PHdNtb47IM/HhrrpCN1dDJr/CfVJVDqoRKTkYO7tWlFrP4rQYb9fhEb97eZYBTw8eHLlJSOxSzBNI4GAsmCx/pNid0iG+u4f3bPFT6bk77h+dZH3jAzPeNeHo7ilHoyNZSGPYAfXFHXzBUNUccVe02OLFc9wPQLpJJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFkvepFr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFkvepFr"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1525849a12.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783911663; x=1784516463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fy4EZP2uQweLrKR+q7jpU3GAZlA4iI/CrpNIH98Z8vY=;
        b=IFkvepFrZwozQIGJa2Zt4gCjAIaxeFVDOFGm1Z/ssewZ5cXlBgNG9RdhOGY7BTs1Oo
         SLh429lUydwYyi13hAPMq2W3iae9V1TNocTby1rCJ0VN1UwtKfqdUhhA8CRchQy7uuwh
         vTugpIsEhjac/i7H7jWe87Rw0BeRJz9DVpATSBAy+glHaoVKYDU/Wb9diqNM0N3dvj0z
         bgZ1QiCUTcyHKr7v1c/dUjjdn30upp+zC/KvyrZbAnqbdJY5J3eLGTqUTe5a9rjK+K4P
         UlR8BatuNMobz5V9pLo8PQniB5OGOKcPmsVxBorHCHcRew3PEzPk6BRSpgL7Iqy1CaKY
         xMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783911663; x=1784516463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fy4EZP2uQweLrKR+q7jpU3GAZlA4iI/CrpNIH98Z8vY=;
        b=DBJ9gr+PbWQU4KMDni+eW214x9NoVTEKuKOHyS+HBlmyAy8e/yWYs5lxfGgNH/aTkx
         7c6xfHka+h1S/UIWWtqJ9xBOC/xiaWX9GhEeNJ5qmEGQSb/TOhVvS28dtApCMd75+b6e
         MN4F956tWAx75lo/7lGzvt7LJJMyGD4wTasDzfpGuV4B8nZnJ0wEW1dNtCgq1Umynzxy
         o+tHBiBn8CKZg5sgfAqxVnCj3YLdKl0/3fY5JS2JudxdMVKdDHhheLdx14gKxPNat693
         iYtWEApfJsfS921RuXQEFvomEkVXTaoaRCudK+oykZoOuSeE3GlSU4NYRMHomQx4Aqvn
         QvzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvXeKr1zgFUqyOO8sLyFj0HVmOCEY2sw7dLuolBhcz/Xx7zoCuw48SpO6b3DR/CB3MwMe7E8/TFjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uUuiXU8cEA4G8m0fgxEiJMaoiLzGW1LfZxgpeUc8BCjb2lWx
	g6dL1DAy1a99danCLHiT4Lpc6WRDqzCS5bA/svEN4MmtkIPXi0GCE2tS
X-Gm-Gg: AfdE7ckgUCsT+oSUPWaw7ez6Lg5L6Ic7Lk82xgVpRbbnoa7jUff9cvx67tK848oU0ly
	mote7CTSIjPRvkwkPP+aP34oNVmH83JJoJG3TRsqW2pfdjflaa04d/T6vHDcZRurCtGAnZj3vUf
	/EanbZckmBrrGZ0hYMzbrYEJdM8/rnCzNyZEy+267L+EW/KxYljPzs9fjKQwyIgy+Co7lcvafHB
	BTQsm8L7QuLg9N68OEIhIn478rwSEgzYiMUebooBXS90elfacPJWftQ+PdodYS4T4PDXxzxteyR
	H1B3ZCmO3eABK1jq1MnBkksP8sepRzdD+JzVUDRZ3M+22xfgpNK/cIteIMFoOAXwJd3KyVEuAxI
	yVqU/1CaiGLyaDXXE6N3+43IAr/pvv5L9Y07pNBoP2BiVbzZ9MZEuE01YxNZwnWm/fQ1m5JD5mh
	C9zqKi8cmSYOSg+xE7cgdpNOVBeU+psLEqdP/6TCbROewRJcvnJdfQ+0d9OPT4vFZz7SVP
X-Received: by 2002:a05:6a21:d83:b0:3bf:9a30:3a12 with SMTP id adf61e73a8af0-3c110ad2b13mr6859782637.50.1783911663534;
        Sun, 12 Jul 2026 20:01:03 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([2401:4900:ab82:b7db:dc18:7983:dbbe:39aa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm67242637eec.30.2026.07.12.20.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:01:02 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH] iio: chemical: atlas-sensor: fix PM reference leak in buffer postenable
Date: Mon, 13 Jul 2026 03:00:46 +0000
Message-Id: <20260713030046.21143-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atlas_buffer_postenable() acquires a runtime PM reference with
pm_runtime_resume_and_get() but returns the result of
atlas_set_interrupt() directly. If atlas_set_interrupt() fails,
the runtime PM reference is leaked and the device can never
autosuspend.

Add pm_runtime_put_autosuspend() on the error path to balance
the reference.

Fixes: 0e4f336f50de ("iio: chemical: atlas-sensor: Balance runtime pm + pm_runtime_resume_and_get()")
Cc: stable@vger.kernel.org
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/chemical/atlas-sensor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 0e2edcff63f9..b2c1a598b3a5 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -413,7 +413,11 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return atlas_set_interrupt(data, true);
+	ret = atlas_set_interrupt(data, true);
+	if (ret)
+		pm_runtime_put_autosuspend(&data->client->dev);
+
+	return ret;
 }
 
 static int atlas_buffer_predisable(struct iio_dev *indio_dev)
-- 
2.34.1

