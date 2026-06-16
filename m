Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5643C041
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610606; cv=none; b=BvhTzeiDkBu/DTrtyxI4YDs9QgM3aKjicnVVUHpaG9lc0DLhNOfTOWLraO5iUJCNWUgEZq4E8tQFjqxf46HRfgnk3zA/9BCCWDQc6PZk+L8/esW1XDcHfqFIOI+ddI4sWDneA+4mWamo5vZagUBvG6ypz9noDh5OVUjERsGXb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610606; c=relaxed/simple;
	bh=32VxMlogY4MRcjKQbweXqyMzyPNQaoLKHG6wxkdmG68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8X/5Ol/IYNF4v4joNvAkbButMfdMgpqR02lIcV1IMkyt7fs6bmjwTY3rMsQcJn3RwSKqiNvhFdBw8mpJKDRFgWI7VbS+vSZeX4enoEnhxT4ReV0pdxjjUIwxKt5yrE0Zui813vBiRbDK9i9coLlqTaveuDoj+haELb7bbRtgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DZj7LsT4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DZj7LsT4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781610602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qqB9gYVELBB8DYOd3X2WMW3NZytrodN9/CVZFnrdAuY=;
	b=DZj7LsT4k8FKfcCZ44oNpbf1/lUBr8g+9C1lC4mKrQjjy+c7cKwaN/MIWCvgNroPeL+/1o
	PYziEjnPIBOxTi+24F9dXhUtnpNKi+tcDUUZE0WpnsHO8A/33toyDxP4KI57dzvoIx77Fw
	T1MTP8Ve40sYkIbrSH5slzk91lWrIg0=
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
Subject: [PATCH v2 0/3] iio: magnetometer: add driver for QST QMC5883L Sensor
Date: Tue, 16 Jun 2026 17:49:36 +0600
Message-ID: <20260616114942.37241-1-siratul.islam@linux.dev>
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
 drivers/iio/magnetometer/qmc5883l.c           | 516 ++++++++++++++++++
 6 files changed, 590 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
 create mode 100644 drivers/iio/magnetometer/qmc5883l.c

--
2.54.0

