Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B73EDAD1
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407005; cv=none; b=QoEhZUtsGlFPjTR5gm+UfQnq0K2PXNOGQqFLdGZis13Bujufke3eTBILDzSG8G0grbX8+5ArmPhxVElcqxFn/co1JDO35e5fb9UlNHiEVDLM+D6WlhYz5wWxs5CLFTvt6Oj8P5/l+3+Mi/2Nr1OFxNGaNZqanRBbyHWWuWa1D2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407005; c=relaxed/simple;
	bh=n0Gc0hfHQ3dPC6EJ+EtDsO1JzSsFbQtFQKtlLtnRfH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9P2IiLxMSO6wGPPqGX+/ITkBr998UMZfiXx6sGdol5mEmUmGpJahdf6i8HlNUeXkl5BgI/6YJiMPlkktk8KckRtpaOthTaLLAgwnXc4z/j7WozadjdWnx+xW0E6z4RA1TPg4DL79js2Bz8w+e3Vebh8vLTVfgi6SURFSyy9cek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/QuVkRk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/QuVkRk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso17798485ad.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407003; x=1781011803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRawE+03HLqYe9WWPeYYzo+Zy0xXNfsx59H3U6+0IQ0=;
        b=a/QuVkRkodFzElxbiBiC0HWVckXYZrq7lmU5oPf71PRpv4bFQ4DzmQkRsHtpDntskL
         9Qa27JiB08WfdL+RE7MsOSoGP85C1nkfxjKb6BqQQbj7bxryf8HridqKwi1jDSMxvGHD
         o7vn5lAsnU4DkGiY4msUfkadvqRpFMmBW4rvrCeeS5caXrXel5pL1O2Lm3YsyhuAYOBb
         CHCxQ3o0EDMGA9AYsL6ZrKjbOoSkwkHMOcKk4YhYTJu1d3A05NPOe/yYzXXdn8nqW1ud
         1FiObD2y/2uUeSHLeYCsHPJ6QvsBaeexPjy7S5qJs0Nqd9srQJ0KVquUvuLhj4TydEOX
         nx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407003; x=1781011803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GRawE+03HLqYe9WWPeYYzo+Zy0xXNfsx59H3U6+0IQ0=;
        b=V92ecg4UOMUfs47JA9ZOlj9NX1AFOaZ6SuaB+QOpywHEIGkGHUVC5ajH0uvlzl8hIM
         5vvn4vgdSwvToLH7YOvVuVm6Ras8wBHtKJFb1w1G0m9MzoHfgs8IFSYfailSXpBHfeYh
         c/bXGiyzSy7j62Z1KiYl2ijyi+nbI2HMC9EWG2mZEj/uPvXw67Io6JcfoGYxIQFHyjA6
         FOL0L58o+CoAs2Ww0GqQtPFNOPocIAQOZfcjnIlYj8+4pOQQb84+CRoVnKwi3hNzlegJ
         cZUL1c6T3lWts5OHMmhag/ocNLCB60wFGKMMrvTz58d45x2ORldlH74PVGnlr6vyAfUQ
         9dwg==
X-Gm-Message-State: AOJu0Yxb7b+E6DU4BQfgJyQsdjCDiBcc0IzaGqjo2VmKzp5giAOVzobe
	tidk4g1qoa2W4LZ6L9HwO57E3nsxEFnwuwaFo042V3FCCG0IjsyJzwJRQzB8kw==
X-Gm-Gg: Acq92OEmFBfj4FCDFzRNrOwt1g9vCr2c9Bavj8flz8ZeEBBjdSzyhUptPZSESTufnE4
	RlOV/DJKdeoyRj/T10jWogU/YmWlV9DlzdvwC4+A8/FzhBirDxXSyCYDxWxaU/JvQW8EBxc6vwz
	51PIss4ACmhzs+KwfWqaNwXtb5tsv+zbgFgw9eFvrQKSAgPW3oGDK5B7dePlaIAoBFXNF8SE4kq
	C+ypEtiRvR3lCk1/k0/6+zBfBCs9bLS6x24nsV9khb2K9HV+tML4dF//zpC2FLG2gfphVyiDllJ
	7Rpbs1fZGbHjOgfpH5Ild8zeffVurmvTvRXzxHnNUh0Gzn2vE50W89eONCMAtYAJ5sODgVxYqEa
	QQtoRYgiKIle9fdRKMr/Cxh3ngtHwElIce0/pGTvMVs7vBNJ05VtxlR5l6I4Ck/5EDoTDw4JVMs
	bVIswe8YlvCPQjtkA4dFmvjd+2EZ/MLE2AyeOVEJHccAzRVBOsBZdOCCBQ06E=
X-Received: by 2002:a17:903:1905:b0:2bc:db35:96c7 with SMTP id d9443c01a7336-2bf36845822mr177128685ad.28.1780407003393;
        Tue, 02 Jun 2026 06:30:03 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm148548215ad.33.2026.06.02.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:30:03 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 02 Jun 2026 18:59:25 +0530
Subject: [PATCH v4 4/5] iio: accel: mma8452: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-4-26d6dff8fc55@gmail.com>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release
direct mode.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 467e42c2c0dd..85dfd854e2b6 100644
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

