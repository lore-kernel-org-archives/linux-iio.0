Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8A375AC6
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779543990; cv=none; b=clsb/tMZx8c6ebk3ieIw2bKhihkg8tIPzEJJhy4WhNV4choBCOPM5fjp1oE9H2LgWWdVY0Tc60zy3HLK8WEb6ZamljkRehpdG6tnaZpprONqnb/EPOSCy7fc8BEL+McWB7vxkPc0vEg0CoVcEsQOrLbwPVg4x/Ic9umEkysnS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779543990; c=relaxed/simple;
	bh=TuoRW0fk8BH8i19fTw4p2gVMYvDPYiQGDUZq51cBrFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bdjdXWutW/s5WCSd7jPJz566Ba/m2q6Snmn0cm1qjaV1uJYNv6Ov7g0j+huzlmKjzAf2bDt467E0vSu6a5N2uYiX1JfrPmInfSwaBP9ReUPGr7cH5dLGvotLIdhqxjzKU36kpmAo0c+B1xF2RITt0sLqN3T97DK9jdMXjdyvU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSnC8s9P; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSnC8s9P"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e935bd6e5so8178511fa.2
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779543983; x=1780148783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpGSKCQuP+N7v0JoSz+WqN0/+2XSxcdCYc55wbyxyw4=;
        b=qSnC8s9PTUWd8vbTdoq+wRbz4TznyrNyOUNsbvPUHqWKUb56uqgXhJfF+3zztJDEgR
         oSE3IEo3N5cpjAFOT0Wnf50F+fhgFDA43DW0mnoq8enNfimx1/kppWRoJ8dIc/uqI4Og
         tJlHTJcjAZos6M+daSEgb3bM/otdy4GQgQSjVo7d8gQREPjg/WpgmF4ov44Sm0PMgh98
         LS0Jj3cvTSF4D2rIoN9otnyQqbiybjIF0dk3PiLbnqtXmwsyC+ODFXuOZa6GYuVi/N8T
         Q0/4DYMX1j4I9W1HPJ2wNBJaVscrKZ2RjgBzhvzD/Hj0bwdQsRTxzDJZAfZI7x0xoGYH
         MbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779543983; x=1780148783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpGSKCQuP+N7v0JoSz+WqN0/+2XSxcdCYc55wbyxyw4=;
        b=e9wS2rac+GQZjXO8k3vt+C6MzPL412dHJ6VpH5G3wnpt+57ImxkWHFS36fwQTV3Etf
         WfSf1dXtthU2/n+YEdc4JGeJGQk8syJ7DaTV8eg0iVNxFMZYO6UZIqPAyYWNgyfvWBT7
         N+2A06W1SOmyVODJlomOoUEAVguTD6B4ZdM9U84Ikyxxc8/x4QyiiPCQXBlTjgmJLk9W
         su4Afkq9K75wikxqRhdMkVrYfpNHJ5PXINGm8Z70AJDHFTkAF0Wv9+8tlB8OLjKyBeeT
         Zs6td4nzNgWg+7mxfaNwBm0AyguQrlXgSlDEkp8kWlC7bDFuQVcFcWnp2mytBM7TFS/4
         0M5Q==
X-Forwarded-Encrypted: i=1; AFNElJ++MfcJOZhagL82texXom8NpY8TgVBzgLqIfnrvhNye/pDZ4YJaFwPhklyjbSEq6D1ROMBAXSq2aIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97RvN1Jn2rCBq5bBFszcQ12NXhCq0z4BMx+q6K59Ps4ZsM+8h
	DrF+qWkJ0C5AU2lwkU0l1ZasWnTKOKqqU3fXg5tUPMV+0SsWpuzydHBY
X-Gm-Gg: Acq92OF8SZlKnshr6/6yEe4A0k3I+WkdNmY2yOvGO1gsEeGQrkAyY9IZtcqF7VER+kx
	kZJxgPoQxUQpr0WtO5txXLL5lg1hj6axU/ldp9WyynDNb+EyG1lU8Yj2fajEUtuq6JOgNRkSR9r
	lUZzyGf3XkikVa1wj2W7Yw9iuTlpslfJUYSCdhvhncn6T1rEp04kgfq4MKaEBqEfYJW6yhsBB36
	+nrZDUOiBF7F8eJ8Sluz/X/aP4DR8mJRkdvR18WeuxWc80PLsj32iWytI/QUUzmEImTmZ906hi1
	iCCnbBfdML448PoIheXgCC0QbtwkXo0xh3Qy92hsiFqbDs5Kz+kUN3bVhU3uRgqNiiPLOsVjxGb
	iAZShA6Z3zRYX/wNApafvjTNT1til7iXp9qLN9EYpTAS97FvmV8a8ES/gpL90uda6UnQKOD8gUx
	Yngvr8lHbnYUDXfaGOw5yKqn/FLwDa+MlvU0NCo/LzDmc+xUdfXmIcxcE0NA==
X-Received: by 2002:a2e:b895:0:b0:38d:ed1a:a135 with SMTP id 38308e7fff4ca-395d8d0a36cmr12185891fa.3.1779543982936;
        Sat, 23 May 2026 06:46:22 -0700 (PDT)
Received: from localhost.localdomain ([213.230.112.147])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc2d61fsm9624941fa.33.2026.05.23.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:46:21 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind
Date: Sat, 23 May 2026 18:46:13 +0500
Message-Id: <20260523134613.4930-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iadc_probe() calls enable_irq_wake() after a successful
devm_request_irq(), but the driver has no remove callback or
matching disable_irq_wake(), so the wake reference count on the
IRQ is leaked on module unload or driver unbind.

Check the IRQ request error first, then register a devm action
that calls disable_irq_wake() so the wake reference is released
in the same scope as the enable. While here, drop the inverted
"if (!ret) ... else return ret" in favour of the standard
"if (ret) return ret;" pattern.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Use (long) instead of (unsigned long) for the int<->void* casts (Jonathan)

v1: https://lore.kernel.org/all/20260520190924.12774-1-sozdayvek@gmail.com/

 drivers/iio/adc/qcom-spmi-iadc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index b64a8a407..88f6be210 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -481,6 +481,11 @@ static const struct iio_chan_spec iadc_channels[] = {
 	},
 };
 
+static void iadc_disable_irq_wake(void *data)
+{
+	disable_irq_wake((long)data);
+}
+
 static int iadc_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -538,9 +543,16 @@ static int iadc_probe(struct platform_device *pdev)
 	if (!iadc->poll_eoc) {
 		ret = devm_request_irq(dev, irq_eoc, iadc_isr, 0,
 					"spmi-iadc", iadc);
-		if (!ret)
-			enable_irq_wake(irq_eoc);
-		else
+		if (ret)
+			return ret;
+
+		ret = enable_irq_wake(irq_eoc);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, iadc_disable_irq_wake,
+					       (void *)(long)irq_eoc);
+		if (ret)
 			return ret;
 	} else {
 		ret = devm_device_init_wakeup(iadc->dev);
-- 
2.43.0

