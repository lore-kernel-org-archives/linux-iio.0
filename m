Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84534CFD0
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041455; cv=none; b=THfK3PsuoyYEYdTrv3WgH+ta6gQnBxgB7oGBNPsaGkRffpnSb1MBYBFan2UPq406OiEaJlgVsgCxZqr0b2tA92nUe+OhekTz/paCZgGq35BjEJRNVBeP2ofTCo4SopXdnaw60/ANm8WZpSa9LOmWBOfMja0xO5rbrEGsw5cH0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041455; c=relaxed/simple;
	bh=DkkdoOLUNnsiWTVFEPwYrf3bDQkuvu0J+zPC3NxuEBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p9gkcdyKrHah1B8wUKhD2OK/uocgBiDTmsLuVao7ER4yN3PFra5wF4a8EPDNBm9v/HEzfJHQwwI6zZWxIqdMclioKjPi98QO5V4mXLwS/SOPSjMrGIIi5M8cugy6in7Pdl9gucxZyP1WzKZP+t6DYJbdeuFAoKrGG19iPkKZp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLOXj0Vv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLOXj0Vv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso3342105e9.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779041452; x=1779646252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsVwJO6jf7637HzPKQn0ozxs4bJowjYzN8lCpJYo0b4=;
        b=iLOXj0VvQmdUXSx0e9UMDTMhzSJdxzVgI71hlngZmBVhEKmpiqLDfvmncG1w4/yOKD
         1VvQhA9nbsZuL65cuG+Mk+VT82yRzom3m/XUgLn9dus6YuY8jnSuVbwIg1vAfl/uBnbo
         9uWYMKCUaAZLaWiMdedYxTkV4YACvt3J+pdb7VD9f0ySOArCBBKH5wxbkXBF8VAUeie7
         tKS1/HqODpClSKpeqJL9kRgErGVEBxjPdXAOauwMhAGdXRlpPKM3TJo/S/0/JMPP2JtK
         eFGwBT7UTC4CHcmYK0o2pStxG0U+Cab/25z/x8vXA3d4ZQRTo0+uiJRAUiHVobT/yZqe
         SrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041452; x=1779646252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsVwJO6jf7637HzPKQn0ozxs4bJowjYzN8lCpJYo0b4=;
        b=PLDXw/735XqqRziFfvjrjNnyg8faMJCf5k4GGJtIVo6T+9M0yWik7159PoVLhwOS9q
         jkLvoa4JIUjP3OOUR7/VRfGz9wc6tRYNv4i0iT3gKPeXQXcG/atSUUsOLqx3rXU0OAFE
         qyMV7QFM5eSYhpSyWcuIkS0as8L3BoJ6b0LI5BdZJpQpZLAR294dw0X//lrA/76hcZMu
         FdKvC4+yaY2QmGk7H7CiNLDPCPvBdwoPezTztDfhCPO0jGApGP6YjGpeQBLyz6Nqp1wQ
         So3bHfQqoG02u/EoGwlupYnouUiWJ6w5wKh31HdFo+/gIrTKgZnrGLrK8QF9q2bu7zIh
         axUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wZ4p44YQ1dQyiQn59J7Co3onAqYw20FhitACoMDwfvx/xNAXe1pdaLijmRUDkYflZ13nIuVBupgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrcab+J3VqCKXjS88IKddnmEo3mPwRAHXcldDEY6/yr1ReD49
	xsL3RndvelIApMvkcX568j8zdJUH/Df3/8d09qddfwyZTPVzqdn+gVzd
X-Gm-Gg: Acq92OEeHEElO6KFbBSHdb8rpHGIOA3IHX/VVr6V6UVVY18rQLoXcEFWWjUu0ETGBFL
	EPrX/4DYkfik14HXAoFWY47k4cKxYlDYICCQ0ARNIZG8MPu3XI7eTUgSF51OrhnBd3s7eVkVpor
	s5msmtDXMqHiwSVCMdXIikofRmMOGhC0ES7Jn7tPGK86Qsc/cnIX9Yj6byrJsxBDqK5Y0a1L5Dk
	m0wNnd1zEun3GtuBmvZajslYFFuWfImptO3CshXbgYL+sp3f64xGzoZ7kgey7tZfXs/EHzZItZo
	ZmZ+kRsSAjLQwA8mIc9qbxWlUqNGieTnwNyuKlJzsu5ONnZuXwMckRlqMZaefZ5HN9Ll28dWQ7l
	WPKAgfx0z2hYGsLy2QZ8PlntwLhnFd5RxBc0PrDRmuhmhmzkX/CloBjK5ADu09IVxT7fm1e8P6d
	18++MShsqXrzLbPMl2RLFaVfunS4Z4dZvxMjSpq1HWFq8HPLm9X36OnEQ=
X-Received: by 2002:a05:6000:1ac7:b0:450:4980:b4fe with SMTP id ffacd0b85a97d-45e5c57d063mr8988312f8f.2.1779041452398;
        Sun, 17 May 2026 11:10:52 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm28958322f8f.15.2026.05.17.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:10:51 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: light: tsl2591: return actual error from probe IRQ failure
Date: Sun, 17 May 2026 23:10:42 +0500
Message-Id: <20260517181042.668-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devm_request_threaded_irq() fails, probe calls dev_err_probe()
but then returns -EINVAL, dropping the real error code and breaking
the deferred-probe flow that dev_err_probe() handles for -EPROBE_DEFER.

Return the value from dev_err_probe() instead.

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/light/tsl2591.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index c5557867e..4b0a2a302 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1137,10 +1137,8 @@ static int tsl2591_probe(struct i2c_client *client)
 						NULL, tsl2591_event_handler,
 						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 						"tsl2591_irq", indio_dev);
-		if (ret) {
-			dev_err_probe(&client->dev, ret, "IRQ request error\n");
-			return -EINVAL;
-		}
+		if (ret)
+			return dev_err_probe(&client->dev, ret, "IRQ request error\n");
 		indio_dev->info = &tsl2591_info;
 	} else {
 		indio_dev->info = &tsl2591_info_no_irq;
-- 
2.43.0

