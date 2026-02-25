Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121863EDAD6
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048471; cv=none; b=j6KgGaspwQFtqFmXex98rKGCymsuZTgQWFVv2qZFXmPYwwf7DTf4+RIA6EN6se/f7l6HsOOLLZ/5KsSfVaVD8JnuYas6tZYQRBrJ20DTI9Kst0qgNb4TD9NIswfRzYeLC9Xiga9TytOCDr4H2ra4pbYIOySCvB6dB6m9EDWG6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048471; c=relaxed/simple;
	bh=yIf0aLAu7vP4qwB33e1y7j5YhrJnPd0BUu9jOQ8vcxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMdzNL5h9OT+hf/6Ew5qbgLfaBhG/FldO+HVTx1CTV8RaG/fHf+pS1Bk0JACK5VwFFmd0QdpZS9NSBJSH2c7rYwDSMhjwAEWBZQo/J4kBMC9473lx017jkkLJVx614gaFCBQcCk+VyW/8JWYXMJz71sAdx65rjBaGdXCPV3U5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4oH/JUV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4oH/JUV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aae4816912so49215525ad.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048469; x=1772653269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4tBd4CTfpioNNSfslD7jE8vnoh7EZ828hanAjhLj6M=;
        b=b4oH/JUV1VxFlR4NJDjISAkuOWCqzHaXE7qu3p56RVj0a+brqmi0oAhLepF9d7hxgF
         Sfx6Xz9B4TRX/m1RcslqFe1PanjTuX9274sExFR0TNPA/z86ZzI6q1SDzXhAfjfxZD6u
         lw28l8OcCuTqUYYl1S3D6MQiA/wRY9kLWJNnZAsOE+vwmjvQuCvoH1aKIZmtCpRCA0U1
         +o6Q6pNhfmNwldDzIBFi+wqZ+Nhbu0s3FQYkppX0nKGCcfyR1jfPPkrcaQL4Oc0K5DS0
         5btbupnhjW+v60jdqcJd4cz441A4Wt/B34uuMGfyEWj2Y2kLYZ34pvLAcdSjQ0lPmROm
         JiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048469; x=1772653269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4tBd4CTfpioNNSfslD7jE8vnoh7EZ828hanAjhLj6M=;
        b=Cz166FiA8t5q3ey1expMFIabNG+Ve/Wd8jmOXsgGJk1E/xx+3W4FsS62QcPr5tzx3Z
         Z4WSdGvYDMDV4TulBzrZYA8fjK2OTFfAknDDfJ34EiqSkAhnM2IYNmF6/IZd/ypSEw5D
         LZB3vb61IEIXF4wmSHJ63QUtjoSxjZGBU3BTGhjoRvGZerjkHTyj4RPwlkXjaQ8mxwo8
         56vvtZRIuco+1axPPYYxBRDWl/03bpdghvSlVQR3KLbuDtZfjaOQAmfzU8yLJHqi5Fuk
         shm6WbXEMqQJaG0Nd96lVizg2lBqx0f1Ac5w3n3+amf33IDmUn7Z5BAKILmTzp3Sar7h
         I1kg==
X-Forwarded-Encrypted: i=1; AJvYcCVDy+RJ/EF5r/E6QoWl/8jeYSsxp1tAkOJmP3DcSBDiL9J31sP2AnAGCQ8G+5OTYAUJaTFm5zu7uq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5k3LfzIVN/hLvil/RM+NQFhWhMkt+fcXXMHVNCq58QofCg4mJ
	ThsDmtb+cu1/s+QD0pxH8kU2oMUCWPUdo3XAKSk28NQS5jsqtaHI5aV6
X-Gm-Gg: ATEYQzw0IT5qywEJ2r+9M8BQMfapPuBJnv7TQbDK2aDb3Kvm5kMttbV5D2xArKi8DUG
	0em5FXM0co5nPpNGo5AWo5jDv0AqypBYuAO9LffCyXN5WOHsRKgf7Zq37zEimTpAIL+x9Fj5434
	lvQwDiB9fBg3Mel+aQt011D1/IMK7rzqtmZMWNdkqVxY3foGbGv5khyF1qvQawKxdPsW98JKq9c
	VPR27KCvh6ip7XbjJ3nPdDi8/p84hO1qOgLWsqzSaCvbm6B1WfUF7c+gl03QzrGoEP5nEGypX5Z
	Mw2Ym4uOVk7TcGwpFD7+Jy++xJHi/zoKA5TkyUO8E64EEBlrYa4DdT3tC3bJYCygX2PVGulJf8c
	q9lDFuWUdV0bj3lPj9BGMlDDgARYD+Bl7UZJz9i3zsdBlPi+GG2DDIyCt5QdYCL5wvj2c62xs3p
	UO5CCoYTHXAluYFY0rjOf71+CM
X-Received: by 2002:a17:903:b0f:b0:2aa:d608:ec55 with SMTP id d9443c01a7336-2ade9a3cafcmr11660475ad.28.1772048469362;
        Wed, 25 Feb 2026 11:41:09 -0800 (PST)
Received: from arch ([2409:40c2:505a:f4f0:ebc3:455d:5e47:8a2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbaafsm302215ad.36.2026.02.25.11.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:41:09 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v5 0/3] iio: frequency: ad9523: fix checkpatch warnings
Date: Thu, 26 Feb 2026 01:10:48 +0530
Message-ID: <20260225194051.8614-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches address several checkpatch warnings in the ad9523 driver.

Patch 1: Updated the macros to properly use their argument x.
Patch 2: Fixed the multi-line pointer dereferences.
Patch 3: Updated symbolic permissions to octal (0444/0200).

Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
requested.
- Collected Reviewed-by tags for patches 1 and 3.

Changes in v4:
- Used full name for SoB 

Changes in v3:
- Patch 1: updated macros to use '(x)' instead of 'x'.
- Patch 2: collected reviewed-by (no code changes).
- Patch 3: fixed vertical spacing and broken indentation.

bhargav (3):
  iio: frequency: ad9523: fix implicit variable usage in macros
  iio: frequency: ad9523: avoid multiple line dereferences for pdata
  iio: frequency: ad9523: fix checkpatch warnings for symbolic
    permissions

 drivers/iio/frequency/ad9523.c | 88 +++++++++++++---------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

-- 
2.53.0

