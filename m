Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB863AE6FC
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658711; cv=none; b=lV6CT00XWpcfx5lYIrBLnPKNwzOI6T7fTQLTTMx+T/RHbHI9Sxvgl974dQobIsco9i6x3jF9Uw80R5LBtyRXxcDYoIjyBbeBeRCGzlw+WRkDa7iMnqZwXtcI9ZNkAfKtXq0YdzdsUiQ+Q089MIOEnBl+4b106/vWB65IHyg7xUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658711; c=relaxed/simple;
	bh=DGI2F5AdCnVZ2nEMaAL2r2ghQD9J5o0phj5AHHYGqdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AYAgD/0vnBa4mI/0rCh+N0siW/cvrBNWPa7flv8d4TIZl7nHfWiITC3Uww5Nc0V4V3euOdQNw2h1iizDHeBIbC9ajSJ6E+E9ziOezauI92Fc1Aj32HCF6pdO0mnMYgWaz0fxpkQe/yI3QzTgRsSrZPya6zyxiALGkhU/VSvZlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIlRQPnc; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIlRQPnc"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13809223fd4so3017573c88.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782658709; x=1783263509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3ClFJKTl3ktD7iBbbLvLy9MML+jSdXhO1GL5Ept/Zs=;
        b=eIlRQPnco9I9nVWw/KUBMaryj5N24PfsrDs0XP/BZwZls7hACZ6AXILkM7Vd1y5HuW
         fubcJ8tJo79lh6cMlLOwpIkPCVcugFnbWA+narf5RKcTFDJ1Lyn98A+7M+aBfkNy/S4t
         6+tpcOC9oaQBomctPTGr3yfyw2lRoy+E2VHtqHKuYzTL7SgFV+6A8lOwzAhgPi71asKd
         sOvaZE0sSPxwzg2mttf8NauUvpqLR7VPFa/d7JCr+UC+360Pl5ic9bxZvfUwfxV9eJUr
         kS/MIdzq4jz+mxzIW7bUGGKA2W75Ocm7SzeCbRUMzICdAui+ymsuDTvTfHzN5sqzARBe
         WYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782658709; x=1783263509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ClFJKTl3ktD7iBbbLvLy9MML+jSdXhO1GL5Ept/Zs=;
        b=e8rMnb+EruLB6zwx0JWW30UO2PIr2G5GfcH9dGxpuhN1gIA0NQCTMJXPkWVj82DvC4
         izBObrd/qNelmHdUPGSujJ9Fca1WAlASP7KZSyjB7zjK1zjbc43QRYqGR4CFNQL0aC0C
         YzpwQJtk1dU5wrCcPMmKaH9yYp0o8MuJz1LXz2LtTNYNrJcnuMzlIp/m3E1yU0ROdwIH
         02I/GuT2DC6ak5Nv1C5nLfmGL5aX01E2mKPXAc/biXIVoKFQd5bPy9LqvyLZCXteo6us
         QYsI5CtGpFwC0LDfoorbQd2E6Mf9kBu/kZ56vxEkpGBBH5rdXDBNGKf2PGC0CwBQSMjS
         oHnA==
X-Forwarded-Encrypted: i=1; AFNElJ/pLK5Pe/KJdxV+4fbjXBtOp57JDTK4W/ThM0IJlDXJz4i0FdShjD40lb0lAuPTnxlaaOqTWpVzyjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kUPR6VO8xKH7DAaJC1bVovKR6IBEVX7cxhkTR540XAJQbpwK
	cjudF5fl3eGkUsKuBOmLS+h25LrO3ln47TEZUjS81FXMOsngQzqAKHdD
X-Gm-Gg: AfdE7ckpGjI2CTvF5dRxldzNt/f5g02wiiMykBOAAdIRD9d7f1eNaDS2V2xcsjxQRv8
	SHhTuasjAQ6MwdbMxW1/xgtZFR/aUi0bPwq6LBWX4mExU+5qjk30Yc3Vu1RwwTVhRig8b3WwAv2
	IonQg0epF8tTMCJnphUiP9doI9ZQwIxQc7A1Exz2vTeTamBWzX1PepRJCfXAQaORchyuIQNtiNo
	lT7fYb/UHPS5Yg7kvWqu0YoNML0PGKymnuMpTHDqfbAlJboCoFM4UvhvfSeWE02Pqsepm9k/x/k
	QwgnAJa3ELEu9vep5eddoxZSxOvoEfs5H36cu0Xyy9Wdfu/mrDhHkO/15NGluArAFS06X67qIua
	pa+QjHVCVefaqRQ+sAvtyhywUgYtRH70P52aRdDxXEFIQfgobW23wiUbuxN5MIBbar1A9R9dAg0
	Zl/oEHY8RrlXkoi68NKL2p6wWmgbQFo/q4KE3D/wIAJFUKE+MYA8e9REJeFTa6OqM2xQ==
X-Received: by 2002:a05:7022:62a6:b0:138:22f:9a2c with SMTP id a92af1059eb24-139db9e5923mr11083548c88.5.1782658708791;
        Sun, 28 Jun 2026 07:58:28 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([45.118.104.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c944999adsm31307072eec.24.2026.06.28.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:58:28 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: ad7779: Remove dead code and redundant error message
Date: Sun, 28 Jun 2026 14:57:32 +0000
Message-Id: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches address review feedback from Joshua Crofts on the
ad7779 driver:

1. Remove an unused completion field that was initialized but never 
waited on or signaled anywhere in the driver.

2. Remove a redundant dev_err_probe() wrapper around devm_request_irq(), 
which already calls dev_err_probe() internally.

Moksh Panicker (2):
  iio: adc: ad7779: Remove unused completion field
  iio: adc: ad7779: Remove redundant dev_err_probe() after
    devm_request_irq()

 drivers/iio/adc/ad7779.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.34.1

