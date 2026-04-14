Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E493E5EFB
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170250; cv=none; b=sATRbOl1M0v3RFi1hbedtL4R9nm260ffMweBzAlqJVKOGsprsK9g5fMf1ZYsADDHjbsyKH33VjLMBESUWt27Piae2S7D0DBknZ50VIkVLkZjkwtusshlYjBlFXMrdHCVodEj9hNQFeqgiEfRGPHWUI/qBYqO60IgOjN6H+y68CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170250; c=relaxed/simple;
	bh=2Ux/T8LM6J0221QP4M+5TenCC8Wr2pPxLS/nADcmqcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElrgHXWPiCpsIZsOGGVrgIArLpdnJMajOQbD4Ul+xODcL7THdjmEH8UyYJyPoaHd9l7A4Zbf/Oy7AjPOyjQxySxpAUyyClXpQ/2uhofUCLTP1r40zQ16DuGdQZLsH5ZPArlJwG3FblnGdd9DfhATx5nRMbOEs7jbvw7EwNSdFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0Co58O9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0Co58O9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488c2690057so54734235e9.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170246; x=1776775046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G71d+Fry0HfOtBb76vvpELUb+ZDGU97NTzjiP00wwrE=;
        b=r0Co58O9l3iyxLYoMFf/w5Mb13ttcNMr9ZFZcy4NevdfZ0e1ieIjFL34+jUupxjhS8
         lr37GervQCWt57RDGUyEuYI5+z7nkCxKzGAtlBk/l7VkKoeLcaAOPFiarDLONL1CMGoF
         eU9Ze0ih50kfSprmzYRWzE8wq94X41LYK9/sg1Z7PqwzayGHgIelRNaXx1OGknrP8q5X
         Ai4YhW0kWWSg1yhAcScipPV6AlCMggeobxkn0PohvqP+qD4mk1fzaQuo6sF+dxKXvSiM
         VoSVhJ3j/3I7SHkra9VzUvohRqbtZEp3njj3cK1hWyKFFU9RYvqCvyehjMNFfevMAwys
         onXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170246; x=1776775046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G71d+Fry0HfOtBb76vvpELUb+ZDGU97NTzjiP00wwrE=;
        b=OVi46BDP8296FIUobz1svXOqgoRe6jViRT5XurYXwBMpnSxRdQObsGHY5kgQ4nGC0P
         N1c90U1SHHBrlfmoKb9CF1k/0OZWoO2r2PoHCgtlL46iOECshT/A6laTqifSGcEdbHN8
         przHv29Rj++opbu6GSdhya8L37Me8wXWaJJ3zrbwQ4W/Rh8YR1Zzz19uDuiuwxLCN/pp
         oi97xfCaXAYjfLpy0UWH9WHY1IzyJNEGlhSYTaUvyqk8phMP1KTuRAtRR7y/1cZwSR5D
         gUMjQrWR8HGmo1q3I2516+xBOitynqK7rCpjKekpqwA66y26PUXeysjrlz9yHW5Opha/
         ISKw==
X-Gm-Message-State: AOJu0Yy8gsvuEtBurqhB8fQq12a0byMSmPWvkRSJEwCXc6f92Yi5cPiJ
	FK4fQA36Qk4KX4NPLFDrrfR/4zKI9D8mCviz56p1hXR34zzesDLnu+f85web4w==
X-Gm-Gg: AeBDieso2CnVkTGo8u9V9du378a/nup2OXbQorrWZ1qnAZnU/+PjpHpH9UoSglsTSbz
	FrioZmLyBeZdnXLnGvunU0jzrCVPlewjEbn/ri/75UBtM2QhblhH53Xfcetdw6Y5rHik0HpbNxZ
	rgW+E3jlM4NbakrAtMTeEC+jpPkM41/eQoHSQjURDv3YTuBQvYE90v1MJUCvnTw6UXZtAommWWY
	48CzWETikAkF3ZZc9AFGVYq+00Euu8jFgWqAI9IIu8XGdsd6aaY6H7ckHTHaKmR+ng2mtzEfC6r
	EjGt8v4sU+sduWIsgKNy64Asf+NRDUy29VuDy3AjMxGnUyEEoizcwsU4j3Ep98a9SYpHpkbsUlk
	8Sp/Va9gVatfct/FyLbRwipQTEEzvin7xvAH6n9YiiBnE1C56hrydRKkPW+GOeVIQTMeRjoQSJ+
	Z0gWlCcHd5R5DPivti8Vo4qSLyHka3ag==
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr220038895e9.24.1776170245564;
        Tue, 14 Apr 2026 05:37:25 -0700 (PDT)
Received: from [192.168.8.79] ([2a00:f502:260:5bd3:9217:8960:5f33:aaab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm41552729f8f.24.2026.04.14.05.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:37:25 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 14 Apr 2026 15:37:20 +0300
Subject: [PATCH v4 4/6] iio: light: vcnl4000: move power state function
 into device-managed action
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-vcnl4000-drop-enum-v4-4-59fde2932a0f@gmail.com>
References: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
In-Reply-To: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.2

Move power state setting into a device-managed action to get rid of
fail_poweroff goto label and remove it from vcnl4000_remove() function.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 52f60b372d2f..1e636e6f51da 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1970,6 +1970,18 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 	return devm_iio_trigger_register(&client->dev, trigger);
 }
 
+static void vcnl4000_cleanup(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct vcnl4000_data *chip = iio_priv(indio_dev);
+	struct device *dev = &chip->client->dev;
+	int ret;
+
+	ret = chip->chip_spec->set_power_state(chip, false);
+	if (ret)
+		dev_warn(dev, "Failed to power down (%pe)", ERR_PTR(ret));
+}
+
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const char * const regulator_names[] = { "vdd", "vio", "vled" };
@@ -2004,6 +2016,10 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, vcnl4000_cleanup, indio_dev);
+	if (ret)
+		return ret;
+
 	dev_dbg(dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
@@ -2041,19 +2057,20 @@ static int vcnl4000_probe(struct i2c_client *client)
 
 	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
-		goto fail_poweroff;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto fail_poweroff;
+		goto fail_register;
 
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
 	return 0;
-fail_poweroff:
-	data->chip_spec->set_power_state(data, false);
+
+fail_register:
+	pm_runtime_set_suspended(dev);
 	return ret;
 }
 
@@ -2073,18 +2090,11 @@ MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
 static void vcnl4000_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret;
 
 	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
 	pm_runtime_set_suspended(&client->dev);
-
-	ret = data->chip_spec->set_power_state(data, false);
-	if (ret)
-		dev_warn(&client->dev, "Failed to power down (%pe)\n",
-			 ERR_PTR(ret));
 }
 
 static int vcnl4000_runtime_suspend(struct device *dev)

-- 
2.53.0

