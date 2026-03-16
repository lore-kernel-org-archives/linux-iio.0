Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F89339878
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682163; cv=none; b=aEwaT+YV7Vjcj5fTJp9J7+xyYgejSonCvarAGYrfEMUqWkc0Kz1R8IcnazPqK2fhmOsjO0Nf3oBApuPxXTD20pLGd0KrSzxZG6p/Ynpbb7xJx5vkpbyK6vnIQzTzlXcOz1Xq43D6EIMwtJD6Vnx4gWLfQMrcY3iWIRr2nxJcZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682163; c=relaxed/simple;
	bh=OTVBwRxD1P+EnzFv/5Fa5libc2m+tby936h+j9EGteg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTYfd18ITon0tvYhPbct5vpuFs547Lp910MbGqLId3ccKWaDPVFfYi02LsHjMQ81mK4XOdRyezEUpVv4xlFtUFqy2rmWp/3CiJv+DcghxxKmpCAxoqwSjDVflhXRpTgxany4YuGF5QOz/dweAGTKHQST3hOIE29PSxJQaIKBX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOkGjA4A; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOkGjA4A"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8299f1ca894so2476774b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682162; x=1774286962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU1JH0J+NqRFBpsmOutLjdRFE5dZi0QzTqc5wrqGr2Q=;
        b=lOkGjA4A/vI2qmDD2WoNe+1rSxiXNDzd2RroYB1GwFwOlXIif+fa2sGW2Ri/PwDnJP
         adZh9cPOiU6VZ56sk/+ofZ6uvVJt8KVjWFnKZvvIrZA0NEudUZasUU+Mx9cUvLsHpqAR
         1P1FMdm8v8guGvcgHjj5xCTCnrlfV/qN96WbnRsLXfglI1Pxc1MynisbMZWjkt/P8bhY
         qAVBy9RiAxzn3+2QH5LycQ+Hrz/x+mYHe1Ait1DGtD2wgcCAxd8JXGAx5rEMC/JG4/GA
         fhFcY5DgjLvzFheBgCDRnHNvK4zw3+0Z2Rxg6CpFvk+lSebf0UnE4Ql52lboDEtgCAG+
         kPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682162; x=1774286962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aU1JH0J+NqRFBpsmOutLjdRFE5dZi0QzTqc5wrqGr2Q=;
        b=QorCbD/tco4rO1bdvKOAagFi+XGnYwOjzwgrP9ZKuMulZ5+hooAMMMBKcYJvylBeZo
         QQEdkJuhXxDj8MBhITONfjPbewhezMEN6TSjfBQT9gr/CUCSE3yjqiqJJZKIq1/bqprZ
         TxM38Ap2aMf5Dx0M4WQRrAFXvCQoS6dx24x3Kznzd4FGfPDuTImYaP5BUoCcMyHLmV1h
         j/3WrQ3hEGqj8UCan+7VuQA6BaLYfHW0rX9BNLx05VLiSbVCdng088S4SdrxV6+JGK/3
         KBVSHUgseJjMLjHGip5FRjrRGk8GDp0HgVjla1nRycAQxSHTHaajx6rVKbDn0XqnmFGC
         tm6A==
X-Forwarded-Encrypted: i=1; AJvYcCWfrs2dVC/WbJezALujV4n6uypK//VTmJ5buFHLSwJVG0mMM4XYY1ImlARe7hyd7hwE6bKZz/kFgMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkmcVK3u38mklQO/BTmy8EmIogJwvCaG97fJlzDzgA8pFcB4m
	UdEh9IhHsf5yqBn6hPNpvKIUUumQf5iqq8UHyx6uPDB/Y2jT1uTesodR
X-Gm-Gg: ATEYQzzzPrDMfdGnsUOaJVRH52eLa/4cUZ5pvRQefN4OB6yQgIHhG6LkMqduftG4sbE
	Phj3ZSRGwh2/yg4zx+yZDV+EwxST8v2ROxxZ34/l2IN/8ptMQ4wKTRvkzOIoBnfypEFE4QPDQZw
	izoEBDd3auaZk93Z51EXHO4yCIVJQFX48Z5xVtNA+i3/XEaeqpRoRlxNa66lh2+rsYTfaPk7kMv
	71vWFUKduPcK7geq4DmEBo3SVMesI0UhKZMnpnf3f8tERl3ug3Jn7HuM8FsZWai95W2AKxayC21
	pYh3KtaQpSHwyv+CNU2axKSeoX0K7iiKuYAfL6JxV40bf/0Z5eTFgi4edJOxKVs7514LC/hccP9
	d3UWMUJENpMbKKu12BrIEpgjLT3AY3rdAsMw03qnba3lm7KszhqMXztxtPHAJ0oGRSGr/FwYpPW
	rYIXbmGDPYyJwc0eaobHZp22jLOaW1MDc12svhMr2Cqdm8zGUpPSfR2PZVjbB9bHkYTm9/Db/BM
	Mz8
X-Received: by 2002:a05:6a00:a88c:b0:829:7e6d:cf12 with SMTP id d2e1a72fcca58-82a1983e5e1mr11478702b3a.18.1773682161761;
        Mon, 16 Mar 2026 10:29:21 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:29:21 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 09/11] iio: adc : adc161s626 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:35 +0530
Message-ID: <20260316172735.11430-11-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/ti-adc161s626.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 28aa6b80160c..88f2daa99d66 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -119,8 +119,9 @@ static irqreturn_t ti_adc_trigger_handler(int irq, void *private)
 	ret = ti_adc_read_measurement(data, &indio_dev->channels[0],
 				     (int *) &data->buffer);
 	if (!ret)
-		iio_push_to_buffers_with_timestamp(indio_dev,
-					data->buffer,
+		iio_push_to_buffers_with_ts(indio_dev,
+					data->buffer,
+					sizeof(data->buffer),
 					iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.43.0

