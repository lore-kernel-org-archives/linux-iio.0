Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3331197C
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451255; cv=none; b=AKrJRpOeo9a2Lmv2sY/BdqkNa9plcs/aitPNBwVcKhOUIK6T5nHMK+AUuh0GamODg9v0dIkMFrL5R3CuMe/4cGv3xR61SrGwWmt4pMvE8VA+CpX8BiuFSzDtg/Pkex0/QmV7ajq5EBayh6EVqRPzCrYceqslJ/343KKPahIZY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451255; c=relaxed/simple;
	bh=hpE5Vsbf9t5iVAb4kHKXf/9owZHyCaVR6KqAE6VTs9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovgCUtyNZ7+HGWjvyzSa0kUpksuOUHDlFcF/OfTjqHi1GjeLQlTNMA4WaezJcIcfNyHbyxKsns8mJDZ9U8nfTSasPMHmC9ceQlN/BpFXJJZDtMBL/MbOTe9Z/orYun9w/btLBMqRIUUzQJvKvYstDhrRTzSEAMRUj+eg1a70XIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZQ2QqDw; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZQ2QqDw"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c307937816so3203037b3.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778451253; x=1779056053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZRrkoNZjQzi2GzrL86AD7mqi3otWHbggrliupPYnT0=;
        b=eZQ2QqDwMY/8z995NNVbcF0QnE4L1Iz/Upd1mJSxqwu5HUVe2j+pEDMLENaSqrTtuS
         7TkkTuAi67HuZ7WVi1kD89LtZR3cwKpM5gHiqdMlsy9Dg3IK6GxSg/4ZW6hFE5Blu8J2
         pOYbCa5j8sQ++hnp50u9CqZAyIwr4a7xuD4XZkj338AaSAuUEN2o2wJ7ID85DzEAt660
         C3wDMYVUpZNXk87FSYVji6aT+pM86kFtSUPTQ2yhd9b2bvwJu0PRaR9V6mWlmh2DyjnN
         vDV13c/ovFazl+ij/k79UvZTlbN6uxyTVwxg/tYQxcmT0sFFffIXxQSpMb13VZEBvIFJ
         qEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451253; x=1779056053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZRrkoNZjQzi2GzrL86AD7mqi3otWHbggrliupPYnT0=;
        b=ZIIyYCau++OLI1WjjUN3aLyBwi4xvm8lnzcB9qoySXF2SrPHgN6oFA9BkLHt9omGyG
         HhZoy21dfyV0TEDjsWxxa4l7anSTSEMWU3U7tDyQGUmNKYlJp2dreBzSg60ug0w+rBDb
         R9MPb/kq8Aumc9S0sDASVhEL2AZ2FJPuR/UMHAzYqHt0mio87GaHAFaPBul+uL1Htbag
         23xjQ6i4aQtEjhWNLmmeBqZckYo5T3BxgueCOn5jGZYEworC9ui1sXlPM3JZkGIeLC6S
         WTOnejLVQJ4WbU4Sz3OHVSuqow0LtWpA9o1vMMay6eIUkXya6pWcLxkZmPnGmVHZcsH7
         1bVw==
X-Forwarded-Encrypted: i=1; AFNElJ/jUDxcjxaRpMfY4st8Yh22vdW6+E+lUWbtfexmXnZaPBnW4yUw+/GMX/juUn8aIKU/5sn+YidIMfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdhDUw/RU/CxmGE6tcsQI1gnbMpmfo1hBpDC/VmEQi3tAkce2X
	u3zEx7f0XI/+otg1sXLaT/3NbY/1jjle993c+llAfWqH777gSwudd8It
X-Gm-Gg: Acq92OHBvr2pmdtUF1EG+TL+T9hKyk4HQdGlF9r3VSD5in/79gbSrZJ05ExAiA4kTcS
	9nov0Nz3Ce6VMbbJ/X1FArlCDZznFPdgcimYA4mXjt2xsYePYtxQqgJqiK0tzDadxLyME99Epon
	c7lrZlNvoj0YRpaZSgb0RzH7KE2RzfRw0AT7LEjSx5JfsXz9de+6LJw6k3IM9shqMgeeUcZN1/I
	otMLE/g9VnSZKv6YIPq6uN/BCar21Jx2le0QlIShQgy8qnjHV/wgqj+AuX/peWkZxCh+eLxaGPQ
	Zpljte/dx7+nJqfPjKN7zK+/BBcNbp1+Sevv/Q38LEfYcg5G+eByzmKj1fCfvthTa4bQ7OrBSmP
	loVbRA1PKdWDksXJC0QLUZq3BuIPJx1/A8f/iZDBg4wb5VtAtKMfUFpxD/dYymOu8oeKVVTC74n
	slCfZSRPxNlzENWGE0/QSN3gwVgBaQf+PUhcwx/PPHoVFmSJ6FCIzUhLqeMmRI1qSsBSRkbDEGJ
	58pJ7ULmBydWU7srr8/Wy65
X-Received: by 2002:a05:690c:60c5:b0:7ba:f907:145c with SMTP id 00721157ae682-7c10557909emr81639587b3.33.1778451252843;
        Sun, 10 May 2026 15:14:12 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::111d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665298b4sm137761767b3.7.2026.05.10.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:14:12 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] iio: adc: ad7766: Update to use iio_push_to_buffers_with_ts()
Date: Sun, 10 May 2026 17:14:04 -0500
Message-ID: <20260510221404.22834-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old ABI function iio_push_to_buffers_with_timestamp() is no longer
preferred due to it being inherently unsafe.

Update to the current standard iio_push_to_buffers_with_ts().

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
I asked a while back regarding possible things that would suffice for a
GSoC proposal, that has came and went, but I remember Jonathan
mentioning wanting this to be done. If this is correct, would a series
be preferred next time?

 drivers/iio/adc/ad7766.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 9e4a66477d2d..4f256ce522c2 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -74,8 +74,8 @@ static irqreturn_t ad7766_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
-		pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, ad7766->data, sizeof(ad7766->data),
+				    pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.54.0

