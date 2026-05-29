Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196C2E7379
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048617; cv=none; b=YlFnB1WbHx+nC6GJilNZro9EANXFleclPULGQHnFQ/I3sFk97y+saBI9uHZPLwEIP5R1MvXr5KNv83BAnBOmNnkc8S6hwbPxD6XV3wfX/v3s+/tHM0JP7ryW+KyrEqL63+6T3Cb/JoF/HFSPqRgTfhsHKMrkWzcArQRbtd69VlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048617; c=relaxed/simple;
	bh=lV4KFFGp0ypFwMw75cgGF7N44SHe2ZGna2tzsRK8m/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WLReBco9vAuTUC62aDIXz+/dwJvnK6EWmFUALLK+VRk9BEUXymKW5oMLdhFR44f5NatLi/gXi3Me6ZwJSVvuUx/yaiVESQqUUc9gpjyLLMzNeze5ZrafLXqqQpPjfGD8HcfQ8SjQ/9cFUlHtR1T2gyX95r4kO1i02NccDPhZwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvpigIhO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvpigIhO"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a41a9a97d3so1078106e87.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780048613; x=1780653413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLbV5NS/+AUn3jPB1rVufRXT2KFY5tOEq+biHp14VAU=;
        b=CvpigIhOFnv0NnKDQBUvFcL41zpR6zaC68nVP6n0ybWVVxsXgnwEFntUjy9yHsCmTX
         1WGz4dkworxwCT43fmLwiuEYvxtXM/mjZAHgYI20IzJ18NjobkWOOiXTvXZZwVsnrfj4
         JNqsdqSdipSjOMcHPD09uTnHcbJTgg08AmLC/I66B0NlaqNW0H4hsktXIx/H1R7Vc+Od
         CGs3V3NRFNxg0y4fo3lX6v53/PUnN7kBEKaTry53/vqlEK7kz0242EdcmFahzXjqHRKF
         BlQ3THSYmBVNeHW164gsHGsQaYSyTPd+UKY0z/8CfZv48xnPSYF4xJL3zmsX/E8+X49l
         jhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048613; x=1780653413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLbV5NS/+AUn3jPB1rVufRXT2KFY5tOEq+biHp14VAU=;
        b=C6D1YTlDcneRjGpwp2IT6r1t3pR5z+zpiavAIJH2+dlC4mdDnIu050m/yCnBl1xt+3
         G2Sr3UQNMPGZQPumJcFjKBdI8REpwki8i5tAROuvB6OyAZeE4xajHvekpHGXgwgOYOWI
         kT54cQXizIoGr9dRp4tmmXiWxkc77ldS7JoIqq7IVMPQgqUE09Y9nOSL+MEpMMaNjpe/
         4ef0mlY4k95XaQldSw4boJ+ExqCRueCQM7vinNr+5aJRMACrhE7fz997i/MN/Kw5VK4g
         JsZobx+Kwc0IwjfpFEopziLnBjeyx94Fhl5THhVDyvf7IiPaB0Gf2efdGjwg1I0SBxw0
         9kKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gYY7ZnSNkBVb+mCK1HU/KgwqSctpK64M1ngX51yZTCqzRwKq5dhD63moxELYVAMLixMWxPzOiABc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgygN8/mJwtijpGVM7sO4dfWrNV+1feVCnW+Ph+97YRwR8t4y
	ESPF0NdIwI1i1qzG97PFNOwUJQt/M1D/Yrr5N4bsD4sx2yUrSYFzGDa2
X-Gm-Gg: Acq92OGG/5hKWrERkfLyMemDmH/cNN2hC/UMYkYxAqFS4nREayYvjqrwbieedq40ZEN
	cn/+0shWKDwqgy8hfxp24BnmVl817Wb4k8/tar0t/x2bpGBGamHi5fP2Pl+fztIBpAhw+8D0tof
	Ay20LScy4e2CC/6nIFHWsp6vLTFvNqxXy3mHebkJeViC2wMRzLRWhMWYIR5Mb6FCbFOg64H8N5/
	mrrNnTkqZ9KHo1lOV/3fKPMG7NHiTkFnzGTcdYhgTLbjzp5Tun0qwrnaN6LaMLI8MBpXSCd4dbI
	s1A3eJnX+Uz28pBoIC9k29FKF3iymb34MrruyELftCFB0Dz4xVwW5KpM34vGq5M9XCqTR+pGcw9
	3uvyjQXQLG+1d65rnVe+MFDThHGQo8LDESYuTNQfw4llFL7WoBaOocBDFbikRSziATYvAltjHZl
	jRwzWhAngAqM7W2wZXChBsublzi9J3cn0tDIUFygkUgjYPs0LiKKoyqd3q2Dk9SVOoGw==
X-Received: by 2002:a05:6512:3988:b0:5a8:7396:63e3 with SMTP id 2adb3069b0e04-5aa59523751mr278652e87.5.1780048612472;
        Fri, 29 May 2026 02:56:52 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b07214asm178613e87.21.2026.05.29.02.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:56:52 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind
Date: Fri, 29 May 2026 14:56:48 +0500
Message-Id: <20260529095649.2452-1-sozdayvek@gmail.com>
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

Fixes: ce0694841ea6 ("iio: iadc: Qualcomm SPMI PMIC current ADC driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v3:
- Add Fixes tag (Jonathan)

v2: https://lore.kernel.org/all/20260523134613.4930-1-sozdayvek@gmail.com/
v1: https://lore.kernel.org/all/20260520190924.12774-1-sozdayvek@gmail.com/

 drivers/iio/adc/qcom-spmi-iadc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index b64a8a407168..88f6be2108e7 100644
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

