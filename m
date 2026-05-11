Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035063BFE33
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507275; cv=none; b=oUBGajQNUxM8/0gBnXD8Ef2paeMlCONMKuISIHNBn2JH5rk2PlRCvYXG/HbklyU0jjqPJIxBwycC6JT5DlLiRsMYKIzJmkvtuvLoprizIlLAIluIaL5SeISE434OKgGBMa61k8uhS053tA4tT/knozgOcQZUHbNAU9B1fZsSbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507275; c=relaxed/simple;
	bh=CS5x8EpFp2CtpMCiVD/KZqSgU/6EECdWvXaBh6rwM6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZ7vlR/B9DWtdmpv2+qzo8ZCN+b8Ky4cMPFtwN7+pfOjzbAzCHNi/An8nvCiuvImN4YF76a/0BDKzqyl6+FcSQiC8r9kwpkVz0rx/Wiwlv3HX+mrAV+4Uv5UmoJZpr/GcqewPvb1pnZ/nYvtIyc5iqo37fnaXgQxmoBhM7pspfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4UJinKo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4UJinKo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe5574cb9so381820f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507272; x=1779112072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmVKXsYAXw1O3P9YRscVU8mdGa2IVPiD09nUeSylndE=;
        b=M4UJinKoHx6yallVn3HzGGDcpnIKvJ4W6ezQrx0HyyBCjhwYMaRTm944+mz0kWfajj
         Of23/AJpDMlNJgghd5NomEWOdDyGpAFD+RHfoxwZfEeMVI88z0kEHbKbLH8bbKwiN+wo
         LqvqL2H7W7XaROD6FNy89YP3H0fOaPJbGnkNaoE+Fhy2UESWyJtV5ef8ZsNXsRs9WyC+
         wAZh8vEbOeAbaBsINf1r9mziL1B8KoeVqbncacx1nWdVrPvhtpCQVwCN6iHhHJAHjK/m
         CIp7hrT9YZYk4dTNYE7tBR415lVym8L66VaveG2MWxHh1H9kxzVuFhNnx72hk7IFai0U
         +UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507272; x=1779112072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmVKXsYAXw1O3P9YRscVU8mdGa2IVPiD09nUeSylndE=;
        b=oCp8EjlE1f+qMPAXlCBbduc0Sjfb4GwkCndr7CpYaddrl1wEnjMCeOngidaOGXjqOW
         QDLWg+3vnVDdGzcrNos6SfS/TsBQUB7I6pDDeRTQ4eTbiBj/LvKOr/DB0EKf0NcLWznU
         xQipTRPcg5S3/Mvkpjwlnl8EITiywy/BZKg6TLkU/22s435leD8g7/3Uko88PFdQ5ZMp
         /D88pmyNYbwXmM8paJt7WipH4kg6QHbTTKl1mozlH43MhNPz0KmtQGpkO2gMVv/ba29r
         g48hpYg3UhwnYSINUK+mG9AgWwAOU+yr9bVWSL93ER3JqhD96H9QDKgS4SiEHaMDnvpb
         IUXA==
X-Forwarded-Encrypted: i=1; AFNElJ+HiaUYM9B0F0fVda6WjLOeiO/J5tvCsdaTltEfSL3I4GQPKBaJ8PUyPmAs4nNVsbaKlj+lXxfXyUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0on7jBq3hBodh6KYeuD9uerJppsgkS4Z7ZYqTXq+uWxQyO35
	ybk9zc6VYPmtOsD6VxMRjGRHT5DMY3hKRIkP0pFW/H5HuMnfuYbruvAT
X-Gm-Gg: Acq92OF5m2ZaJx6JtarVCvYXEinr36+mG8k8EJ1QrGEeC6wWCZj39qWez+Mifg2TXk3
	1q5iTEltSGMqomRrE5BZ0aCMa+wjb+TJLbMhbj9AKspGCVGOhfJedlGf1jEetwQlJNv/Ck6rCtB
	Z8Ms59moxLuptJsHWdU2HPNVwD14hmFPnxviEaZ4kQLIPtt26YW2RDy6zE+Rqj41NQ/qaDnARaI
	is626351zsCjWpmjzBowV+dEfEFHj6suA4PLM1aXwCHc0dJOpF1uhsfWV9Gv9KxjUNkXyBco9mm
	RASwBEuXyvDfkbnj6eisGDPgtqV7Vjs3jESqFmgYUwD39VEgHYGKp6ATKoOO7kQ75OjS7uolFhB
	72YhjdiLL0AIEAAXT+9cKpdTRVSj7DyiPblVJjKn3BCufT47r33JnoSrxXY3Vq8hLIR1hDb0G74
	LeFwsgskw8LsHgkoLJUlEEQmObSWnZQ1vzrdePWdBCK+m3xdGWfDGABqk=
X-Received: by 2002:a05:6000:4401:b0:446:9d8:bb6d with SMTP id ffacd0b85a97d-4515a6c2a22mr12848251f8f.2.1778507272370;
        Mon, 11 May 2026 06:47:52 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm26196662f8f.26.2026.05.11.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:47:51 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: trigger: iio-trig-interrupt: use devm_* helpers
Date: Mon, 11 May 2026 11:32:29 +0500
Message-Id: <20260511063229.1433-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260511060732.7728-1-sozdayvek@gmail.com>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to devm_iio_trigger_alloc(), devm_request_irq() and
devm_iio_trigger_register(). The driver-managed lifecycle removes
the manual error-cleanup ladder in probe and the entire .remove()
callback.

Drop the now-unused iio_interrupt_trigger_info structure: its
only purpose was to hold the IRQ number for the manual free_irq()
call in .remove(), which is no longer needed. The matching
linux/slab.h include is also dropped.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Drop the dev_err() call after devm_request_irq(); really_probe()
  in the driver core already logs probe failures, so the message
  would be duplicate (per Andy)
- Use a local struct device *dev = &pdev->dev (per Joshua)
- Drop the "No functional change" claim from the commit message;
  the resource lifecycle model changes (per Joshua)
- Use .remove() function notation in the commit message (per Andy)

 drivers/iio/trigger/iio-trig-interrupt.c | 64 ++++--------------------
 1 file changed, 9 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index a100c2e3a..ddd80ff82 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -9,16 +9,11 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 
 
-struct iio_interrupt_trigger_info {
-	unsigned int irq;
-};
-
 static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
 {
 	iio_trigger_poll(private);
@@ -27,11 +22,11 @@ static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
 
 static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 {
-	struct iio_interrupt_trigger_info *trig_info;
+	struct device *dev = &pdev->dev;
 	struct iio_trigger *trig;
 	unsigned long irqflags;
 	struct resource *irq_res;
-	int irq, ret = 0;
+	int irq, ret;
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
@@ -42,61 +37,20 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 
 	irq = irq_res->start;
 
-	trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
-	if (!trig) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	trig_info = kzalloc_obj(*trig_info);
-	if (!trig_info) {
-		ret = -ENOMEM;
-		goto error_free_trigger;
-	}
-	iio_trigger_set_drvdata(trig, trig_info);
-	trig_info->irq = irq;
-	ret = request_irq(irq, iio_interrupt_trigger_poll,
-			  irqflags, trig->name, trig);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"request IRQ-%d failed", irq);
-		goto error_free_trig_info;
-	}
+	trig = devm_iio_trigger_alloc(dev, "irqtrig%d", irq);
+	if (!trig)
+		return -ENOMEM;
 
-	ret = iio_trigger_register(trig);
+	ret = devm_request_irq(dev, irq, iio_interrupt_trigger_poll,
+			       irqflags, trig->name, trig);
 	if (ret)
-		goto error_release_irq;
-	platform_set_drvdata(pdev, trig);
-
-	return 0;
-
-/* First clean up the partly allocated trigger */
-error_release_irq:
-	free_irq(irq, trig);
-error_free_trig_info:
-	kfree(trig_info);
-error_free_trigger:
-	iio_trigger_free(trig);
-error_ret:
-	return ret;
-}
-
-static void iio_interrupt_trigger_remove(struct platform_device *pdev)
-{
-	struct iio_trigger *trig;
-	struct iio_interrupt_trigger_info *trig_info;
+		return ret;
 
-	trig = platform_get_drvdata(pdev);
-	trig_info = iio_trigger_get_drvdata(trig);
-	iio_trigger_unregister(trig);
-	free_irq(trig_info->irq, trig);
-	kfree(trig_info);
-	iio_trigger_free(trig);
+	return devm_iio_trigger_register(dev, trig);
 }
 
 static struct platform_driver iio_interrupt_trigger_driver = {
 	.probe = iio_interrupt_trigger_probe,
-	.remove = iio_interrupt_trigger_remove,
 	.driver = {
 		.name = "iio_interrupt_trigger",
 	},
-- 
2.43.0

