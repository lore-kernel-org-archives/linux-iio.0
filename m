Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBF2820A9
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533183; cv=none; b=IQugRxipX+l09nUhj6FPka6RWFhd8D3pmj6E6eVaerf29l6eaHoOKzpH61iNEx8kx/ztqdcEcQvcepNslKWxEf1QZI7i0DD9/Bv9WX/8KC1Hc9uMYyULcco9Sgm2OEGHNZsYLIYgdiTlU08/WgBL7K356bmE4FrmJL3mmZDRW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533183; c=relaxed/simple;
	bh=zurSHM2O3dUZxj60XdWAS/6udk1I5SqanvzVClgDWHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh44qeKclltwxWLomU+NvjbSuk/f8r0shlD+GTMxSATV0d5XhSMC1BL86Dky/UBb6DPp22kWU8uL+NWg/mP05YxnTXDhStzYB0bbxtO5Tc7/zpY9kccdsvNTd3J1++vpaSJaHHSLOB9hlnhjQsHNL9NsRsZ2JHrjmgxXh0ZguE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJb5NjR9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJb5NjR9"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8220bd582ddso685420b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771533181; x=1772137981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGipjKzRkKk8a6B9UIUbo0n60PHe2qTPntOmo0YjjLE=;
        b=OJb5NjR9hjO/YOXI8J9O7HSfKyKkhUisiB6x8xLjktpdEzRVnaTzEzSSYqhOHtnU1S
         HgWyxrgoRGfU3FQ00subwguZS+Xg2DnZuwslfd+bVRxFVH3twHurRxulDNBETDprjC/g
         0XZReHyGSmlnH2WYoG33Ps1zNnqYNlaFIkcvkMiFO0t+Lc7wiSeSKakuoFWilAmrmyqK
         rZBA79JCwz5fMtaEvQDSqd2ktvmMveH4k5xnRhKUlrD9w3i4v1TcERf+HuU6XukwWwEr
         n/VaUVUUxbypklk7fBRMm3fivULBbT1hSGux7iYn+ggRGUGh4hwmsjaO+/SSvjAp5bh1
         p15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771533181; x=1772137981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IGipjKzRkKk8a6B9UIUbo0n60PHe2qTPntOmo0YjjLE=;
        b=Wt4Pv+2UiVn/blh/Wzgba4cvD2i2+j+ghPaBTjnwe8gpoACdLd/t3a5LPZe/OJUxEw
         Gc8bBdIoUDrws29iKXAT7/aE+xSUydP689gK1TPjh0Vk85dTLpuj5I2cp8UMOz3FUS43
         GVa6qlJUSc1N+zKT0QKUgBlAsM/C7LenbHiNs8498Tk9xxpNk8DChtbUUKvuP4sgCUCt
         QLVtMfIUm5AWUhvYkgywD3/MlmkgUvaymfoOnOYsjKjEBO18iMtedDbJnfZqB6V+7GuZ
         Asjnkfp/DhPO1tALJ6ls7bgX1Wwa0gNAGXJ9jx+O62TrR9Vj4qTFfruonvBfjAHeKhMR
         zpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtiNgHJzVZR3H7jFmEyq48e86e885XiNeQ05V3f1oDrysjNsuuszlFiDJDOKQZg5XXiNqbXmByEZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uHNIFj9DACF0M+/G6abPgjQfFSOD39iidbjEDS0qQGf2aqvT
	nZK4bgHgkfUI56KUBAFj9fSplO06mJGTPfoe7//LiXMF8a3eBmP1+Xz0
X-Gm-Gg: AZuq6aLmOmPSVsiiqFSWEOrPd0Ox3Cvt52MjOMkutbrqedu9VG5GWWkQuS59DN5rzqC
	vmCjX7BeudZlHFDu1WxvJFRuIhpo/TLLx1IMAWvxZBQtEhBhLtNT4KMbzmTaE+vfeUJQYGEKqgE
	Sb9PXW2ZplipsklQFvfL+P8S0FdFByIO4+5+7rtReklQeeWHopIv+3CaaK1WbGS3eqS5fMos9A6
	ZZuPfGPsqkikvvkSnLp87cMv9jpSUJ0/oqW2UV6kZuks+RGOXYQBgD/5Dm76fuwjRll+5XM1eWL
	RVjBjCdiIQnrsM+j+poj5E5nXaFo90aP0BHT4sqygn5/wyG82dwnD4wdA47ksdrod7ZtAHykrJn
	nalFyi0vXEkqxZxZhbwxDT8ehZW9vDfliEoMZrdiWrUyAd4ve+9Y9G3wkf8RFZgR6ow5ZqpVPmr
	5+KIsQTr1kuiHrGo6b40+An/q7
X-Received: by 2002:a05:6a00:1903:b0:81f:17b:c70f with SMTP id d2e1a72fcca58-825274df33bmr5699691b3a.29.1771533181005;
        Thu, 19 Feb 2026 12:33:01 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94b80sm20339278b3a.55.2026.02.19.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:33:00 -0800 (PST)
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
Subject: [PATCH v2 0/3] iio: frequency: ad9523: fix checkpatch warnings
Date: Fri, 20 Feb 2026 02:02:12 +0530
Message-ID: <20260219203215.15566-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aZa_QbwCumULvTf7@smile.fi.intel.com>
References: <aZa_QbwCumULvTf7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches address several checkpatch warnings in the ad9523 driver.

Patch 1: Updated the macros to properly use their argument x.
Patch 2: Updated symbolic permissions to octal (0444/0200).
Patch 3: Fixed the multi-line pointer dereferences.

bhargav (3):
  iio: frequency: ad9523: fix implicit variable usage in macros
  iio: frequency: ad9523: avoid multiple line dereferences for pdata
  iio: frequency: ad9523: fix checkpatch warnings for symbolic
    permissions

 drivers/iio/frequency/ad9523.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

-- 
2.53.0

