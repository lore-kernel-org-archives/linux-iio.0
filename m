Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83A3FBEBB
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432072; cv=none; b=VQ2xAop2mvmyK0P8Hkg6TVW0iFhnv5TFB06ir2SeZltLqZXGnJ5WWWBwZFJlsDM5u3qNi7oWtDe7z9MzRR4heGdL/YR5r7r7mFKNLEbPmGx093cTWThus78MYr5pkSroV8T6QWd+4a13gDUf4Oo7rqFcH1nm3vKFMqsPcXptoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432072; c=relaxed/simple;
	bh=9o1HG7TPq5oF8OHulY6/3Z0/0lfhuIbTOStUmewqt0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fT63ThgrMgYZ9z5dfmb/w+oSziUyryrgEa3H8fOoyqSR9vDqV5t8xGw6UGXrjvYcSqXkkO0DG16cTJ8JKAw+FvZ5N+f8kedDxGrM/Dk8inIENQ6cCp3B972VwFjiWY8FlT23nWtXUXUYFX4uGBu7AyO3ofPzmt9KVuRRJGpSs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df2qMHkX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df2qMHkX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so474146b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 00:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786432070; x=1787036870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0clG2VHFI7ZfgF7/7C6METDrFiRccy8/pvJItliEIu8=;
        b=Df2qMHkXaQYYqBHHcuVoWEzERfPqdZ0biUiH93W5quFpzCKu+L0EeJdIgT0/faUefF
         ETmTq9rCIF3RKbrCw9ROdNK4ilc4nfKjU3pflwqkYgyayCJ/WM9dy5tRjDuHMHteXL7q
         0yn7HGgs3kgPbh/OFnGCEQIvh2+kAHRxgt319t1EZCts1pGsKaXydyF/PaGSQJY6+nTP
         +eWuZGyymiMvnxpeDa8W0weWRUK4nI5u2nh1IqS+hZSXgJbD2/xHyXv17C7HxsqOxVK/
         jL5GEii3XzH6zmq4KDE62e5uDw+t0ugKwJ1ZOSsOSw0U+Syh1juxSQ/KSUwrpHJXo5pp
         sDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786432070; x=1787036870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0clG2VHFI7ZfgF7/7C6METDrFiRccy8/pvJItliEIu8=;
        b=XC9lmHk0f4kHnhfXUfBwBeZDIxWPhhMAtyXuOX7zCOn4P9lycMfHsdQIOcgYOPSokV
         XgR4a5H8CqM2uooQRSmo5D65CGAfO6+WKE4FN+rnxTqT2hgKc5GCTISxz5KMNcFbkyoJ
         z0sIyxrLd4R1ImzsWPjKsGLN6nBiZTn7pv0RbGly4dgAJ5sQzzN033tbCE/rx+ZW1HtB
         xiWIQn6e1CIk2aeUi+i16Wsa5dWMp9HkBhpBaYbMD+gOTv9H8UJqkK35EcVhyIFgl7MG
         aPK+Qt7dIrKf0VaN6QbnRt8xX73ZV72JPf9MRNsl4BNGWnfWOdhPnMP0HNfQZe2XpB2F
         bPfw==
X-Gm-Message-State: AOJu0YyQwxWIpjrHn4GLj6nhQlQaL/eWcZ/ec/Mr3hnUXgWnhUvsRNU6
	2Hm1oRXY9CinPC/V9ydp+p55HPpHYdSj6TlkAPVdWYmQEIH1ywXnKjaE
X-Gm-Gg: AR+sD13d6nSA4Uod0qJLVXKa+62DPqBT4xTYh4KhTX2BY2d6GcvjbkRQ5D3TkrQbfxw
	7f2LP3kJQRSQ2Du2BTVcmhLuZGBno/wdOQZ+PQuw2Wi0BvsJXcSUjivzDCSQwuoRj7Cb5w2m7OK
	7l8LVc+Taykar78eKUegpqKtL9cfWOjzxYkD523zuLIxbs5J1psDPFlV0PCCWX9zl3Myk3M7su8
	oQqhwlKSIIQcJM7tQjbH+cXPxiWCNH1iT39MjMq1dd2+lN9urDxyYo5n3G6nJHTJLXP5cTof/xC
	3sz60QTqnbGtgQHWSOt7gbxTFNwvSGk5Bn5ENa2+m0BgPxCnBSpvDPOQGS/FHtmexhPien6NOA7
	FDSeVjXfc7KdKqihU5cOZG7BerbvbjRTVrm6DxpkQ2J78UYx2jIw2t5+NaEk0uWH2N1I/u0vX0H
	xkcTKwe6fsUf+tV3cWtNBMa8s9Z0z/AZDLrJaIGQpFF46k06Ukq2LZKnJlxF36Ugq/TdMqNzSDA
	JdREXiekcI9li9bTfMB3b5GsW44
X-Received: by 2002:a05:6a21:3204:b0:3b4:8ba9:4d8e with SMTP id adf61e73a8af0-3cc2ba44057mr1749846637.23.1786432070171;
        Tue, 11 Aug 2026 00:07:50 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c619d0209sm1765052eec.5.2026.08.11.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 00:07:49 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Tue, 11 Aug 2026 17:07:24 +1000
Subject: [PATCH 1/2] iio: light: vcnl4000: use correct channel array size
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vcnl4000-v1-1-50e7fb657692@jacques.com.au>
References: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
In-Reply-To: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

Use ARRAY_SIZE(vcnl4040_channels) for num_channels to match .channels.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 128ae3f94074..663e623da833 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1874,7 +1874,7 @@ static const struct vcnl4000_chip_spec vcnl4200_spec = {
 	.measure_proximity = vcnl4200_measure_proximity,
 	.set_power_state = vcnl4200_set_power_state,
 	.channels = vcnl4040_channels,
-	.num_channels = ARRAY_SIZE(vcnl4000_channels),
+	.num_channels = ARRAY_SIZE(vcnl4040_channels),
 	.info = &vcnl4040_info,
 	.irq_thread = vcnl4040_irq_thread,
 	.int_reg = VCNL4200_INT_FLAGS,

-- 
2.55.0

