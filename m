Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060238BF8C
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053160; cv=none; b=WVHfruRfjvNxtQRrGtWbZXWT/86Z5owIPxIB4NynkPVHrklJPqj1qd4xirP1drLoKu6VSgdOSi/5cTksNCx4zNb8oVvJ5ITuZURdbe3abxyboSLfsst+f0FL+jAXVGcOvNQ1u/mnXloz3bFzAhHUPBwU3DVs9ya7lOyUKIvKvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053160; c=relaxed/simple;
	bh=O4gEiGCc2XNjPoD7AuUrEV6Sb+osVHVJP1Y0aAA1tTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6xQHVoH8/kT5UL2LWbdQgKlOAJUtUbw7QAPTRT5HLubs8NTGUDpTh/lB4wicyKQJ7XW1cKqk2YYI+ITmAc+q1wzbladIYzfgEJwmAw3QiJEvqscvsPh3Bv+d6L6UHh27Zz4Cx56suWky7OtPdRaLBcmfW29aCahkpfZGCx31ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx2ImBX1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx2ImBX1"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82984c077b2so1859674b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053158; x=1773657958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5Q6JH7ir7f585HJelVMQPjjKIMWEKALemlf2LRjXE=;
        b=Zx2ImBX1psfYfOFA404Rqc5CPwA+kSKl904DF/JxnW7zICSZUpmsuLC3JPsIsPgQmk
         1+m7nqXv/Ms8Vv4RYzJrDI/OLRKknHObiwadTbSMWyb5Kp1Vi1bHgUoH0YOTy2n5PloP
         0mW51ONcdHgXUJGxC3gtOsweb9M2jNsJTs3r6E6koCnhggQWvLtu3HUejOEH0nv8bmoH
         mwEpvgrHHCQI9mjZSqCgX0T5c9Up5aTNEVOYtQLZ3dHrHjKaGNhCEDLy8+PcSvxHO40s
         Rki5oMTKOyQ7nkx9VJg6iFpkoF0MsfFpe4i3weuLDbL85ncvzEIMNj7T1Vd6G92JNOiM
         Hldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053158; x=1773657958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+b5Q6JH7ir7f585HJelVMQPjjKIMWEKALemlf2LRjXE=;
        b=II4NOmaY6IuCsC1qmbgjovAlf67ujkhP2rKmOjIJ9ugSkrxAupfO2ZJam9laWLqRAQ
         fTmFJf6NxMZbAXVFpVkj7h8aN9vPdQPytUYeqHPtVuF2NRjYx5cOqLHqKqg807DnPS6R
         rFYtMG8Io84jmsrffMcn51RHI0PmwJS2XyHETtiVppILiFDw6mHRiqQvOyy9BLcoTDwW
         LVqdo/3p37dubGB8xJUsE/8o/NSvdwZmIirWpO2+wJWJRFTvrD5MOrx0UD7OD56PLIMT
         nFrtPj4H5Lw19eDvFkU0hjFkzH3NIVhNyYGKq8siGBN7gtTG1EoTWkMDT1NfGEbUziG1
         523w==
X-Forwarded-Encrypted: i=1; AJvYcCUvVan/rvsiEbKT22niHsOcXqnfN5iaotdfPmseLbPAWxlr6+WqHcN1VIlLGVjlBcq317+RQKaJDB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjBTrV3LlRzAR/KBjAQM2ai0JtjPwGjmEGOkbkqygJ7lLkHaz
	ycuOZ0UdAghSr7lUAyK3yoPKankpmhalgFtAwslruaaYhNoeOF/qDSZK
X-Gm-Gg: ATEYQzxEjG1z/Vb3rjKE2mLHl3CfLJtCFGpN0HK0JIehh6SnE++0MGyWJ0wG98KZGoR
	tPXufStou093SawguXS03fxMD7tJ3DfqSJhJN7c2dhFC0ruLmI8GRwNDBCIPjoWtTvSEGzoOrnp
	SW9C5Ym8VH3mV3VBlmoHH580wIn+KNQAGWFxy13ZOgZR/8uobekmFAer7AzmrJjCSHPzoJ0ZraE
	nNFNWbjah6hI4yeb5rC8K53Xlhc80sNOSmFZIY+dP06GwMhhX4zipxZdyFY3Dy1oLNUMKqRzm53
	lo8IlQqeDZ582RJ+4yZrak8UTzaQMKFwn823nEEWDc/vdiMl8yHsq8yz6THDvjL8x7BWvqyrfdd
	zNVZYSlUbAAVyFmrh4WvNQFzZZfb07s7N+bv7xvFd0WFgaLeb9VoioXUFJQd4JC2j/6M1TlXHTv
	642fMAPlIAc/xKuy15JNqWyATn
X-Received: by 2002:a05:6a00:2d89:b0:81f:4a0c:c584 with SMTP id d2e1a72fcca58-829a2dc04e9mr8727258b3a.1.1773053158592;
        Mon, 09 Mar 2026 03:45:58 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:2ea1:a1a7:f2aa:545b:3c1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm10276143b3a.17.2026.03.09.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:45:58 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v3 3/6] iio: amplifiers: fix typo Curren to Current
Date: Mon,  9 Mar 2026 16:15:10 +0530
Message-ID: <20260309104513.40359-4-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309104513.40359-1-i.shihao.999@gmail.com>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix incorrect spelling in comment

- Curren -> Current

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/amplifiers/ada4250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index 40f396ea9069..71e361af2074 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -109,7 +109,7 @@ static int ada4250_set_offset_uv(struct iio_dev *indio_dev,

	/*
	 * Compute Range and Voltage per LSB for the Sensor Offset Calibration
-	 * Example of computation for Range 1 and Range 2 (Curren Bias Set = AVDD):
+	 * Example of computation for Range 1 and Range 2 (Current Bias Set = AVDD):
	 *                     Range 1                            Range 2
	 *   Gain   | Max Vos(mV) |   LSB(mV)        |  Max Vos(mV)  | LSB(mV) |
	 *    2     |    X1*127   | X1=0.126(AVDD-1) |   X1*3*127    |  X1*3   |
--
2.53.0
