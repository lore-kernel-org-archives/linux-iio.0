Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472B361DD0
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003241; cv=none; b=EGHdnzvk6dTQbq0LI3cOAzLVK8gwrhcTyGiEg3FGZKUMnyJ2GTWvPDUX25yXLpjUSAzg78ynxpX1DWVDkeNicdQFp9Co7b78tl6XZie0ftPmDHmYCtLlkTE3H8FwRMADtwgG3RKX+Zja5LNSOQYvt4gq2GWgeXfidfvuMaNJScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003241; c=relaxed/simple;
	bh=WcK2GcDqNaaiTtJknltb2zliZF2AboIM0EtKhNSkLLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiaB+g1asoYCogwe5u+esi6yM+vvREYJWmwcpyJfC/d1Y2trFd8FMfoCpSS2zkmTuU9DrAZo104EtydpKcA0TSzTwpoUW5+ydU33lJmmUuxTt/4WiZwcmrD8jJHaPhsHH26KLaECa15YCeLZjVCB9jN+rUWN/4MW8eRRlqYLi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaFX//4O; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaFX//4O"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-364e5d895e3so3591724a91.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003239; x=1778608039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQvY2zanoXQzF8G6K+yMU4QmWySA5sByDgB3bL6cpQg=;
        b=LaFX//4OpplNy3NyVc9zH6xd9UHWAk7+ngXdAWetSjv+j/nJVXNUGW1Do+38T0Jzss
         UT0Ov3SzWAfw8VQbI2OK4Vyt0lRzAvSGlu7/IWMi6fT+xoUIOf4sGCLZmV63rHsvoELw
         kVksgUfNcxpEpM15sJ5+V77Uq75u/g44JwmSwZhZaBwJ3xsfKxnhYgPB6aL3XgiNAxwK
         ZWckLWIVaCRlIG45fhMrm1MDCYvmv3t+yDYmxqIaFSW+8A/6MRpPQaS1sPvwKax4IWwM
         RgsVAjiItOh8Z6JcwXR3fPif/PNgWGKlEQWBgmeFR7IKncVHi/F9H7IWmAEu+ti7dbo6
         SGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003239; x=1778608039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQvY2zanoXQzF8G6K+yMU4QmWySA5sByDgB3bL6cpQg=;
        b=hFTkDz3WkLqwakG9srfBYd+NBIR+MyhgfYH6sdavGO+HhzZ9mbnST10+EWoDCTy+5p
         p3dB8V3IgwQQxvkS4cPu3MOJJJso7d71+UEDd711A0tlYhFYIdHZzhGzPHlEzV60yDzd
         T8tOXkPbSW3+pgI5JFlrLpuzuVn2C+G4SnkRvYcckaMo3ShkAMbiVSPwYVUTPSfMpwtX
         BA0rqVK4bZtq4e0VP4aKz+Bjsb0Ubr97OGdnsQ/kG45vg3lZN64a+IjnGKG7TGWNkygp
         /WSwc+UfojoGdpPwLTfRN+VTvlTkdXol4GVEMCsC/Oopx1qEW4uV5DBHQbuiLA+tr4UO
         RslA==
X-Forwarded-Encrypted: i=1; AFNElJ/5wgkJil95mEQW+sB/d0f03vZmysSq/uLmgmp1h4vQJmLgwKH6DlCX+2O/cRkraBwYRHYWuzssmGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhOqFEbWz9z94v2BHPZZKaDCuD2GtBsbJqvfxmUQQZYFLwyDI
	tbsWkvU01mcbe/0/Our/iUPvC8U2rHzOZQdPGUHWWVZr0Djeq4ihljsA
X-Gm-Gg: AeBDietoUwZzaHj1xunv9M9/nPsd2C7REsQe365dkEHYstQKQQQNE19YXSeUP4bDYZc
	Jfp23R+4vfxob5qrP1np9MogZE1uGtuFXMI/9dEfAoEI+BBcI4/DAnWzcZjqSmlTwYIVapra104
	EtH/zmndCBeFcrxIdVVK+6M4kT04pJ3X4VZcdbDROPL9LzNTMM9+yhXSrosZsnZG3hdmDjlsvMK
	n+rZBngyYyR8910f4O5nQKmdfrNFnwpFyJmCmmgxTzE+Fkokb5siCWOIqonLHue+Tnc/8UFfLG+
	JMJp9ROgtWF8eoxQyekbDED/5ZQYSZ9l3yMRn6Fhtymk3YSVIo38acTrOEDajHn3kHvMNZ15ZSe
	CcNDpiG/5Lcqq9HYetmsJLNlUDiIy2CeFudW//d13ftDREIDawzoEuD4H0eyVLHEBjDFbmkodxY
	ioBhIkh5OSf2KJkC/Te51USA63q1/6Z9nVxI6lRTmlxCI8+capj0VpRX6Jqp0=
X-Received: by 2002:a17:90b:580f:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-3650ccefba1mr13939427a91.1.1778003239236;
        Tue, 05 May 2026 10:47:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:18 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] iio: accel: mma8452: use pm_ptr() and direct runtime PM calls
Date: Tue,  5 May 2026 23:16:38 +0530
Message-Id: <20260505174640.3998281-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use pm_ptr() together with DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops
pointer is automatically handled when CONFIG_PM is enabled or disabled.

Switch to direct PM runtime calls and drop
mma8452_set_runtime_pm_state() wrapper, which is no longer needed.
This follows modern kernel power-management conventions.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v3:
- Use direct PM runtime calls and drop redundant wrapper along with CONFIG_PM
- Link to v2: https://lore.kernel.org/all/20260422165643.2148195-6-sanjayembedded@gmail.com/
Changes in v2:
- Use DEFINE_RUNTIME_DEV_PM_OPS to address review comment and resolve 0-day bot warning
- Link to v1: https://lore.kernel.org/all/20260414192045.3598010-1-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 55 +++++++++++++------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 2cd24b1543af..5ab981481599 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -219,34 +219,15 @@ static int mma8452_drdy(struct mma8452_data *data)
 	return -EIO;
 }
 
-static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
-{
-#ifdef CONFIG_PM
-	struct device *dev = &client->dev;
-	int ret;
-
-	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0) {
-		dev_err(dev, "failed to change power state to %d\n", on);
-
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-
 static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 {
+	struct device *dev = &data->client->dev;
 	int ret = mma8452_drdy(data);
 
 	if (ret < 0)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
@@ -255,9 +236,7 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 	if (ret < 0)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, false);
-
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*vals)[2],
@@ -974,6 +953,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 				      bool state)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 	int val, ret;
 	const struct mma8452_event_regs *ev_regs;
 
@@ -981,8 +961,11 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, state);
-	if (ret)
+	if (state)
+		ret = pm_runtime_resume_and_get(dev);
+	else
+		ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
 		return ret;
 
 	switch (dir) {
@@ -1452,10 +1435,15 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+
 	int reg, ret;
 
-	ret = mma8452_set_runtime_pm_state(data->client, state);
-	if (ret)
+	if (state)
+		ret = pm_runtime_resume_and_get(dev);
+	else
+		ret = pm_runtime_put_autosuspend(dev);
+	if (ret < 0)
 		return ret;
 
 	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
@@ -1738,7 +1726,6 @@ static void mma8452_remove(struct i2c_client *client)
 	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 }
 
-#ifdef CONFIG_PM
 static int mma8452_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1792,13 +1779,9 @@ static int mma8452_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops mma8452_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
-			   mma8452_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(mma8452_pm_ops, mma8452_runtime_suspend,
+				 mma8452_runtime_resume, NULL);
 
 static const struct i2c_device_id mma8452_id[] = {
 	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
@@ -1815,7 +1798,7 @@ static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
 		.of_match_table = mma8452_dt_ids,
-		.pm	= &mma8452_pm_ops,
+		.pm	= pm_ptr(&mma8452_pm_ops),
 	},
 	.probe = mma8452_probe,
 	.remove = mma8452_remove,
-- 
2.34.1

