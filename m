Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A2421245
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902418; cv=none; b=LVDXyPfbBG9oOCdiUKsc3x4z87k8Xi7mHoX9j+OlYrAJa7tVF8O4/ccq26vx5nuhK5p8PuvWx0RwB+edHx+AKBaPimM2/6qoGt72JX9J/hz3b6srf631JuxUaHNm4qB+bMdMbOmtTwB+7p9tq4H4xLpXTsK0sn7S3MHdv6TagH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902418; c=relaxed/simple;
	bh=z93uA9eVPPPE+/UYifdKtIesam0NYWgxTBqS3zlFsM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ctn6ncmSqk6Njf09fvhfNEdh8ctLKumQ5gfqN6yo4gjqwSwul64tT6XnE/RMEg7RlWLk3kdMEBIuNW4VEVySIdoYc1JOS/P05A6qsQM3ojffVEtHuaSXMBCik+HTX8vfdYMIpP5JhhTLPJTiVNO6WOlXWFL2lhi831Le4TCtR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dssAprsj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dssAprsj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49e73611928so32151255e9.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902415; x=1792507215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7sT85pHsC4yeFSJp9w6DFVT3d+NHjHi+Irj3RfF2og=;
        b=dssAprsjoeKf6hg3Gv0rzc2rbo0NHWVnELEZIKT87O577M0DlRlJpolldaEovutbJH
         t2nmrQqlVzzeOev/1gTB3PR86ltkl1cuaKnl9+un5VS0StMa4wTJYfb44V3vHDIEyvhv
         FBJzOjM2wcDrOY4fCEGLGb+3gmQMD0T3V4l3DZc/djzV7JL5iJB3fVMWhwM9yXXfFpuE
         /qF0tbaAyCvrAq6Lp2Oxs28wcODUFyx1OcvOxNI2K9anWNZWcyjQk+lOqMUP4751LIpp
         x/6MwaqaPxZhUE1Pe0loyhzSkjS63660rFfSR6g65/ZPbX3JQRxhQJ2a9wePscCjLtit
         r7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902415; x=1792507215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7sT85pHsC4yeFSJp9w6DFVT3d+NHjHi+Irj3RfF2og=;
        b=k8QYPpFfta9FNQxMXUkU3nGJEclZteKQRE1hVdJcmFfEaHuZAmT4NUuVAofcssmDtT
         nEAcEXgZHk1AC6/VoKircinY14TxTIp+3KhdgbHIwHToo30mftyLTsjUPnx3ur5i9jKR
         gr2NcS4HaRK/FtBIAOzyJpSKSiBq9hhBxXPQdcJBwx3/5pzh8GcNEaKCLapdV7tzF1cT
         uWWzf+h+pYYw2UntTQ22E7Q/xNQK8huCt28Z0JqPc1T3zbHZ0X9pRSGT8LTBdWDzenBl
         1Q4FDFEc4Jpqo4TCrcSKjxs12489HvxJSBbolDxbYwOIrTdsX6pO40MxeLAU3lSpq4Gx
         KoCw==
X-Forwarded-Encrypted: i=1; AKwUvBzqNrDFl+lpTUCPRrPL4FHmZzv/BD+WKVwdFAO7z3Z2RA5K/sqND3DEYwbGf2ZtRwkCpaBb0E9s7MA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcv3DGjRCxNJSkFJ9hxt3SOkmoSJBhixhQ+Y9ImNyPpBEmlFDK
	OvT2P7WhuWUb0VLmaQdSNdJsBjaSPWrRUv5DxQGUZJOhWcRKze8U4rtQ
X-Gm-Gg: AYBFou2le2fmmB/FMDGlxApcaTL89nkS9HhZ0ReFtFK19qLTcuDVbSSlCgDbLhLcEdE
	A7ls6lxOaxgsXZUeZATlhJKG3Tvw1CPCVE8q1qnp3qVpfgCWLQwzc2AeM/QfwJEQqT5vEezoG8u
	yE5beWvKX/Tje0vfBBPJaoVZ23/TSgVZIjyaUUXrY5j1wdF+Nqx6p4UuA/L2vlCO3WKKBp9bYlC
	9jtGwkAa0U13KA7UlsKPgxO5HFw5IpRjHC3lHy8qd0WmkI9K5dbPb/cq3lhb/UiOqJmwq0TMCwE
	OW7zw512vhoTHGYFsqYeH6p289wGsGT+poVBNTft5OakuILMxnvLOx49XCYFcxYXhsHBega5hoE
	sLQ3iskO9jgpWSEEHOIadHT/+Og7uRGYEZWAVupdWBAoytkT2knZGujeyiEnzedehGsNmy30C81
	WVGS219Rsu5Xkvw0piLQ/ZUOMPw0aVS/dH8Tz9E4CY04vkt7ajLBKF+R4oemkecyMUlq3uasuWL
	OHMMd+kUwf6ibH0DXxYLs+9jMMw6FopoA==
X-Received: by 2002:a05:600c:1d0a:b0:4a1:7f96:9b42 with SMTP id 5b1f17b1804b1-4a18e4a94f3mr236923185e9.15.1791902415551;
        Tue, 13 Oct 2026 07:40:15 -0700 (PDT)
Received: from mm-ntb-00805 (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6b3cbsm294892585e9.0.2026.10.13.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:40:14 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH 0/4] iio: light: tsl2591: fix lux calculation and precision, add I2C ID table, report saturation
Date: Tue, 13 Oct 2026 16:39:39 +0200
Message-ID: <20261013143943.436816-1-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

This series fixes several issues found while using the TSL2591 in
company products (Raspberry Pi CM5) and when testing (x86_64 laptops
with MCP2221 USB-I2C bridge).

The original field report found that the illumination value has always
been 0.0 (caused by division by zero on ARM).

Patch 1 fixes divisions by zero in the lux calculation, which occur with
LOW gain and short integration times, or in darkness when CH0 = 0.

Patch 2 adds an i2c_device_id table so the driver can be probed on systems
without CONFIG_OF.

Patch 3 makes the driver return an error instead of a bogus value when the
sensor is saturated.

Patch 4 improves the formula for calculating lux values to make the
returned value more accurate.

Patches 3 and 4 change existing behavior, I am OK with splitting the
series into two, if that makes things better.

AI assistance: Claude Code (Claude Opus 5.5) was used for research on
sensor behavior, datasheets and Adafruit library, to compare results
produced by old and new formula, to draft some code for patches 1 and 4.
I reviewed all of it and tested it on x86_64.

Jan Remes (4):
  iio: light: tsl2591: don't divide by zero
  iio: light: tsl2591: add I2C device ID table
  iio: light: tsl2591: report saturation
  iio: light: tsl2591: improve lux calculation precision

 drivers/iio/light/tsl2591.c | 58 +++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 16 deletions(-)


base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
-- 
2.53.0

