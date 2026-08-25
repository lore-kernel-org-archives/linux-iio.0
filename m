Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046B332EC1
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678550; cv=none; b=nPPUGKhe5g79ssRA/xhDKhFqsoFQh0bzP6idNKT5Ih1MJumfAmeGz1+9MsR9h1UubQOsvR7Li3n6gWSIYrUbinmvyQYJNfskv10WajtShejJ63apmJAonVPtXn4jVID8p9diEyIOx8aKiwhzqH5EFIdIMeGHXIEOHomFQLsaEWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678550; c=relaxed/simple;
	bh=nVzGJxY4bXetZ0xxkC/uaAJPaakwNOHhLjneZwt1NOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIiXK5f7Evi3DicA+IblYjM7yxBrD4+08+WjMXLJ6peAXqhl4mRwM2a0uwzu212P+OUY8mP82ai8a0ARZQDawFjp7qOJNZWlRFheZ+tslS2P8GatMZeeizOViPuSkXCp6GGD8w5LjFDkqONfQPE9orFavrhBFm80xzFFrcPLiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPyIwzha; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPyIwzha"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caed617615so1052435ad.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678549; x=1788283349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=smb+eC3dhHT61c6tdVhm6kuxDMtS75d/UQ8YVvsOsKE=;
        b=gPyIwzhaENP4vfd+7OuP+mTyXdiOYWWrteEhZU09rOdxHQcFNq45mIpYI1Hwza+rg9
         CVWXcufcphdxwn3lWfapHf5sZk1eoqIm1vv2hp4OVS0MU9ps/WchNSHxebtd/yTkWkmE
         bjT96pV51dScSKpVTAMraqUMClJjrRovkWnPug8Kb0P5UghXN9Sz4fogzSG2KNRGkh1F
         2GxHGXJnSsl/HU4yprVYW8H6ntJDCZ+1dTP2D3+qsFCMymLWTlRsZ0EFAWt58dHy+Vzf
         lYLdEG4j7n07MRO8SJLhUtNtp0M5+Ek4SRmziwyDoGLkcRg+hyweygrI1+GScL4WN7MF
         +Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678549; x=1788283349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smb+eC3dhHT61c6tdVhm6kuxDMtS75d/UQ8YVvsOsKE=;
        b=HxvIPOb2XlJcrsLrVbjFrCqlD8ujCK5oYQ3Uj7LiDgpDqF2npoSXIfR1g0mC9OEVch
         Gci5Vic0mgPIdOfowf1zEoGKUFLGBkkcbu98CKfRzMJrtJ+b5BjjnVziQqpKIc1CTkMQ
         o+kSjgfrNcFODoSH9O+bmLcKFGrBH8e014Kq9e4j/y2FtHH5rYbDjXtqYFP6OOBozgmB
         PejbeT+pne/QBvuSsNYc6CiwiGEV6Sspeuya8wgQl2x6M6MKm/hSeJ/hRelLXo/3+DKg
         jk9qjH0felMz6LkWbNKanE+oIqEl1F6m+Hpx6QaFD75rIF/CrBBxkZfXfX97Z1br1Nrz
         xWvw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4xrhl7+8D62pdEiA4/ig0WgmBppKalQCPGZFNLH5T2iSeGv+oQjCeI6DWpUPvtDOm4BwtDMFdDVc=@vger.kernel.org
X-Gm-Message-State: AFuF++ki8vbt38K7WNJtx8Y2L0T4mhVKPKGwdZ7rcdTGFDh7EVtH06hK
	hJ4/u9adEV2XCaNyTA039YK6HOVICoPLPsW8+T08ZsnQfUo5kolgjfi8obXFQrqWwjg=
X-Gm-Gg: AR+sD108ugYqeJbjeBu6jmGVHZLE2UGIN/vbQSSwtNHiZ2sfKDGwdG6LLNbXEbaZpPI
	/fbffFtfgJgaXE+8I+B2gl0Cxx+6LV7Tye4519yvJljJ9hl/dxLHjelbO8hE54jZqClWcFuCpWR
	Kl65DuUaX0DRvxmekD+1/RzkII3f1r9wKkDbzWm0SSbYhF3i8TCgn/r91zXLpKgEyOiigu5IZK6
	14nBucylSkhT3HDD1QRygxvdMAulmM5c9fZlKhl0v79UkNBRwibmXLq9AM20Y6CyXZQa1WFlyE+
	2sgJUXHUsTORS7VNitf0ujQdNZIJfSn1syYh8csngAyuSJ0ZglfAtHWjGm75HfARBv7iJov9gKY
	i8B7mL54mNkg36Z4/pXiGJahItE14sLTudpSUGgd0kWxap97dki70h4iffCb7r4qG6eCkYuz/mP
	s7RcsN/oTWJB9K4iHXjbdv6jljzyrkmf2Tvbwjlu8bGzqO6JbU0FUPXMEKi2A=
X-Received: by 2002:a17:903:a90:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2d670b60ceemr551159465ad.2.1787678548700;
        Tue, 25 Aug 2026 10:22:28 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:7ed1:605d:3bd6:fefb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm327637eec.23.2026.08.25.10.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:22:28 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v1 0/3] iio: adc: bcm_iproc_adc: Convert to devm-managed resources
Date: Tue, 25 Aug 2026 22:51:52 +0530
Message-ID: <20260825172155.250484-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

This series is a follow-up to the previously submitted probe cleanup
series for bcm_iproc_adc, which is already present in iio/testing.

As discussed with Jonathan, this series continues the cleanup
with a few additional driver cleanups and devm-managed resource
management.

Patch 1 sorts the driver headers alphabetically.

Patch 2 replaces the manual ADC and clock cleanup with
devm_add_action_or_reset(), allowing the probe cleanup labels and
manual cleanup in remove() to be removed.

Patch 3 converts mutex initialization to devm_mutex_init().

---
Mohammad Shahid (3):
  iio: adc: bcm_iproc_adc: sort headers alphabetically
  iio: adc: bcm_iproc_adc: use devm_add_action_or_reset()
  iio: adc: bcm_iproc_adc: use devm-managed mutex initialization

 drivers/iio/adc/bcm_iproc_adc.c | 51 +++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 19 deletions(-)


base-commit: 560c1aa128cafb238f460826abf43bc8b83aa0a6
-- 
2.43.0

