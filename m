Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A14F3EAA
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788341; cv=none; b=e9qQLpHLNvSQxibbSS9STBf+JnYM1P8hhMX6kg2Xg2l/BJfEHYKqbLGvFIldxDY/VUwxwXdbV3V0sbLF1TkYKceh039hjEn7rdg7uq1Utihn6fULOB5f1zMv72nTrAeWoL+3qsD3Obz+JrwyLiKxND/urJipGV4bWe5yk2KqV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788341; c=relaxed/simple;
	bh=dd1I3r3F7lLJezbJ2c0vFVJogVCqoQehOAJ+ZNxAkyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2/XdaajmwvBzcbLeij8yHcMd0+OF/2X/ODUNJ06Q9u0mFTP7LYP6HgQnzFH1aTCzcBsH6ixMjldF5GtzD3y1PFzsoqRWUP9agpmC5upXKYSx/E4kKNBnxA8P/UDdAJ6+fPy2j90iZ27EUyUHxfB0XrTjZVsyTn93cSEvMM2zaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FesgtJzF; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FesgtJzF"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86e6d007703so2701458b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788339; x=1791393139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o+X1mw0NxxMT1/FtTHXPunXU5xaJlmPTMYaptRLwyeI=;
        b=FesgtJzF3w0/vb6dYh8UubmdgX1wk+8QPfreIeZ64GCGiweOROQXI/rvOWScEl4GCQ
         dSbObZdMFIs11BOpVrRM6Jd9qX95Mv7tuluoMBHbm2hMiBo+EX3z97Zq2Y7bdCFTHewA
         sW1w0V1G4OFYkhQPgyIyG67vQhLJuZbLbpSLwCAlXFQQ5L7mPzsE2fJaG3aPnX0BsB1G
         ylEGTmVB3uYBOoOS6oszZjB+6+bc0UqyQ0gHyIWIYfABa8hNzP1pFwCJvw/+qC8XTF3S
         aU14QYCJ2T7zLy0h3ryf8C0dTDavpoED4XyD47KZTfPl36hjqHYjnp+/NN61CKDaStam
         bQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788339; x=1791393139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+X1mw0NxxMT1/FtTHXPunXU5xaJlmPTMYaptRLwyeI=;
        b=J4GvnQAGosmey0XPbvcvFrWWg55S0RgERT3oNztRQ6h78sfCNRz1wj+lMjQdQw4aWt
         Cc7HeZWQ20j1rvt1PD6z6R4XubBrzXov2FInfL7p6LjBjCNvowDEeRYL0jH+6+2OJGae
         QKA/3P/pKFXem2Y4ilUOz0ND0RKzAocvVY3ZDep7QsJo9cmDKuwH39DyfnstbFWdaE3T
         nosmFPA3aRGTib0K77myDbnvuLRF8kAWYbEDSKRFwzNCgKDrBIyS92QLltkUE9xU/xZm
         1iizOkahHQGhvVtxDsD28iht8erJv90ypPPUraDJpaF4J32uPlK9IiMKn+ziuBH3f4xy
         Ramg==
X-Forwarded-Encrypted: i=1; AKwUvByMTjBosL5GNStcqGiMYK2FT4DN/J/5I46eo30BGJdJ972+R9/VpJAQOg01ll5Auj53vcmYA8AEDN0=@vger.kernel.org
X-Gm-Message-State: AFuF++no4BjVXNlqHNuS8VLvrgWBmLc2IlluZ2qmZ0cCc35uccf6jz7x
	0w2xJiPIPx4ibn5thZE2HUUo7ZqtyfdccxVD804/+OQM1ptyYUNFCujh
X-Gm-Gg: AYBFou3cfY2pJi3Heb6jHEgD+jwr+O2rqNOUG8CJEk0id+H1t1BxpomJO3TgwYlatcl
	33y0rSXruZ4E+8K67eR3sAUiuAvSb2txBTYtaARGd28VeqLX/PRKIk7DNoktLSD6z1yY9whNH7q
	55kK9am4wkUQUf+D2dtNsNXm/Tmx6eIJ1OFr6/OhlwAooWqIiZGjyYsax9V4em3KFwuUZ/BN7sn
	VMG0kt8m5NN1FY1X/3GJCiUFy5fhzyApGmlP7dbjxydQ2ID8aEQ39CI1O6r0TxvP2mrpaLsqfg3
	Z3qOXZVtFDdGXxq3SopNefRapgukh0uJz/+9yFs1XgMU4eAnJzq/1mpCFTGtJE3eOHa3R67vIKl
	7Wc0+77Vxab7E0T+SgnaxuVwlCKZfuISHmeqiP2YiqLV4BnHk+ZZwN0G3e8P6fx8sYP3RROt4Sn
	FYUOgoK2Jz07Le+9vcHD13BjDO9rBcc7JMn51FIuadrJQjryJ3T1hJsyqMdb5GbfDreKaf0C6Qe
	D4yQVUaeTt1ttgjl51j7Tkb532dLEvHr3Zn5LZNeJucoDXfZw==
X-Received: by 2002:a05:6a00:b92:b0:878:3538:8f7e with SMTP id d2e1a72fcca58-8874b06aa70mr1662616b3a.44.1790788339324;
        Wed, 30 Sep 2026 10:12:19 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:18 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 00/10] iio: adc: ti-ads1015: modernize resource management and bitfield logic
Date: Wed, 30 Sep 2026 22:41:54 +0530
Message-Id: <20260930171204.12863-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ti-ads1015 driver by updating its runtime PM
handling, error handling, resource management, and register bitfield
operations.

This series builds on top of Stepan Ionichev's devm error path fix [1] and:
- Replaces SET_RUNTIME_PM_OPS() with DEFINE_RUNTIME_DEV_PM_OPS().
- Sorts the driver headers alphabetically.
- Returns -ENODATA when match data is missing.
- Uses a local device pointer in probe.
- Converts suitable error paths to dev_err_probe().
- Drops unneeded '< 0' error checks for functions returning 0 or error.
- Converts mutex initialization to devm_mutex_init().
- Transitions runtime PM setup to devm_pm_runtime_set_active_enabled().
- Inlines the redundant ads1015_set_conv_mode() helper.
- Replaces custom shift macros with FIELD_PREP()/FIELD_GET().

[1] https://lore.kernel.org/all/20260529183708.17819-1-sozdayvek@gmail.com/

---
v5:
- Reordered patches: inlined ads1015_set_conv_mode() before applying
  FIELD_PREP() to completely eliminate code churn.
- Extracted FIELD_PREP() evaluations into local variables for
  regmap_update_bits() calls to ensure clean line lengths and readability.
- Added a patch to return -ENODATA when i2c_get_match_data() fails, as
  requested by Andy Shevchenko.
- Split devm_mutex_init() into its own patch to decouple it from the
  runtime PM modernization, as requested by Andy Shevchenko.

v4: https://lore.kernel.org/linux-iio/20260827172100.39176-1-architanant5@gmail.com/

Archit Anant (10):
  iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
  iio: adc: ti-ads1015: sort headers alphabetically
  iio: adc: ti-ads1015: return -ENODATA when match data is missing
  iio: adc: ti-ads1015: use local device pointer in probe
  iio: adc: ti-ads1015: use dev_err_probe() for error handling
  iio: adc: ti-ads1015: drop unneeded < 0 error checks
  iio: adc: ti-ads1015: use devm_mutex_init()
  iio: adc: ti-ads1015: use managed runtime PM setup
  iio: adc: ti-ads1015: inline ads1015_set_conv_mode()
  iio: adc: ti-ads1015: replace custom shift macros with FIELD_PREP/GET

 drivers/iio/adc/ti-ads1015.c | 160 +++++++++++++++++------------------
 1 file changed, 76 insertions(+), 84 deletions(-)

-- 
2.39.5

