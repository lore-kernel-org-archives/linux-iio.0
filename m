Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243401E832A
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632520; cv=none; b=qJbCwcKhyvJI1Jt2pwYTYHlQnZU6Yxw9wW/AkKLeQDt9+BwvceruIdEfb/jjtdWg9XfjndrOgjr3ug6psj9wed9+7aK5RW3LimCcDHwXKY/VbBHmCbM8bKajMVmDf2yKAQ0/OPfirgbnJRc0rJAJqmhx596FqUo4GYUwEviMKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632520; c=relaxed/simple;
	bh=vNRA6J2+Nh5kk+8wVzqvkREK5Nenp0Br7khYY03UGDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4MY5EbJ9xl4PTjQu1dO9GeLT9lALQXCingJFb1Q5jE6SihPSyZ/ftMj0qfBcK7Bnj4kxgvttKOEgN4G1zG5k8tyLDqOGpzB0DMgDNxbXYD8ieavKG9TRdcKaP7dz1hQuWjkh5cijpS/cqpLY9X2Sn7J7iSjMKA1VGc4CQx4CX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=JlMIJstp; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="JlMIJstp"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso6986603eec.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778632518; x=1779237318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xVaqx2bA0uX9Kc1Awl/FAoEiMPC51tiJH6XAaQB8+g=;
        b=JlMIJstpVfmAa9Y8CwvNa3Wf2UvcIW1NB1pn8dDpl0r6D7lwfJwR5xvc/dmdP4SRvO
         D7QadDkmzmy6n8UpX96+1e9PVWUnt8RI0ZO7sbn4aXrn7Ex4tB8HEwafkopUn75tU2nn
         6EuTCDblLZHa8uXVAtPV4ifhwf9ig6hvgQjS1EOEqFUDGgZd6Knkn7Xyc1EK6C7XOTWj
         9UL3PA8nu3/+fQhbjFfB0bxnGL3hnkyjGCdT2+kmHHlSLyFpGQ7JszmBfE8xk1VU1O9s
         3Rsj/hRQdQ4vRgO8b3P2q9QHvUCoOmPEvXrwk3fL2TeBLs0pvjOMeJ3D3AngLTJJViTH
         8YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632518; x=1779237318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xVaqx2bA0uX9Kc1Awl/FAoEiMPC51tiJH6XAaQB8+g=;
        b=lDhiiQgLp9uJkU6dRcH1MwA7XTs7pG7/m3cTKJ+rNIHsy/qdAUEvc/WNiBDegHCBuf
         whz+NqQ8Wz92Qyjo0J25xjV6yN2mQA43IjYb5RuCoH50le+DEF+j5hg8teyfmXg1ThH/
         S4ZitQMqMJsir1W1InapksnftrfJ3L246DP2dDYipY3AOTGsvcVk2anVidRtEg6gOIGK
         s2FkUIM3kt0JBlRu7+IaHeF09O96DZio9/BEarGthjK+tYSummx/TO72z9y+bg8aOXAm
         KeBXhZcTLyW4ebpABiVVz620EXKEwB94We1cwQBpWKZL9QWL9T/3ppkmRjjXUUAA+gt+
         C4EA==
X-Forwarded-Encrypted: i=1; AFNElJ9iDMs+wFEzx8FByL/gO1KrvyevuiZsGazgxp4IdLvWpHsUZr8ksu08+pzQOr++wpR/+SSV+2ehSj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6FPwXvcQkmNdG+NA/N+CM+ntIhoVWiYvbhid/ICictRvKdSw
	GFMDz3b9lctURCDu38Bd5+TquovEEUR5ykTVczY3tqfSGA4B7OMKKs3K2tbxzMkk5s8=
X-Gm-Gg: Acq92OFFTGry6E6HCHZYrmff+IFn27aL7giMApaB/uRjmhXKvH6anZ8S+5S705JEkD4
	qZbsPEk1wzhyNvje7/ctdf8HNRKCQnxJM8uV4IE57ke3sOe5ly8resLvYTUl+1wIHkIbwlSsYex
	bgq1kH1AHrLWe5o/kRgo0D1RfB2DyR3KUuTd7gCgBrNIGh/1bG4Q2Mg4mKtbaETkwZuQQNFl5Qx
	xSoGJ+ghrKytDOIe3/hXRQ2mv4tTjbVDq0DmBuiaDKYjRKF8GyP37jyaPD0BCc22WPcArq7q5yH
	fKqnBI3AYRvYpv+4HtoCqVLk5cEfE2vDXtwHSEmeUslltYe5FUAb7fhh27roRq6eaRSb4XNlfFX
	89ViqXt90CU/Pi/jHPgSqM5/mY8aB/n+Vgkefonn7VoOvgiWunz4h7kSJLpvT6x1nSOoGH401zX
	3Tau2SZnzHJgzuj8/R2GmV1T1W0qlSGnkfjrzxACEBppORqw5B3mByWgDdkWj+RmTxwd285rxm2
	5/0YiEPn+NmUehy67K81rDlVOy1GQUokBZqhlqtqs5zpRQQ
X-Received: by 2002:a05:693c:3004:b0:2ed:e14:7f5e with SMTP id 5a478bee46e88-3011a465fadmr816322eec.34.1778632518216;
        Tue, 12 May 2026 17:35:18 -0700 (PDT)
Received: from gui-host.Dlink ([177.140.77.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm18471381eec.0.2026.05.12.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 17:35:17 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: anand.ashok.dumbre@xilinx.com,
	andy@kernel.org,
	conall.ogriofa@amd.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	manish.narani@xilinx.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	salih.erim@amd.com
Cc: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
	Jonathan.Cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handling
Date: Tue, 12 May 2026 21:31:50 -0300
Message-ID: <20260513003503.339418-2-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513003503.339418-1-guilherme.bozi@usp.br>
References: <20260513003503.339418-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_event_to_channel() may return a pointer past the end of
dev->channels when no matching scan_index is found. This can lead
to invalid memory access in ams_handle_event().

Add a bounds check in ams_event_to_channel() and return NULL when
no channel is found. Also guard the caller to safely handle this
case.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/iio/adc/xilinx-ams.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 124470c92529..6191cd1b29a5 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -871,6 +871,9 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
 		if (dev->channels[i].scan_index == scan_index)
 			break;
 
+	if (i == dev->num_channels)
+		return NULL;
+
 	return &dev->channels[i];
 }
 
@@ -1012,6 +1015,8 @@ static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
 	const struct iio_chan_spec *chan;
 
 	chan = ams_event_to_channel(indio_dev, event);
+	if (!chan)
+		return;
 
 	if (chan->type == IIO_TEMP) {
 		/*
-- 
2.47.3

