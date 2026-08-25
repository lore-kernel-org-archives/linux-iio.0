Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CF388394
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678570; cv=none; b=P5G1bw0fPqBH2HmdrTtfRGuWTjSjvUUDXDxYiiPqfVHtfQ6ZsDEfKS/9ayWj6mgqGfvPlQKlcBqHyJOjZ1V18xc1tQNUbri+0mGSW9dxiqdyOqIC6Nkvk1wQ7C2lfSFR7lxLk3wdNDrOldSwVN1iHpUQ8ATyHisN4A/b+eXA3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678570; c=relaxed/simple;
	bh=I1XI9+nkPCrX73hyNcHT1tU5DDgec70XDsg+P0Gkh98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFoxiwsEnF0wsIH4lysj0f/zzrqgvJBTwZtcGUo7L00ksrcmFy6IW+uVGQoxmc4eOS9gfxMX+/9CaOwsPSu5iTLQK16CfjexbeFklubrHMnjz+vOZbnQhTy2kmW1UXNXbulPb/nSWfiUmleb3ctKGqclw5Hq1z+smIY+7f7IB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3NbKs7O; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3NbKs7O"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso111740a91.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678568; x=1788283368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGjwYaAGAPpb5UsGnRRTSugqMWHugUl+MPT7Fj23bh0=;
        b=W3NbKs7OWUGx2MTpGxwkyvJyN0wZ8x8vp9GPcUSe9JlZprO31RThzD94hnfytZx193
         7OX0u0wL6giUboCSGc4PNgVMuqSwSkedTu1DRvTXv4Ru7mSZsVtzeF/aScN1kjw7cgwu
         HtnJCmG9sFRSec984qqqoyk3+g1TE5wN8ioQv+Ni6lV+D5UjwHdvYDuvtH2UurCkqYlH
         vk9I2S9KiQ8aV1GBsmP9t3WOMOW0n/1ndX+1SmFDPW31LlzrlVA+IMnaHrTxSvCE8nDL
         CO6it5llV/zk1wFuhjenGz0wlIcb7nQLJoLhXSLlbxSgwX2FKM1FI6QINtubFnhJBFAx
         MQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678568; x=1788283368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kGjwYaAGAPpb5UsGnRRTSugqMWHugUl+MPT7Fj23bh0=;
        b=FH6BkQFtPwsOW1c/jEFm4AqCGTyI+2UBC43x5/cddd3R6bqQmHJNHDWQMV6OX3qUFR
         vjynQM5QWlro5XR68I3t7PEcb78ILJesrzsmFNysSmnVTFBpQYjQXFkSqK/F3iCfWw6F
         021nNj9gGVcMUgq4ae/AoX0HZwlE9Y4sdMl7kV2WIcoC9cpjEKjQAjhfXuCKuUTNpcDj
         56nDqeJ8Pfx46t7V4Az63qpPFIbMOgwwDDNDRjJpX2kIt1U/TkS1Cx2XXEU4dndHgToF
         Q/qDg1G2Y/adFT+jhAtS+eHdHYQYrH91Jqy0J5HH40GONTTe5cXYX2NDE+kWyhVoOD0E
         hSKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn45hspPdvucNr99g9QwHb2lPnAcqajgXUftmiErEw0eGGqWEIDU7ssSEtcrlA9asOOffTZm+FtFA=@vger.kernel.org
X-Gm-Message-State: AFuF++nRBZS6jHfzNMDXEOvOXx2HV7SwVT4PJTkoME48iaPiXZ0aEn/l
	U3HE7qUHwrZqHkcJ3VNcMksSVpEAXmalweJ+p/adsAbswGCEL0e2IhhX
X-Gm-Gg: AR+sD10tL9/zhJbQQJhhxv4oRJxelX6tAzxLfes+0WB8CFZpptglPXcMPz+OA/Jj0S7
	5KOH6jPh4UDagNTm4RWEe4ZDjbKf/EgFweqjBpHiwl+cTG0Sib2qTO3e3IsiL1WFYYxbfSeeXnI
	n9ZIl5ltYkmtW7+PVcV8rhvtX2SlU8IvitKkDIbcA5sbUZdq3NtAM9VAMh3GTJVU8xTT919/Tmg
	0AsNfLe0NQ5ap2kqg4YtkPCEryV8jEv40/52ujQKBizSamSiUS5GnCIXQOWYEoiY1QbDyAzhDEt
	+4V1byC/xCfCdgha04O/Cpwccr5pbFkKe2WUEOscmtyRWGv0vK+iWKF7vzHmMW0OA+uQcyVMHct
	MgzGGA0A7U2VA7nexh5xBrEgWxZ2QxoDOwagLNHbN3tHz0FFNNVlG5tPULrc1v39lMCTwHEaIrt
	+eF5TpXDxsyMVDPArxKhUf5aA3G/FBHzLhLyWP6mNnzniUuWzbG9AamY3jgFM=
X-Received: by 2002:a17:90b:3b52:b0:396:602a:5bb6 with SMTP id 98e67ed59e1d1-3966d20f12cmr1147836a91.8.1787678568310;
        Tue, 25 Aug 2026 10:22:48 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:7ed1:605d:3bd6:fefb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm327637eec.23.2026.08.25.10.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:22:47 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v1 2/3] iio: adc: bcm_iproc_adc: use devm_add_action_or_reset()
Date: Tue, 25 Aug 2026 22:51:54 +0530
Message-ID: <20260825172155.250484-3-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825172155.250484-1-mdshahid03@gmail.com>
References: <20260825172155.250484-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Replace the manual ADC and clock cleanup in probe error paths
and remove() with devm_add_action_or_reset().

Register cleanup actions immediately after enabling the clock and
ADC so that the resources are automatically released on probe
failure and device removal.

This also allows the cleanup labels to be removed and the
iio_device_register() failure path to return directly.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 39 +++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index e46e3761993a..1464c60bc83e 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -448,6 +448,20 @@ static void iproc_adc_disable(struct iio_dev *indio_dev)
 	}
 }
 
+static void iproc_adc_disable_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	iproc_adc_disable(indio_dev);
+}
+
+static void iproc_adc_clk_disable(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static int iproc_adc_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val,
@@ -551,9 +565,17 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable clock\n");
 
+	ret = devm_add_action_or_reset(dev, iproc_adc_clk_disable, adc_priv->adc_clk);
+	if (ret)
+		return ret;
+
 	ret = iproc_adc_enable(indio_dev);
 	if (ret)
-		goto err_adc_enable;
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, iproc_adc_disable_action, indio_dev);
+	if (ret)
+		return ret;
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
@@ -562,29 +584,18 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
 
 	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
-		goto err_clk;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "iio_device_register failed\n");
 
 	return 0;
 
-err_clk:
-	iproc_adc_disable(indio_dev);
-err_adc_enable:
-	clk_disable_unprepare(adc_priv->adc_clk);
-
-	return ret;
 }
 
 static void iproc_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iproc_adc_disable(indio_dev);
-	clk_disable_unprepare(adc_priv->adc_clk);
 }
 
 static const struct of_device_id iproc_adc_of_match[] = {
-- 
2.43.0

