Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742786;
	b=aeK6Xkdf5L4LWLNVx4QOX4PRB+TDexjsDccBSGIHcIZTILxOFnVBz1XMWKuSMQsxcJQn
	 Fb6XypOvlYfoYcUBKlCsX4m8jliL+9IzzS4t6f3lAapg0MlB2EOidRiQRydycaKrQeQ1E
	 OEvwPnPPzBqFu9IDikU/+TKs3Z94TTW24muPI2TVehv0xqbS2spZqbKHVZmiU1sLvDhz2
	 JwKnwcbr++vtL72ep4SnkfCGJupaLVx99Eb3Qm9+4DkbODQihKsfhz36yZaezHvpWZDtP
	 Z/ZTLbT7h2dMnKJaNphWUN8uLgLc0hskXlYcviphkVhZUMFbr4kLoFo6vNcv6b5oxHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZT5vY911PY+oPZWxUSYR9KkzLhjAtMnoOlULn7xIyWk=;
	b=ue5Sr4gscLbkcL/S6RGt/Z9mZWnCyXrJ8wT15G/x7dtqsftHFh0B3OtTrUrEu4/8k5z2
	 sSJNK6C/mpqZOSJsrvDJPzU6ijOl/GcwzL/eyihzupDG4C+enPuHRCaiRalJBdJiAGpzS
	 QYoH/w9PgXrUsVgE438UkjksU+/B6C2OD0pAlB7i8J2P4qnXEcKlR8oBeDtC4fkzq4147
	 njSCy1u9g4dJhJerZVEP5aLiUC9aktlS/ZSMCXizoJQ2xKZAmDS7Pv6TKU9FRo1cLdWTn
	 6WtCMNUNI9kb0fvOMz+DkssQjjqWIebRIbnASJ1LQOwyozYoOqushSqtimtPNt5LFFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5nhRQgO;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715C606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 01:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B715C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5nhRQgO
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso3839245a12.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 17:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742785; x=1796347585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZT5vY911PY+oPZWxUSYR9KkzLhjAtMnoOlULn7xIyWk=;
        b=b5nhRQgOvmU8zK254e7mxA0oUMCGzC+TNauGOd43QL/xLLkKG7nIylaXX9O9i1tsv/
         96gUbLIZ7bhY0W8vUpULQ2AiGgunxlQpfRMJhBcy1XLnFiGC+btnC32SzzqCNOBERWjX
         U+Ra9kZyRHKAJ6xECJlLcC1pBRwDMUrRMaV2YZ+qtYYBzfpa5RW4PljuRbNUm5jOVMis
         yTtYeN5OieTLksWFMQe73+NyCS88Wvg7IFgTcrw5OpPzNW3fZihiWCgAeXWvIDwUjaTm
         xdr+0cuqZTY+sdC3TogGdjDpEo+1PxTwG8bF91pDZjCZ+OxFuOa7Sj3yR0ry1bpY6J5H
         Dxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742785; x=1796347585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZT5vY911PY+oPZWxUSYR9KkzLhjAtMnoOlULn7xIyWk=;
        b=rQlDpeWdfEVgd5ulKcpbZSbADlr2XDtxROr2EhTCGCakE1IYqBhQ7s/ZTXRcObiliN
         VUb9rD8diHSWaI5NwCBReX/uuDsE8SZR6u9MUBBmEPBxha5guJEw1J9lejcwFIIjnav8
         YVM2dCgrIhcuZ2u6yehIhegSD2lZbTZVlUk/OKtYD8ZwoYFxsRLfDHIJhQSN8dDaAjaY
         FeNtxEaGSm4x9bYUcmzif0InA6lf4FAJvbYxPlesiTAS75gXUbEGOw7mvWPQFVkk6BIj
         Td6e8i9Bt56qlUhsZDk0c5dqTtVSN4/8B3a38uRIkWVa0ax+p1J2BErXfVezW/hP+pmp
         yjrw==
X-Forwarded-Encrypted: i=1; AL+hErGagQH0ZDxDjXEjBI4Ld0m1zJAJfQ7bAfDs3P3YuKY9gMlf/6amVaGu8IjWI0MRWiIZrRwyZTbRXVY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gFQdCER9kuwyvu/Ni64jcgLrSqlPW3KCoQ3NRm5hCik5ofAQB
	wKnQF5Tq5SQepGJaALclHNTxygkcmzJh9igSAneAsIg9Dx7UVMV2oenE
X-Gm-Gg: AZFdTZc4fsjLinP7JJ13n2rKlxjD/Cea6b7B+oLKOoAeTzdJ2tr0Je91MS/3dIZ9ESk
	wKG0u5ya4kuIT00pSylPZnMANGRCd/tbL950NJ+oaflY9sp1JyWt6BqLFOdUDSfnJTN38I0bFdH
	k1fPeO7vwzIGyVctmSVtl8eEDqcpsznHLrwriSlxCanVIsoe2P4o9Wp0ZBhj2ZwwWfFSOBw+DGN
	zFSJpQ+EX0y05HFgJfI+Tkw5a4PugysO+w5WotFXTYzw6W4M/0WjfdJkwxtfDn08m9isDsIZYFj
	fZjBow7vfid5r31dBBU0DVskfbDlea/l+7EEmhCclN/O/w4T7L+PKE68r6e4Sx2uw7lRGYrF+7X
	tdcUd2mFJjiV/qBvcfV5MmGScUcyUz7Ra1hxEZkNZ58JGvriucy5GdAu6sBrRhxyY7chPUORxDi
	Y07i28l63O2e4KbMLca65NSAsrQCsSdLYEVCizVoodTv2okDGy1zUD38IDj5hEVmEoIeYK9Ij9h
	QDl/VCxD/9Px4jzBF4nEqHNBmjJnQqa/GCIh8Ticssdv9v3diBy0xj+ebmcFMgTpXn0ZnzJPYIS
	h6EuiCMxyrNSovd5VECtKrHY3XDNoxEO2J3QiJX3aWT/YbAtdH0gU12T/mJfM+bbHJJd7FGc41e
	Efhx0Bu32phIfmWB/p8XmkXe8iLp/x3kobF4HkiyDdYa/OA==
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr22091582a91.20.1795742785083;
        Thu, 26 Nov 2026 17:26:25 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm35042866a91.4.2026.11.26.17.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:26:24 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH 0/4] iio: adc: Add the Miyoo A30 and PocketGo S30 analog stick MCUs
Date: Fri, 27 Nov 2026 02:26:08 +0100
Message-ID: <20261127012612.1589039-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Miyoo A30 and the PocketGo S30 are two Allwinner A33 handhelds
whose analog stick is read by a small microcontroller: the MCU samples
the stick potentiometers and hands the raw 8-bit readings to the SoC,
on a UART (A30, a stream of frames at 9600 baud) or over I2C (S30, a
four-byte read with complements). Neither MCU takes commands.

Both drivers expose the readings as raw IIO channels for the existing
adc-joystick driver. The A30 MCU pushes its frames on its own, so its
driver also feeds a software IIO buffer and adc-joystick takes the stick
from it without polling. The S30 MCU only answers when read and has no
data-ready line, so adc-joystick polls it, as on the Anbernic RGxx3
boards where the stick is behind a SARADC. There is no scale: the
readings are raw ADC codes of the MCU.

Patches 1 and 2 add the A30 binding and driver, patches 3 and 4 the S30
ones. Both use the existing "miyoo" vendor prefix (the PocketGo S30 is
a Miyoo/Bittboy product). The board devicetrees will be sent to the
sunxi tree.

Testing: each patch built with W=1 for arm (multi_v7_defconfig, both
drivers =y and =m) and arm64 (defconfig, =m), no warnings;
dt_binding_check clean for both bindings; the board devicetrees pass
dtbs_check with these bindings.

On a PocketGo S30 on 7.3.1: about one single read in four fails an exact
complement check (the value and its complement differ by a count or two
at rest, up to about thirty while the stick moves fast); with the +-2
tolerance and up to three tries, polling as adc-joystick does (two reads
every 10 ms), no read failed over 2 x 6000 reads at rest and moving, and
under 2% needed a second try (exact check: about 4% failed). The in-tree
adc-joystick driver on the S30 channels reported 365 and 374 events over
15 s of full circles, 42..231 and 24..246.

On a Miyoo A30 on 7.3.1: rest 136/123; reading the channels from sysfs,
full circles 22..248 (X) and 11..221 (Y). The in-tree adc-joystick
driver, without poll-interval, takes the stick from the IIO buffer: 826
and 852 events over 15 s of full circles (the MCU sends about 67 frames
a second), 37..246 and 11..220.

Retested with this version on the A30 (7.3.1): with only one channel
enabled in the buffer, each channel gives its own axis (stick held
right: ch0 alone 141..242, ch1 alone 116..119); three unbind/bind rounds
with adc-joystick bound: no warning, the readings and the adc-joystick
device come back; at rest 139/118, +-1 over 50 sysfs reads.
On the S30 (7.3.1): at rest 152/126, no failed read; adc-joystick 1213
events over 15 s of full circles; three unbind/bind rounds: no warning,
readings and adc-joystick back.

Tool disclosure: this series was prepared with Claude Opus 5.5
(Anthropic) as a coding assistant, in an interactive session: it
captured the MCU protocols on the devices, wrote the drivers, the
bindings and the messages. I reviewed and understand it, and tested it
as described.

Romain TISSERAND (4):
  dt-bindings: iio: adc: Add the Miyoo A30 analog stick MCU
  iio: adc: Add the Miyoo A30 analog stick MCU
  dt-bindings: iio: adc: Add the PocketGo S30 analog stick MCU
  iio: adc: Add the PocketGo S30 analog stick MCU

 .../bindings/iio/adc/miyoo,a30-stick.yaml     |  42 ++++
 .../iio/adc/miyoo,pocketgo-s30-stick.yaml     |  48 +++++
 MAINTAINERS                                   |  14 ++
 drivers/iio/adc/Kconfig                       |  24 +++
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/miyoo-a30-stick.c             | 204 ++++++++++++++++++
 drivers/iio/adc/pocketgo-s30-stick.c          | 149 +++++++++++++
 7 files changed, 483 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/miyoo,a30-stick.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/miyoo,pocketgo-s30-stick.yaml
 create mode 100644 drivers/iio/adc/miyoo-a30-stick.c
 create mode 100644 drivers/iio/adc/pocketgo-s30-stick.c


base-commit: 92c9d64c0cf749c8369403a32630562f0e855a6c
-- 
2.43.0

