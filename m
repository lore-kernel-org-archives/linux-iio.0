Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4962931C0
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785636402; cv=none; b=s1uI3wg+QDnUkKnmFiE8GZ6LoWpl33JnlU+8qGXsRRm9P6pVRdmot7kOscSsgkavJLSIRPQyhWpDy+nhGBsUEZ+tO8mw/lfJe9SRA3AJfWa96+efsySLFBe+mTjUbF16utRPBsfUakFL+QP7g7VqXcZwJR634pPaaOCmYXBwRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785636402; c=relaxed/simple;
	bh=iOdYjF6hv/ITTRfMDORl9pV86CmTWdrTCbN5iAE0ALE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dS1mRVdDldjE/g2TWxjnm8TZCxJBuePjXMJxKOAwbdAtq8tsYg7I+Z0lJ2OrNrnfiId/YNisKy0jwhkQeT1otqyqlX3ocHOmmNWnA/0MYODCIPoskcaMIPSZ8Jv7LxMxgVXCBDF/8vWG6wzw2wBg18ReQNjPPORjnQWdPVD75SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpgehJsJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpgehJsJ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbb973e6749so2533132a12.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 19:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785636398; x=1786241198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=roCtpFt3o6xF6qwGmxiPg8URQzw6aIcPH38NLNstqGE=;
        b=ZpgehJsJCjy10aKiMkyoKsn3GndILmbH+ejzgxfbCb4X4eLWR6VKAobsdVj5ryGY0y
         JoGK6CjRuwJrU/QxfGxyGuuHsqRXbqR71WxGq5ek4ZZkwn2rTaSmF6zKrLihi03j1kbv
         +4Fez0J2RIbqFsW33A9Zb4PwyIXPeeSU7ku5hSfudDREJ7Usdua/9DrTYtlg1NSE5RTf
         XYvrgDt4segZLS7Ygtu7ilLYlinNeaxZRSMGR0kcNFlSk2b/LosDCCw4MBm85PGkGrnm
         1YUR257MO+MWnHCIyOmxMOQTRKUxehUS0M63zVK1QcGltIYdZHKW/+HZteAF3Ujagz1g
         TsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785636398; x=1786241198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=roCtpFt3o6xF6qwGmxiPg8URQzw6aIcPH38NLNstqGE=;
        b=suHwAZpVw1AjkNMjLbvPyFkilSCKLDJggTgM9f+xYkD2Il+s1/dzKRoWIZ8V0wH/1j
         m8GTGvg7x1MqdCrC70KDrk1HBnrJuYETf9YRaWWck98ruMSdC8Xt+064yFHiUWWLk3It
         33Qo2IbASJZj9C1Nu7JtKQjFmirWJjlSjxT0juOUqyoVArGt+MSll37KG1uNnfQ/dru0
         jSZUjtwZoCxXmIETLeuzxKauMUBqyPdhnyyNDuwAmyWbBqbdcljFptpvS7+Jhi8kmwQc
         xH1Hhkpieg1PQkZhVv8fk9WvW0wHWsdH+BuSVZoIOvC47PqzIHd5pcknR3V9Tg073hYF
         skGw==
X-Forwarded-Encrypted: i=1; AHgh+RqnNr+t41Tdd+Wr7zi4s3+5Gw5FhQZSTCfawlJHLUAZdCnP+nZSbvF+rqh0KPHnrcc8X2eSyFFzGqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6QNgeMuX9GKnCZhp5qsHXXcfl/VuJUHwoLGAOqtVFInOv5TX
	yrCCv0H3iKAiA5ypiMo5lgx/UAL3bERBtGkuwGybEs2QrNTANyekPG/H
X-Gm-Gg: AR+sD12wge4ojpSwARBSCWVlyxGeA0QCeBdDZtteOftix4kcu+EQI69IyzwXkoNBd0X
	VZ9V0ukOZqklxVEXLaT+JHtV9ZsTI1sXRX1vSUc19EZ/45Q7zr30bFM3QG2uF9nhScb2hCU8tFg
	HdkPJ/ZkVDQbObDlahImOoXrmg0ocAWpVsiTtzVTSetslh/s/ZRQ6s/eWRN/ch5zfHKK+aHghyj
	rVeVcHamqsqZpgfbUoUCdn/l7EtJJZUfi8BheyM7H8o4vE2Gts/ajVVqcjySwxhXFHnSiTmv0fm
	FwKUbPsN2JxFPIRLu35Loxyorgh81bdLCP9Fwl3GWR3z7hrYWoG2hy3Yx9gOIW3X2wMluNkSjBz
	xjiFCxn/HoEfof8d0mWuYVA1WP50tvLNFMhj5qcaxedEAAMFFZOAmEqDcr6MlTy5FavLbBLynZT
	w93sAOiFQhjo/QIwz4oJ1rfQG9iWITIuoADwuzUIey5WhQysz8Egnrxw4ds6ZN4nGKDHq9fr/jS
	wrrLZJEnISJuVFZ54VM6RyKuJ8gRglZ1IVOI5kpL0mJqaZHz8UEOQIqPLgSrA==
X-Received: by 2002:a05:6a21:6487:b0:3c4:2c02:eabf with SMTP id adf61e73a8af0-3c92a9021e2mr5223879637.60.1785636398225;
        Sat, 01 Aug 2026 19:06:38 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm32231795eec.4.2026.08.01.19.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 19:06:37 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH] iio: humidity: hts221: Fix checkpatch blank line warning
Date: Sun,  2 Aug 2026 10:06:13 +0800
Message-ID: <20260802020614.19732-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch warning:

WARNING: Missing a blank line after declarations
+	struct hts221_hw *hw = iio_priv(iio_dev);

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 4d03db19063e..c868549d09c0 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -194,6 +194,7 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 int hts221_allocate_buffers(struct iio_dev *iio_dev)
 {
 	struct hts221_hw *hw = iio_priv(iio_dev);
+
 	return devm_iio_triggered_buffer_setup(hw->dev, iio_dev,
 					NULL, hts221_buffer_handler_thread,
 					&hts221_buffer_ops);
-- 
2.47.3

