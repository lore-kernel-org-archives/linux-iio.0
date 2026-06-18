Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB403403EB
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798516; cv=none; b=f5OjzG+wFuXYiL5rbe+0Vqc0pk6AduZ0CVSwB0Xi5yAMi9xpZW1u5pIIpmf1Ozq6ZbyEmogeseueljjKPPmQEq844Qul2mZoGjk+4RQn0CUlicin8kHYiYTyqEcUbE5BCC3yqgtgR3EhHIvnrk3rkFc2aTjvlMyVfPxVOveD7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798516; c=relaxed/simple;
	bh=+ZfrwAlHc1DvcFEr/8rwstlWpm9IWgekDz2iNBTwKzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BCo2h//QpAME5KKbTvtj04q+kggqUa8wt1Xq/rKptq9WbV9+bHSmRQxVF8DgCYhZ1nneytFDQDF2NEwvBQH8RLaxOwb//gwZNMmdIclHjvTvcTfo4auuQ/+LAlwpXuGaJgpbYTRUhXCbxFCRD8pX4p1zvYp+6SRvLgbo76+76zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvVNtPgB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvVNtPgB"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so1134843a91.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781798515; x=1782403315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9+PJwtSfKZ+xGloTz14vmNyTIImuf5/PM4ChtjIZSY=;
        b=LvVNtPgBSGSYPPZcZbqC7+gWOU9EsJfmV76IHmkQ6298gxcXXQ1xUJY2Zj+gRnrY3W
         MI0va8rxmkTSpx1HIM9HR+depjl364HNIasllkeSLNrO8ddT9AyIMZexfU878tK0ezT4
         szj1lkkAdhWxMq8g9JCwLh38kbI1DDXiNKE4EKW6H1sBKqZYcwiPcBhMYhOw+MVxytUg
         TUFvQbYcLEzb8RzleWNjkm7XdOUD9/ELGPzH2+D6Rdy8NgTeAYimrrLc/DR0LJ/Ze8IO
         jv7/TcKFQEn7sX73l7ZDSASX68+6QjFAxU6CXxIF2vAPgHcy3jsT6iOP55zJGjEYxirs
         V1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798515; x=1782403315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9+PJwtSfKZ+xGloTz14vmNyTIImuf5/PM4ChtjIZSY=;
        b=VBYTQ53xYFm63ZJ3Xanj6URvkEMypHmgsKl6vZZQJtS/NXS2VprN55Zow/h36EQLm2
         5NtWZ9+gtrSTl6KnzLzZhVzCSeuMZH4V54a8Zapy7bKbLBLfrbM3fh892D5EDrSTU3YO
         ttM3/uxW1MgidpinqfT+Lf4gmU7gY/PuMZj6HcI0/8HfqNXn7ECFyr0FRHYb5yLA9K4x
         j+g5p9idmqhoMh42ZL84qMaDDY4VY03/sZyiBQuMg56cMkwBfs/OZpSAfKxW1GN5sCBE
         vcF89Z47X8pfYomBQRywUu7fd+2uEV6lipiYikuOcYQOwL3LhsXObkkAdzKPUB+Zbuw9
         D07g==
X-Gm-Message-State: AOJu0Yxo1NQg66tyYl0svRf9B0Zv2/tw6QwByuPyjHLHcbRfJ7zB2ijv
	upAZtAu9cKLPq6HbsGlH0CTGV2rgR8NhZC7p4/IYJXURtXbKm0GxHGYVxcwTt0JBqw==
X-Gm-Gg: AfdE7cn55Ub57PR0NFBq+zmvE4VoPLqP6AF657kOMlnXmMVQcl8zwGFR//XuwUOXpdy
	7+WQvwO9PtOUoNcFVWcyFoCtLZvPiFMGupjXijSNguZM2DvXaH9WpHdx+vy/9/twM38TsphY7gs
	YmW47tW5VLlVAW+0wut8dNR6e2I5lIat3aW1uUFh58/JaX73QZdpFwSZCUADIGfO/rky5PfB5gk
	8iGKkAGjQVJaDCjSVeEwn0LmJUs6hATSRoDUnpLF0UJB4I6TfbXwH73c2J044uEBWaH6cV0jG2S
	zr7eKehzxDhf1JRpPPLUS7EGjGHWlph/PcNBMv5l+frUZSMGUzlAyR7voq8JdHSRnbhrF06ghaB
	P+lpqehUBK6Yo4uJjSz3lZ6Ua32RTRkA1+IsfBlrI01UrN8DMe/IvPCxQD1mabe/OLfPcvVQtw8
	NcHvTOXK396p2Hy/DN/4pbsFH92ZfABOWXM8Gyv4VMG1sXipKIii8U
X-Received: by 2002:a17:90b:3a47:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-37d15df8a20mr46056a91.11.1781798514599;
        Thu, 18 Jun 2026 09:01:54 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15361af5sm53807a91.4.2026.06.18.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:01:53 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 0/2] iio: magnetometer: add support for Melexis MLX90393
Date: Thu, 18 Jun 2026 21:31:39 +0530
Message-Id: <20260618160141.11409-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds initial Industrial I/O subsystem support for the
Melexis MLX90393 3-axis magnetometer and temperature sensor.

The MLX90393 supports both I2C and SPI interfaces. This series
implements support for the I2C interface while keeping the driver
structure transport-independent to simplify future SPI support.

Currently supported features:

* Raw magnetic field measurements for X/Y/Z axes
* Raw temperature measurements
* Configurable gain/scale selection
* Configurable oversampling ratio
* Direct mode operation through the IIO subsystem
* I2C interface support

The driver has been tested on Raspberry Pi 5 hardware using an
MLX90393 sensor connected over I2C. Magnetic field and temperature
measurements were verified through the IIO sysfs interface.

Previous Submission:
Link: https://lore.kernel.org/linux-iio/20260510191010.155380-1-nikhilgtr@gmail.com/

Changes in v2:
[DT]
- Extended the DT binding to document power supply regulators and
  optional interrupt and trigger GPIOs.
[IIO]
- Removed the RFC tag based on reviewer feedback.
- Added a MAINTAINERS entry as part of the initial submission and
  expanded it in the driver patch.
- Reworked the scale availability implementation to simplify the
  data layout and eliminate the need for constructing a temporary
  table, avoiding potential race conditions.
- Replaced usleep_range() with fsleep() where appropriate and
  documented initialization delays.
- Simplified helper functions and improved error handling by
  returning directly where appropriate.
- Reduced unnecessary local variables and line wrapping to improve
  readability and align with kernel coding style.
- Added comments for lock protection and command definitions to
  improve code clarity.
- Switched to devm_mutex_init() and cleaned up include usage in
  accordance with the "include what you use" principle.
- Improved consistency across the driver, including conditional
  handling, switch statements, formatting, and general code style.
- Addressed all review comments from Jonathan Cameron.

I would like to thank Jonathan Cameron for the prompt and thorough
review of the previous revision. The detailed feedback on both the
submission process and the implementation has significantly improved
the quality and maintainability of this series.

Further review and comments are greatly appreciated.

Thanks,
Nikhil Gautam

Nikhil Gautam (2):
  dt-bindings: iio: magnetometer: add Melexis MLX90393
  iio: magnetometer: add support for Melexis MLX90393

 .../iio/magnetometer/melexis,mlx90393.yaml    |  55 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  10 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/mlx90393.h           |  74 ++
 drivers/iio/magnetometer/mlx90393_core.c      | 681 ++++++++++++++++++
 drivers/iio/magnetometer/mlx90393_i2c.c       |  72 ++
 7 files changed, 901 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
 create mode 100644 drivers/iio/magnetometer/mlx90393.h
 create mode 100644 drivers/iio/magnetometer/mlx90393_core.c
 create mode 100644 drivers/iio/magnetometer/mlx90393_i2c.c

-- 
2.39.5

