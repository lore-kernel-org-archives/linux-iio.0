Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1771E5B68
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521933; cv=none; b=XSeNzLxOM8jREqmN8rcB93ZEXn7pp8yt2Pl5FJ2P82M2vRDMcL/joXGtjNRgaHv0nvBgTH3sC4m/pqcJIn8AUedjVs+OthX7AsZjd6arEbvubu7PMeSzrCrLCdb8bUuIllanOJRaBXUrOsGCmnzeLGpdydnkraO+cMxDDolyl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521933; c=relaxed/simple;
	bh=PodgZnbJRED924mVBo2w1V+mkOsOSuih7wFp4EZRS8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cEOg2mfwuoMoKuX1h9acIBEnpdPYSOvFdLkijb81e3g71pUxoDLwm9HbPpgi3lLkCKKC9bi1LchycazKSZ9Uy/BrRI+aJWOHUqoEOj1LRNzJd47QFJ9Xx16xJS1VuTf1SElC+QmJRlbwip771R1dbz+2rc1y4XhKKOkzSlH1/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faS/9r94; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faS/9r94"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1397e093f90so940021c88.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 17:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782521931; x=1783126731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EixgeXE6KkLS+YBHBaZszqWx1D/TOijdoC2xbqpvkwE=;
        b=faS/9r94vJTemcgFl/xNmxLL1w59EVMsrmUYNW7iNvNbQAd5+hPn409AuUsaJmifl4
         wjskIWtXIwoa5sQLxD5RwZeW9fY6XBOswNyhF4rEqpCna2FlnRopjVtn+gPrm/HEeEuC
         bZbjrNa2orvjAqFEBxybJJKbRu8tnKJ7KrvNAGpaEJ4sbqiypbrZaiEiDNzLElD6Lzu8
         GVpJq9dxheHwhHNMnxeCz35OvbfCj8vOWvsaRSIt9EuB7ka+oyIQDJ4Q8RiEXjpYermq
         UNV9KkP80/ZO7Sm3iNS3eMpB/bRAm6zOWPElBtmbxs15GwFeqBL+dQuweasmrkxRXyjd
         973A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521931; x=1783126731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EixgeXE6KkLS+YBHBaZszqWx1D/TOijdoC2xbqpvkwE=;
        b=qMyzg+kYpT4sQdF5wHh16rMEFkfPTlN72EyrVW5a1HJ0G8IbHe0X825L+tM1hH0Udo
         NyJcEAAIYDMEeWzmaoHfDS4jt67r3iyepFPU228KZvR9+fZGU9Qvis7SpRCBAUuHqhH9
         90e90zAXxrjBaYhBnUFSxe3xLxir1mcrQiFWUA4xg4bE5qVehLljuE/dlU9iFotlvwuY
         6ZAhYdMya9Uf3x46wPeCprnUQ08CjnUWZyXo50pvND9Swba1BaR2Pp95B/ltHrF6sZMK
         CQtib25jeGhoOM6OQtXsxYuko2bW2tZ+lEgSgKamtiXHKFnzNX4XT6eKD//KfPdRP0Mt
         BdVg==
X-Gm-Message-State: AOJu0Ywq5svLYZJBKuTC69Xm91Ss0hXZJmY9lqAtkZQpOHCzmSckUy9H
	fzJcVyI/SoC4K+uZzM+PiSntzG9XJ7G8ldX0tKHNg3iq00fNgIJMitLkpuEkQW4=
X-Gm-Gg: AfdE7cm82V5pdsyACwvA+/t5XTLBaNxQbZ1t26XQEqfDv/WNQcGt9lVD/GqylwYM9Sk
	AenORUw4HJW9AvAc6tkOHAYd5vWcrLaEqiRzGtNb/VA4+7ICHVJQ3P7YgLRnzaNZmqma6m3/5E8
	BDR9iflgFnAYiZEqyUngzR2G0BQ5m2u/f/BApod/oou/Rdfgq3fmi6GHSzW1piqieQ3e3xivIOd
	2/bMy2nWlrsJ7JEhwPVhUeOsDGReBOYql6Jvr/c+I1mbGatylxc6xXLbqSfnlCLaUuc6sNG1wc5
	nUb/jHBjNWFt9M3hi4Ja4e3e8IaTcAcjDY3eM9uc38KuLe/Dj81gwJ+8qF3kPbRwY5ySKfi+jhu
	5nK28/MDG0BbD1j+FlQc3++XjGfsu6oxaF3tB/1o9OzAsTXpmKEMI5pwOdMGdsd8+F+iF9q4qSm
	ZOlXtGW2t3MStoRTj9QYNTSd+UM0Op3Ucveo+/jkX6uneb+miy1Ys6
X-Received: by 2002:a05:7022:90c:b0:137:eb21:eafb with SMTP id a92af1059eb24-139dba279f6mr7228865c88.13.1782521931380;
        Fri, 26 Jun 2026 17:58:51 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6d2e4sm22387112c88.7.2026.06.26.17.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:58:50 -0700 (PDT)
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
Subject: 
Date: Sat, 27 Jun 2026 06:28:41 +0530
Message-Id: <20260627005843.7786-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Subject: [PATCH v3 0/2] iio: magnetometer: add support for Melexis MLX90393

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
Link: https://lore.kernel.org/linux-iio/20260510191010.155380-1-nikhilgtr@gmail.com/

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

 .../iio/magnetometer/melexis,mlx90393.yaml    |  54 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  10 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/mlx90393.h           |  73 ++
 drivers/iio/magnetometer/mlx90393_core.c      | 701 ++++++++++++++++++
 drivers/iio/magnetometer/mlx90393_i2c.c       |  76 ++
 7 files changed, 923 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
 create mode 100644 drivers/iio/magnetometer/mlx90393.h
 create mode 100644 drivers/iio/magnetometer/mlx90393_core.c
 create mode 100644 drivers/iio/magnetometer/mlx90393_i2c.c

-- 
2.39.5

