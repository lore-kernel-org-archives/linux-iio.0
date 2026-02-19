Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E030DD1D
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533232; cv=none; b=cqF5jJmPH3QekhFavHIJuhMMAwzyjAV6DiX4ta4HUEX5C/a0Pbw1oO4uFVf2WAEvjtklQnskVpBr0j3l6FFdEw3ZmXpL8QXJxE+t50SEBP1lFzOZbksYm02woYnOmiQDCgTrfQTDc96WI9ijEO7qbNz7sU2bOSlR9SKbZrEL1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533232; c=relaxed/simple;
	bh=cKXXqkuHdb/6PVrhi193Kpkk1MRt/bN7Gazuqm4hFTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy+sQ/RRC2+zHiBQU42FDee9HfSjyaK2/rDv+CzKBbl6GH7tt2h/aCuB3pSR5gxI2lJ9AhigHeDG0ZWWucosJccG9n0TROIKAvJA1iqfH06OuAdpw1B9YbILfnjhD2cbWaC6xSoXZEJCqDnrAoU94haw1eq7UcRi99mCVeL6aHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPxWi4TW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPxWi4TW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824b5f015bcso1288279b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771533231; x=1772138031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIi+OMPIEGzkATcR3nbeDpG++Q/GFRTfTECN7DMuE60=;
        b=iPxWi4TW7O7Tj7gcsYwBPsnFNBkceHZHuofKPsqT55nVzGM9wyAfyZarjFPi46MQkt
         LwuLxthqBiXYLVUNBJWVR4qebJhhYiqwfwSrZU0uiI8awCSy+b3xI0dxVlbFXagsBJvz
         +4BVlV7Y2mKR0wApzy+aUNXE7r0lvy8iYbr1LJnS8ogIYK9pnDlTCgm8+k1ZzIjSEL+H
         l1pfiKs3SkELVWBcUa7TjulVJMK79dax/qFJPfYBgNj1WINWxmK4ywqUsLoSUS6JXN/F
         8vNlvWyCaEnPzqRxHKKnV0bIVclg2xwJnbY3pBW7Vr3/PsAiyLJojmnhffOz0cG3p21Y
         6f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771533231; x=1772138031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIi+OMPIEGzkATcR3nbeDpG++Q/GFRTfTECN7DMuE60=;
        b=WSw3765NuLKICDAnncAL+t06W0EWjc6I/Wk92ylKxHpRnuon1hnZ6peqh2au4hDj5i
         bIrADacLz/uDJbZCDFI7CA6CCayQ0zkShVFcIvqO8IQsqOkbD+hUWjp3fRp3VNdLOufO
         22M5DclBtjvh4krW/UDsi9esboP0xTtS3QALDT8+MKRLi4u2ewzthg2BQv0jLdFo6XxX
         coKe9WufG3cwtY16NkCtJI8X/NwqxrQ4wP8FWNFJscErWYec6OQQx6ah+BR2DjdAm69D
         8WqFbIPOSAR+PLSp8ibnF4opEbvYr4LE9wb9F8bvbQC1YjNqkahPOn/J3GAd1XBNha7h
         obeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn70oaLtuwj9cyxjcZL5uzsK6Xc1MfesY4SBTQSW6SGufwZ+hlkq33NHiG+tVGl3j1dBkUsgiCJHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWRMEOfRzzd2niAKaBNb227OjUo7qCPkdmYwQaa55/oZ0jVx9
	xWVdQBl5TiCn2jys8mAIeI4Ix5DAQV8BjQdgYZc+zi5shk1+u7CzgxRc
X-Gm-Gg: AZuq6aIM+5QdzY/1pA7IU/WrZr9rGiPB6q8CqCe1f5QsRLI0ZObSHBLX7+DuQenVJb6
	86M+OoN/ckzCTOSCNeFeSdoseWYFyH4/qMbE3FFb2vY6i9FPfHaiU1cCnPOwzJs701ucC6RmfvH
	72ID90fS8SSWDEMpdUKXAISa+kAHGg7PqDuPeB6EQaNuWgysHYCoSqr1Rhd/7RCJNlJA+VCvsHy
	gSf0LBbmHgQxVwHYnJID+GS9yvK7tc6/IKI4mJApp1p6IwashCHSttvkue6oivPBZDVBP2/5Yh0
	vybNazlcNb9vxan0RF7EMRss+ByLyk0iP1HDWv/Se4l3G6U+7d7lM9uLsIn3bceqNcUm6MAqeZB
	Ud911Cgl5iIwBd+p1s97tdutAj1jN2idwit32vU0kILt31rLeUUxiBG0ECThtZDmiqjD9ayfP5D
	tPLczQyMMR3AkMwD7T0l8OT0s3
X-Received: by 2002:a05:6a00:7584:b0:81f:997e:59a0 with SMTP id d2e1a72fcca58-824c615e2bfmr17662092b3a.64.1771533231072;
        Thu, 19 Feb 2026 12:33:51 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94b80sm20339278b3a.55.2026.02.19.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:33:50 -0800 (PST)
From: bhargav <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v2 2/3] iio: frequency: ad9523: avoid multiple line dereferences for pdata
Date: Fri, 20 Feb 2026 02:02:14 +0530
Message-ID: <20260219203215.15566-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219203215.15566-1-rougueprince47@gmail.com>
References: <aZa_QbwCumULvTf7@smile.fi.intel.com>
 <20260219203215.15566-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform data pointer dereferences for pll1_charge_pump_current_nA
and pll2_charge_pump_current_nA were split across multiple lines.
Bring the dereference chains onto a single line.

This resolves the following checkpatch.pl warnings:
WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

Signed-off-by: bhargav <rougueprince47@gmail.com>
---
 drivers/iio/frequency/ad9523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index d127f3aa6cb8..4d0556ff5601 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -797,8 +797,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = ad9523_write(indio_dev, AD9523_PLL1_CHARGE_PUMP_CTRL,
-		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll1_charge_pump_current_nA) |
+		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->pll1_charge_pump_current_nA) |
 		AD9523_PLL1_CHARGE_PUMP_MODE_NORMAL |
 		AD9523_PLL1_BACKLASH_PW_MIN);
 	if (ret < 0)
@@ -842,8 +841,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 	 */
 
 	ret = ad9523_write(indio_dev, AD9523_PLL2_CHARGE_PUMP,
-		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->
-			pll2_charge_pump_current_nA));
+		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->pll2_charge_pump_current_nA));
 	if (ret < 0)
 		return ret;
 
-- 
2.53.0

