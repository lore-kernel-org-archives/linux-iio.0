Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC143391E51
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782554133; cv=none; b=Oy55hVvPlQy7P103LdfDwjd9T9OqJlhdeOD6tL4ZNL0Z7u0A+ELmM9k5B6baQmEI+dVSwUv3e2as28MexHC4VGwdFgcYMUahs8hNMof9YX7Y9+2SZZHFkRCoqnF9cnOvI6j20Tg1ILxyvIpQCxLJBxaCbT4zYIRv8b8+/8LBIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782554133; c=relaxed/simple;
	bh=JYEB2GGzGuVGn3ZHt1Esr5e6a6hYBrKtQb9w6zIphMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cwMAzTcuRlgObv8I7HgOaa0XpS853CyCZ2wWNEM4FaKkdlq4Rssi3NC3vL3wz5oKPrAlB8LaZb/scaL6vwaqE/erIeFme6w23dUI7GXW5shzmbUYPJ8fXxwYqXgryHiubQKgZfWHemuwecmp8IroEEWtNyr61UFwxsR71TEUhcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOfYp6sH; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOfYp6sH"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139a5f4ca15so2061806c88.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 02:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782554130; x=1783158930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUCiXf3YY6LMy+qULWgTh3NgENkEQgjFeYqpd4gaR3M=;
        b=eOfYp6sHFVu7hT7nlbISn7oDnFEu6x+lNBSu7ZqKKgvtsYgbIo1YYzfC7Vv8/lW0gt
         WA1f6oMKfBngfOm8Ta66/guJMswgfZGp2eATrSEs5B2rWj5pnenzk44RrhMxqNCPAI4m
         wSVY/QK3OCaSSzPEJdp2zb1wg6QXAtQ7ALxZgJa5H7nYx0kPfIZ1TA+2fGz7NVg++FGZ
         5BO8vQyOaa2eDNJY3h0JnWTzCLGHXQJABG1kZ8LgaU8/RlrnNhWK/G958CmaF8mLQopA
         51wOnTyLZUFj2I+pPvXwCsLrOuvhtDIolx8o3QUkDkSjngYNv3+ruZZJw50hNDrAJPZp
         YIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782554130; x=1783158930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUCiXf3YY6LMy+qULWgTh3NgENkEQgjFeYqpd4gaR3M=;
        b=G/1X/AUkIQGmbXpOLYH2+GIQjG8TsXQPqh7Mutfn3qiXezpqgkgxqQKp3K3FAayoCK
         BodHGITPTIEmIrv72h5isrCu4lZz/3eUXleZCKFPtrV7hZxckochv/HRdDbrUeX5rPkA
         2zYBNJ4PuC6LLad+gOp0zf1dPdeojdDYDQrSvT/zm95rQAC4ujhiDmj7LaOsPMHMDeZB
         nEq7gxoxzlEJULqXpzwoGAct9lIKSK6dc3AqHsAwOKoAn9ikPPqecFDSfGt4Bi8nHTp7
         fOq3493kwj3U3+kNrBfKdpn2xBHjooZ9J/xA7RdMl3iNPsj3lHJuK0Oozq+JbfrS+3V/
         X1DQ==
X-Gm-Message-State: AOJu0Yyi1U4M28WIMXj3MXWKFprS7nUom8jc/0CgVmDkRTJt8WeCvXwo
	RniFYt53RhkcgzUVS9WjvDa6Whw3NHYdpg0ffweJIpWpE6T5LOMADLGnVQajDfw8Ug==
X-Gm-Gg: AfdE7clzwL3cG1rCA0Nugar2/LCP7F2JBsHE/SuV4r0Q60lE3cfBYB+UAm/8SUQTTue
	NFmGO10CwEpYehAlCm0GbsbzCPsyqyQDNY6cOCf8dhqxWq9Sv5ZBuq/QlipTpNAJb4/g0eDb09U
	UDPhYmPXLzhkdAKAHrDYhhkAoa5sytO/UbSfmYnE08gIHakza5ibuB8ENLv7oHDqIlksJo6UOUy
	VjV2QAnhaxWkOsQfhRb7Jvc2bhwx845FdN1CnXBE0EeUT+5oYfuOV3ZkUT5+n+chfvs4H1j+u40
	4TM16X5BtXpw8CDl04aC9gcl+KDA1E2QUpvOmQ+3xVtqADfg0OsPpSqQAof8q4Auh0Z4wygEhFg
	F9ztpfFLdiorUw7ua3RQHrNs0kuPsx2clN2nqHpGnLza27DES5ce8PKe8hc8hH3IsUjkth7GeNL
	dtdqHrrMEAJeAaDSXBGp72aaErF6pUdcNTceucvAVD6CS9Fc7kZFRr
X-Received: by 2002:a05:7022:6b9f:b0:137:4061:8cc2 with SMTP id a92af1059eb24-139dbb134d9mr7904228c88.35.1782554129383;
        Sat, 27 Jun 2026 02:55:29 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.116])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e4c33af7sm12886141c88.5.2026.06.27.02.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 02:55:28 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v4 0/2] iio: magnetometer: add support for Melexis MLX90393
Date: Sat, 27 Jun 2026 15:25:17 +0530
Message-Id: <20260627095519.8377-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series adds initial Industrial I/O subsystem support for the
Melexis MLX90393 3-axis magnetometer and temperature sensor.

The MLX90393 supports both I2C and SPI interfaces. This series
implements support for the I2C interface while keeping the driver
structure transport-independent to simplify future SPI support.

The device uses a command-based communication protocol rather than a
conventional register-addressed interface. A small transport abstraction
layer is therefore used instead of regmap to share the common sensor
logic between the current I2C implementation and future SPI support.

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

Datasheet:
https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90393

Previous submission:
v3: https://lore.kernel.org/linux-iio/20260627005843.7786-3-nikhilgtr@gmail.com/T/#u
v2: https://lore.kernel.org/linux-iio/20260618160141.11409-1-nikhilgtr@gmail.com/T/#t
v1: https://lore.kernel.org/linux-iio/20260510191010.155380-1-nikhilgtr@gmail.com/

Changes in v4:
[DT]
* Updated the example to include the required vdd-supply and
  vddio-supply properties.
* Added fixed regulator nodes to the example so it passes dt_binding_check.

[IIO]
* No Change

Changes in v3:
[DT]

* Made vdd-supply and vddio-supply required properties.
* Moved the MAINTAINERS entry to the correct alphabetical position.

[IIO]

* Added the publicly available MLX90393 datasheet reference.
* Clarified the motivation for introducing a dedicated MLX90393 driver.
* Added the I2C device ID table and switched to designated initializers.
* Added a forward declaration for struct device to reduce unnecessary
  header dependencies.
* Added symbol namespaces.
* Improved include usage.
* Improved status validation and consistency of conditional checks.
* Added comments documenting protocol encoding, initialization delays,
  and temperature conversion constants derived from the datasheet.
* Improved naming, formatting, indentation and general coding style.
* Addressed all review comments from Andy Shevchenko,
  Uwe Kleine-König and Krzysztof Kozlowski.

Changes in v2:
[DT]

* Extended the DT binding to document power supply regulators and
  optional interrupt and trigger GPIOs.

[IIO]

* Removed the RFC tag based on reviewer feedback.
* Added a MAINTAINERS entry as part of the initial submission and
  expanded it in the driver patch.
* Reworked the scale availability implementation to simplify the
  data layout and eliminate the need for constructing a temporary
  table, avoiding potential race conditions.
* Replaced usleep_range() with fsleep() where appropriate and
  documented initialization delays.
* Simplified helper functions and improved error handling by
  returning directly where appropriate.
* Reduced unnecessary local variables and line wrapping to improve
  readability and align with kernel coding style.
* Added comments for lock protection and command definitions to
  improve code clarity.
* Switched to devm_mutex_init() and cleaned up include usage in
  accordance with the "include what you use" principle.
* Improved consistency across the driver, including conditional
  handling, switch statements, formatting and general code style.
* Addressed all review comments from Jonathan Cameron.

Many thanks to Jonathan Cameron, Andy Shevchenko,
Uwe Kleine-König and Krzysztof Kozlowski for their detailed reviews
and valuable feedback, which significantly improved this series.

Further review and comments are greatly appreciated.

Thanks,
Nikhil Gautam

Nikhil Gautam (2):
  dt-bindings: iio: magnetometer: add Melexis MLX90393
  iio: magnetometer: add support for Melexis MLX90393

 .../iio/magnetometer/melexis,mlx90393.yaml    |  63 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  10 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/mlx90393.h           |  73 ++
 drivers/iio/magnetometer/mlx90393_core.c      | 701 ++++++++++++++++++
 drivers/iio/magnetometer/mlx90393_i2c.c       |  76 ++
 7 files changed, 932 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
 create mode 100644 drivers/iio/magnetometer/mlx90393.h
 create mode 100644 drivers/iio/magnetometer/mlx90393_core.c
 create mode 100644 drivers/iio/magnetometer/mlx90393_i2c.c

-- 
2.39.5

