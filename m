Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA8258EF3
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068577; cv=none; b=dGDYlre3cG3wjbAzjajKCPs8a4/xWeM47M7uNUs53i8aHgDkrt/LC/sRzXvv7qCq5TtHdMeKjgSuw6QLUwSrooed59ZCIoB03ahJjndgb7PKrrV8Uwvaz5EMAozbTpPFmXxbE3CRumg+DlgQ6cimcvHnb7bSb+ea3NignxTsfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068577; c=relaxed/simple;
	bh=+s/v5GLOFlvOVMK5SETD1orZfbBnXi2XVTW2DNvvDxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyE7h/mcGnQi+aQed+ai48kF3t72jrsiCQ4IADUmHroW8sRWTBIA1LW+w8K52PPi21oNOsCRqy5ymZ7/clrodkFCSFoquaxOp2onO6ZsQTxAHvncdfmr6WkRVck9dH8W7QbQi99KtmnnhNFgGCf47F5eGaPacYRVpPPIA3ngxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NM4mnCUV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM4mnCUV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d560775ca2so16097745ad.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 22:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788068575; x=1788673375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8zBuAWBdPaHf6WnQ75ec30yZDUQcbxFXmLKJ2IcPwQ=;
        b=NM4mnCUVFqsVVjgg0on9MLfewbPMKW6qk7WWxcin622JEPwcpl6Ah5n3K26icnf4Mq
         qL+0EFMNx3ppCi/Y+xxQwJsQnRzdce0rtyqCt7F79jxtFfsLdOb3lqrVz0MdjDBJDGUc
         t2YFy2xJQ7wRR7so7ClvGRpSIlu+0Ij+CwBojjCNrf5vG2u5y2LO7oYBpD9dyGVLF+4q
         AXD8pFXCkI4GyJlrkaUlWpBQx8lpiGbwWv0BDz4QdCPkd1L15IAneKg1dEg+cR6NH3TI
         0SIFnfkcrNjUXQPAfdbvUUPUhozt24bV0rNsmebtKmAkmWUrpskO6DFDlgkpe73FsDmg
         Fbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788068575; x=1788673375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8zBuAWBdPaHf6WnQ75ec30yZDUQcbxFXmLKJ2IcPwQ=;
        b=B70q4YFjLffuUewnHqfIkhP8U1vYRD6MB8d8GmMJr5DUPgK/uQoghAd+VnyAgmTZKF
         wgsWjopZEfE3rNXFxs8u0UdwFlhS/H3sG6p6WvJESh/WAssJZPPVDqr0EZDmxGC5IsJO
         edtSJO55g1QVJh87xmEeo6aB6WvtrXLdFhIneyi39yW7aTYxv5+e7kQ7PZpdXgfO+vJW
         2nx8RUXpXotvKkvEtQm6NshqT+CkY692aoeV1JI+Ps8jOeV4DKDrmyG7/FW62htSoVxL
         pKzpBrCzSB1RVBR3SowUBEQz+60bgIDMXQNvy6kNuRL5BhG58rdmPmlqUkvnHyVoNMbg
         cZ2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzqxFcDBc6osdy5jzuOfI+K+rqRhmv7AvzfBoFguhjbJ+khzxFnkxSxGDj8M8aAm46c18Kk9eZ3daY=@vger.kernel.org
X-Gm-Message-State: AFuF++le6oRGckyzUhdrPEKFg9230FQ7aK1Bz1YTMC8mbHFAfY/i84wA
	8iy+lp78aWC8jKjZUaJDhOOSMnCcyR6SvmltNoa399jT0DH8WuI/7ZQ=
X-Gm-Gg: AR+sD134aEjrkS9h/CO3VMJAGGynF+dKvug4P/ztQ8joCzNTnbpEg5cwe0QptUNOv5P
	b1YsYgalM1Vst7MYlpQQg6Oxu0755IDS/YPv7jviMqJKAurkqC7MmOR7aPmZyM0LpUjP6c/+mA5
	sKkG2Yii5N99aDiPM+7fJhmrF3nWTRXt4P6IJIyZE6CkcmUPtNBTnpHUJpM/BKUc2k4GyhKKppH
	K66iT7Fw/IWDxLvbhJT2HXs7uYdkL4MgNFvdz9y4ZTi/IykfOYg9bgTUA7Q2Tt9PAMdQ9Gau+yu
	ZMXXCIiDHS8Gt80Yxp8ltIyjiuobnLao3SttYekqg8u/eoDV8vweH7DZXTJAeKbabZXh+pJgBNX
	NoT/K3ndAMUlfZ3PVB+vvl2+a7xVQLy/cCwTzrDIeobEwREHBqHoroTVeqD2AD4sKYgUVjXMYMd
	I9VQZjqTvdHKg0FaUPZb+lYb57ahVCTQ1s1CYF5Kl5MndmTMtnQWtnnQqTtWr6wp1c6xpi15HFs
	w==
X-Received: by 2002:a17:902:e751:b0:2d6:7409:7145 with SMTP id d9443c01a7336-2d74dbfe91dmr241822205ad.1.1788068575063;
        Sat, 29 Aug 2026 22:42:55 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6496:3266:4625:ebf0:e422:3504])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm19575735ad.59.2026.08.29.22.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 22:42:53 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: vcnl4000: use sysfs_emit() for near_level
Date: Sun, 30 Aug 2026 14:42:36 +0900
Message-ID: <20260830054237.2147950-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sysfs_emit() instead of sprintf() for writing to the sysfs
output buffer. sysfs_emit() is aware of the buffer's PAGE_SIZE
limit and is the preferred helper for sysfs callbacks.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 336468d59ea7..dac235dd6220 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1504,7 +1504,7 @@ static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
 {
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%u\n", data->near_level);
+	return sysfs_emit(buf, "%u\n", data->near_level);
 }
 
 static irqreturn_t vcnl4010_irq_thread(int irq, void *p)

base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.53.0

