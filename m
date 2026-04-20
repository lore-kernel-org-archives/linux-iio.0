Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CD388360
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673487; cv=none; b=Fqj1ez2TiCEJ+UyBo1RpVcryT3lbFYCA6uaoD7rtl1J9AbyhVYBiGcBoUwPnXJVg6PDqGMJW/94VfdVYhFa9csb3023P/E/1VfZ+AaCfvubx84IDqwuHvP6xOyjWNrQ2BLZyeOqBK0/DIPaq0aaX+XWx0DJk2THqpJnd50sqSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673487; c=relaxed/simple;
	bh=Lr8kUyIHvNKl2R1SYvP+op9vdcsSpWm1kCDtDV1J9iE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1uXbbmHEZkZdzYFXbMQFU3j5f4gL8kM+XMlpSbcJTwWY4RxD3dV7sTjJkd0T+A40S9JTSLJrqep6WfKvZJC9rSmiEs/ezdtynwEJomBMVpzvU8k/WAZrO8nKKChCRa2x/XBrw5Ke79hJtepnAAkKM2dK2O2oDLjUZXkN+739Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOM3UlN1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOM3UlN1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d90833cacso1614320a91.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673483; x=1777278283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+h4BSr0vg2KmncNClXlM0YEviPH3JJGrtGmbcMzsxY=;
        b=ZOM3UlN1k/6qkt7FtoJ3RZLzQwAK+KeUkjczjvwMVWkYBES8jOxGQdGwhhExEtSUWf
         Yy237Um53PtDtRAo2Poc09f/i6rBSMGmFpsZq3Y7BrYj3Sl0apSFHUIjtVGaO5t6Mzgp
         clPNfNJypzp4g/FsxEwr/nrKofakMwTWzHfwhfW+el2oZKyOVWKQ2Zy33pYo36SayfFJ
         +arNGrZ0WgQtp49m63IErMOlvvlU2f6rd9TYBE2Absci55vI3BpjnjF34qGOREnujVLI
         1S0zgScX+yUo/k5WTfrLr56UACSmYyg6d0sOUYSmMan/IQ2JODZBIhIX+MaOZ4X77AsX
         N73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673483; x=1777278283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+h4BSr0vg2KmncNClXlM0YEviPH3JJGrtGmbcMzsxY=;
        b=cdksxXX7rhc3ynbgOfpSgnRnvdgnRQAZEG7CBu0QoIr/Ma7Z6Qk0J414Rs9Ge8CQJ+
         eN2MQwuRRzEW7w8ELcwfZdvDgDdzTq4o/Sm3hlLXgvykpwUQZ0UpYj3O3AseZA6id0kF
         jgz7NkeQt4HMbHjvTQ5Wf/oexKeH6Ql7E1E+LLJyV+37VD5H2JhrI+AXWa1ijSmXTrKb
         nN180otbWEM2HAi9v/V7XGaZoKCnLHhak/SWhzvpVq1vwTlYmhyArKDlgTcK1FKkARrC
         /gpfmnXFMyiZocW5+a04CiX6p+/yp7rOnrsLF9MRvYDkJXbNpkJZvEmJ9x9c54aUuahL
         dZgA==
X-Gm-Message-State: AOJu0Yz2WL8aC1iGtlY8mFBNuwc3algstwSIpm/0hxVYVDtRQHlYSQj6
	ZWlFVbOBSUUZaG30mXiv0HzMCkI88V16kCGxGAA3cm5EFn9l0kByin53uW04pbefsQ==
X-Gm-Gg: AeBDiesYUe/h4S21Oo3cWg302ZxmBqFW2qRNTdZl3T+FBjIhPY3eF4TzOl64bYFj9QA
	MNYz1Lo+WpWarAblwB6g9e4QyG3C/nvMoHXMp8dp2tRnKRHQIA3v4AfEl3DZZ4KL8jpUwSKxh+F
	EXMnbaynBttYnQw3t7roh/eGx5p4MHEHnNQVSlagb+ODJbSiglPQ0z+h5MPJ4lHW+2CXLnItwsb
	T2NU2iT8xYngfnSGYHIYur2OePDDvfHEdnB7NsQH/aa9Rf9PIw8stkRFA9xZC7vrTTFcP0CknBL
	c5+rTCQ8S3J3QrhYzmfeBsLqfeNBASLU7GocvfXIVJvrw6G64yGfg7+ZFKDwt/kEzB5M41FGpIH
	J66ywJLaSfCV8qrz2heU0mji0ZWCkkTwhO/OtJa/5wSjPINHtBE/9LhhTwxMGBpkquM6kVLrZV3
	pRcEfD2z+4V8N6ncM7VgzL9FRx/I88ULLmod+vWanDUor9u8fJ2yd/
X-Received: by 2002:a17:90a:da8c:b0:35e:581c:6bca with SMTP id 98e67ed59e1d1-361403ca597mr12990415a91.3.1776673483027;
        Mon, 20 Apr 2026 01:24:43 -0700 (PDT)
Received: from nik.. ([101.0.62.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20e80sm99464395ad.57.2026.04.20.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:24:41 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 0/1] iio: chemical: bme680: use BME680_NUM_CHANNELS
Date: Mon, 20 Apr 2026 13:54:35 +0530
Message-Id: <20260420082436.7223-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch updates the BME680 driver to use the existing
BME680_NUM_CHANNELS macro instead of a hardcoded value in the
scan buffer.

In the previous version, the macro was proposed for removal as it
appeared unused. However, it was pointed out during review that
it is intended to represent the number of channels in the scan
buffer.

This version addresses that feedback by using the macro instead
of removing it, improving readability and maintainability.

Changes in v2:

Use BME680_NUM_CHANNELS instead of hardcoded value
Keep the macro instead of removing it
Address review feedback from Jonathan Cameron

Suggested-by: Jonathan Cameron <jic23@kernel.org>

Thanks,
Nikhil Gautam

Nikhil Gautam (1):
  iio: chemical: bme680: use BME680_NUM_CHANNELS for scan buffer

 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

