Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E062DD5F6
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405343; cv=none; b=XVVJfYT0vpEjz8wxOpy7uI0Ik1s6nhrR/MQwY+R22wtSVJ21gwTeBQ0Bu2RDXHgZ7Ble+1zhV1lpQURJgdT/RpApglqidBosjbPyiLanWtl9EngGiXabI1Q0nmBNVY3drM1btzfMQJmObZQY4kVXf3Ipemo7o4C83ymKOBo/Yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405343; c=relaxed/simple;
	bh=W4Dkv/cxqcbtSFxMXht3/xCgABkjPmCgOyi5wTUTfxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fi66b5dZFyc8SXo0JVnQHJwkfMPRw0oMcFaQTWRn/li12Bdg7g7fNil+zLuvHjjFkJZyQsN50/ftfBB/3Zmv0mNz6/cYKHhC3tdnio3HoBjFuAiImxlrmZcpE0yMU9oAGh13nkNmHB8Za3tSCrh9b1hZBZ5ZIDVUSQ/GdsovJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWHhEfzF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWHhEfzF"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso5908006a12.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405338; x=1776010138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gaxsiUdPDi9gewdcKx5if8b3gQMUYuTELRJfI5bMzA=;
        b=oWHhEfzFgygWR+XTfeEevXh+U7ryPNjZ4PLfUVPU6aP1lHlERNSqS7kIDDudeGqvAd
         +8U+MYeRM3qXi3P3FtdplEbH44SfAt0+XRrEVxcRzf8c2NyCjME89XnSrxACIapLMVaM
         sueS/dAeuZAtO56R/URq/NdUI/+j+sGyQuri1WXYFsaD4Wq3A+LSZmc22DFs95ejQVhV
         pRRzMGPVw9AGQJpMmsxLya+LnDZJ54IFI+bumY/Jb0OHnbTHMG/QuqQB3nBMOHip8Q6H
         QgcDI9kVVWFe/63TOoC/gKzuxPjtLT3/dcmx4MQjgWbd9AYlyxY07LCIc2UMkOPWL10E
         389g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405338; x=1776010138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+gaxsiUdPDi9gewdcKx5if8b3gQMUYuTELRJfI5bMzA=;
        b=FK3lT4D1s/X1+grKFahn9LBLERFK7F0C+XUJmhnIo/5tSXASFkLi1tdA1H6HlBTSPP
         AAUDzUZJhvgIwPWbZ0W50bJNOGjclHZ+yH605RW2/3mwbrl97qc13Lho12wYX3pQ7q6F
         /PfAKFPdR3jSA7X0WXWB8vMdGkL1YzKA7KiYWRJkdTDGUWDzHy7ZVgUZDGXQtpwG28gx
         CiFKrgJyBN4swoHvk5l7SMBk+IMxzPbXMJILj+McNCjzxmIVjPxa6jcKwARWwi6tI/yH
         gW8cuIrhyvyNFU9nIfYYX9SY/erzQ/dlXDBXqOqxH1KWLpGEWPEQLOYxFMUjI93ltyMX
         xOrw==
X-Gm-Message-State: AOJu0YyAGp7gM1KAF6KTwR+PcVlNo7Pjd85COpn/oxOqUbcDmBkF+o0/
	vd8FpUSKTROoxsoCu+jdiAkv06Z61oOXqIBC6R5tBjKhxBRhNrZ+ailysz56YZhf
X-Gm-Gg: AeBDieuOZ5cvXky8XK0hUYu1MdMbUIyXeuhg4DAELSL5E/9nwtVtk7+dFTz75ZtirSV
	hHex69k77TQeNDKlAiVqA7PVaB3jBOket/i56FQ3ZagmNd8sq4DUbH3UGMoDvnlgMp0PVZB3tn8
	7ngcOJ28TIxyBkdqfxlaxZ02cFvhwLYNYA6XZu7GG8OHq5oeDkPrU8xmRXBC4pWmvPibjy5JCWw
	w0hX/CUw/SOjPPdQXZQaCiZbphS89DRndn2W1XOJqFdFXdPxnsMSVvPMIA9oQSpL7tOL/IiPhHB
	0/wqVbvIJP2nHz7eLNLKIzg4rCRaO6EMgJa8AcUQQmETqSbDFK+0r1IWbsGqOvq58WADbbd5BYt
	cMGb9tbuN/i7jwb64s8Wf8SYgWdGP3dkF3+PyqNOQRSmPU9VVnXUjUyv0znj2yy8jG8NbVtnh5S
	6/LgtY0Ili6eV9hLCBCNp/i6JxgQ==
X-Received: by 2002:a05:6402:5106:b0:662:ac7e:aac9 with SMTP id 4fb4d7f45d1cf-66e3f71d3c4mr4260796a12.20.1775405338237;
        Sun, 05 Apr 2026 09:08:58 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02f389absm3195890a12.13.2026.04.05.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:08:57 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 05 Apr 2026 19:08:41 +0300
Subject: [PATCH v2 4/6] iio: light: vcnl4000: move power state function
 into device-managed action
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-vcnl4000-drop-enum-v2-4-7c8dc98c3974@gmail.com>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.1

Move power state setting into a device-managed action to get rid of
fail_poweroff goto label and remove it from vcnl4000_remove() function.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index bbb84b71f226..d28c7abe7642 100644
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
 
@@ -2041,20 +2057,17 @@ static int vcnl4000_probe(struct i2c_client *client)
 
 	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
-		goto fail_poweroff;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto fail_poweroff;
+		return ret;
 
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
 	return 0;
-fail_poweroff:
-	data->chip_spec->set_power_state(data, false);
-	return ret;
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
@@ -2073,18 +2086,11 @@ MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
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

