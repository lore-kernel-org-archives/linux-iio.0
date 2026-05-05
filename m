Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B73859FA
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003220; cv=none; b=kmOFVZC1B/SyujuGxCRM5/Qt12GztqLfUUjfm9PZaYH6VAEBRF6Anp6oEmfmSdYNCy1d9t/XkaZusAq/bZradN9amIVOp0UWUd2swsGP0BkEht/CkGP8tlS75W40nzADrrBeFVcX1rQ7qZtGFhCTUMDn5VOTvH088bArjSiuqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003220; c=relaxed/simple;
	bh=XI5blpbluZo6VAkfAG2ybKsH30PQQjRvdqtwzMfXfAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ej934iywZKc95M+Gh5jpecYYx2LUWJouo97ISzvOcLECEdu1lxetXZhHfrFBxVxskIrzODEPrIJy7ws/e3vjlM/j8UPAsXu7574r+d73/sJOFYn3LwDQjkm6oalySUfXgPassfNJyN4Y3hofJZR6sArDCaD9xrHcGlblgYrrPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVfkJxy+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVfkJxy+"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so48373305ad.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003219; x=1778608019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZSbvp8eMrVEuQD81q0rzP0AajZbs6/47uUXZzpLcJU=;
        b=JVfkJxy+NoY3dy8weQLXEFdUWN9mKsh15Q2BRuWqZludFXzJmfWXu+tSl975lGxIkA
         IXtZcTeL90fgSmtnVk4d32d/wxdp3RJAcdhy7ssvx8DlwEqLTgZiNy2JKVeS5D+LxYrn
         aY9QAWRpV1kwONaSbLeLTxn3Vdm/y7ZfYXf8QjLFEQ+3AlO4gG8h62W32TVllCGWgtTp
         6Mo37onS2c+CbAMHssQk3/wP8XzAygg19E+mYMxMXoxv0Y55PeO9+WHjSdv2dN7RPo2W
         Mb3ro0/6SlSm92TTuUVNkcZsofFLf7Gl64TWSjv4e2eGuwGzDTCQSqWuZu/NoIolyjtv
         Yxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003219; x=1778608019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZSbvp8eMrVEuQD81q0rzP0AajZbs6/47uUXZzpLcJU=;
        b=PXZjqytOHC9GAsnGTJNktzShS6+Q4Gz7hujc48eS1zxQdZHgSdqUdB74ZXRHinryIc
         LEmMqqE3F18ECnaKLOOq9OFIFzmfCD98Kl/WvTA7UlIsZZvQToatoxqOPOzjJCw3OxZ/
         erORNo9mNOIlNqdgwGiKVJQ8QXgt36Vz4V9i1sUI6hVDmWJMGi3ewmYGAMn76R6/B+1j
         PuUcSctGrBh/JdgERu0nipiQIfRtFFZtq9Zje+AhLfDO2gvypxcQu8ouWXLmuKT035LZ
         uVjSHo8188cjfFQYNuhytJw7Oo0PQjeGvrtR81E0isthaxw9D792EJLnPSPjD+T3+j8W
         SdEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Uis2QoNWSV/AYy39/rO22ioRGCyA5/N6k5lMX/kbaifUKVSfYRBcswm7QOZaDr3EYs/Bu1hlIgLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypkjZUWVuJ1dwTjdc9uVOd+K13llgRcPBSKKbF0/Orye0EoHU7
	T3CBIt3HTyxsL+I8h3GgVitAxqW1FCSNMluYilQPRtQ00ZhJDpkrrGOn
X-Gm-Gg: AeBDievAcAQzADDWS1isHyh7A8kUAv7NfigqBu3xmytQ+E9XmMc2cxjTqEuHjLWTyZi
	UL5l/Y/jOqslXppzHcMHcV7e6MgrWTs8TdpF6iYWsaj2SZMOAP4SCadLdedAe5OmxSkeyZ5T+6c
	Z7S1AicEKfSDotHTAss+bLGoERTZ7wIPwo82IzfLKHQ2hSmtNlTurYVM8PWh7xO0/+IfOBGpV6l
	Xkkzm8SV4AomhVV++S8ixIDMpUu5uysR6jQG/JrvIh7r0VeoAlQFWDmUL+AKAc32TAXrdfcpNtj
	BG/gcK3bfp1DDSwhW2vzjzLpglu8H7D+LT/fIGpIRJxvDJ16tfr0c50ZUd51EYiV6oWvkqTOsfk
	10LIDLkFdml7h15/3XG3g6vuT7Hff9TOXPe9Kce3ouy+DW79WJ25gnAldk42Qa4vHhHy+s9lL2n
	3bk41Xpmx4D0No1NQTzab3zpbl3AburUbVxRoteu9CYAYeyUIFFFYWsX2oz90=
X-Received: by 2002:a17:903:a8f:b0:2b2:b117:1e16 with SMTP id d9443c01a7336-2b9f25e609emr127202825ad.20.1778003218591;
        Tue, 05 May 2026 10:46:58 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:46:58 -0700 (PDT)
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
Subject: [PATCH v3 03/10] iio: accel: mma8452: cleanup codestyle warning
Date: Tue,  5 May 2026 23:16:33 +0530
Message-Id: <20260505174640.3998281-4-sanjayembedded@gmail.com>
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

Reported by checkpatch:
FILE: drivers/iio/accel/mma8452.c

CHECK: Alignment should match open parenthesis

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 47 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 279a9b364886..916631519d3f 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -706,8 +706,8 @@ static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
 }
 
 static int __mma8452_write_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int i, j, ret;
@@ -788,8 +788,9 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 }
 
 static int mma8452_get_event_regs(struct mma8452_data *data,
-		const struct iio_chan_spec *chan, enum iio_event_direction dir,
-		const struct mma8452_event_regs **ev_reg)
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_direction dir,
+				  const struct mma8452_event_regs **ev_reg)
 {
 	if (!chan)
 		return -EINVAL;
@@ -818,11 +819,11 @@ static int mma8452_get_event_regs(struct mma8452_data *data,
 }
 
 static int mma8452_read_event_value(struct iio_dev *indio_dev,
-			       const struct iio_chan_spec *chan,
-			       enum iio_event_type type,
-			       enum iio_event_direction dir,
-			       enum iio_event_info info,
-			       int *val, int *val2)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, us, power_mode;
@@ -881,11 +882,11 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
 }
 
 static int mma8452_write_event_value(struct iio_dev *indio_dev,
-				const struct iio_chan_spec *chan,
-				enum iio_event_type type,
-				enum iio_event_direction dir,
-				enum iio_event_info info,
-				int val, int val2)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, reg, steps;
@@ -955,8 +956,7 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
 	case IIO_EV_DIR_FALLING:
 		return mma8452_freefall_mode_enabled(data);
 	case IIO_EV_DIR_RISING:
-		ret = i2c_smbus_read_byte_data(data->client,
-				ev_regs->ev_cfg);
+		ret = i2c_smbus_read_byte_data(data->client, ev_regs->ev_cfg);
 		if (ret < 0)
 			return ret;
 
@@ -1193,7 +1193,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
 
 static const struct iio_mount_matrix *
 mma8452_get_mount_matrix(const struct iio_dev *indio_dev,
-			   const struct iio_chan_spec *chan)
+			 const struct iio_chan_spec *chan)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 
@@ -1516,8 +1516,9 @@ static int mma8452_reset(struct i2c_client *client)
 	 * The following code will read the reset register, and check whether
 	 * this reset works.
 	 */
-	i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
-					MMA8452_CTRL_REG2_RST);
+	i2c_smbus_write_byte_data(client,
+				  MMA8452_CTRL_REG2,
+				  MMA8452_CTRL_REG2_RST);
 
 	for (i = 0; i < 10; i++) {
 		usleep_range(100, 200);
@@ -1647,8 +1648,8 @@ static int mma8452_probe(struct i2c_client *client)
 			dev_dbg(&client->dev, "using interrupt line INT2\n");
 		} else {
 			ret = i2c_smbus_write_byte_data(client,
-						MMA8452_CTRL_REG5,
-						data->chip_info->all_events);
+							MMA8452_CTRL_REG5,
+							data->chip_info->all_events);
 			if (ret < 0)
 				goto disable_regulators;
 
@@ -1656,8 +1657,8 @@ static int mma8452_probe(struct i2c_client *client)
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
-					MMA8452_CTRL_REG4,
-					data->chip_info->enabled_events);
+						MMA8452_CTRL_REG4,
+						data->chip_info->enabled_events);
 		if (ret < 0)
 			goto disable_regulators;
 
-- 
2.34.1

