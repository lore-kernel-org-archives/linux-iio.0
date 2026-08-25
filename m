Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FC3EAC61
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647944; cv=none; b=JoOZu85Yj2MSuZ6OrQUipD7Bt/s2AHp8bXiVAr+/LM+Svq2DSlQzc0GNapJxNWMaFg3Ynca10YzU5CdK4BBQR/He0gus6xsBaqLaRcBje+dzT7Qkb3GtBcRKUCZa+ZnZik1Sm//QgK9Kl1f2qsrfPrFkjBrsRyD7iCpiXwUDwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647944; c=relaxed/simple;
	bh=TZ0Tk02P9YLuRvbKHnx8xQeRXeHOdPj+cyqR0h2JZfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCSkdweFSoFOTLfTr5NK4VE26aodZ4RAY8RqKLA2JtOZlhjsEuLbpuK5xVsHmIdAhurz+ZGb9ars66AbVOqc8PM9kyoCzMVD3hUfZIo6WMtJSRMPdRWnOtW/vDDWQ54TqXRYs9qU6hKSqUQvyLxzuNWnVXIK5liTnou3rTXiOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK42kcs9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK42kcs9"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so2977464a12.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647941; x=1788252741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gu7Nc99xk/nLbpeUOexaTxz8Q5kk/2EyCmw8FRDGVrU=;
        b=PK42kcs9HGikPZT9TW5bh3Fpu4VX7Zkub0R5/TVpgXPUMXFHEBOZ7b0hPPIRZcS6tT
         c6cZ/VkE2z1eubGas8F7Prz6MNfB4kiUb6PG4UX+wjRWZ0oAu/dEmJzqkTXmb5TU+tEC
         yCSfA9539z00hEValD1afhjvCPnUPb7MNvMkM8FVRXWEDFm2xZX5OEcQECfLtHvQscSM
         sXvnKbgAXuI46jpAZJz/8g2Qop1J+UUcB4QgrZSkK6OPWbxLoONgviYDm+Vm9ffTTQoP
         jsgEae4tY0j7iG2QkgPFQvp1DMIJULVFt2fPajtbjcgl6e/MdSFGpl9W5F7Da68HFLck
         2K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647941; x=1788252741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gu7Nc99xk/nLbpeUOexaTxz8Q5kk/2EyCmw8FRDGVrU=;
        b=gY0RbJXZ3LG6cWeXAt8/ulFvlfpfX8p//4M5XLQCh17QIbzoRqpwwlKNTJGhXdbcM/
         0Oh8tsFyrvMG2ntiWwp96ka2niG/BOK7ETAwaALbJh+QrivAU8HvcsYQ79n9y+Fj57p5
         MTxrkr+q17aC6+HBre6v1K+cR+1/M2vKLvWScivWD94utpUHMyequGpH3fDUHgwIU/B9
         eseyFheAM0jNBz4CFc1+tQ8NjO7Dl1zxANG3Tw2lEqTl1Insf0YSTVw/mJ+iXJfD425e
         NjHm73Y5KArl6PNcdpYa782OMkrSisDybFlRai634OMEqE89a+kewo4K0nbhelOaZd/T
         Ib6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqGqr9TP4SGCnF/7xRJI58YQuPlTr9hI0/dFp0VHpzgvzMfBa10Lziw9mJWFSMcFb/Gh6hu4cB22OM=@vger.kernel.org
X-Gm-Message-State: AFuF++nlMNd4ath9iDZrwKwB4Xxj4UuihB5WVbqSqd3LIeGPR9A3CfWU
	bA2zTlClwK+9ulR1FMhR0kdWyR7jzTsbFVBziQafzqe5uu3qnbEzCpmu
X-Gm-Gg: AR+sD10Nyfb9JMxMXRdmPYon039rNrf0lBPltUpz9RGcxKVA8ta7ZnZG4s5QLjk6LSJ
	izi3TcmUJG9+D1MbhSj9tQtc6yH/Jq+W9hsSYXbEf0F0ATjgGqmpYfxbaUT4l3HoHN5ha3xAC2W
	ypnk2Y1fJ2qeqSHvG5kGHGawAE4IBT61zctFUVa18EuuTqV7d/m+y4O/s/hIeaau2NDWi7EBLC6
	K0WMvDodVFlRPa/MsIqfu+GmS+JCA4t7EWN2B8C3fMEyTQmM40syocWRchMAzkxqaplGwiSAvSk
	mnuuUT3sQL3umzVI5JbawOM1i81EDsFe/hxft5WpGrIqpW8nTbxbFw4pehLYCZKBj0R42A9+8g3
	QvWdZl1mo+zB64nJfjrPvE+TsrWm8YkSsg5iywUDjw17qxAZ/vRv6PZbX/uobFkJ5jAV5m0deiK
	I3upkUIs5oRmdoQCGv02d7/toOFqcpcJTdUJO26GL9QEVG5tqzLJ2MTbE0pdPL0QSHRj87
X-Received: by 2002:a05:6a21:6010:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cd3009ca00mr63740804637.10.1787647941193;
        Tue, 25 Aug 2026 01:52:21 -0700 (PDT)
Received: from shrey-Mi.local ([106.51.251.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0a59sm42032202eec.9.2026.08.25.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:52:20 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v3 1/3] iio: accel: bmc150: use aligned scan buffer for both trigger and fifo
Date: Tue, 25 Aug 2026 14:21:54 +0530
Message-ID: <20260825085156.212042-2-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825085156.212042-1-yashsuthar983@gmail.com>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop buffer as duplicate and s16 is not correct we needed __le16 as little
endian, keep scan at the end of the bmc150_accel_data struct with
IIO_DMA_MINALIGN, and use it for both paths.

In trigger handle, replaced AXIS_MAX with sizeof(data->scan.channels).
Additionally, ensure mutex is held across both read and push to get
DMA safety for the scan buffer.

Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c |  8 ++++----
 drivers/iio/accel/bmc150-accel.h      | 14 +++++---------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index dc8a6285cf3d..1472e0d1ef65 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -131,7 +131,6 @@ enum bmc150_accel_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
-	AXIS_MAX,
 };
 
 enum bmc150_power_modes {
@@ -1191,14 +1190,15 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
-			       data->buffer, AXIS_MAX * 2);
-	mutex_unlock(&data->mutex);
+			       data->scan.channels,
+			       sizeof(data->scan.channels));
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 err_read:
+	mutex_unlock(&data->mutex);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index e8f26198359f..9deff256aed5 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -64,15 +64,6 @@ struct bmc150_accel_data {
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
 	u8 fifo_mode, watermark;
-	s16 buffer[8];
-	/*
-	 * Ensure there is sufficient space and correct alignment for
-	 * the timestamp if enabled
-	 */
-	struct {
-		__le16 channels[3];
-		aligned_s64 ts;
-	} scan;
 	u8 bw_bits;
 	u32 slope_dur;
 	u32 slope_thres;
@@ -85,6 +76,11 @@ struct bmc150_accel_data {
 	void (*resume_callback)(struct device *dev);
 	struct delayed_work resume_work;
 	struct iio_mount_matrix orientation;
+	/* Ensure correct alignment of timestamp and DMA safety */
+	struct {
+		__le16 channels[3];
+		aligned_s64 ts;
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.43.0

