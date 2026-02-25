Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AC3D668E
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048497; cv=none; b=mwFnTbf7X15/yAcbZQoTs0iC2sYois9/hZIGOIg94PgO+WMxtpd92E5ovu6p1JifyPv58d8mN8gXfBl6wiOTYauXibUfi4y/1k/hbTpSlm6oAgtLzl3W/axP86BJ6lyqQZ+PnchDm1bcDfuPC87KxC8bmyNIFZdtUn4cnG9pSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048497; c=relaxed/simple;
	bh=Z3vqpdzy4P15FPUceY8g//2rh6XPHFHMK7osbY08yuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdCHjzp2a/uevhM3hXgMDqmVLBKW7ddVcLBpskoFbB0arbX+Q6ita/zQmzQHuZ79EzxQcnF4NW45KKshPIuXxzYWPBmgnbnh25yEdLUBF0nBTBOjz1d1dIznEfU9zWT3qRtBDS1k7crRkD02mTcwtn3lPm2u5ic8oqH1E8FcbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl0yV4nl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl0yV4nl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2adae92249eso471645ad.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048495; x=1772653295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NGRa9BZtJnOsjezolXh2TfIQtmHdwApL50cqmrG6f4=;
        b=hl0yV4nlZyGQIzOPFuIv6JpNvcJ8SvqBCos/7ahb9VcjZKQwBuO2W341Hfk3bdjLBD
         lWz0pHmjQr5SzF6SwfMB7DQUik5k0CnLfva+nTW4RjtWGGl0Y3ATGWyqVN3ARMHYLLa+
         X3iE6qGZfuVTVyIt4e62vJxqDLSpWHDVHc7J5JgwZZ4FHwTteTRZPHQHELeT0o0GMTlZ
         72sOMz45SiATExZ6VBnbEOo3/wMhtUEnDbtxBNzod7M0OUgRVy30fZGqjRq4quSFUa5R
         g9egGQj27OVzYN7uTQAQfwUC3eB2r6WSvAP/svCoClRXtSH3QXcsp6NKcAxccFITsf1g
         PYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048495; x=1772653295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1NGRa9BZtJnOsjezolXh2TfIQtmHdwApL50cqmrG6f4=;
        b=P0v6VyykZyEETRi84nYqouFAZD2lSkiZuDJgSUxKjP2cJcn2ZDgwDQ8tCzV9QbcHlt
         tzJ6j+i/4u/07m54qZOxdsLVJz3+6B1tgCA40W+CB95deAJJBWMgAiW7y0nKo2EXdjAk
         8RRETSIijw59wY6F0d5KHWSIkYS8OaN8OkTT+6v0Tb/GVG7QamVGYQ9YqdyaV0UJuX1t
         VMdxcviDs9WWnHwJs9tOG+M1T+sWLYdaxbJ1S9IgYtuYYiiDhlVHZ5lK83FbicKygEjx
         /l5WijuflTL+6gYF1srube6HMoPC6NJqJ/l3VueIcsfp2kVdSkK23uAdPMTjae4LS9vm
         R5gA==
X-Forwarded-Encrypted: i=1; AJvYcCWD5dVZSUfdDmgra1wv0vUUAWPGLPm0Se4bWxhpJ2/pRJExgpr1et0D8rC75WmJfeTkZRw4q0YZAcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygvt/7qWyLDAvelw2xiTyhjW7M8hsRVesYOCxiKIl4Tcbt+b1r
	HndA5EOgoWw+OJyCxeaGFd959smdNeHvtCAnpBgm32P3KA7g5n08s1/m
X-Gm-Gg: ATEYQzx//BlIUBt1gjakx9rfuLSg7nZuvVPcj2a9UXmslWdTqzSejFIe67M7uDb6fJV
	mFH+XKbrPyc1khi4f23HUvOmIt2YEA08XdsgdW5W3OsMGiQreNLjJd3XEE6Z32EiGZP+G7A2n3Z
	VijqBZ49QGPEXIGD/wTgDTqZNxbNPk53c2jv5bNUDC+6tfsKnDztcUe1tAkcGErx6mb3iqXG8ZE
	5iEK1QeXWOty7XijC3sZEIJox8z3ylyCOICm9rSFIaPUPURaRFSt/ZI6vKZzgRaycOhSRGWJIq3
	XnoT7ca/oXa4i/LK8smqKk6RnHHNdJP6Fwk2wAMyPge/HMt6uwB+obAbYwgXBBkLSC9PgtKtgXe
	6Z6cckFzX0weIm0kTEm0odqcLnwmxl+IJqsREavx0vU8gormhyMp7gjNFEYr67KNZ16uhWnfLHr
	kwjhhbgjqjNQZyqpZBDSVXy2yT
X-Received: by 2002:a17:903:37cc:b0:2a9:5db8:d651 with SMTP id d9443c01a7336-2ad744683e8mr158321255ad.25.1772048495565;
        Wed, 25 Feb 2026 11:41:35 -0800 (PST)
Received: from arch ([2409:40c2:505a:f4f0:ebc3:455d:5e47:8a2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbaafsm302215ad.36.2026.02.25.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:41:35 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 2/3] iio: frequency: ad9523: avoid multiple line
Date: Thu, 26 Feb 2026 01:10:50 +0530
Message-ID: <20260225194051.8614-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225194051.8614-1-rougueprince47@gmail.com>
References: <20260225194051.8614-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform data pointer dereferences for pll1_charge_pump_current_nA and
pll2_charge_pump_current_nA were split across multiple lines. Bring the
dereference chains onto a single line.

This resolves the following checkpatch.pl warnings:
WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
  requested except for warning messages.

Changes in v4:
- Used full name for SoB 

Changes in v3:
- Collected reviewed-by (no code changes).

 drivers/iio/frequency/ad9523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 5725ab62e0fd..6daa2ea354a8 100644
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

