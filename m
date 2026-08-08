Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D5346FA8
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179648; cv=none; b=EYTff7P3HfbSfognbbyheshYkq0UBHyr7HEZ831zMfp2AADadMH/5VZ8Skkmtqw1MWcFTYbr25Iu1hjyp/zRd/A8iiJpC40/yVUW+YNGatwqrKT61sHxfHwaAleGb1EmQP+mls3V5NN1GCK3Jk5z7dGWCAMGlaKcpmq0xhRRNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179648; c=relaxed/simple;
	bh=qxWTv8ASCjnCZ6TSATakBcbHMCZGrem2cbfSEhGoUeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIeRkuEmHUIHbqXJuZMHvo7hXuVtwE3+A4SEOe3YXAK+OYWLWVne2jK9F3ZIJF/+4iXIUaT6a8uxIAmtHqiWcW1cFpfRz/BySGauAud2orYmsujI+sKmjSvBazs269K8omAoD85s+XRfwbYWlr0s1OBJrQoMNLgnamijn+zME1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKwFCzcz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKwFCzcz"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84847482584so210080b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179646; x=1786784446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yt88+cQt+lLHD2Jf2jU1wGbeT/wb1MRSKM+kEtCms9Y=;
        b=CKwFCzczC13fvKgngW6oNitU8eRyts1zXKWl1b9okwT4KNsAAkVD1eXr9u86tbLMz7
         Xoyz8YE8fWTk1ngNiU93Hlincly+idvpONyk41JtaIyWLhXO6+HWxSNgj1xSOe/a+Jau
         0/CbiqGS2sc5Kl9lxABJ/s809Ewh9vHaF69c6IbVhK+u0xpLMB4faCiZ9CLXW/UqQ2qo
         pg/XMG8XFtmrR/mw3wfuBfzA4TFp05zGA/wsJBQXMNgGJGYhvY0d/BJcj6NJd0z7Zxc9
         uPOhpg8lJoUXzmqIem2d1F9vpDCqpze0fNKHiUWx/74Gj814qaRiTFsP88bFwitIPW/9
         P9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179646; x=1786784446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yt88+cQt+lLHD2Jf2jU1wGbeT/wb1MRSKM+kEtCms9Y=;
        b=f/+4g4TWMwsyDkP9Ob/UMnrDp3adFaTdr9+IekEIuzoGnnnBqoFiccKIGvpcJRSWyv
         HM7gmermsIC0zw8PZRj7FpMc1w5IqSFWpXeO8zBWAtApDtqC3V0eXvJLGuG7feXOzIya
         deRL8zfsF9GYFeu4E5jo4hcKOB4yCtMH2OwoXul15RZ0ILtTPRVV8PpEaHJvcZYm3+SU
         VD3sXxNQ6bxgFiB3KSj32o2QJTGEgnLTlO0Onh9dL+9TpQiuso3rvdJgpIFNCgxByH1l
         ih/dzpsfIIssi7GARBSq9XQ+1T47Ez9F75Bs8eEWiVRI1v1C+d+Z07T8VWYX/RGguDdA
         Rcig==
X-Forwarded-Encrypted: i=1; AHgh+RpaqYGzvxQmgqdBj1/ybbiB6ePX3uOXDLdL8YdhnMhqIDdcq0fWSABSTYIPIWhOXg/hLVkArabhHcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv71qrcPZrDTeG1fl1XzbxjKvG1sfvjke4TlvPsGv7lJLqdMPd
	rocuPlxLvU1/hQaki4bOkUV4kQr9oMDRMNyfsBmdjULDHNbgYZ7CvTqk
X-Gm-Gg: AR+sD13tediAaHRdP7E8LtDPBwJCgtcWFjwlagVPmfKG8fCqYb40hAH0XMElN0Zc5M0
	GwXFCx76cw2QcpLxOu+YileDMvG97Vk7bGcsqAvwtvzFroQPh6To8J+DdvNBpsX/FbT3yBMH5a6
	WFzx0IObsqCNydFz0MDcmPrap245jYxa/vv9vLnuJStZY3v19KM28gYJJ54Lx5wXjSb7L+dH0AF
	ucI0NtcseCNhkGDPvZyjhTDSQmPVfAWnw9ZDxrfLhKh5NPAu5Mb93WimPV9I+j+PFB9UJfuWkUJ
	mDPEKrWpLBQrvj8BMbzQUjkk8Wah358q8AqujVNrPIdyITR+cEGErmwI5b/snIJnhnmfbJQzUSR
	4vi8rST8kCTVO+K/gS59YcAVUUZqTHAplypRGip+cspUzMM5VXA98dNMEbzmXX/hFWrhJtIlE4/
	3NKksKpGJJbkZgxJU7tpwtdCThsdGZ1LZ7oEkJufNnFzWliL2PgUmw+HuJyeNLLkzbCWnD316wu
	B9yaPm9RmciQia3XMtRu4mpSMmkZeHvjcaWjBzrB26Le8yQBBaoo5GNz1raCg==
X-Received: by 2002:a05:6a00:3d0a:b0:847:9d6c:a56d with SMTP id d2e1a72fcca58-84f6b78b1bamr3840408b3a.12.1786179646272;
        Sat, 08 Aug 2026 02:00:46 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9f0sm1973871b3a.28.2026.08.08.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:00:45 -0700 (PDT)
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
Subject: [PATCH 0/5] iio: humidity: hts221: update probe and logging implementations
Date: Sat,  8 Aug 2026 17:00:21 +0800
Message-ID: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
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

Adi Nata (5):
  iio: humidity: hts221: report available values via read_avail()
  iio: humidity: hts221: Add a blank line after variable declarations
  iio: humidity: hts221: Allow unknown whoami for DT fallback
  iio: humidity: hts221: use dev_err_probe() in probe paths
  iio: humidity: hts221: fix division by zero in calibration parsing

 drivers/iio/humidity/hts221_buffer.c |   1 +
 drivers/iio/humidity/hts221_core.c   | 171 ++++++++++++---------------
 drivers/iio/humidity/hts221_i2c.c    |   8 +-
 drivers/iio/humidity/hts221_spi.c    |   8 +-
 4 files changed, 85 insertions(+), 103 deletions(-)

-- 
2.47.3

