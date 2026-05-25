Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54573EA95C
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706340; cv=none; b=hbCgrxtw+hNGHFpCTJ4tRUhT9f4kCAQQkPSgQn/vxMn3Pw4VmetADDOiqyKUFHROutQxWYD4VTN6k9UusBIuT00+MKBSqeDgl7090i+1qcufWbKFCUP/k4u02/SfuqHmyUDKxV+UZfR6Wf7xi9MnAb5P4tVgmstfPOOInlbnqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706340; c=relaxed/simple;
	bh=IyYb8UgF/AKA8+P9d730SEMTu3OzJGnh9mo/jac4tKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbPvbUnW7Pf7OCnkClwTKQyUnXecieenyuvRcXIA5oE5uH0R8ct7sOsZ6W3L7zeLU3Ho5eLpuffpnIffo7pNVVuaK8ZtTfQ7qJLGcNum9LIga3iUJ3LLV+rAOPqSd4Lb5yl02DcZBQ1kj5AqKJY5G2bftzBwhypg4NSFR9GN8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnAlqXMz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnAlqXMz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso6231078a91.2
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706338; x=1780311138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1zPHIbDPv87v1NJ8/Wn8nmreCkN/BzTtCRIc6PgU/s=;
        b=HnAlqXMz4pjSY6XewYyx+fEW2iNHMKa19A7mrtobAQGct3+c2/dfpzMAPOlTVLTqf5
         wcLVtTBfTRBfsgDFXoXHtkirGXI6PmKxPQ7zw2MWIF77SW140NfXxBXKqPK6zNzHDnwj
         KWvChcBCotPknH0DAUQ2ed/gA8imlLki/q05/3iiMSes0vIZ23pJGwk6fCN5/owh0cxI
         jTPGVAu0mf9MbHKviTPgfD4xWV967RrehZcZMaYWDnSd9UrqG9miP8RT+cxYPG4buJP+
         s2TIkFiofmdq5gxVhlURbx/cT1B9nRRfzaKI6AUBcf33ghlVwxUW0CKcw71S/UYXkCrY
         oj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706338; x=1780311138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1zPHIbDPv87v1NJ8/Wn8nmreCkN/BzTtCRIc6PgU/s=;
        b=kE2L/hzrmRSsCxBp3hpVf7XD1oHD1Cq6Xzq85iyWBM0Q8VRunkTzp/x3BDNKTbqJ6u
         7vpF9CJlTu/pfMSKA1QAdcPeqhyq/cY7Owwuosc1qyEt6rOnSQ73igG/AKjQkZck32qp
         uUKAguEqOmQJg3hk3N+ioCKVPbX8lXOuLkBrzb7GnbfBLB/lP0Y3G3UVd3dD4A8O148W
         zvJaKBNXIxuQe6mawB6sIloMo74fzNcvtkSU/mJuDLBfvt6ebHQYGWy6QxBChwRcz3s9
         tNeyEpa/UxFUJIVHUP3o6aAgimG7XoST0LhvFdV0yLXRypzlAaeb8S4aqiiEj2X1+M9j
         DDPg==
X-Gm-Message-State: AOJu0Yy+JCrilsbq7+FzBQStWoQEFE3tK4/uYzFT8QQ6PG6u0RPXFYsk
	qxJUnqOL1F8T1wK2tnokvf9ZvQgiPoImLR8NCkz3y+DAYBdE5FxEepQgPGxzWAnJ
X-Gm-Gg: Acq92OFfGLDZVtR4V55m7Dd6D5q/oN0U+0GXFDWYPocYpmk/9J2n7Dp3lp/yZgVBa2P
	2UqTlAyY5JXghTpxJa4uEoV1hQAgXHyJArpZjEYbavVVnjj8taKS2+RK9CaWwDFNah04DJbt5Xk
	hzzH3z886F5SBE/IEgM6Dhj7DZ3o/gf6RFoqDUK5MHnTA9qaP9eZkZY7H8IOqpoZMzae+r5R3eB
	lk+8ir0yuoHdNxmpavOqGfB1LhmH2I8uDL88ivHgJl3uqD7MPCpdlhtSNk7HC8RaZ5Ny+aZ/fZd
	QQ+iL7/PLBePj/aoTzRwM+84gwW0Oo1c4wdbtpJAA/MeEE5VC7nPhlvV3eW/2fvO3hLbPN4cAr3
	3PKdiHmeNQimwOHF6xT5g/x+LwTYOSPXvmKwHr3UeFC+SJCCJNpKECxd+77fghbJJ73VAgZEkGr
	eMYzybFbBNSyTw7ofUW1cEkCwKsag01SFDdjjJEzgQkXIu0H3y/57FEv6F1rm6vy2Sv/U4qaejS
	Y6K5oT+w+S0Yv4xHQodDjPxmRZ0ONuUKyYVWstp+w==
X-Received: by 2002:a17:90a:d886:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-36a676f061fmr13821722a91.6.1779706337998;
        Mon, 25 May 2026 03:52:17 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:52:17 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v10 08/11] iio: adc: hx711: split variable assignments in hx711_read and hx711_reset
Date: Mon, 25 May 2026 16:21:24 +0530
Message-ID: <20260525105127.180156-9-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the initial value assignments from the declarations in
hx711_read() and hx711_reset().

This is a small preparatory cleanup before the later loop-iterator and
variant-specific changes adjust the local variable layout in these
functions.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 30e1ce321747..4ccb0bf2d71f 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -159,9 +159,10 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
-	int val = gpiod_get_value(hx711_data->gpiod_dout);
+	int val;
 
 	/* we double check if it's really down */
+	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
@@ -204,8 +205,9 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
-	int val = hx711_wait_for_ready(hx711_data);
+	int val;
 
+	val = hx711_wait_for_ready(hx711_data);
 	if (val) {
 		/*
 		 * an examination with the oszilloscope indicated
-- 
2.43.0

