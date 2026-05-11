Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AA29C328
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505778; cv=none; b=CtuCTrbyPOIVIh1QMCSZo3ZiJFrhNVjw/twVUTpg7zYxITsO9C2VLsBR/sHAIkj2IuslnPY5ACj5tuLh5tphtO+vdJYkmdEmLrrvbs5eC/lQWXxZBm0NvzBmFCAaMS3r/q/VU8Zwu345w0+dhuCmjdxKNr9EZqp0CXGL1InCZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505778; c=relaxed/simple;
	bh=7bj9Shz27ymdJxvAShbWN6eBUNTlvQqeCYKehlMyfc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QT/qiAP05UwM8aAvl6kUH1yZzUkg1v1QGyq6ls7vvZYbaJWOrx5LtAG0JN52mnqVZ2SqosahiGfx1WmPmrb1S+B6g0xKWfN0cmVQo+/vilJx70U5A8x1F7JZr1eDSFOJ26RYbJpuI4ilnha97rd4TLHVkvVNsCY12GDwa58CEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTfnxnrg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTfnxnrg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so4171255e9.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778505774; x=1779110574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SB1bzvAZ6Njmh1JX3tJzouTVDFsiOD3VPRvbyVuZzcA=;
        b=UTfnxnrgmlv5/vfG/vj9Av0IV1aHrdfEgTH6KeFlE9kujZPsL+U5QfmaD6p7ESVEhJ
         wYifQ/T5u7ZgRFkRmLPSpUy1rcjSyq1CYGoS5QHZ4zDAMPMkmcWYQ9esHgzQOg7wMU6Z
         rzSt1SNJxkWe6ZX70jf3Nka3issPf5276drWHp6g5v7i3/cQ6h7Fhe38mrghRac3IHsk
         dFcopk/VulIvmgT8JOSkF69+pkIS1AEaG6WHWDmqA7OyB78DHqWkpL/Mfp9nspnA7NMz
         Pc+H1UnRPmHhjjDEKDbkVENYdi6rzh+szwkQ2F2Eh+EWzg+6UaOo7baAgB5orciWCFRv
         i1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505774; x=1779110574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB1bzvAZ6Njmh1JX3tJzouTVDFsiOD3VPRvbyVuZzcA=;
        b=PzdAjRpjH+Oq4ELiSztj0dvHAvqTURvn7rc0TlChnA4hpBG2m9LyrSnT9toNCB3KG1
         JHurS/pyLNlqPO5klHmTacpgLXXeh55CzL2ffTEtHwwjQENdS+8yxOMwsUNLTeYZD1DS
         EePnjWY9D64Bje/arE5ks1YxKRUZe+67yZvQzYl8i/lDcfWddtyWwE7LACXUf1HWfGdS
         J9tuWq/DAM5GQQ6VmIxEv75NTEGBusQLazCb2SfTR/BNEjR49uDSiLviADgN0EJvsrfD
         oSfml+CESgvH7ALyf+cNOePAgp+6Larna8OxaPTVqNSS2pMo6Mmnodt8jmZN20quF0YJ
         tjaw==
X-Forwarded-Encrypted: i=1; AFNElJ+Wmqw+HU5z5vzETlPV2+KpPhB9RS4RacHajunV1Q7ksTgxNhvLNeQalD5m46HfbZFr5+HjN/hB44U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7kktRcGYPzSs12SQJ7sjylrsq9l5etRtncyQiMWm3Y7SIc/U
	tFal9IwaTVGvEkqYz5yuJiKnzKWVKYo8gDI9WMjMPh0ZnF9UfSjufFCq
X-Gm-Gg: Acq92OHEm38BrmQ+v9Mw2AQz1K5pztAQTEkIQxGcW6Fug4721G0tSO5pr1P7AU2redp
	uo7oQcp1NiQ05A4hisrTSCjEftJ1/r3YEl/jl999pZ0uG32kHyZMj5LbW/dcdO/bMkD9jiN1mxV
	lUo7hr6fO1E6IyiMAjtK+kjCEETvXC3pH7GOEeJiL8O9lZZoc+yIfozPuJGkVyE7mtzBl4wLo2q
	fr7BoKFpxFTOK5v99eCdmY2xP11pj82aKiboQpZzQ2RaYdTstKNKwIGbcyWAefnTZu2w57tm6yZ
	9tHD0n4d/qM1NWRWyEd5J1TZcAT6tDvKVBwJ2SCnxmjdnezIdKyv5llcDUqCdC/R9hF2ho5UETU
	UlbVwR9wKkvteulyL0Ro2SUXrODyb+Qz52ismWQi9qYVXoYAn7DQ2INZwWDVHrYHp27H4+tL/AK
	yaQ+9olpxzImpuddrEckQEPWP7jvF+6OxPCvQzpUOEEGag
X-Received: by 2002:a05:600c:478a:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-48e6db57727mr51981645e9.2.1778505774315;
        Mon, 11 May 2026 06:22:54 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4f0dsm64359625e9.11.2026.05.11.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:22:53 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Date: Mon, 11 May 2026 11:07:32 +0500
Message-Id: <20260511060732.7728-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to devm_iio_trigger_alloc(), devm_request_irq() and
devm_iio_trigger_register(). The driver-managed lifecycle removes
the manual error-cleanup ladder in probe and the entire .remove
callback.

Drop the now-unused iio_interrupt_trigger_info structure: its
only purpose was to hold the IRQ number for the manual free_irq()
call in .remove, which is no longer needed. The matching
linux/slab.h include is also dropped.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/trigger/iio-trig-interrupt.c | 63 ++++--------------------
 1 file changed, 9 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index a100c2e3a..e7db61fed 100644
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
@@ -27,11 +22,10 @@ static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
 
 static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 {
-	struct iio_interrupt_trigger_info *trig_info;
 	struct iio_trigger *trig;
 	unsigned long irqflags;
 	struct resource *irq_res;
-	int irq, ret = 0;
+	int irq, ret;
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
@@ -42,61 +36,22 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 
 	irq = irq_res->start;
 
-	trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
-	if (!trig) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	trig = devm_iio_trigger_alloc(&pdev->dev, "irqtrig%d", irq);
+	if (!trig)
+		return -ENOMEM;
 
-	trig_info = kzalloc_obj(*trig_info);
-	if (!trig_info) {
-		ret = -ENOMEM;
-		goto error_free_trigger;
-	}
-	iio_trigger_set_drvdata(trig, trig_info);
-	trig_info->irq = irq;
-	ret = request_irq(irq, iio_interrupt_trigger_poll,
-			  irqflags, trig->name, trig);
+	ret = devm_request_irq(&pdev->dev, irq, iio_interrupt_trigger_poll,
+			       irqflags, trig->name, trig);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"request IRQ-%d failed", irq);
-		goto error_free_trig_info;
+		dev_err(&pdev->dev, "request IRQ-%d failed", irq);
+		return ret;
 	}
 
-	ret = iio_trigger_register(trig);
-	if (ret)
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
-
-	trig = platform_get_drvdata(pdev);
-	trig_info = iio_trigger_get_drvdata(trig);
-	iio_trigger_unregister(trig);
-	free_irq(trig_info->irq, trig);
-	kfree(trig_info);
-	iio_trigger_free(trig);
+	return devm_iio_trigger_register(&pdev->dev, trig);
 }
 
 static struct platform_driver iio_interrupt_trigger_driver = {
 	.probe = iio_interrupt_trigger_probe,
-	.remove = iio_interrupt_trigger_remove,
 	.driver = {
 		.name = "iio_interrupt_trigger",
 	},
-- 
2.43.0

