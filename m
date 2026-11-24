Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795560433;
	b=kRgyonmtMLqEPHSy/4AkggFKLvdOp26YlOGe4qJktWMo4xF9P9JdsXFA9ec3knuzHgaR
	 uaecMElMT2ty8mzm6dEIJDsZUEW871NzRtWdSwvw53lcDKXIvWoeZMVFVggtf2/kCjARt
	 dLaMOXhXq6ZooZrTEjb9rZxAJi2cp1CGM3iHbf4oIKf394PUvDz9oTOZqlbT6qC3Q1E3Z
	 6X3XP/hixMwM3Mtp5Z0sUW34p3VdDR631ZhBeUjvt79o7gUWb3ualTpKeeMeap8afuk9z
	 4HT5BlMb+SJCj2ZOd1lXa3bfFBRPd30wOq5XNgshry2cb8A2F24+JVvDbj/xUuUcfBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560433;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=UJPhuGthwRJehmNTgJYSSAun9WlQWtzcDxri6C6V+Bg=;
	b=bP89ZY5dYnpcbbdvXPATbQF/H5yG5l5mZZePKFBcKX31aE6SmtSMbwF8eO+0+6DSQ586
	 0Y/O97Um/q3sYK7jcBIEB0/59EiVJQFbYhgafvSktbUUFQTt/UnEScix4kLzFYtknnhnJ
	 i07UzHzVJWVWXnh8cw/LxDp6wQqJjgSCNzgiho8/HeWBKUr9OqVAnuPiEZ9AAdsdn8EeE
	 A7q+EQr118RlMuEDFI6I0exaC0n9ZnOQhmdxDEgyZDvlKZIaw0UT8TxXH35VZvW4rNy2d
	 q318YTPl0Ja5LASe2uT8cnmRQkgJRL8687kJhkz3aa27e6KnxYgoJBgLResornP0bzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqWtoghd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B158606A31E;
	Tue, 24 Nov 2026 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqWtoghd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795560432;
	b=Kgwt5aOA78jCB0JuqhojDdEZkHp1MSUzmWKn+ihjFuRj8blzDDtoXd8xpEsfoIJ5gqWB
	 zzJyM4orEu06pY2xyzML85n/MChJEGiJwet7CdRB48ZHwBMLDCVNjbeuqGJbv6iZ3PUR1
	 FjIG0n56ascCDuwbPT+4VflDntSvac2eDyKt3DwAQGdsK6AD/apjRpf+XuS2S8718J9+A
	 9nhUKZMjJJT/qovQNNssN208k+9UV5+S6uIK91UWMMlcf8weuOokDiganrkLdBLx+/WtJ
	 PA8T5kUy0upZdro3WN7y+3tRWUYJMXG3W7LrDGw1Yzegs4G8wTCYe5DqvnB0JeClO0Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795560432;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=UJPhuGthwRJehmNTgJYSSAun9WlQWtzcDxri6C6V+Bg=;
	b=Ce0a6vHyi7w0ZDBPpkhPWJNBAM5JHBkU6leeDXZ95uTF5B3kZ9bgaDcFqtlx3D3TXGo3
	 e2GSQCu144CKiNpBfax7RVyLHHEGV5o/6/b/TA7zmpB9aWHuLv2QCNbKnyt2esqZ6p2vl
	 rAWIEwnAZxdu0QvN9jKsWJ6ZAPjxO+9GIpUFmVPAw1gYQx4rCz7xnhFyzTOZNAhNPbOKG
	 qA4yz+D7yKeha3csG81KswrvbvpEtpiZEDLVyeUAQDFOG5bVBF5rm/7ju4oz5Pmz2GwAT
	 3W9Vxr2RSFUfTaaBCWnorNXN21hJRti2sxnRIt29KocD/L8CUzJGPYAVpNeDw0mSGbA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 15FB61F000ED;
	Tue, 24 Nov 2026 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560432;
	bh=UJPhuGthwRJehmNTgJYSSAun9WlQWtzcDxri6C6V+Bg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=RqWtoghdKY4ZiXgHdonuEAeilvxae11sK5mNen94WjdQcmvCMyGc7f/uDrROu1aVs
	 M7dDsFkcPzSCwxfGWq4BVhHpFdkv2IDaCH7naj373hujq9XSxwO5JYVRzByxeVZ6x2
	 oVt3Ns7c4VUP3hfTevgwMTjGHYD7U/u5UDXmH7xna60/IHuAYU9DEumJ07jEwpI3g9
	 wGeHVXyJmvRUzrkP2kMIMyJEFt0GPjy34pABvD/xv4aBUoUoJvf8j8LsD7zdgCnwEv
	 YrAq6VWMLdL33umeYCZAF/loc9n7c+uVNLPQdP7KYtVydDcA8RXdNuaHCIf9nvEe6E
	 /ah1/5oCYlBTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E5594CC0B;
	Tue, 24 Nov 2026 22:46:59 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Subject: [PATCH 0/2] iio: light: add support for ams OSRAM TCS3430
Date: Tue, 24 Nov 2026 23:46:56 +0100
Message-Id: <20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDXRqf+riAU1GAukg0jE3RXLb
 /HeBUKOSaAMLnB0sPAye+gwADs280CKO2/ACFOtMVbMi9qsmNhECvvE5FmRYEYd+GJ11PP53ar
 6t+ztRHZ7F3DfDxcKWmlvAAAA
X-Change-ID: 20261124-iio-tcs3430-2f53879527ed
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795560418; l=1023;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=LG2ewCo1AW0swjfSDYupyXwfkuTjQvVui6Y094td8Y0=;
 b=aeT5Ovy9UV5sBRx5TnlnZJ85IXHLGjZCaVNRFzuXR14XS5g6PMqzdDmos4mS3XTs2yTrua7Fc
 xouJsr5bsyEDG0KsPjnGh/ha+OpfMRQT2IZJleZOu73/SU60fbprAha
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
Robert Ijtsma (2):
      dt-bindings: iio: light: add ams OSRAM TCS3430
      iio: light: add ams OSRAM TCS3430 XYZ and ambient light sensor driver

 .../devicetree/bindings/iio/light/ams,tcs3430.yaml |  52 ++++
 MAINTAINERS                                        |   7 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/tcs3430.c                        | 345 +++++++++++++++++++++
 5 files changed, 415 insertions(+)
---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261124-iio-tcs3430-2f53879527ed

Best regards,
--  
Robert Ijtsma <robertijtsma@gmail.com>


