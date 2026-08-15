Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53841D131
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786816664; cv=none; b=csltejjWaYwSZCPSDAgOIbFJk/zFhrfGlnECkglcN9atyHTJSjCr9zN2kla/Ia1nmuhwI0aYucdtpkIHKFyBOid/nLHfeK/v96Hei989V+NcYoAHv9kJswlAQ6QkrJXgaHyUdCiDO9XfeFNY/dZHELH3VmaiKkVLYm6wjvvGAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786816664; c=relaxed/simple;
	bh=nKxgDH4TdWB2d36OnxpU2PoAKG4hTH5rCToucuzyeXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csIdqsHO5e2eEhwwnF5UMfkaYcYM/BwkhD1Pc5/6WNjvqm58TX/EaYYCGAXbURfSj65hcB07baGpD1LpIZlblAlYBcFgWQ5JjbxVD93Ae0xLcB7gOWXCS9vlp1IGOs6Skf1MBdKh1lVpUgKY54slLBRBpd8mrpG2tmz6fVOjta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+rh51rz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+rh51rz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2534018a91.2
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786816662; x=1787421462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nrr+5GeNkVo/Yg6tMxCd6vMnt7MSIfXEc0j1vvogzWg=;
        b=k+rh51rzE32Bq73aUo4Rjg0fi7JkiB95JMKrmz9wSpvVKMaFkYeHIraikrlCpkq+Qd
         bBxzSZJII5hs1UaLo0m17ZXUQgaKbbvm+O0fJ8iuEYJMNl2jzSPw00WbFB9Fp6+7I2sO
         +iy2LhhX8APHRqRHKn4z1AJ8r/lNHafw4ITPolwR+orAarrFnm1/ZemSs93sWFFBUHPS
         lbsbOPl+kdb0+N28+uVhjpGbK+79YmHakCkee+y8nO6ZUkqajEA9yimxqiwz7gDjAWoA
         PeMS0l5ZPplK/ASdEUVkJ5xUlqZrAY6+lZKA3lzgcpomL4njZVRf3kWSA98tFiDDY7aj
         dKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786816662; x=1787421462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nrr+5GeNkVo/Yg6tMxCd6vMnt7MSIfXEc0j1vvogzWg=;
        b=D7bIcHFITZ0vu8YsEVd8J+7MmgFvZHLIEQH+D8R4fdGLyvtEZr8Y/MfhvpLfsanMXb
         g/F+Kkw/Xy5SxZ1GjWthDf9KQTuqR4WmqJ/teBDMV7yFa967umN5386f2IlL6v8K8iXP
         BqDdVwKXBZCRPOaYiEqqSORFOPz9r+03r6Tffz3K4q0Jxs6Oa6sMSGC27sVpqmmEU9n8
         sjWCYLudyLBI3ow26f92N4hAt60vtVTHPx0/0cDHHNS8MHbV12WoEZ8wzjm+dWrYAJyP
         n2rYcIiQsSvzwducXTDVsM86xtxJm9DrwQUqLTqumZ+0Wfk8XDmyIeZc40qfsm1VeO46
         nU/w==
X-Forwarded-Encrypted: i=1; AHgh+RpmgwU1iAXvnmG7itz0SSRhK0IfU9cMqjFc++tlne7SD8dLeD7XnDLexJdS19T7Flcde2fBL6+VOPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrd7/EteMpzK8WchzYXCzi9YGaVDTeKuRgMSFWpOV008jppjP9
	zDfx4XrgA7RYZv2pg+i5ZQvkcIVaFnIr7Zy6MlnbLTSHF/IHb82NUJGA
X-Gm-Gg: AR+sD105D1r5bqDr3MEr9p7pghKhpqbShtBVhVS5iBZcbByQ+O8RhzGsshsp1q6qcvP
	8SREeLQ/zIe9O/1WXusjgQPbfESBB47z1CYWoL2IkkMy8exyNDbuKpRs2XMKYh20YWbdaq+9vwC
	fk9zZ8DqhBG07/nVxL8f5n9nemA9woxPUKtamurr+4VcZiuSaWHkQ0ySKuzj5aE2GPZxRy/7ous
	SSRAETFl+BNxoafzm3ZxWfdUwqYvAdECCgeomAixjNg6jOrKCGFx0Su1tfREjnttrLNOSTgKBY3
	V6ScZ3b+jw+GlkuEFgEBHabLtQdOSMVaeGNfLCC98zuZyQb/VnTKaakj8z3PAOjJO7SpAK4NEbX
	/JKSYzmFKF4DGThZpOz6dyj6wM6paY+WK68+n+N/N1f/U/3TYyEIuIH8HW5GPkPftJVyxHZVqfy
	mrQRMZlh/vZyFYhD8DFQvpemsFiIxLtdww6fR1HHFpxHi5rRD9kTDZ5+NkOhrboi/+9j2drM/WC
	DqDfByi
X-Received: by 2002:a17:90b:39b0:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-3933b500d17mr14996336a91.0.1786816662102;
        Sat, 15 Aug 2026 10:57:42 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1248:1816:fcb7:1765:17f9:b9a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fcfb8sm17305163eec.21.2026.08.15.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:57:41 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: accel: bmc150: use aligned scan buffer for both trigger and fifo
Date: Sat, 15 Aug 2026 23:27:26 +0530
Message-ID: <20260815175728.99541-2-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815175728.99541-1-yashsuthar983@gmail.com>
References: <20260815175728.99541-1-yashsuthar983@gmail.com>
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

Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c |  4 ++--
 drivers/iio/accel/bmc150-accel.h      | 14 +++++---------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index dc8a6285cf3d..89a475ef9a9b 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1191,12 +1191,12 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
-			       data->buffer, AXIS_MAX * 2);
+			       data->scan.channels, AXIS_MAX * 2);
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
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

