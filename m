Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B853D8132
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281402; cv=none; b=nKvJeNArGgVq+p+pbcg+LfuyS/XpIqFr/B0x/5YMlGnkj6zM5m9cwVcj0bWTv6fNHDijo5pQ+HtNKyeJTSeO6FveMGgCP7TeAKVLPMZYMMH+UetspRxeEUfInKkHVe3iDSmcLL8hppBH3fA7jFZyRCfX7qcvyTOvOpFBOzIo/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281402; c=relaxed/simple;
	bh=6YM5dOs2Pa7yUNeFsnmXwCOmE6Ns3r7eTdFiVyrvPY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZX3HznomVKByNdNXWkT1y3GewD0YPBF9HD7fxvEliJcM5qIkUu87JAcaY9CfljDaNZVDe0kYMYyQiB7EG8Z3NmrP4q7BHQm6B8fJV5Intvs/coVGIQnOSpO8RpVr/jl0DyNKSOqLtfoECjpiMjhEs3tdJ7KOOvbQH26jaBFmbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmjqhzHz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmjqhzHz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-88bc25fcd0eso2286799b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791281401; x=1791886201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QH7NYDc+Yp9RWvv4A2NBCx8EZXAjVS1e6vOPWVaVpKU=;
        b=KmjqhzHzjz2gaQvXJtt4xACWGymOsdN4FCrS23pBQM3EWS0ZzdgutNj+Ut6p+HV0dp
         Jx9QbTN7GlL5rI99Yja90Cuf57APhG2UmOAPqDtysPVrp2YQP3JjDg3NZKbICbkDqWoU
         UJr0Y/A+T/3REA3m69b+LKJ4qtpuuiRUQhSz4AwARBtUflwHylbJvgJe36A7SylHpCo/
         DbfPn73pjzJkUcnH7FpwNJifRw50gdbXQBi1ZnBYD9Oj+789laBk20WrJ4oB2qpYuw3L
         Q2dlF6mUhP82ynL+buPRMNzZ8bhXf92/9lIw031fplo+qldSD2nGrWlyFiiKqn7dRqBG
         OnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281401; x=1791886201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH7NYDc+Yp9RWvv4A2NBCx8EZXAjVS1e6vOPWVaVpKU=;
        b=bExCtY/c3928ZAdZYAGju8+bn+Mkn1xnkoPoDrzGkoSu/4smHt6o5fa/wii3wAkVod
         uApf7eULRAe6a5pihRT1n2fLMj4U2503zwbO29RyiIWcR3DzRsG/AX+4NbDe6Yc5zK0V
         HnlXXApaNy8RvRzh3g3p12M/o5CgYHhZmP+gPSu7RzVXHsUwQa0dOJBh+Hnz8anYZWHd
         ccpJrXPDjOh+MyCEmcSLSmx5zJJR/ayCqHUepZG5CkhNv/k+jPnLJHlYw79sNdLtRX2C
         wtQwemdBR4eQQRAlSyxdu/zhMFztNdvksR0yBeybhFI1184Pv31by6Q1tlqW5KfVvwjd
         OzpA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ+3pUEPn/UEUXCA/hp/7ymwRrc1lIAaMULVL25Y1L9yr2VTSl4fi4QyMRmlproaqvOd5j7jCuNzE=@vger.kernel.org
X-Gm-Message-State: AFuF++nRLwN6C+Hq5WRoKp2DLrYSkVopJs3dAHF/AINjsc2J0sFJPSM5
	9qy0H+YprbwdlqhOvCvPd2l+24ASCLWNbj8lhsdc+4gs7SGyBcbqqcxA
X-Gm-Gg: AYBFou3o8H4UB4vDkpjPuzibdYNxUsKcI9oRAfZXfsL0SAJklwhdDVyhl1HJa2hzK8q
	bVH5Pi4eZWccqg7Ej5Cc4wv/xsUe3CDy9smFmr4kD21DYFlcAzbXfbwEC3Fi5DdvRbqtJ770nX8
	PmkUWYITIBqx0Hkr2mjqJp3byXnLPIx0o8/ltnlhUts17OzHkFhh3X6p70P0ABd0Z7PM9Dv01Df
	CxLUH6k8ur+qaUpARsCqgDqYgn823addSU5j2EMdr9gBHNi17GBloT17VbLZLfEepiHCyFsapEB
	BGjQSacptYflia2stbk2JxPKrBZWmaUipLujyAbbQNmVmRISVRZF3hduObK/ViTiWcnDjY33ZtX
	pbUkErMJYSupI7qPaB/lqfrkCF6OpMqQTNoRV1NscL2nZC6NkzzcnIDRhnlrQrvejrtm8Eu9Ac5
	GFJW8QxmjUSDRrqW+uM3RTzi170VGyUwiIQTWlTradxptVeqf5UpmpdaK170vceg/gpdiTz3Gs3
	86BzKHeDtSPyck0FFw=
X-Received: by 2002:a05:6a00:4197:b0:881:4b67:ffd with SMTP id d2e1a72fcca58-88c6398f00amr10813068b3a.26.1791281400579;
        Tue, 06 Oct 2026 03:10:00 -0700 (PDT)
Received: from l (ec2-56-155-114-54.ap-northeast-3.compute.amazonaws.com. [56.155.114.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0b8f7198sm4592961b3a.9.2026.10.06.03.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:10:00 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
X-Google-Original-From: Liu Yufei <lyf98405@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Yufei <lyf98405@gmail.com>
Subject: [PATCH v2 0/2] iio: proximity: Add Vishay VCNL36829 driver
Date: Tue,  6 Oct 2026 18:09:41 +0800
Message-ID: <20261006100943.78971-1-lyf98405@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Yufei <lyf98405@gmail.com>

This series adds support for the Vishay VCNL36829, an I2C proximity
sensor with an integrated VCSEL emitter.

Patch 1 adds the devicetree binding.
Patch 2 adds the IIO driver, which exposes the proximity reading and
a configurable integration time.

Tested on Orange Pi Zero 2W.

Changes in v2:
- dt-bindings: Collect Reviewed-by from Krzysztof.
- driver: Address review comments from Andy:
  - Use a Datasheet: tag in the commit message.
  - Drop mod_devicetable.h, sort the includes and include what is used.
  - Drop the i2c_client pointer from the private data and use
    regmap_get_device() instead.
  - Drop the unused i2c_set_clientdata().
  - Enable a maple regmap cache, mark PS_DATA and DEV_ID volatile.
  - Rework the integration time validation in write_raw().
  - Use reverse xmas tree order for local variables.
  - Document the power-up delay and use 3 * USEC_PER_MSEC.
  - Warn and continue on an unknown device ID instead of failing.
  - Join lines that fit within 100 columns.
  - Simplify the Assisted-by tag.
- driver: Drop the i2c_check_functionality() call, as
  devm_regmap_init_i2c() already checks the adapter capabilities.

Link to v1: https://lore.kernel.org/linux-iio/20261003050453.413700-1-lyf98405@gmail.com/

Liu Yufei (2):
  dt-bindings: iio: proximity: Add Vishay VCNL36829
  iio: proximity: Add driver for Vishay VCNL36829

 .../iio/proximity/vishay,vcnl36829.yaml       |  55 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vcnl36829.c             | 298 ++++++++++++++++++
 5 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
 create mode 100644 drivers/iio/proximity/vcnl36829.c


base-commit: 52c36105f76e96b638152a42e735f2e7767ed946
-- 
2.53.0

