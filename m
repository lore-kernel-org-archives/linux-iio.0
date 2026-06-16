Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5142B742
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605622; cv=none; b=IDTO3WRcKSFcwxKkVKPxbQSGzeO+V2080Z7CnMHyudnWH7C9ahAWnmSmnTsN1IiV6ILn5j8letkiLCFhTwM72GIFpft47+xWCdgO06zUqsoVpWaiqZVaioXqN1jrjeUsMqDbjF35QIOCQlnK/8wF9R7Lc5YuYSsxkU/zDydl4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605622; c=relaxed/simple;
	bh=b3q30hN8/8zTi8xRwokSZ6zlcxtUNegwQuHZnD/20BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODXD3RwnFteL+31kvKe9REmaUXpR07Rc4Lp8jS7HXzMTHelS3tGYXkQNNnMgnsKXpNh6xFniLTaYDxIQ5ynz0jo8ql9RcXFDXSxX6M8zpWB4xEhIB9F9M9omLh7ZgnHgJyprdLtMPHoKFb+GcrJ4L7DT+dErtRkc9ENBEzYA+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/Z9ZdXy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/Z9ZdXy"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so3109919a91.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605620; x=1782210420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIpkRPu/+gZceoyeLzf2KDGQKKvzitCGsNedMKc2VSQ=;
        b=B/Z9ZdXyGZIxs6xqJjtY70OhytMFXhWngEaJj3zVGVg5SWYbF+VWTeEzzyxwS+3OMc
         VplnEjdLA+fgq8FTPqWAUQPpFpJ9jzS1Zh4U91IPwZ0PoOHljtF5gjRTqollxXuR+8b2
         Gto4UAE9eG1ZjpshJGu8XQxMHqS2GGd3/EoZ5+1lf57ddSmEWvZIZXonWeuHZ5vtCm4e
         QCjihZVKnMLbPZgr91D17w91UlpUDNjhOex2GhksD19qh6oWd5r3tko2HSnDZyPAMX1F
         JUi13Zw1tcOVFhChFfHI8o5icyVz18lcpPqQZ5Jf9HKyIhTm+Lq+9+sfpJZQyYBNfRVt
         ydTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605620; x=1782210420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XIpkRPu/+gZceoyeLzf2KDGQKKvzitCGsNedMKc2VSQ=;
        b=R1FQ4mVZ9HVaV9VkZVkQUrMBFokgAPLHs0oZX3KU0bbaXQuzqHpaGEQ7GoEOO5BwpU
         JkuOrzuXc921D7u+oCpIRtFsbhq/alKS1/vb1YrWlJDCxxvpHCxcbjDFO80yzwsl3Vvx
         7O+roTRXVnbIEBF1sbbLmoXFGiaErlmFSwkOKXQCBrorAXY11680e7tWZwJXpZ6UQAat
         qi8L4NOEqxqsMlwr5KXZJbit2lV3Z+ENJJp1VF7/jKgpfH+N8oKFWEgTnF3YJlMyWDgl
         JXvhslYKv29GXV+I14b+xC92S9WDwy57hT1+VKDhTuaX/p1XyUalJLqwe//hLJkdteZE
         qdsg==
X-Gm-Message-State: AOJu0YzXyPT0ONNd4KkFBPc1mIvGvrB1u94xg2lxyPSx0iYCs9EMMzEo
	gJwz8b7gQCwoLzZoe6jXx1hhn3zfXDq1VrD/I98RxYYYDYfQbVMGmS8NX3pDMw==
X-Gm-Gg: Acq92OGLClQD/pqS9ziTH6IEJnSNd4O4p5VSfY/7U8OzAMfua5JZ+14aTQuX7bt1lWw
	mEkqXXVBwueH1LATel2p9pzStXRUI0Ug1xePhgcFrJA36+yIp+6dhX+RhYcwbxmPMCCQCOMGPku
	f+eVpWq+iChmWiyhNMAmABot4s79oHEQO8/qTxR+M0SdVuh1H8jSrCEP1wt/T/jdsGTkpFQrWbG
	Zwemuou++h7EHIWQaIXGgnuv5vqkeNw5+lsNHY5Ve86/NRt3i2VNhxsXhW1u2EenCdSSX9ZmF2N
	NxASJdc2TO4h/3CkFeg5qnO3Yp006vvr7TCg6HiHWIaOFVArbkwXVBq9l5XbQaTtWIa3HP8nw5B
	llba/RkQ6atzKHWM+yuNJaMLIz1KfiZ818L8/F34dsXRihdE5QQ/fkHpyI+N4qLVhhR6BKEI3IR
	1XJIK/i/BgzsGQ9iQHv4ertORt/Zvj+uwR2cf8l6p/e3YAuHXX
X-Received: by 2002:a17:90a:6502:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-37c607b3288mr580665a91.0.1781605620467;
        Tue, 16 Jun 2026 03:27:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:27:00 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 15:56:12 +0530
Subject: [PATCH 07/11] iio: temperature: hid-sensor-temperature: use common
 device for devres
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-7-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..31ebfd1a1fe2 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -213,8 +213,8 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	temp_chans = devm_kmemdup(&indio_dev->dev, temperature_channels,
-				sizeof(temperature_channels), GFP_KERNEL);
+	temp_chans = devm_kmemdup(&pdev->dev, temperature_channels,
+				  sizeof(temperature_channels), GFP_KERNEL);
 	if (!temp_chans)
 		return -ENOMEM;
 

-- 
2.34.1

