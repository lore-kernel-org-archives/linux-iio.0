Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3231449B23
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702758; cv=none; b=lRm2C5Y0A6akJUYmhBsg1z/FsTU30TC8rx9XH4anmXPT7XxcljROh9Ibfj0fUUarta+7ZFZMA6ymmA7f1v5mnNhhkr4cXOrFrRPJA/ytcGRPTK8ZoilHAYfdXM0j2cMMO6G1C25nl2dvplXyr9qCPhHF6Cv1R8u7X/cGvlpdBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702758; c=relaxed/simple;
	bh=gr2vkX2WytW2dclIDo6x+kCceMO3WjL7tTKzxEI7Zlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpfTjTnBcSg08XCiHlQCyIxEA+ac4tdia6nD19uFkzrkrPvbT/gykeZQtJFFcZVEiFMsPrQ+y9MMGxD6qAE+i1600Hh/SNcj8Tx8y/Yyvif94/ZG5qZcZdaCs2abxwb2LCBJNk3MbLYWnhXVrN1y4qnjwIqvJqD0QBP1FtDdwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm0TXp80; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm0TXp80"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso944565a91.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702748; x=1787307548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8X2DzoqFH7matdonUd7YA/b7NIXmlkIfIulsDTFoluM=;
        b=Cm0TXp80SMWVMbEfUieXOQHZcsB05uxzppfaz9nfYqB8RO6tfE8vxcw1/sRtjId2mS
         mXdv3FZQsm6gJ6kVQ4rAaROOkt+dNL4Ng4mv28+VlKnr0cZy36t2bEGRykXSDE/9509e
         YLy4AwZdatQjvsUBKZBrB8BkXq7HzcwcGSCmaUXz0HTqfJOhBTs9mHs5QOxNibIT13kq
         EfDSJinBgPqc+nPdg9ivxD4tw+tpZJ0hOFpDNo7gn8ZDLmpi4pnrZsZ9jQu+sU01ofHp
         NPUdM+B7DFOt3Xm+tPMuy3hRXV5tTIAZwo9aH2ObSxXqw6Ybs/nW+AVU2yP5g3SnBFSf
         zubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702748; x=1787307548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8X2DzoqFH7matdonUd7YA/b7NIXmlkIfIulsDTFoluM=;
        b=OOOFUH2EwZkmGuFOVbdzhXp4zDAeF1SUkY3ZW8zHEWDIO12b7+CdxtlCHYmr4+h/j/
         kd90cyufGTrFPGAt26UGvd43XarDZDb7FJz6dSGOLm28LUN7WmYe9AqRWS39Ksd/QHt5
         SHKifNCdHJolfn0NebWmhmUub6NWoMlLLrkyisNylBzrS9LXDg0mMWKQqu3Bn4hegGtO
         9uozoSasFZ+Dhh59OjaH91BX0Tu6a/y6Mi+9L2TPV+Hf8uWvVqpwMFeeaswF3RcGeg11
         u8PhGTpz4zu8qjzBBNqDx1O1ugR8kEGpSHV7/GqsCxKyEYn0vZuBKxnA3PIWLiMsoARo
         ClJA==
X-Forwarded-Encrypted: i=1; AHgh+RrPnFMB0XUEtGTnZKWvcKN+9dD9re8P3+MRnXG8iAmIB+lFvWM585eD53FSOQeniRk/2YFZGf570QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlzGexMnW4yBhrm5vvuT4ZuNJqKUnvOzxEAithSwyMQafUqqY
	sLreEw5Ej7kEIrHqPLiOE55N1jryCn4NkUZqekzvvFyJBVoGzXqWHYEh
X-Gm-Gg: AR+sD10s2gxiouQNWggMGRLwxJUF7ysEifp+Z3Pf/TFWuj+9UmCcDmdv+CPLof2iVrd
	+mg9I2jnbOpSf5EgvBxuSth+Nk2wUy4Jatso1lDcwW8Tf9Dk8o+WhD1gpMRQpfjTx+lMCAa3EGz
	6f+H3/90cn6EQyNpJjnNpVcpmsZiv7hMVIDO6UF+pbls102as2PKcQE6lTVg+2VgE36DHj09oLA
	gycCracmnSWvNYMgydCr7FxBLo373M3EHR+izrrseVk1Asb7NzVnb8vF7qhXYfSFW03RdqgOwoS
	7lXvPCbZf29bABXdprBgr9a/GGMpJno+DIpIScKTXYal/rlGNuKUCKS3TmPFh9eytN39/TyhXG3
	WGZb8HtDZQR9Gft87ycYAR9mFOFol05Ib36QHRIda8ib5goIgxsSHq2QpCaJvn+iVLlluvQ/W6t
	AIvKs/mWyTYHjZbIOy0tqQczvLuh78LpCk5GcNteT5TsunR07gZz7y885UYlYDyOW3mtUcdtt7c
	5civ5aK
X-Received: by 2002:a17:90b:1c01:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-3933b8c67camr4164703a91.14.1786702747852;
        Fri, 14 Aug 2026 03:19:07 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:124c:2e49:6997:3d3f:909e:c279])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm2074218a91.0.2026.08.14.03.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:19:07 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
Date: Fri, 14 Aug 2026 15:48:44 +0530
Message-ID: <20260814101845.301769-4-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814101845.301769-1-yashsuthar983@gmail.com>
References: <20260814101845.301769-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() to allow source size runtime checks.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 30d91d417ac4..476c020c41f0 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1009,8 +1009,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 			       &data->fifo_buff[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1191,8 +1191,8 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
 			       data->scan.channels, AXIS_MAX * 2);
 	if (!ret)
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), pf->timestamp);
 	mutex_unlock(&data->mutex);
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.43.0

