Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8164BA9FB;
	Thu,  1 Oct 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845911; cv=none; b=lgStrTqY5/BQrpZRNcC/6dJXKN8XSX8tbQudeHMIqNXIyKAQZCmbGWLjlv90WEb9otqbJzZ0SK5w6e+XDFhGGosgmgr0UYm6mTwEw+8Xbm2QmkxWKi6wwjyukqVhl4aYmgDP5kfE53QTwV8lI8IiONwInayZUhGuD6d/5Bi+kUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845911; c=relaxed/simple;
	bh=gMp7R5zJn7U5a8P3NC4uUcNkoLWJcHWT+xzoy9wVpLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=forEcDgQ3xX5mQ0z6YCS/fvJ4SpT5egDk8jkkYMGm1gXFhz2nAcxNJA5mlA5ym5sUDA8Ns5mZbOFBW8Qbgb9kau7pXD7M5DbuEqanx4yHXx1Wrmrv9EJxQ4FrLOW0FZhKrhqySosDPbzXPrHQbDvpZMiG5k+yr1EKOqcaJzOdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4rML4+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4rML4+l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9A72C4AF14;
	Thu,  1 Oct 2026 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790845910;
	bh=gMp7R5zJn7U5a8P3NC4uUcNkoLWJcHWT+xzoy9wVpLQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Y4rML4+lO6MH1t32cUmUvdhzSbIY+bQc2FUgeUqsB9VS+257AWUL3m+v0E1W3Vytt
	 w+ysDrLdlO83NYil7yioINbMexolTQx70/e6gHvds2NZVSD5DVP/TqvJ31S4ckvjx7
	 8sy3iAudtXZc9D/DErWYzY9RSr24PpgTE9tJMlH9HQptlg4m3fMrAnYsk35ppY/ki7
	 aQQAHnPICt1WMQuGR5S3R9IxkFivZdykpb/4cpKFnv8Ey8/+b2FN296NZUOMcG1vmK
	 Fn2d8o6IM/pvfkXDQMbpHZP+HblVMOgGnPWO4Sryjv2lphcQOYLp62cFj4VEcR9vtl
	 LcR/cF4/NciJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A837FCA5FCF;
	Thu,  1 Oct 2026 09:11:50 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH 0/2] iio: imu: Add support for the ADI ADIS16607
Date: Thu, 01 Oct 2026 12:11:48 +0300
Message-Id: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQjvmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Nz3cSUzGJDMzMDc10DC8u0tGQzU9Pk1CQloPqCotS0zAqwWdGxtbU
 Aje0QmVsAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790845909; l=2098;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=gMp7R5zJn7U5a8P3NC4uUcNkoLWJcHWT+xzoy9wVpLQ=;
 b=UCdKmxVu7xaeC3v+v77WnEQZqCJ5oyXeBkeJ6KjcYAo4qS/62FM2dAaSSG82BAG3uoTK/pC9T
 u1QeFeqcuH0A91QOImhSF/dE/mNIJzQoSMEFNdZIMj5wjNjR33d6FwJ
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

This series adds support for the Analog Devices ADIS16607, a precision
MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
temperature sensor, communicating over a non-standard SPI Half-Duplex
protocol.

Patch 1 adds the devicetree binding.

Patch 2 adds the driver, built on top of the existing ADIS IIO library
(drivers/iio/imu/adis.c). Notable points for reviewers:

 - The device does not implement the standard ADIS SPI protocol used
   by other parts in the family; reads/writes are done over a custom
   Half-Duplex sequence (see adis16607_spi_read()/adis16607_spi_write()
   and the adis_ops overrides).

 - An optional external clock (clocks property) selects between
   SYNC_DIRECT and SYNC_SCALED modes depending on the supplied
   frequency, with the internal 8 kHz clock used as the default when
   no clock is provided (adis16607_config_sync()).

 - An optional hardware FIFO mode (adi,fifo-enable) is supported as an
   alternative to the default single-sample burst-read trigger path.

 - Sensor self-test forces a settle delay (self_test_ms) between
   enabling and forcing the test before comparing before/after deltas
   against per-axis thresholds (adis16607_sensor_self_test()).

This has been tested on a Raspberry Pi 4 (arm64) with the device wired
over SPI, exercising both the default burst-read path and FIFO mode.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Radu Sabau (2):
      dt-bindings: iio: imu: Add bindings for ADI ADIS16607
      iio: imu: Add driver for the ADI ADIS16607

 .../devicetree/bindings/iio/imu/adi,adis16607.yaml |   91 ++
 MAINTAINERS                                        |    8 +
 drivers/iio/imu/Kconfig                            |   13 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis16607.c                        | 1513 ++++++++++++++++++++
 5 files changed, 1626 insertions(+)
---
base-commit: 9c87e61e3c5797277407ba5eae4eac8a52be3fa3
change-id: 20260617-adis16607-089ffc655ceb

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


