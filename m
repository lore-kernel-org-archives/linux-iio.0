Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A753AEF36
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003247; cv=none; b=C8/XWcCMloegybaOWqrRd+KTcgd1/XhQhS72LLEwKypnQ0kRNPL4eN82WnxVmWM6A6mNroGjlsPTaCelgL7nt6jT/gG1Df0k3jv12SAKmYf4sdVK/HYufVQsKzTiOQ1bysYoDJ7JiMGtInOKcfHHi4XDDBaThrC4RoiCbO/gq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003247; c=relaxed/simple;
	bh=gbBWcCKF5SIdyOmHNAYksgzC+iEKG/dPVheYUVfk04M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1dSk1fN6gkpxvI5W/b7E/IW0hqRMZybJ7bozjk+/DYWP+Jhh5DUjPqBgDbeS6Sgt4WvF75802Os/BZe3es66GMbb2z3e+Vib8nMtsKixoADbI66YFXA4MLeMRIQoKzQyMUddYMJZ6eNNipIsmdcm18ay5wlC0HEuRNLxtbe8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk+CIIT1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk+CIIT1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-364c5317d67so5696231a91.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003243; x=1778608043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM2ixPGoCvqmSBsLluGYBaizIvX/KE6p9fFw6df2t+k=;
        b=Uk+CIIT1B0ThtUapkbEyraDEgipm6uelvxUX49bOw5FLcuTQeAPUFtOOwx9iyx+Cna
         1u1gf5NfwVyANvjbIcZr53FsEfc+fHI/pvm9RlTeOBGV5XMzfF9ydtDWwddzZWDp1+OG
         tbkV3KUNabgXjfFUuPYgkw+IqTJtErQDu2TxRLe4j3VaANw10aFDBq+rb18IA2sh148V
         WnW0qp/Ay9UnYRu/FzoDyGUWgn8Yqq+OPYbx9QNbhKAOd+hZRZ1IXdZgMERWXoIuaTf4
         ebVolIxNUFgD1qtfEfp4xHKZZDaVMaZ34UMGwAoedg42ELr3HRZ+hsqfQA8IY/q9stPj
         E1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003243; x=1778608043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aM2ixPGoCvqmSBsLluGYBaizIvX/KE6p9fFw6df2t+k=;
        b=feSIh8NLBGP/TJyHDOmRdcJwWbM+pEHcw4uCnh+ft9bcZ94BTnMe3VT/MGHt6yFs8D
         Cf/mMaGXY/b6HjImsRMa+dXl1ppJlxtccr7eL1p5ukaziM9TQpJPYkTiSdUuph38xCMm
         ZJY3xFRh8qmpVdIyi/2MH0Gi0yE53QkuHv851rLM86nmg/MOKEl9hw0PPDNToSVwE7IR
         4VMw2Ab9BzfE+XHNFmtTTnTw8BMhNZ+u0YeFPAYoi5uZAdGMZkzGp5PATZAZAh8ctt0l
         u6DhwJzpIoBV4eiKOlL3nVNFDZQr0zUbr2zLWcOV/PuV7n4De+k4W6yHDydlRSV29KKJ
         cfDg==
X-Forwarded-Encrypted: i=1; AFNElJ/WainYGgpmVHi6czl5rg0AZ8knYf8krL485OlCIl8ecFp0s4oL7pNcbjLxUXB4iEqmN4KRIhjRb/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSHD2VMPxj6anu7ASl1bxoHODfop4m/E8tsr/vNheol7CKIuc
	BbOVPdhKs6/rdDgietc0a+VrI/TkiIlWiV0wTxz2aRca0CkZZ/Jy6WVkBlPAWg==
X-Gm-Gg: AeBDietDyc20viSt7durK8gUU0wHCMUclVzgQ7BThATtg4y87k2gexZKAXcUq4G/4RA
	VGN7Kzriyb3ouFqjAG2lMQzOElcTqyOI6NGrRvZrc3yBYGOUUABhylYEQcRS8ztcfQtKYemnCdx
	SgZcm4o5rSCk/Nz1LMvpe/K/BAIJRHyHtEY0Q+TZ14O7q86W3O8CYIasfM1solQgJsCGDYdy++c
	ruBcFR8GCuldxReRytst1zhjf5UMRNvhqXwaao7sGrFmzFnSByg9tL9LWFVTBMyLE0LeET+lBZ2
	Y/uwixy+wcejb/h5FbGNRXpzc/5+z2SOP+trVE4LSJBOthNOHfRvN3qLfIY0Vv6qy5dv+yg4EHn
	KvTiZmGIsgChF92aEMRZxFzKY1UUq7ZAj7fPSymU93pKToW6P8wPxwPTsg0wrkTwMQxEl6fT9eh
	fL5stVOkIn+z38NUAquoo1Id161kpx7rU1OJHtvb6TKySarFjEGS1lbssbDBPJ2fJhz6vphg==
X-Received: by 2002:a17:90b:4b90:b0:35e:3b08:8fc4 with SMTP id 98e67ed59e1d1-3657737bff0mr4022027a91.5.1778003243244;
        Tue, 05 May 2026 10:47:23 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:22 -0700 (PDT)
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
Subject: [PATCH v3 09/10] iio: accel: mma8452: Use IIO cleanup helpers
Date: Tue,  5 May 2026 23:16:39 +0530
Message-Id: <20260505174640.3998281-10-sanjayembedded@gmail.com>
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

Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release
direct mode.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 5ab981481599..3bc53cfdac24 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -474,14 +474,14 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 	int i, ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (!iio_device_claim_direct(indio_dev))
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
 		mutex_lock(&data->lock);
 		ret = mma8452_read(data, buffer);
 		mutex_unlock(&data->lock);
-		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -490,6 +490,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 			chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
 		*val = data->chip_info->mma_scales[i][0];
@@ -756,14 +757,11 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
-	int ret;
-
-	if (!iio_device_claim_direct(indio_dev))
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
-	ret = __mma8452_write_raw(indio_dev, chan, val, val2, mask);
-	iio_device_release_direct(indio_dev);
-	return ret;
+	return __mma8452_write_raw(indio_dev, chan, val, val2, mask);
 }
 
 static int mma8452_get_event_regs(struct mma8452_data *data,
-- 
2.34.1

