Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE133A16B6
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141213; cv=none; b=I0s0ZOPvEX7wL7MG6eGt5JTaR7o/z2zlqGg9ug5zIWVsyysZzsbOkRIhOze2ayQ4bpnSViFJoo6Esfl3JQMHlmThgmgVSOhIGQlshxKMABvLXsI/RmAYyTOqOW7YpLk3BCrxO1Rje5ozaT6sSACNGQJxFyBI212bj29U04FPeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141213; c=relaxed/simple;
	bh=Mhx0z+syGJL8iXj8CfFuAcr5tavxGM1AgsSsS7jC6w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqsfiLPQwq/Yprhe7C/M9/dFshfdKnrQdjBZX8WXDLtuw1esO16NWqBdiOrAtXiAMsqDwZFMHZM7bVssGVz1xx++HXvfbmGbSA8+fruSexTyTYsqrS+MwYZCRyZ7mJVzGhtPXcLiSLkdAkHVEhTo1CAZ60XjOzOrogQq/cPE9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLIQYF6O; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLIQYF6O"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84229481d44so208882b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780141211; x=1780746011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIIyDr6/RBY3rTp7heBCHwFxNkq7nFTnyDyon55fD+Q=;
        b=cLIQYF6ONf6LSVHOeB8GBaRI48A/Eh1mzDdRh18/WZ+zAa9XAVn0cdQ7gs9N9MK0w8
         pj/Ir/CCIkb+YBcppnoDQdRMudb5LOZXNUJqBgDEC0ERrXih9AfqDRZ8NUU2nEJ0Mb8N
         kPFcMcoCcfsePqNp+U78SeNuSOMz8vRNWsLC5btm3tORIFqe+YJ1M6P5ZEf7n28uZLZp
         TMZunlfrtO0kBpkTywicgp/tqttX36Ku4zKcFzfH4d0hPOyljdDdctpwnUkQvXcI5Wr1
         q/CKcJ9tgU/jSpMmeKnOK3SBj+ie/DS56/7h4iXm41T3zyaR4FhK2G9Up0UMjQksjNjm
         asNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780141211; x=1780746011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIIyDr6/RBY3rTp7heBCHwFxNkq7nFTnyDyon55fD+Q=;
        b=Hplgr0LyKsdGCz+AIYHyjuefqXFwr53QnQtuQ9g8XPSBFZt1M9OHJaRBDSsC25S35i
         a9VItjaQVPZ5Fa/pGAyXlWLznnEO7u9q5OBM9cbDJK7vDtT6wP6j3Nfp7YBzLoQUrydj
         u1TLe9I9HWlemmd9awQapgZvYNp+zWicPtAZY3Wc+9HPI/py5D59s5TDI0HVi8VB22PP
         cv74NW498cjQ67G3diE3il9mCNpxqZv1vCU4om/rTxZDpI73/sW6ANAH63ZU6J5Zkqrk
         SQs7NGcWZebfH9Rou6z/qGxmHYg0joxROY7Kzse+T8DInUq/48SUPvHaejqFnDLCVc79
         2fJg==
X-Forwarded-Encrypted: i=1; AFNElJ+U9GIvkVCIkW50aGJnsRVL2s3kfHv9hcAQNulvPsrmKuMKhju0pqlfwt0TkHpE0UCom1RtYCv2nQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZOOq0LLITnpkvZ7rMmu1s2pUfK6KmLAAdColeIY5dAEkXw0m
	NtmaQ73kLewl7/wN481OdVTvp5SdQ959b4DCyoO2yYOWamiBn7IVCna4
X-Gm-Gg: Acq92OH67+gLNpbtyvspvIDJjnw4JDaUAZAgO93frnsuacqTGBTrq5cireY8n+f33A5
	zK9UzWwc/4WTsQuojocJGGX+BIzVrxO/7fyzqEJEzWOUX0ETB0iNyh6XY2U6xBtJ161zyM37YxK
	AaM7ZbcU3MoWj8I+n6sMnGX9VXkWGf9Q364feGx6O6HWRGXJ2wjoJEU1PHWRXGrF23Lm2jc6KCA
	hsRo0jxuxDqeZAFdqUPJWW1XuQZBFdKhXmESy2rEbUZXt82FRU9voWWdvBGbiVIN/G3wYsooAb1
	vJWwhkc/k5ptf8oNJLAyEPI3jHuIwZiTfQS+tK08QZmtE9vmHYf9j2VFAci01Db1gtkgn+5o9g6
	ZmzAgwexvgNwjLjhf8D48JTCdqYyJhiehNklB5TW1T1xiiotjBinlfGYPMup7BCDVNugTitCkSt
	MgkkPuhupk4zRZIZITPfQHCPt4eD+uRcITLuk6Y0c/t4FQiS7lgLatjLSpHQ==
X-Received: by 2002:a05:6a00:948b:b0:842:2ddb:e305 with SMTP id d2e1a72fcca58-8422ddbe832mr1655705b3a.43.1780141211102;
        Sat, 30 May 2026 04:40:11 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b6797esm5467518b3a.26.2026.05.30.04.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:40:10 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	apokusinski01@gmail.com,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 1/4] iio: pressure: mpl3115: convert probe to fully devm managed
Date: Sat, 30 May 2026 20:39:35 +0900
Message-ID: <20260530113938.171540-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260530113938.171540-1-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert probe to use devm-managed resource allocation,
removing the need for an explicit remove callback.

Replace iio_triggered_buffer_setup() and
iio_device_register() with their devm equivalents.
Register a devm action to return the device to standby,
replacing the cleanup previously performed in
mpl3115_remove().

Move mpl3115_standby() and suspend/resume helpers above
probe to satisfy declaration ordering requirements.

No functional change.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 81 ++++++++++++++++------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index aeac1586f12e..befb6d48efa9 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -691,6 +691,33 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
 	return 0;
 }
 
+static int mpl3115_standby(struct mpl3115_data *data)
+{
+	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
+}
+
+static void mpl3115_standby_action(void *d)
+{
+	mpl3115_standby(d);
+}
+
+static int mpl3115_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+
+	return mpl3115_standby(iio_priv(indio_dev));
+}
+
+static int mpl3115_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mpl3115_data *data = iio_priv(indio_dev);
+
+	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+					 data->ctrl_reg1);
+}
+
 static int mpl3115_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -730,53 +757,24 @@ static int mpl3115_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = mpl3115_trigger_probe(data, indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, mpl3115_standby_action,
+				       data);
 	if (ret)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		mpl3115_trigger_handler, NULL);
-	if (ret < 0)
+	ret = mpl3115_trigger_probe(data, indio_dev);
+	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto buffer_cleanup;
-	return 0;
-
-buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
-}
-
-static int mpl3115_standby(struct mpl3115_data *data)
-{
-	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
-}
-
-static void mpl3115_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	mpl3115_standby(iio_priv(indio_dev));
-}
-
-static int mpl3115_suspend(struct device *dev)
-{
-	return mpl3115_standby(iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev))));
-}
-
-static int mpl3115_resume(struct device *dev)
-{
-	struct mpl3115_data *data = iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev)));
+	ret = devm_iio_triggered_buffer_setup(&client->dev,
+				      indio_dev,
+				      NULL,
+				      mpl3115_trigger_handler,
+				      NULL);
+	if (ret)
+		return ret;
 
-	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1);
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend,
@@ -801,7 +799,6 @@ static struct i2c_driver mpl3115_driver = {
 		.pm	= pm_sleep_ptr(&mpl3115_pm_ops),
 	},
 	.probe = mpl3115_probe,
-	.remove = mpl3115_remove,
 	.id_table = mpl3115_id,
 };
 module_i2c_driver(mpl3115_driver);
-- 
2.52.0

