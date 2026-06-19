Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A0375ACF
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866196; cv=none; b=f4VdvjW2WyD97XobyVy6WML6vHMqU3LMpAteATmBldH4r0KS+A+GX7BrgHcRrvMkqDSI+K77hFJJz2JvxEV5KMtaqDHXAU9ioUeYf4SVAiIgUP8lZ2mnxy5Yva/QtvE49bp3aXEFFVdmOLe1rEFr7+ZIPLXVKHwimgA6TZB30qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866196; c=relaxed/simple;
	bh=aU5X5BoOUmPx0qj1LUcUPIAiTL3FZ+0HTQErgjJ3ipw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxwHK1BmGzdFHjxU3S/UwjtoD7go+u75xCA/ASMrgN4hKte4ZBL2LhLk1r5k3l9wxfiERHj6UEO8rK2JE3GJXqrMYn0kpj4zF/VE9/wk5LMrpMzyjsD64GlX0zxpnX74YjNSCBm+TuU/zDi+BEkD0zKQrBfl7ZCGD8xnKr4dWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ionfzKX5; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ionfzKX5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781866183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=In2axHd9UDaAPxtc6hOvWtDlYJS+YT889NEcxoMs1AM=;
	b=ionfzKX5o2V/lKkRClaZnARnd5KEhNg6tULA6lSf4SfUrOP6dPfvesRb2RLDk5sZMerJ5I
	Jqh6AX1ATeq45XR5eGzDajDLyXUTFSwFzxq8B9PpxIapznqkEh796Ix3yeAWi/R4bC7x57
	dkB5bitVcwH1IR8yO9ZkdGxAoKZw9E8=
From: Siratul Islam <siratul.islam@linux.dev>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: siratul.islam@linux.dev,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iio: magnetometer: add driver for QST QMC5883L Sensor
Date: Fri, 19 Jun 2026 16:45:03 +0600
Message-ID: <20260619104524.10172-1-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series introduces the QST QMC5883L 3-Axis Magnetic Sensor
driver. It is a simple device with minimal magnetometer functionalities.
Commonly used as (software incompatible) replacement for the
Honeywell HMC5883L sensor.

This driver implements the basic functionalities of the QMC5883L sensor,
and intentionally leaves out some features like DRDY interrupt pin support
and power management for simplicity, both of which will be addressed
in future patches.

There was an attempt to introduce this device about an year ago but
the author seems to have abandoned the patch series. Since the device
is simple enough, I decided to start from scratch.

Note: I also noticed a patch for the QMC5883P variant. Despite similar
naming, the sensors are different including different register maps,
so these devices are not compatible with each other.

---
Changes in v3:
- Add trailing commas at list endings
- Rename regmap to map in multiple places
- Add and reorder header includes
- Update POR time comment

Changes in v2:
- Update commit message in binding.
- Reformat header includes.
- Remove iio_device_claim_direct()/iio_device_release_direct()
- Read the measurement registers before checking the OVL status bit
- Replace scoped_guard() with guard()
- Fix function parameter styling
- Replace FIELD_PREP_CONST() with FIELD_PREP()
- Replace qmc5883l_rng_avail[] with a 2D qmc5883l_scales[][2] array
- Update mutex comment
- Add a devm_add_action_or_reset() callback
- Use a named initializer in the i2c_device_id table
- Combine u8 rng, osr, odr; onto one line
- Various styling fixes
- Update maintainer email to siratul.islam@linux.dev

Link to v2: https://lore.kernel.org/linux-iio/20260616114942.37241-1-siratul.islam@linux.dev/
Link to v1: https://lore.kernel.org/linux-iio/20260612124557.13750-1-email@sirat.me/

Siratul Islam (3):
  dt-bindings: add entry for qstcorp
  dt-bindings: iio: magnetometer: add QST QMC5883L Sensor
  iio: magnetometer: add driver for QST QMC5883L Sensor

 .../iio/magnetometer/qstcorp,qmc5883l.yaml    |  52 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/qmc5883l.c           | 517 ++++++++++++++++++
 6 files changed, 591 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
 create mode 100644 drivers/iio/magnetometer/qmc5883l.c

--
2.54.0

