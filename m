Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F447CC6C
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851295; cv=none; b=BSlUYqGmbmC1Yn4K/AbdYE9uogDBPvbF4nK9OJ+Q4rgz09LJK8AcFnI1xvP3JH9En8Q+PgOTB5n9+MV0+SxxWW29OR1zrjqdDLxfg8eYbgV7ks9rJOV9WueY/3k80Gw3JL0yO2hjRk5Vog9aJRPrXGnH9A6pqrO3SlrxNBa3NUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851295; c=relaxed/simple;
	bh=TUonyImlFY/rVwlfDRO8v/UDvMzUF1i/lMk0MIe4OQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGmpSwINwjNbP8Fv5zj7jkkcywhq6Hyu/bzCk72lVwmKMMYUqWQCs8HEPmywLBZLDly0cKEXafVgqhi5MTtEEaf8r23Ww+E6h3WzPV+17VGLwHoGHPpw6sX9vA5wFhXtUH+P0uf/9Gpt1ddGDIU0IYQu2nSzVcW/bfKFJgrtEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pcw5T/F/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pcw5T/F/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so219049a91.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851293; x=1788456093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F4arbSueCZ9tfuttAJ7Jp1lnf9RoIfNdNZ1KOU8xkt0=;
        b=Pcw5T/F/ZBt9n41E+hERCR85NlqKpFAI492ZQceN39hdQCtM3T8eEQpf/Nl6Csi9QM
         S98cKf6csMDeaAgh/Se5zRR6/jXWQaYrSGvr6dk2+MAr0xhfcECiXJrh8TEBA7PWo1Lu
         O4gVuhMDKbjuK56klQ2FPSjg+XrR23s3XJNq/4hfw4J2oRQLUZJqiifBpzkLvsFNNjJM
         PD3lNjWVQWIpYD5SnL1ukcbmOTureBZhXanSkAuXa5mI/6pxCQcFll9vbmvqDco526TH
         Nim7+yaJyJ1avrt7W9DfkM1nct3cei9TYhr38766VLT0NMpkWlOl8M14kGrZvhRIdrfk
         KSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851293; x=1788456093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F4arbSueCZ9tfuttAJ7Jp1lnf9RoIfNdNZ1KOU8xkt0=;
        b=Do8jYf7OO/PXTPq3XNe49jRiDSRLKtn1QSfLOVzsOfpguzd2SpJRUMTcQrfrTHMfCr
         0k2ueRHkBD0RsFivs7MaAl2nylBivxjrv/ZxHstipirLq6+g38TNs6VSTgCliSm8kn4O
         06ivHeQmyWkb24tzC4bOHRwzQyZo+3D7j3ZgFnYCalWptSzLWYoO+HwscGWtOrvII+GX
         L/jFPMNHSLTeCgNI/KhTE6UD8sRy++irTjSK+NMn5DuWWFHJ6oY33NVjjRMXtVOg3yhm
         Fl4auKBmbt6s0MzQs0g3IyNIcw71ZHt6tbZ64CD/MStkRIk5Npel+lgN1RSzMC1MrU+D
         YazQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVjMiDnH79KCyHyeyFTi1CP/iW+ahs8hOead2kCwSccvkmlDfjmIETR8dF2ZzPQJEXWM8jEVektIM=@vger.kernel.org
X-Gm-Message-State: AFuF++m3Bn6V+wvwPQDmoyu1vWRnGUstcwmmcOf+2Iul01IY6gvJFlWe
	e8rh5yp7A71TZw0Z+Mnmb2csLL3mYrV12lOiq+VCp01W3srmTyNNSFJW
X-Gm-Gg: AR+sD12PQ37NE5QdAynWl11SKja/JO6rDGqtO4OfPV3JYNDnUpsGsce6E93kpfV6zgI
	WaCZuKzrX0dVy9IdSX/grGoEKJNBlXgDje865VukggWgEdOyQYvUqx8iLZyi0iM1tBMST6+Umk+
	ZgCHy340AfJ5SXeQfcyt7eIO06BcK7mtxr5e8akPogdz03hqAnZm43GThKKTP5nqbGaosNX3izO
	1Nl/H4Awjvisju/uxgZsCDr4P7tzDnmvWInsC14k5BkDPidfxE9TY0FwhkWBBXm6pqyvM4x/LGv
	bdI8uVgJo27SB+gUTuTt6LHklQNPCa7pyBHssBj0xc+cLvevOOnTo2BYQkXvIb4i40PyLNQdF/p
	5Mu1gUlUouA3udiq63Hro1VEIes8eU6F9wA70ZYMCpdiPSiuuf33GOxKj5T17msEDQhdQU7y4JO
	F71t3nZke1f1GBlyumzOI8MYpasUrgA5dA4LcdMNzdWjzLieRsetXw3+Epe6QahqWINnMVsUq4B
	FoSnoEG2dCIHGWDxqK3XR8IN2lyz1ZxZNM3
X-Received: by 2002:a17:90a:e185:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-396d0ecbdb9mr1509289a91.6.1787851293068;
        Thu, 27 Aug 2026 10:21:33 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:21:32 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 0/8] iio: adc: ti-ads1015: modernize driver
Date: Thu, 27 Aug 2026 22:50:52 +0530
Message-Id: <20260827172100.39176-1-architanant5@gmail.com>
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

This series builds on the series [1] and:
- replaces SET_RUNTIME_PM_OPS() with DEFINE_RUNTIME_DEV_PM_OPS().
- sorts the driver headers.
- uses a local device pointer in probe.
- converts suitable error paths to dev_err_probe().
- drops unneeded < 0 error checks.
- converts mutex and runtime PM handling to managed resources.
- replaces custom shift macros with FIELD_PREP()/FIELD_GET().
- removes the redundant ads1015_set_conv_mode() helper.

[1] https://lore.kernel.org/all/20260529183708.17819-1-sozdayvek@gmail.com/

---
v4:
- Rebased the series as requested by Jonathan Cameron.
- Use devm_pm_runtime_set_active_enabled() for runtime PM setup.
- Reworked the register bitfield changes and inlined
  ads1015_set_conv_mode() following review feedback.
- Incorporated review feedback from Jonathan Cameron and Andy Shevchenko.

v3: https://lore.kernel.org/linux-iio/20260812164433.23011-1-architanant5@gmail.com/

Archit Anant (8):
  iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
  iio: adc: ti-ads1015: sort headers alphabetically
  iio: adc: ti-ads1015: use local device pointer in probe
  iio: adc: ti-ads1015: use dev_err_probe() for error handling
  iio: adc: ti-ads1015: drop unneeded < 0 error checks
  iio: adc: ti-ads1015: Convert to managed resources
  iio: adc: ti-ads1015: replace custom shift macros with FIELD_PREP/GET
  iio: adc: ti-ads1015: inline ads1015_set_conv_mode()

 drivers/iio/adc/ti-ads1015.c | 153 ++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 84 deletions(-)

-- 
2.39.5

