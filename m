Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089708;
	b=gikOD4nPWs0CneyR6fqUhYr6/zNmIxCTBXp1AF2gISWbvliISpXLZZur8bsF0TgeHMYk
	 XCE1Vlwtci8uuXY1G7kr0g1fhh7ARgpAh0N+EyX7cJKKYM2o84xIs0rSCwF2PnzaDQt+0
	 TJSIy+RWEXeSWuxsW2BsMl+du5KahBrtHGbJDRDMRM+g5HP4CwhlB/vzIYlbLU9FBtGDS
	 qx/yoxP9aL1wDM/N8+Hflvpssj+qe57J3A4BB6wqCuV1I94VEVwULewSh6Ai8SdDKNbJq
	 fwR1d9wrKrtArGGtaMwnRYmltMSP0veopnQMdHx3OQywOzPu5LJWqu9BaU3QVxhPOOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089708;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=fC9nAZVA9V08d9m3Q524IxaflkcbRp6Mqgh25OsIK9o=;
	b=IYtAWxs2VA7T4lo5R09f3SyGoi4NJff0K9CxifWbtnO6JfpINqv55nCnnlEChujGM6Iv
	 43OO0yXIt5UU1uPr5EatPsw4b+PWOBmz0nHBdxS0poh/D5J4A9jQ3G7M2yKPA/e4Ekr5r
	 ssRq5qacwF/4AaWsIjAX3zHdZhD7vwSbb18axgOe4gXnHahXTgHQ6f9ggLk44cO2UL/bb
	 nMl9OsBx1EesfSPpC/KWgkTeVvsEFTv1Br+/k/mN4TxkN2mflZyk9pUvd+C87utRbIB2O
	 44EodilH064om8sYiv5KETuhB70R7azVebhrz6BZR7hLBYHr7TeO9AJoqux36Y0HUBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTfZMhNO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9265606A33C;
	Sat,  7 Nov 2026 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTfZMhNO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794089707;
	b=lkuCOXoMp16nKNYxFA0KiZTk4AyZQSGm9iXrQskV3vhifC58swivsqtVy+0fGNLnVGKr
	 iwyJEGnHlYAcXOA1FQukehHRsZciq6mfntOCql7dR0lAHuQW9oBfwFHXvs3iiYl0DR+tY
	 Mzf5js/wjm1OFREl2sn7h8LhWUBFbciqzKNlSAc/WA/omh4hLnezg7IyyDoFccjTwyFtv
	 AbyQfZcLW8lTsglb9nDPd8Tug8kR96MwVMJDArlo97r8CVxCkqtuuVKnEh8TP00lpjXuz
	 BcxKNIT2oOiSi9KJYY4oC6iwYMuMPb46pgsusV6q629I+F6iZYnxSh828keNt9YkOvQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794089707;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=fC9nAZVA9V08d9m3Q524IxaflkcbRp6Mqgh25OsIK9o=;
	b=kKkQobwCIE8R4rS2Bu1Bl/KyC4wiT5N0TinzIKJErbpMzvisegJ/fGDRpoJ1x9cW3hQ/
	 uPGxgE3HCWgp6n3Sayd0wsngnlcOyUXkGlvT7r4bjDEp/i524PtPXRwKDr0ipJaF2+GUv
	 YzaxxZLVty6BjPPv4BfwtuNiu2tapphZEiKIfwdeRyCh9fZcsfnFDHfus7m2mz4ukdTvn
	 WV9YtjblGB6dYoJWk3921GjlWYGRL+kLcBZX8GN7Dv0l5oNjGIfzn7oOA2ujh7DOylkV+
	 IJM0C0bJ7UEmqEqF+niIoBBgjmdb3t7JQBcEadqDARNYmgMSiCs8nKrXuJe3xIzz6fA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F3BB1F008A2;
	Sat,  7 Nov 2026 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794089707;
	bh=fC9nAZVA9V08d9m3Q524IxaflkcbRp6Mqgh25OsIK9o=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=UTfZMhNOIVrZlcyRLdRoQAnnBKxze8hBe43Wq2HLep8PLOnx6bZhHb+UUHGlN7QoD
	 44MqJdFQRw1RWoZZGKH35NKyGiQCM7yKsvmeHpOk7OEuhcIsKWBVfQ6OY+AqrHHznb
	 s9UUNPVrgcpwY221jYGPVKzI4OI+g1529hAgBu4XZ8zGt7GqWXwVLCQLc0WWNResr7
	 p5yrYRE84QhnOVrPp+iIQ4Bh/rGafPLVDDLaDsnT/LHB3PF3tCX+iPuZIMl/lfuKil
	 Maj9c+0V+97Kl2Y2avq4mHVokUWT8VQIBmOX/49BYdDDNifuyalXq8mW0LV6bWBQdN
	 BNVCpe6jZd2JQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A098947D34;
	Sat,  7 Nov 2026 22:15:04 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/4] iio: light: stk3310: stk3337 support + vdd supply
Date: Sun, 08 Nov 2026 00:15:02 +0200
Message-Id: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNzXTNzMwvd4pJsY2Njc11jkzTzRKOUJONEIxMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAwwIPuXAAAAA=
X-Change-ID: 20261107-6768-stk3337-34f7a2db3a24
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794089703; l=969;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=J7EpCcudKslIFmWVaj/lQjrcW5V1778FeNRCMHZxV0w=;
 b=XeBpOofutHPzMGqYAXYM0cq2/fNQbuU0FzLK8+nly2nwniSkzxA+lSGzqbSFGta1w3+onjACD
 vMo6ACJMzTXBEnmJ63XAcVVj4ruT8xL3D9amAZQpk3rZEh1we0IezUp
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This patch series adds support for stk3337 light sensor, found in the
Xiaomi Redmi Note 9 phone. The sensor is compatible with stk3310
registers, while having Clear channel, similar to the stk36c61.

The series also adds vdd-supply property, since on this board the sensor
is wired to the shared power supply.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Roman Vivchar (4):
      dt-bindings: iio: light: stk33xx: add power supply support
      dt-bindings: iio: light: stk33xx: add stk3337
      iio: light: stk3310: add vdd regulator support
      iio: light: stk3310: add stk3337 support

 .../devicetree/bindings/iio/light/stk33xx.yaml      |  3 +++
 drivers/iio/light/stk3310.c                         | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261107-6768-stk3337-34f7a2db3a24

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


