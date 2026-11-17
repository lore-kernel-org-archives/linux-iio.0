Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938918;
	b=q8ZczAVDE8cySRJdWJpMXeX9g3/aYle6glOM9O4bctEk3pbfVF7wBURKLnQhNbeF6aKS
	 sG1NfzhihqNvgyz3U3zlwKh7wHB3mUet8KH3BNzV4xNoGu+LQ1MXrYmpUCVBqSu81QCuO
	 /j5QSDxjhJ5xutoH6uqFW2Ci6pihnQZoH5j3sLjPqdg/4vBQoQetIQ/abpCeYvvik5bE0
	 wyPwyl5bCHJge+3KKSvr+hk5maJn5pYnWLPbE6zcezZ3sv3ek4IglUfn6gJiPBe8eweQM
	 jU8Imu0VD7QH1pfffl60CqGURmVgXgW8tatPdKSQ+wPdM5kMashhzaBRMqwHaQLCRNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938918;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=85uilDky3vjfdfPy+HYkSRA0zAe9Gu855WzlPaah/vk=;
	b=M5yvtyjSDoM8efs/uyGPcT6EA67Lk6ZC5ufQOL1BgIKBvhvOHYpNksUhzRuz3lrVtvKG
	 j+3E+lLMA10Pu/TT/+oOAvdG2lC9zTKM6Uk0514V2IW2bSUFK3kIokwcUVu2lz5jj+RKn
	 W7t2YwErsGqCuk7a5L5aYBkveNShFc4Ju6sS9Rt4v+k728qQbSwoHOUnScYe5s15s2DbT
	 DDcpsgTVg5ydTu6HO4eF50BUwlmVL0SnZamhnQhdY+C0ZUulqdP091h7JRVTqn3Jl8ANj
	 6+wV3pu7XXrf9tO7RbvSt4C56wKcKe61DK5KkdTJAY+edIKI6zocPPz4c5BR2PukozQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z6q9/74y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54638606A31C;
	Tue, 17 Nov 2026 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6q9/74y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938918;
	b=HzGRbJpP11kMOwKyxfVle0UMzln0sGRDWr3i7SJAChgpyHhPWIOFe8dQcmYdA/t6Kl2i
	 tuRwyE0v2qedv4Fvn5MT+2VZPRDdhtcBK+XTHygPDZFNZupnZIpxdupivwEtHFZi8+Ztc
	 HVPLPVYLWR2hjh30CzXRNTEvp+iAGxbYfB1LSIWnvxyf8iiAIXdtWy8h3TPVQk1CB93sK
	 NYzVAUGPkKpoM/On8qaPxyLyt7ow7c92kpWQYxcKVrT8ruHMPJegD7EtIZqLzr6f+TROc
	 soFq9D93PXLGfFIX6vGVeAxw1l04xEdYP2fWsTRPQVb6sNnBxjj9wbt9fZxXJvCagNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938918;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=85uilDky3vjfdfPy+HYkSRA0zAe9Gu855WzlPaah/vk=;
	b=bjvjRR5ajyqPL5AbgclbDpMUP/OQ9tlQXWwkvQvS3Zfy1K1RbSYNjRn5PkM3pMSDCP31
	 baYKQVX9CYioVzJy+KrBMSUuGgPuuRaiNyMOMKkkxP1QnfUJCsTJxGl9yEFUYVul02P15
	 Yn41VOBhmNSE3IAGjBh0AZbOT/CGpLh2zup9JbksN56SdRR7cUjkSFxTvung2RxsWSXAS
	 3y+CiK8nOmwgnsR0fJ12+11XTxBdcbvyD4VHtlbR/Tdm8MDkcfIZgoZ9V6rTXZdHHUXOw
	 m6ih4+YYJxg845NlUx90Gw3wIBGe6j3DFFn5BztCmV3IpnZsUhzt+Rt4NL3kKwgsiUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9B4871F000C4;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938918;
	bh=85uilDky3vjfdfPy+HYkSRA0zAe9Gu855WzlPaah/vk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Z6q9/74yxHoyVSyxz3fq1JF8B4ba/QRt8glHaRXvqBYBbEIhdIe9GTbjJbFiFZq2T
	 oEqCaxoG+moBh0OTv9O6gcNsJxpaX+noKh+trQNCulIOrbKC7fmfYYyxNKFoWQdbQS
	 SUxUAlO0QCqibERiUm+G4+vsIIo4pFC4Nzru2UhVCnuZ/qXCmP6AURn2LrGSQbP5Mz
	 vEvSwTODAD9UycMb/+fh2Bj8ccXXEpC8/6C5rljKRxoLWW6094DpQcj8XJMGIepbRh
	 OlYyYsAx6mqj22a89juuLKTWXVi6cNNXJ6z3dPuzsXKO2Jvu904qm4WRdwFcCOsukb
	 Om8OAVtUct3vA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EDBCA4AA3B;
	Tue, 17 Nov 2026 18:08:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v2 0/4] iio: light: stk3310: stk3337 support + vdd supply
Date: Tue, 17 Nov 2026 20:08:34 +0200
Message-Id: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNwQ6CMBAFf4X0bE3bJRQ8+R+GQymLrEpL2ko0h
 H8XMB48TjJv3swiBsLITtnMAk4UybsV1CFjtjfuipzalZkSqpBSaF7oouQx3QFAc8g7bVTbgFE
 5WydjwI5ee+5Sfzk+mxvatDU2o6eYfHjvf5PcvF+6/E9PkgsuIBe2qhqBAOcx+OTdYOhxtH5g9
 bIsH784dBa/AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938915; l=1167;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=FAzYg1TpkGb7wV9Cp24G4J88VqcXA/Aizp5voUGpLIQ=;
 b=6DmnmMwYtz0Vf7smueOV07bHGdtjBO13koGOuoiSbrCd7WOyFnkfDRXZu0zhA4D2qncrZwm7A
 5C3y9IwNJfuDkU/nM6IkztzB5J3h2KYLANT1/hWwPiUAvjELJ73IEI3
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
Changes in v2:
- Clarify that stk3337 is a subset of the stk36c61 in patch 4 commit message (Jonathan)
- Link to v1: https://patch.msgid.link/20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com

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
rva3 <rva333@protonmail.com>


