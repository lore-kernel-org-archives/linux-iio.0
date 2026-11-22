Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367807;
	b=tr0URK3E+roToOzLmWiUE7u1nbn9A7rZQtkuZ6OpGeUn3+NEFWkhle4vk++VeA3/ZRt4
	 d0Keqt0EiTg19wP11/VCprW42N3E7Kgt3/QzjI9G3LxxqRyE7a8rdQ6LvKoshJNcOOTuX
	 fSMmZSJ4lx6twiG7045j+UHheqw2c8Mml/BYLjyUDsEFJpaRPY+9tuUezbrHbR5B2ShK2
	 oBMSdm/h8rOIdwt/5iYIyOuJDyPzBHPTgm8TTR/opgNobdJ0497qwWxE2+xSN39SKXV+m
	 rzbE3BxF7JhBst4C2quGX/LCXBcti6Qng7T/HOJccmj3bVb4RQs5mDbJ81QCmvquAIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367807;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=SeKjELiXemrmuj/pVrBt+Gcb8iYnRIwz7DdKgSPAfSM=;
	b=L4Or2pQayrjxRQodKcv7a8pMTR3zSUMTGXs0ij88MAT85mCBjOihON8/U4yQtojBBDch
	 2GJdD5iljF9VhweIPo5hSOqbno/awA0nlQUZeTo7PgC8363aC5dxmb5bcvFYdd6jg1FKE
	 IV6VVh/MCU5i1Axn5HlfziSt4t2yby5Oo8rGA4OmGUOyJgMuOCL+685KqtzedfucGJqcj
	 jFd7sQBlVCPClwl1qBDfFDNnH6ctY9M74L0LkbEzw/ker0nCcIOQpDld7tSokhpMPhYGa
	 jF04WzcDPzAsAtHgvD7GGKOQwJCXorwd8yTioEHysXS0y1vmolI1kddcYZXo2h7MoiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atXhAlcL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57E606A33E;
	Sun, 22 Nov 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atXhAlcL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367807;
	b=I4ACU+UPl6PEAn3t2TS7ErqeX/kLlIUU9cE50zGjIEloG4jBuxgCMr0nQMlZo+QtMw3p
	 g94DyiUjuRr0adhkELe40BmurUddgFVr8q/VjBcyyx2ZFzIwKUSUYeOE5itmXn4zgvdbT
	 pum2DLHyhNxjolTEh7iL4kVhLxsCPAS87vLolia0IGVryLldZHj+MxcnzdwkpuymSs/aw
	 q8SdHr89/M5Giaw2O8sBRE5BdLMtXhcygDB4WAOjEo6XpHLwGKZ6fsVJ4py+YqY/EbN6k
	 Bsx/rOvd7gBAhwYmQPowxczQkx675pQ6nd8nyiwF6yIxuyOnG14H/yDuMsXVODs8KMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367807;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=SeKjELiXemrmuj/pVrBt+Gcb8iYnRIwz7DdKgSPAfSM=;
	b=gXe4lzZxwu2cBbuwos0gtOePczDFnhuDs3cyGxaehR7ScD2z6pfX9tzv2pBGh28rfP92
	 pl0Dscq95HCTfZq9gGBIv6yxAW75ovi+/OWOGc2bS40ipX7NTHcOX52L+kLg0hm/6hZYs
	 dgMeuPULedluEVkI3gW1mv2nzppeTp93seBTB0eyfghu53lDcd8smHXfb3642iYjvfx+z
	 dLujpO3PvdUNHmf5WsiWHrnfqpEdYrkalixfT5QzlKbRhRrYXLkTWB6MBsiU/tQB/nQGq
	 xzdhlPuFQtl0DlTS4zZcnKIA48b50IBM/iKjjOQuvQsdBj534HMaII2Kzm5xiCx9yyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF38F1F000C0;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367807;
	bh=SeKjELiXemrmuj/pVrBt+Gcb8iYnRIwz7DdKgSPAfSM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=atXhAlcLbnIKHguPmu4cTfVBw3vMOZr+Br39m7y/7GpEBTjqdc+7W5jDNfdPUDuEd
	 6Dpi1oPAFJbfbGi7fL1O+Ta/ysPKkd6mwuHPMEjXv5R4fa+U5A5OHqzKQ0J8nkzGFD
	 byQjoDttuB29xdIiDx+9s1vnDYVzz/2K1WEvSB/zO1vvm36CAQUYrYpVo5EOFujncs
	 oj7Tf24qDNXSMvLcSnyVjFGyXeHbRu+V2oJH7PO+uOGtCzfaRNQTMHfad2IE30hRXv
	 aLmOG9X119Id8lhjk3nTfzpp6dqVMHRFXFvhtTWsjhjOXbdDmH5JnEv/P9hYsRtJBU
	 tFysP/qEYhyVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2EA144C141;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v3 0/7] iio: light: stk3310: refactoring and new chip
 support
Date: Sun, 22 Nov 2026 19:15:41 +0200
Message-Id: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOTQ7CIBAF4Ks0rMUAQ6B15T2MC6DUorY0UImm6
 d0tNSb+LF/y5nszoWiDsxHtigkFm1x0vl8CbApkWtWfLHb1khEjTFBKJBZSlDiOFwCQGHgjFas
 1KMbRcjIE27j7yh2Orxxv+mzNmI3caF0cfXise4nm3psuv+lEMcEEODFVpYkF2A/Bj77vlLtuj
 e9Q9hP7EOjPc4ktQsUabqS2oI34E+Z5fgI5GlYIAQEAAA==
X-Change-ID: 20261107-6768-stk3337-34f7a2db3a24
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=1636;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=2HH/HfdtFY3GEA+ss6XCFk9efzMGE8PhUZ5o2ui45Ac=;
 b=mSlQoXrvmtI+m2p+Qk1db41/fr0QqUtgUyMI8Mb3aUa2sLNnylKR/bxAaxqdHhaYjTb7Z/iAJ
 +20v4gc80YOCXMWqPlf9VdEcW4lCfidKKyCsEW9EYbSFbCk40lNhY1u
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This patch series adds support for stk3337 light sensor, found in the
Xiaomi Redmi Note 9 phone. The sensor is compatible with stk3310
registers, while having Clear channel, similar to the stk36c61.

It also adds support for stk3331-a sensor in Realme C3 phone.
It's stk3337 but in a different package.

Additionally, there's patch for vdd-supply property, since sensor can be
wired to the shared power supply.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Changes in v3:
- Add patch to migrate to devm_* helpers (Joshua)
- Add stk3331 patches
- Link to v2: https://patch.msgid.link/20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com

Changes in v2:
- Clarify that stk3337 is a subset of the stk36c61 in patch 4 commit message (Jonathan)
- Link to v1: https://patch.msgid.link/20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com

---
Roman Vivchar (7):
      iio: light: stk3310: migrate to devm_* API
      dt-bindings: iio: light: stk33xx: add power supply support
      iio: light: stk3310: add vdd regulator support
      dt-bindings: iio: light: stk33xx: add stk3337
      iio: light: stk3310: add stk3337 support
      dt-bindings: iio: light: stk33xx: add stk3331
      iio: light: stk3310: add STK3331-A support

 .../devicetree/bindings/iio/light/stk33xx.yaml     |  7 +++
 drivers/iio/light/stk3310.c                        | 60 ++++++++++++++--------
 2 files changed, 47 insertions(+), 20 deletions(-)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261107-6768-stk3337-34f7a2db3a24

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


