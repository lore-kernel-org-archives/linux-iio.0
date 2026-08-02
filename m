Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33E3033DA
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785653749; cv=none; b=EbjrquAd5kQ7ptuEmZOPTN+O791pbWg0NPNpw3GVAFCE8/j9+m0m+MJeJffpLJslwwiTKW+e7qZCnteJAtuwzKJ+RkSaR0WI0QV4NFjkRR/SG+lHGoaTYSx7V2nbtuurFPcKnUWbJPpRBFTefic62vOPkdqQp3bhRsQUgiuvRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785653749; c=relaxed/simple;
	bh=O0QzfMOPr6vkrOHrhbKyJAHJOjCmMJTXKRxMQ/xCu50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5HIU1p6BpC0Mcr3xNX+H8DaWP+wrXdWJYGOVTNg0tcZWCbmiw6UZTFvZHCAGdmyegHjYe14u7UQasfQGNCJWTqvZGBnkuYqPLgduGxmcarDIpLNrwlnDPfsJPfmhetgTQnqHb5VNG1TIdBNMg4106UuzrrRF+YIlEmevnWOoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJSVOCmT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJSVOCmT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2250253a91.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785653748; x=1786258548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f8LYikitMrC+BH+jG/GkXkTeEEEki2FXKlfuLfV91rU=;
        b=HJSVOCmT72GlPOmufknuGfA0G/KuRhq9H7kzDXKBW9DFqBfR4yGPqEcrsktSUJOJB1
         WQV63nNmTp3pWvfA1EZ22Wz4cK1BhDB2DFuidHyVdMPT8hFXwXhIk5FYMTG/6sMP6wv5
         ULo5xfnO0zw2S4/Xe+Ml+3yC0maF6FvpVyuMgVTu9ibx2hQEHDQCy0xp7SyzWCVZM49l
         wRjMcCI7r97q/x8y8vSK1WB0Kbt5r7CJBBrClmjR7qKyj3Md+LhTMCG1ownolOWqnD/N
         qgi69ZD7g5ZQUxGno1jiktEUpUTM9MaKTYQUSAVx63A90kEqKw1QutZIQvMmA97RfIux
         8Bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785653748; x=1786258548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f8LYikitMrC+BH+jG/GkXkTeEEEki2FXKlfuLfV91rU=;
        b=EE3YRPO/jve47hcQSybRqPtKI30NHxFMC2ZnwYKmZnaB0o9Nb53EruQ0ltsj4YLY44
         dJIuP2Uy0/aP/1xYB3Mbt/6x4ryPg7+Un4yi1m9J0+fmtIP9OgwbpP0OAWB5SqxACDTZ
         zNGD0i2rzJoRYw+7DstZcOs0WSySwWkWGYWiwrw5GA63OT6Pp1Cu1UFojx5ReArVb8Bi
         k8oMpRDGNC2K1ucbHO83aj3hLIuDpWOO4EhWBMTQfJjXSoupEUycxxWBsUbfFhnOYT1+
         j9ZVvpo8bgpv9sfH9p79Vn/qzayDM+zIhzzMvaOVp/LxPyBlrCu3HKJjAqQLwOLDET9b
         luHA==
X-Forwarded-Encrypted: i=1; AHgh+RoEv4ryUhV2Ev0BJG86iAA4Msc14K1K/pdfgZBAh4QL6Id5qy8NeIEVDqseY3IdIrcvbOPupi9siD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwznJDEcYUXOcVAmlKBfIhzuF8yeCxOg17ZETAOOBSxfw5ULCp2
	ONzdIMR98zY8zjlxI77zpX0i0Xpc0bftYu+8CciWD1QbnJKWgRoGyZ7f
X-Gm-Gg: AR+sD117CBAm+oflcH+lFu+YE/ucS0RdCJRQ3NuwMDjvMIIVZjmFH0OYXvSorLnLoR2
	PReUKNPKb18yqj5t4dhd82VZc4R/x/u4ur+FCstWcxT37UTLE74PLXhLXQ5KF+WZXGJPWpICEjB
	e0i18LO4Jn5I96B1TSdpdFzBDv2fnwZq9/iU0zxPgjCBv8I97J9BD+Jzdpdqvrr3ndLkuzyHFbd
	mGwXIPu2Z5l/r4QoHdD3V8G7EjCIDfq1ZcjiGE4kxDQtpYZBLb5kl3oa6njdDJyf25APt+meaHS
	qTpdmrpyt1iFG4B57OiumoqhLgBxqb508aTC5+V97EoYBgy9sXd73tP68/NSxPPFnypxZ3/eLlQ
	LK/E1m8+s7MXp5rlMLTIOzXWTIRovd1nb07GWEB1zWbQEl5TeiwRTihG+Ao1qnc/YhUr411PwrL
	dW3gp8AIcbFbmU+9YM1ruOGR/5CuklyMcKMXwDpDfXyr2jSbtvg5cqcH0F5JzEwQKVkZ2U3lyPY
	HQaXTqczkQ5fBhf
X-Received: by 2002:a17:90b:5111:b0:37f:ad36:8fc5 with SMTP id 98e67ed59e1d1-38fbc53430emr5982092a91.23.1785653747827;
        Sat, 01 Aug 2026 23:55:47 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm19641297c88.6.2026.08.01.23.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:55:47 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gyro: mpu3050: fix sign of raw angular velocity readings
Date: Sun,  2 Aug 2026 13:55:40 +0700
Message-Id: <20260802065540.8120-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MPU-3050 gyroscope output registers hold 16-bit two's complement
values; the angular velocity channels are declared with .sign = 's'.
When mpu3050_read_raw() handles IIO_CHAN_INFO_RAW it reads the register
via a big-endian regmap_bulk_read() and assigns it with:

	*val = be16_to_cpu(raw_val);

be16_to_cpu() yields an unsigned 16-bit quantity, so negative rates
(bit 15 set) are reported to userspace as large positive integers
(e.g. -1 becomes 65535) instead of the correct negative value.

Cast to s16 before the assignment, matching the temperature channel a
few lines above which already handles the sign correctly.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..07c0f9011c63 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -356,7 +356,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 				goto out_read_raw_unlock;
 			}
 
-			*val = be16_to_cpu(raw_val);
+			*val = (s16)be16_to_cpu(raw_val);
 			ret = IIO_VAL_INT;
 
 			goto out_read_raw_unlock;
-- 
2.25.1

