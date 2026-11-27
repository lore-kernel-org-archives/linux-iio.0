Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795767175;
	b=XcICiOrosgORew8ui8oGKEZ4F4jqOh9y3z2i1w9w8BAtE2PhLAqlwOur1tve6O5DwtqJ
	 5rZwaorcFx2abIsiY9uIxNvPUtw2IhZ9uEd8Mtaq0nkz01SsZ+wkK1VA53CXqntWjSWxw
	 u02F4lV08Zk7ZzLPyTRmFZnDlNl3P3PfRBxlfFRbq5hZ5fljoWwYnecGmhfOBlC6KBAEA
	 bpMeqAMPwL3lnxQrwda7s1PLWEYzjyVyOeM1luzLfZgbXQ6k5qBz/9v2GOpRXNHWCOJHP
	 E25U+0nI0L1fG8ggZO7GxHK33MhzeuqgCyQIcYq/Wx/GyKcBXpSvVbzT/+ktzXMHV1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767175;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=/hVyNF3xLIIhkwlAx/u+gUeg5nNF10nSIgNUvJ0Z3oA=;
	b=NhtMI/pbe83Qf/21UlP4VyBgfjABZGAjgCIu0yaKOhVn+25bMPk+5h/eXiHsRyh0bk12
	 kjDHCCflCDnj3UJWyHs/s6yO/6DSj/prsmNs/nFFPI0qBf2lwXhPGjRUlVXy9L15SkjIn
	 zyhWYZpoVkF+WpGYMqx5fQxnFZdFEmbq9oEWgTwVvFrVgStjZhaujbSNxUKSCAAZJyM2g
	 waaLaNDlKsBRQRQVWBvSYsGtS0/ncOEzyNuSIJYCU0kBh4b/SREetC4Hp0oVpizT9zyyu
	 pzXsxMxfVIWmhSoxmWsk21mctNNqYVOJZt/HgBmG7jCSXJh2UJBl8GVgTiOLEPjRvpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuC9uPTn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60340606A31C;
	Fri, 27 Nov 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuC9uPTn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795767174;
	b=OaMNjBifdEECmDhO714F3Xk9ptX8hsdSNbVKcqikH/1mrszTpvSZtodpGbTQt6dlwGMK
	 L1h+kM1r/lI9FP268+FBaKDIpt0VH/R1/qe+a8Lnx7Nn3JFTMyip/h2mnN9lbdA1UprJN
	 0yus7jCOdfPLVbgRo5BLOj0D4OfY1P+O75ktPJ5Nz5xVxvBWz8LdKd3XiWe5LsiZywiMJ
	 4r9zmCKdxLIlUMLV2HgBEvcvT777NnbUkEJ4/DJ98M139qZIhcjaJrA48B9GTDkmcLXii
	 1L0PfzG1+S/h9pwAiVqVzs4LWLhkNJLN+3/iVWSeO8nPuY2K8Q3uIxr3hlYETEdulYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795767174;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=/hVyNF3xLIIhkwlAx/u+gUeg5nNF10nSIgNUvJ0Z3oA=;
	b=eq287kVqA/cyoU9OM1k6Cw7G6NHGtqsxNKY0IvqIFJ1aLPzXvHuL3wK6+GHYwQElwpvl
	 UZxOML5ro9y9wKH8RhlP+nn8Ppqdw9xDXmJ9c5FeziS2G3nuowF5Jthg1wX4hQhQGmsz1
	 Bfx06WDNTN6z5woLodRtCvOhhusujxluklAf3FoJJipjU2br5O1iLmGmO0pHD8kuEh50q
	 5JxtEoN9Np2/vEbbSHu63S29T/0bhslZB+y5ANUaR+eb93UydAv/hbgR3UY13xV/vOV9D
	 tFVfkvAK32IrOIJKlyP7b2vVw69j8743KzFw2IB687V/aMXN1u+SM62al/wq4D21ZYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DA8011F00923;
	Fri, 27 Nov 2026 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767174;
	bh=/hVyNF3xLIIhkwlAx/u+gUeg5nNF10nSIgNUvJ0Z3oA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=IuC9uPTng70jHGYDvFkT4ZKfbIrlPgKkD7IMSYhX4ohvPNEo0UTmcsPfpcM8VkZ/Y
	 gEVFVkkNUT/49jM4ZDw7Zh4G7uCIJFsSpvqdxRHu/eDrRPnYYj7IL8VZbGGC/FhJUf
	 tpT+9tW0KrCExHPDsbme0Zs7fPjxpQ+YYBgIxm+74rXBoDFa+XojNvVmAusH2TIswt
	 1KidzJWCKNICUwyzvpQy0AQmKkpGq+g2pYQ4U8RUdRrx4gOHr5EYRtCxhPcbi7rDfy
	 O+4TbweCnARJjt7nbFt8xJ7pxywfNQNVhK+ja5wp1yHHnsnwDZgLKc+Goi4oEsVcK5
	 chxzkkiDiwneQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5EEB84B62D;
	Fri, 27 Nov 2026 08:12:49 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] iio: light: add support for ams OSRAM TCS3430
Date: Fri, 27 Nov 2026 09:12:48 +0100
Message-Id: <20261127-iio-tcs3430-v3-0-e191a40a4ae9@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIA7CWsC/22NQQ7CIBQFr9KwFgOflhZX3sO4QErbb7QYqETT9
 O5C3dTE5SRv5s0kWI82kEMxE28jBnRjArEriBn02FuKbWICDCTnUFJERycTRCkYha4STa0qqG1
 LkvHwtsPXWjudvxyel6s1U07kxYBhcv693kWed//LkVNGWQdaNFrq0vBjf9d42xt3J7kcYevKX
 xeSK00lQLXAFFdbd1mWD7qXnzL0AAAA
X-Change-ID: 20261124-iio-tcs3430-2f53879527ed
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795767168; l=2793;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=Et/l27YtcKEISI6lN7W3Gjj8ZZUwqHD71s8HMID2vHk=;
 b=k0FMvHMwng07hSnPZ1075uN9j3w4uxD9DygJjEgMRacDTfnwx/k2DmD4AOV7oe8IeXAws6pSb
 1bCylw3FQRKCrDxB3JR+6Us0Q1qm1QFVd2AVC8R3kYTmHsvrCnE6Mao
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Reply-To: robertijtsma@gmail.com

Add Devicetree binding documentation and an IIO driver for the ams OSRAM
TCS3430 ambient light and CIE 1931 XYZ tristimulus color sensor.

Tested on Microsoft Surface Pro X SQ2 (SC8180X), where the sensor is
connected on I2C at 0x39 and used for ambient light sensing.

Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
Changes in v3:
- Import the IIO_GTS_HELPER module namespace via MODULE_IMPORT_NS("IIO_GTS_HELPER")
  so modular builds (CONFIG_TCS3430=m) pass modpost.
- Enable REGCACHE_MAPLE with a volatile register table (0x92..0x9b) and
  regcache_cache_only()/regcache_mark_dirty()/regcache_sync() across
  suspend/resume (Andy Shevchenko).
- Align Kconfig tristate prompt, top driver comment, and MODULE_DESCRIPTION(),
  and keep driver-separation rationale in the commit message rather than
  Kconfig help (Andy Shevchenko).
- Simplify tcs3430_set_scale() to drop the keep_time boolean, rename
  in_range to gain_in_range in tcs3430_set_itime(), use local regmap
  variables for readability, add blank lines after guard(mutex)(), and
  keep dev_dbg()/DEFINE_SIMPLE_DEV_PM_OPS() on single lines (Andy Shevchenko).
- Link to v2: https://lore.kernel.org/r/20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com

Changes in v2:
- Replace hardwaregain control with standard IIO _scale and configurable
  integration time using the IIO GTS helper (Jonathan Cameron).
- Hold data->lock across the entire IIO_CHAN_INFO_SCALE path in
  tcs3430_read_raw() (Jonathan Cameron).
- Convert register I/O to regmap_i2c (Joshua Crofts).
- Wrap guard(mutex) declarations in tcs3430_read_raw() switch cases in
  enclosing blocks to fix Clang -Wjump-misses-init / cleanup scoping
  (kernel test robot, Joshua Crofts).
- Use switch(mask) in tcs3430_read_avail() and tcs3430_write_raw(), and
  drop unused linux/mod_devicetable.h include (Joshua Crofts).
- Drop redundant L: mailing-list line from MAINTAINERS (Joshua Crofts).
- Pick up Krzysztof Kozlowski's Reviewed-by on dt-bindings.
- Link to v1: https://patch.msgid.link/20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com

---
Robert Ijtsma (2):
      dt-bindings: iio: light: add ams OSRAM TCS3430
      iio: light: add ams OSRAM TCS3430 XYZ and ambient light sensor driver

 .../devicetree/bindings/iio/light/ams,tcs3430.yaml |  52 ++
 MAINTAINERS                                        |   6 +
 drivers/iio/light/Kconfig                          |  12 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/tcs3430.c                        | 521 +++++++++++++++++++++
 5 files changed, 592 insertions(+)
---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261124-iio-tcs3430-2f53879527ed

Best regards,
-- 
Robert Ijtsma <robertijtsma@gmail.com>


