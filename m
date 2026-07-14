Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A94D90CC
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047922; cv=none; b=JVt3N1xewpopI0NsiqoV2P2ZRUjjlUyeEExC2HG8Xv//qnJFHxYhbYFMTVjCZAXc35YSC2rzlVzIqryb0RZu3XgCNeTHFNj7WllZY+gqRgLiILKxzT1L6PBb6k55RTNenw4ltVLb+cE39y8w5DjXATaDLNDYPq7oyqOzh4KAmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047922; c=relaxed/simple;
	bh=1KmXBvv9ogEWCQG2EGNt09pxwnGjngtT7NexAegcjhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/L1VS3DT4BdPW3czwlB+PRdtlgR9MF4ZUSsaM8zIlYXGvxCaK6cXUQzS0OI7+jYTbr5SXIKgTH8isWyiOOmFgnV48DWKkJmXLqdEztRMzYjN+hn5d66OM356kaPO3mdhWpBr82F7G5qA9UxnfzdDdsOBKLas3mM0FtkuU+w1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw2r0JAH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw2r0JAH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493e497643fso6099595e9.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784047919; x=1784652719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ESKjOB3jL6pY0WANcfW6zVin9Ft9lNw7GuOHaqZcFD0=;
        b=Zw2r0JAHXGzu2zZ7y8HThEUA0CtlEWs13J4wTyizD3LUhC/mpcSPINFBBH37wlTOKo
         dQJFp4tVs1Klxi1zgtScYCaA1TOtpZSiiSx09URhh1t0FU8x2NM9yZ33+Z+L34behDrO
         NxzKOcpV/PPS8oGg8ZuUeEAdDa9AAt4RJ32/LftDY3gfaOnOlfb95amULRPLH+4kAinb
         epjMHACeX6slpHBpbHbCOOV07j7/z7sXcMEHmlGI0WLtUfCHp/oLssRfIz4SxfCx+XEW
         8hu8CmgaWjDkVkKmdqLKC2R/et1+i9OqO7HH8yr9BJp4LSk8i8x0fCZ4LLxFiwNlsv7Q
         1wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047919; x=1784652719;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ESKjOB3jL6pY0WANcfW6zVin9Ft9lNw7GuOHaqZcFD0=;
        b=NWt48nBlgqUvbXDcNM0taPIuN9ttSzbm2s8Q+mRCAa8oqS0tl+WTYmL5fW9XsFQQpC
         +XUwQbdKSZwUYIaJehT21T8XH253MKIpqFKNIR3SR0EFnQTCTnZ+AoMiWo5tabqX2FH8
         w0MBtYcA8v9TNuuUs+YlQdIbKE0FqQoh/u2g/V++DG69oaF7SERcdU9Oue0Zdx9Nsy0x
         Wz/A471iz6aUccztpY8pWGCTq43f6qnLeX8NlvE9AgQdOPe5TGNGO+QPRcdZZP+jXv8e
         12h+KXar6IvZu0OVv0jDsle34e37b8AJIadSVD+EzVmlD8vFbkB6sKxUia15byD/IC69
         jrqg==
X-Forwarded-Encrypted: i=1; AHgh+RqEQmt4FYRkewWCLN05Egc3efrMRa2K6iXyolJ7FX0NUkkt2xnnsqFsGuvQ1KeHZIXqhPU1n3NwC3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUU3JW9L+xlg3hVk9woEjcC+ZYjV8as08TW4UzqML5C5e4mnko
	SIkRpwoQtHpIcph55xuTy/OSc7A+MwvP9KcQxR3P6V9FBjAkiRQWxMzK
X-Gm-Gg: AfdE7ckhHJ3VWUMPJpYYjovH1ahMxL3v2RbY4f1UuyfXnC0dV9J7dTXnhCw3R2qw3xT
	Kqf+UQ9XRQjCuW87wn+s0R7JkL3eC3XdIJxxaJv3LmFuAm+4CROCsylh/BZe1LJW6HLmsz5ZFUe
	HDd6a6xo6d7pnSF+fjjt2V6ChkantmmSVFW8uYW9PweEW2YsRiZnR+fz1UPc1IByiSkvso4O1/G
	2sHtLw8RpqpRjQVS2r0FQ25CKvpmfTv3yrmVRH/gmtwhhYUy08y4Noe1bKMdaLNWKOSXblveM/7
	lWsff0mw7Jm6HIujd+13Uy8X1DPdbY/vp7VgANQ4xyU+5l7mOA7H5tgula10Zdfgp4AZDJPvJOq
	rku6VuZGxU2xeCFPoMgA/kphaHFaQ3ZSiEFttQc7LCwMxDZW620sa12u2E8JnyjdpoYA0XMCyYG
	SUUg4AXRkvu0uYZ0GTF/Ri8A==
X-Received: by 2002:a05:600c:3acf:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-493f884f5f2mr140030335e9.37.1784047918898;
        Tue, 14 Jul 2026 09:51:58 -0700 (PDT)
Received: from localhost ([5.83.201.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508725c0bsm87574585e9.2.2026.07.14.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:51:58 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: make read-only const array config static
Date: Tue, 14 Jul 2026 17:50:12 +0100
Message-ID: <20260714165012.184651-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only const array config on the stack at run
time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/adc/88pm886-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gpadc.c
index ff9bc5f06c18..938ba43c2c35 100644
--- a/drivers/iio/adc/88pm886-gpadc.c
+++ b/drivers/iio/adc/88pm886-gpadc.c
@@ -279,7 +279,7 @@ static int pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const
 
 static int pm886_gpadc_hw_enable(struct regmap *map)
 {
-	const u8 config[] = {
+	static const u8 config[] = {
 		PM886_GPADC_CONFIG1_EN_ALL,
 		PM886_GPADC_CONFIG2_EN_ALL,
 		PM886_GPADC_GND_DET2_EN,
-- 
2.53.0

