Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16791C01
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950814; cv=none; b=mnhZb+sRUXrfjPONZt/oUTh2Bu0OmWm2ZKKORWCrmmW1Sxn/9VyXtj21VsVyu1nqycJBkGNlJ4Neiuxi7RVB4+nPlOSw86qjLmlUGaP0TlBobCj2q1LyJ5aeuuIGOBbzJEc8lL16g9roybhRHB8YzdGSsZndRezYcmO+JuVuanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950814; c=relaxed/simple;
	bh=k06iNkdUqRcIsezgbNOaN8EjnwaSbxKzgfH0Vnq0HC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPHWoYj/jxO9UOGMThdd1LcE09SyYSSau+z59ZHnE9MvyQUZ9XXphtWawXuOC4EMLnU6rcoLTQWlYZXOX11KGLpPEC7ewmFjf743sCGJ1O2Ghw27+Pz2JADkh4XeRahNwXyVGFSRNRiaIl138nF+GOuFW7qpgjfTmJnKWNgKx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I79bVtoV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I79bVtoV"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d556c1a79eso2177132a34.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950811; x=1772555611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bU5k+6sNB0KTbcFvy5Ke25ujYH5KIYZfLNb1U8JEui0=;
        b=I79bVtoVWLYL8XQAOfIbV0o2Anyvtpqzi69bo+9Zs6tA8cOyfyhVoeCNp505Q6Clyd
         4T2rqyRHn+4zpuF3ALmcbYW5eDkYFg9wVqA/5pgINjr7vl60drXlNHd90iI0H82hGUtM
         YrwMLSgXlJwzFIUJ4oqhw1JRhClR6OBwBTrd0muof/zIVPq6kWDooRmHPYEwJBrXURy3
         9hbMAp9Ouu73K4nJKejGhGzWgIonCeBDKWDXCd6fOHI2bQkIH0uqEbCBE2LhgBcANIQv
         EWkzU1vjKmuOsYwEZEoBjV+YWlg/7cggcezRQ48wPtzHyElHnzIaWfJb+nnI/2DEqkbC
         tmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950811; x=1772555611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU5k+6sNB0KTbcFvy5Ke25ujYH5KIYZfLNb1U8JEui0=;
        b=KZPwfxOFoJL34R2PHJ5/UXVkeoqopTMB+Ab8bC4eG3uBHN/QYxal4sy3lPENBzN8a6
         JpStlEAt4u/8tMCc26ie2amX7QCK7be+fl7q27N2SmZy7Mz7sin4qg+QhxLrg9sr+YIB
         IrVFuwrLrAHucltT21NQMXtMaJMRZ+KuwTwz/SEe0G785wsM6NmiACuIgkJ0bYy3J2ak
         lijMDHxP86lMJ1wmHw1sbu9nD+vepsPVPF119Mo70GA1WIkEZgZI3x+P6QHRcVlkBvh7
         tQ3Fcl2w9xUfohopuScutbGCCaRy23AEChA878cnisUgou/1zCHJj+UovUUGJKBGFEXM
         UhIQ==
X-Gm-Message-State: AOJu0YwkQG2qT/uBwdTM/Mm5csgSdjij2bUGXbmJJySBBiupa9/fh3V5
	gdTW8yogoxuBKNrz0cZS8zEjOZVqvCSL0k309i9O2/zT+LgyYxyaU7CE1uEJ5Q==
X-Gm-Gg: AZuq6aJUZdeLiPL5tdsCZ6nzc5WDqrP5TdHE284nKh/C0oaA9GpYLhbkI1qLYRi+qYF
	Ezr+klWYfXLtHBhTCAiKl1G49lX/9MKvTQTGRfuZ5yyOowaWuQirop17M5JD2C+1v2Uh1gh9G0U
	NEG67NH5JD1JcKQV4hp75zSWZTO2fnhlUn18euSiZabSVSAISJWKtEx+Ze0253WgMyswCqQIatx
	/HquOIU+4ebQUmIC65XHDL7xk0y4Col2TSEVoZDYKo124eZ13v2Hp3f0gEP06c/inGq6Iw3EwYL
	b8FnPpOfzhpPwMzmn4Bvs14tGtaMocm1KAeP2QXB6U2dXB6t1SNr0MqWmlkqpeV84pjBBr0qmmL
	sgYI+ux5Ww4rwzI+C6C8QMBQVXx996wsYEnz9Ys0EaPyU5OAdz7Rb9eJuvQNiZPf17IGgueWwRx
	Sqd92xTWHYr04bnVOyHCd7
X-Received: by 2002:a05:6830:7317:b0:7c7:62d0:b462 with SMTP id 46e09a7af769-7d52bdf6f21mr8759906a34.6.1771950811307;
        Tue, 24 Feb 2026 08:33:31 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0725c4sm11060130a34.25.2026.02.24.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:33:30 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/3] Add Invensense ICM42607
Date: Tue, 24 Feb 2026 10:31:02 -0600
Message-ID: <20260224163109.370930-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the ICM42607 IMU. This sensor shares the same
functionality but a different register layout with the existing
ICM42600.

This driver should work with the ICM42607 and ICM42607P over both I2C
and SPI, however only the ICM42607P over I2C could be tested.

Chris Morgan (3):
  dt-bindings: iio: imu: icm42607: Add devicetree binding
  iio: imu: inv_icm42607: add new inv_icm42607 driver
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42607.yaml |   92 ++
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |   20 +-
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |   30 +
 drivers/iio/imu/inv_icm42607/Makefile         |   14 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  472 ++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 1025 +++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.c    |  566 +++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |  100 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  811 +++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  |  578 ++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   93 ++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |  100 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |   82 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |   30 +
 16 files changed, 4014 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
 create mode 100644 drivers/iio/imu/inv_icm42607/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42607/Makefile
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

-- 
2.43.0

