Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28646AA62;
	Mon, 17 Aug 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987244; cv=none; b=QgMi9ezPGSh6dGP972al3VvDfXyg+b5OuvQUIdkeLh+m3fUafKwzNgKLZZqQgQ67QN1tYbM+rHq1yMb41VE6i8qNhRjjCZ70kM1wetwfSUHbiqPcKhUAv6vI1vr78ftiguiQ0gnIocbMaMHuZVBusWG+rsVM9sY9+fhMcF6ZHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987244; c=relaxed/simple;
	bh=p8x8yPEoZddzM3p/i0OAw9/3wes/wPXVoTWxCfI4Uhk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kMaulHrs+qInpVHVrlJX82V4uOS77IN+snxxp9t3nwsTI6/8css6738DmUXclBGn0VicuH9sR9XsqBMblINACaKEfenofoS8/Si6Aoc5Cgi6ewmbWtaotH1WxgEKMV8MstpgPs0/0uk07pettY87pacgRHlhIaUmHxviRFrIAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bpqdLNQ1; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bpqdLNQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786987236; x=1787246436;
	bh=5K3Qc6W2uxUKL2uSKp5o1gXIUPVU8YMVZQZpa4ySIOs=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bpqdLNQ1Cy6bH8oQ1uMuwLsrQ6NtCAXGh7JGMw4v8bQdYN4C6giez9mzogL8zkieT
	 sF3P5WejTlPqBzWULhOidfIn6pjWRjEYZ+lQ1FWpePU4Xmv1n5cxVKOb89C6Dfvdf2
	 EWpNvKBjyI2R0jPEI8BZTlGSBB52yciH4PufIZv653tuq/Bvmphargm0hEhFKoIOlv
	 k1x5TAMbaeXtgJyn4263TfctwpMI02po3YcWcG9QmOuXYAewcIamKlMRYNh3bMiJZV
	 KwCgtexpOZ/6z7XlfsGDfco+JVo3Z2Z60OyG9dGLCysNd47K8EIO0PZ2h3ocVKRZ/X
	 Fj4TAFbuRcpSw==
X-Pm-Submission-Id: 4hP03714fqz2Scd3
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v5 0/6] io: accel: mma8452: Allow open drain interrupt pin
 configuration
Date: Mon, 17 Aug 2026 19:20:22 +0200
Message-Id: <20260817-mma8452-open-drain-v5-0-e34e872d7d57@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPS47CMAyA4augrAmyU7tpWM090CzSPCCLpigdV
 SDUu0/KZgZRieVvyZ/lh5hCSWESx91DlDCnKY25Bu93wl1sPgeZfG2hQDEQoBwG2xErOV5Dlr7
 YlGWHrLUjbDQ7URevJcR0e6Kn79qXNP2M5f68MeM6XbkWNPIWN6ME2aP3yhKBa+HrHGxOt4MbB
 7F6s/psqGoY7oOJHEkbfjOaP6ODbaOpRotkIkFrCcybQf8MVJsGrb9EZ5E9qJ5fjWVZfgHS2ez
 IgQEAAA==
X-Change-ID: 20250401-mma8452-open-drain-81577c41375c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786987234; l=3165;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=p8x8yPEoZddzM3p/i0OAw9/3wes/wPXVoTWxCfI4Uhk=;
 b=9dpOA7o4zU3fDwwirzsUIf5GxQYkVezvdelHB9O3xQEOkrL34fQcs86uOUz1iZ+6mi3P5uQez
 aiLPmMxMX3MAQIUqkN+X59cZmuE2Cn1O/D3ZPXy4PeuP7pNR1xXKNLq
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Extend the mma8452 driver with support for configuration of the
interrupt line in open-drain mode, which is needed for hardware designs
where the interrupt line is shared with other chips.

Adding drive-open-drain property to mma8452 device-tree node for such
designs to enable switching pin configuration to open-drain mode.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v5:
- Squashed dev_err_probe() call to one line.
- Fixed typo in patch 2 title.
- Added synchronization between runtime suspend and interrupt handler.
- Link to v4: https://patch.msgid.link/20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com

Changes in v4:
- Fixed interrupt handler to check runtime PM status before trying to
  access the chip.
- Split open-drain support and interrupt sharing into separate patches.
- Added new patch to reuse existing struct device * through mma8452_probe()
  function.
- Print warning message when irq type is not set by firmware.
- Link to v3: https://patch.msgid.link/20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com

Changes in v3:
- Reordered patches, swapping #2 and #3.
- Always add IRQF_SHARED flag.
- New patch to change it so IQRF_TRIGGER_LOW flag is only added when no
  trigger type is set by firmware.
- Link to v2: https://patch.msgid.link/20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com

Changes in v2:
- Commit message of patch 2 updated.
- Operator precedence bug fixed in flags argument to
  request_threaded_irq().
- Always check return value of mma8452_set_interrupt_pin_mode(), and just
  check for non-zero value.
- Added new patch with optimization of struct mma8452_data ordering.
- Link to v1: https://patch.msgid.link/20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com

To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
To: Sean Nyekjaer <sean@geanix.com>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (6):
      dt-bindings: iio: accel: mma8452: Add drive-open-drain
      iio: accel: mma8452: Optimize struct mma8452_data member orders
      iio: accel: mma8452: Only apply trigger type when not set by firmware
      iio: accel: mma8452: Support interrupt sharing
      iio: accel: mma8452: Allow open drain interrupt pin configuration
      iio: accel: mma8452: Reuse existing dev pointer in mma8452_probe()

 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  6 ++
 drivers/iio/accel/mma8452.c                        | 98 ++++++++++++++++------
 2 files changed, 80 insertions(+), 24 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20250401-mma8452-open-drain-81577c41375c

Best regards,
--  
Esben Haabendal <esben@geanix.com>

