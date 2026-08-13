Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91C48A8D1
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635107; cv=none; b=Mi+xyfB9udKATub38mvRZGPsSna928iENDs8vq7C5LCz6VaMN0naLxj0HZGf2+1lS1aKXJEvq5HYJ6IhDKDkmwhg/cQP/OXEC+sMroEnSq4zRrgcI3RCvBFekAE/DwqKvm0CAqiYCQsdMiFj2kvXNvDEo8sQUd/V3/teYsWw/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635107; c=relaxed/simple;
	bh=3V58kFwXBYHTqu/lknOdvlSejNFDj4QsTgxXWJELNe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8Vh4OBuTywxl8WeeqszZLRnrbhYObz3P6k2ocS7HJR9a9V/+FSvtuJzQuOsMcfCLqh/taUAbUYXNev0pwVY4Q4hDSDmRNX4Y+cyAwrNQHhJlXOdDGDEvu/srs3IM5Mv6eu+/mLIkoImu8g/akhUdJ4tZsJA1W1G9GS2htO6k2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F57aYVKU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F57aYVKU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cedda2ce6fso515185ad.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635104; x=1787239904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mMrmCE/vqNNHJNQcz/hlB7uwFXJ2DVitmBQZAYXHgA=;
        b=F57aYVKU0WPT1Jpm2WCEdWyNR+MpAXYYty/DIC7HaONUAbNhK6mpo9oq3zS6YBLDh7
         oseprnnDbA3Me+w4NhV7Nz+kdNmz7yfGqKh1J43blF8IdyBd+XpbeJ0RqSWQUOSWNaNn
         hFG4MGlYtKqognkUhXasvrT6olxfETvorCkYk9aP4C58aJjFBydLbM9LIZEzjwjWgCam
         S+bVw8Y8qVeIYTizJ7sIsJJdFbaCNG1/paYvg8PmxXMSEpe2Hw1KoGCTEftrbym0q/Ma
         lF1IdXQGJStg8ZBowiniLOemPOMat39J+of7HgWJps98BojZdQ8RywnmzHPymjGCNjPB
         E9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635104; x=1787239904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mMrmCE/vqNNHJNQcz/hlB7uwFXJ2DVitmBQZAYXHgA=;
        b=Fc9i7w6RCh22r76lXuIiP0Mxg1bAqsFtG2T2p+EA2ZCtB6E40aTLhnNqynJeUca2Qe
         fxHLQz4kEg4VYI0kMnvvlO+bQOS5EZmkaMDCmtxoRNofIJ0Drk1K8ddiuZMIG6BDap1u
         NJ6UXy2ZauKGkOtN9tWWSNAOhsBSWxleMPNbQHtdpR0QR/UsKLn4EVkGy4qKPuncyArN
         x/v2dMw3zim2c0827CWiROTJyLgB+RYn5WgFYOXxoTY7yXu30NZ0rhmsjPIHajKXRm9+
         TBX8IqHy53UwzAToSNoD2HInS3+ikfEbhfdTb/+pX/WMPlm/ybWwiwwEuaOWSVw4DenH
         Dcvg==
X-Forwarded-Encrypted: i=1; AHgh+Rpcl/uWB/lTlHQkyw0gtdTDvLdzQG4WZ0SymlTtkrbadBMAj7zhrqsyhOzT3n2tgqbT6VMDaEQ89i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9A4YDcmkLap7SOAfRJAs6O0Khyz51T6GCJI110HdkS6t1yml
	lLB9gapn9f+62Wybnf3HA1z2/3UFgjvOy29SxojxUgd8OFyRMo6G4LHO
X-Gm-Gg: AR+sD11NbyQ9o8JAn9p0VZXhXgOJKKxjrV/9TjqE9a4m4dVOPMRORbA3RIx2+Z9slXA
	q5iNt4fqckXG3XEMAGjyQrQCO1pBSz4ey/Kq4oybP9Gsi/i+NlHj5qW1+3I5wE8RJ8ixGFhUQfd
	Wy3omvDDjqqcvFgP076PuZgzBuQOb/89IopFrFfJnUJNrKTExmTBLAg+uwE5LS9s1AWn2b0ebHP
	P1eN+ThU8pfL70qSBNO/L2nofw3knkKLtLwNf45yoOtGHF2vsw+ErK8noxglYkke+cEJn+sYHhD
	FkD5A461cjcm8sJsHmnbmYnrgzLQ5E8tJVhLOeJ8okzN/XiRJelL+ZY2uU/h/Xayyx6ycPytJ5G
	RXXptMFCOryWJ14gGHSANsefb3MjQRSg8Wf1jwSN5s+3ynNcEoNh/ptoy598ek6PYnQ8ER+9fkQ
	kXx2vNrP0YEau/XG/vllhvChgYskNc/n/pdb4LEUeb0RZEG021D5nEl96XQR4xnqIXB8ZCt3U0R
	qlbSeH6fxvsGCknoMfZXzEne+sMODampSp9d4tEkvjaUVakrRWeUFACHWBTPA==
X-Received: by 2002:a17:902:f647:b0:2cc:6329:b7ba with SMTP id d9443c01a7336-2d37ebb797bmr82446625ad.16.1786635103822;
        Thu, 13 Aug 2026 08:31:43 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec082943fsm7960604eec.29.2026.08.13.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:31:43 -0700 (PDT)
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
Subject: [PATCH v2 0/5] iio: humidity: hts221: update probe and logging implementations
Date: Thu, 13 Aug 2026 23:31:24 +0800
Message-ID: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HTS221 is an older driver. This series groups a few small modernizations
based on current development practices.

- Report available values via read_avail()
- Add a blank line after variable declarations (style)
- Allow unknown whoami for DT fallback instead of erroring out
- Use dev_err_probe() in probe paths
- Reject calibration data that would cause division by zero

No HTS221 hardware was available. Verified with checkpatch --strict and
builds of hts221, hts221_i2c and hts221_spi. Probe and calibration
error paths were exercised against i2c-stub with register contents
pre-loaded via i2cset.

---
Changes in v2:
- Use a local 'dev' pointer instead of hw->dev in error logging helpers
- Fix punctuation in the commit message of patch 2/5
- Adjust commit message for patch 1/5 to include fixes due to ABI change 
of in_humidityrelative_oversampling_ratio_available

v1: https://lore.kernel.org/all/20260808090026.34187-1-adinata.softwareengineer@gmail.com/

Thanks to the reviewers for all the time you spent going through the
code and the comments.

Adi Nata (5):
  iio: humidity: hts221: report available values via read_avail()
  iio: humidity: hts221: Add a blank line after variable declarations
  iio: humidity: hts221: Allow unknown whoami for DT fallback
  iio: humidity: hts221: use dev_err_probe() in probe paths
  iio: humidity: hts221: fix division by zero in calibration parsing

 drivers/iio/humidity/hts221_buffer.c |   1 +
 drivers/iio/humidity/hts221_core.c   | 168 ++++++++++++---------------
 drivers/iio/humidity/hts221_i2c.c    |  11 +-
 drivers/iio/humidity/hts221_spi.c    |  11 +-
 4 files changed, 84 insertions(+), 107 deletions(-)

-- 
2.47.3

