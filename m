Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E063B27C7
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020769; cv=none; b=ghY6k+gR3Ot9i6RmijK55YmVD82WsqW2qiBtwPdrP66SMKs0ZyZUtTMJBdPnvfkMd/DwWLz6hTIc2Xyd7P1QD+KmM6w3Ibz+p+jcF7A0blceqRjus3LkXTANPcwqbs5oshK9UD2HGTK7CFks507jRKULaUzk28n57kxd2V9AZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020769; c=relaxed/simple;
	bh=JRj39m44UG7x7nuL83AF6glKV07IjewUYbAQNaqM7lk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JLO5lRfXpmn6DF9dTuGpdJu6uqOQ2QOgdjlCeBJhn7MUommH8jmqCK1A0+lSIiJx+5/gmJ56J6jhT6RLi79INZKZBbWpPKTB732QsZtogAm0+YabJk1xGzDjm3mFTkRS+XzvJc9OSWS5vGAxpUknTgEHjt+q3SwBBxlAocbo5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY50TZ9E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY50TZ9E"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so19580885e9.2
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020765; x=1788625565; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qCJSMZoS0QNd9wZ2SP5uBlAyYhJin6wW0R5sadc6nCw=;
        b=dY50TZ9E7jYtz27W5ZSHELio0WReBYA6z4GXq+H75nIN1LmsF98GKgA7QdYs4nE/me
         pDW5u5q8BipNXYnDEDokRQFVCfsCEkjOmGSlMO3XoqKvAv6FeVHSF3/RI/i6gcPnA5HK
         XhTS3yH/GqjC2u6LDmZgKoaC5tIrmg+qqKwAy+I1/lIBVeOBgwxAMemI6tfJ7eShyZ1C
         dyPQzoqqnoJs4Tj9GqKMVcl8qswKv07320v/zC4Cf+Ix1/xwj8g/QilaFTBAjB68yqaF
         vPQsAlzAK+KisroZje1xoIgp0HM+GpD97CA6u1bCuo9xc+nHNGfZnyxi281MIx8ezTnU
         J9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020765; x=1788625565;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qCJSMZoS0QNd9wZ2SP5uBlAyYhJin6wW0R5sadc6nCw=;
        b=CdcAr64eVaXuXNzj3Q1eyrkoLLk9ZvJrli4YE3LV8zrB9QKFNCNLxAFkHp5Uk/+xGT
         9udZaDKMbK0xH3lweiuJoD/y8vsAc2Px+3itvUK8+H6c6KkE9/Cw9J6AmGbiqz/x5Swg
         yYcZw8MIXP1cCXm+NSQ+K1aNQc2+l8VBfrPwdWpl0cye6zJBuRVa3CyGhHnTRcbIaaK9
         2TArIaDaDb1pJYJPMtSGbmYEGKh/g2kTnp7rLG/pNwAkhZncXKnUIk7w108KY6sJe7RC
         gHhZRJGRjvhnxbGiY0Zkdnfr/EhOcmjPTT9ZZ14BAYVkZYgKow45jIjPUVpJ04xd9lsd
         gkOA==
X-Gm-Message-State: AFuF++miLXr+w9A9/w3FicW0xvxwFtg2MLusHDq2GZGQG5haNdoYidj4
	e5E/mC9+UMVP8XjGxBCukAPbsJC+7W52M65THFaBWoPG7MTe6QIef0N0
X-Gm-Gg: AR+sD13Y+8NE6gwB5E94nf/TiK+s3z9GjrRDcPaFosJ0rrmAe0MGN+ch4/MjWO3gaXQ
	EoIIb1+YcQRSYfVpdm0Gv3fPh9khcpvEjf2y1dVwc98jNOo3bmeuIPmyqjOaIrCR1K9AjHBbrVP
	qfVRE1OxA/scX2EB1RcqGRM9ekZhIO67s+zqyDhRKzDsyizI7GtCWaw9bCk9I2lErBUM4v+PFV/
	OLi8sl2cKTKoAkw0QfyZ58glnR+4NBNvMmDFS/QVWKIuQHYxmGOZyd0RAKcx0qURkmaqqN2WqQA
	nDJXiwI/EcLzeGArvRTj5Wb+hDUM3MX+zZ4V0HVw4TR+7dhpfqpNr4nH8DhRq1PspeUS/Nb/t+W
	gnYU0ir9ipyjKI0LU/Dz2onCdmvnyEwRydBc/9cw9KH6Z6TKzqc7+Z0J0JXe/cyscgVGT3rD6eQ
	GO1jCxu6mTal/GvxjA3QhUB7s8rgK9M/FWezJ1QDt3vM/x2qEEfNIOE3cF968og7sTlwPGOb0SY
	jVertp6CHfba2tUzlBPPra45LpS63/xCLN8n0hW8OgUXcaSd8IEE1zYbgwnehfa+zCITSJkt7OW
	fenQ+DYCrB9LIUIIdqJHFyCUR5QJYve/N4Gk/IBPkflL950CyvdP95prrL39dqjh6LogbiyWOel
	nKotPzopNob505kJF3TfyRRt8
X-Received: by 2002:a05:600c:3b20:b0:499:8704:242c with SMTP id 5b1f17b1804b1-49b91bd78cdmr189918175e9.0.1788020765322;
        Sat, 29 Aug 2026 09:26:05 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:04 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 00/11] iio: temperature: make headers conform to IWYU
Date: Sat, 29 Aug 2026 18:25:57 +0200
Message-Id: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jFMfQCu/A/DotABJgI1U9NoC
 P9uJXHp8pzknrtAYBUOcMkWUI4SxM8JzC6DdrBzzyguMZjcnPPSEN5ZZx5xYOtYUXny0Y7oqhN
 3jqrCFSWk7UO5k9fWvdWJBwlPr+/tJtLX/ormTzES5sh8oIbMsWGiaz9ZGfetn6Be1/UDlXWqO
 roAAAA=
X-Change-ID: 20260821-kernel-header-removal-d95efd197d78
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=2113;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=JRj39m44UG7x7nuL83AF6glKV07IjewUYbAQNaqM7lk=;
 b=hR/2meirejwqk7Aum4g7w7kis+9c0lVjbw0i7GaYrzwy+BIaUw6lXx4kOmrmf2Na2JOM31Vup
 RuVl9jONATBAbzxenstawDr+1hGf5cDVG6osRsZQqd2YpnHwGYlRxVA
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series removes any instances of kernel.h in the temperature/
subdirectory and cleans up the headers in order to improve readability
and enforce IYWU instead of relying on transitive dependencies during
the build process.

I had Gemini generate a summary (a bit more verbose) of changed headers
under the --- in each IWYU patch to improve the review process.

This is part of an ongoing effort to remove kernel.h entirely from IIO.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- Add missing headers pointed out by Sashiko.
- Swap <asm/div64.h> for <linux/math64.h> (Jonathan, Andy).
- Squash small reordering patches with iwyu changes.
- Link to v1: https://lore.kernel.org/r/20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com

---
Joshua Crofts (11):
      iio: temperature: iqs620at-temp: make headers conform to IWYU
      iio: temperature: ltc2983: reorder headers
      iio: temperature: ltc2983: make headers conform to IWYU
      iio: temperature: mlx90632: make headers conform to IWYU
      iio: temperature: mlx90635: make headers conform to IWYU
      iio: temperature: tmp117: sort headers alphabetically
      iio: temperature: tmp117: make headers conform to IWYU
      iio: temperature: tsys01: reorder headers
      iio: temperature: tsys01: make headers conform to IWYU
      iio: temperature: tsys02d: reorder headers
      iio: temperature: tsys02d: make headers conform to IWYU

 drivers/iio/temperature/iqs620at-temp.c |  9 +++++++--
 drivers/iio/temperature/ltc2983.c       | 15 +++++++++++----
 drivers/iio/temperature/mlx90632.c      | 10 +++++++---
 drivers/iio/temperature/mlx90635.c      | 11 +++++++----
 drivers/iio/temperature/tmp117.c        | 10 +++++-----
 drivers/iio/temperature/tsys01.c        | 16 ++++++++++------
 drivers/iio/temperature/tsys02d.c       | 11 ++++++++---
 7 files changed, 55 insertions(+), 27 deletions(-)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260821-kernel-header-removal-d95efd197d78

Best regards,
-- 
Kind regards,
Joshua Crofts

