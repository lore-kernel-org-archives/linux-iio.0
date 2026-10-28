Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793226269;
	b=VbCqwXgkT4X1vhpYdQ2+akRHOhFu5LMmyPUSZKluGAnTmK4fR5Jj+mBIkOJP54viW0km
	 jZAl32NXJM77C2dNoKJR3f8hZpT15U7MES1jSJJ8aahyIikSgJdCMvVpvBObRfI1t8OeJ
	 Tev4iCMTbuxfxBY0uf4WyPgwE621zkVqvi/RCDChBKbauOFXh8Pxel+YijZn8YYZf2hvJ
	 tbolcPLHChoE4UBZXD21/lp0s9ALPEY62YNxe+1nsDa7XnLZBcuFryQogMSjyg9X8TaDx
	 tuwMrVQORbocTN679gWLyi9BX2rzgrstSI92gJseI4h9qJVsu3hL8FgyiJoJxWA19bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226269;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=FOjUM1QU/65yJdqKRUJpV2huVdJI9vszG3TaDRFuNvI=;
	b=s/zE0UuzqC/R4EHn6jQ0HnjB4kmSYVKt098zXD6NTgOmS69Pk3ttvO3N3rbL/T5vdYKt
	 rjGxnxWhry/3PdgWLQPcsJMwVZbAEY4kewO3eRwL51IgLhDrCGf9hBX4R5PKNuhpyWGuC
	 ia6eMj5Jzlemnru59yGuwHcgGbNxnUEtuBGRfqvD2U55i0IEtmjTUzJR6FcDChG4RfXNy
	 NJXaUrCA5oMXz757oiS5XtFd92DeTotH+pxBoJIEqX+OKU1OEQfbsHuzCFvUL/eDoXsFf
	 5GFTFhdb8yE91xeOQJHB9px/49uTAc7TaetDiKCcm7/GE94d30UagYIGIfE3c9pBtfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsiGnW4k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11454606A321;
	Wed, 28 Oct 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsiGnW4k
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793226268;
	b=WTRtpCTw/LxEL+JU5wVreE35/XApqogNpLtohjBdVUmYNouVBtdkFuFO8ZYWx9hy2ZaH
	 RCJrPhPioKTOl1t7IZkshZ6PJtyFZLb+EU9G88iVkzSuDWAfHz2ilVgDvu+pJtmSDchcd
	 TgIuKbHJKqwLLbzpJxzVhHill5pZfD9nZzBliJLdajBuXGzg64+OLj6CHjeBUrvnx1t+e
	 4sXqaE/r1df546lGzxy+kBqSQ7Cl4NeBC/ltIKFKL1bVf5b0MAPTjNvFMdim1gDbi13rO
	 evl19rcaX1NfC+18sstamyZ6HPJEjMgqmPKvIrR4wQFClWTDU570Ffza/4nB/Doe9Nw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793226268;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FOjUM1QU/65yJdqKRUJpV2huVdJI9vszG3TaDRFuNvI=;
	b=r+iRkpbEbceK1Vo1VV2FEh40bxqntUxbLWt0DejenEAMoxf6K7CkSSWPLdoHikf/H9al
	 o4Y/+xQjYCO4wYj4IgIDJNANbU7TI+ysUuYxb57VhowSemy1+KSsgYv4N2NqYPTOT558C
	 SOmZfdaOy8M29tYY62RKc6NgYut4quL9hA75UaJyjQ8a6k8SjMmm1DrZkQ7MCVPplXef5
	 W4chaxdezMURIlTGhv/iWmfgu0HgRsrhnHck9ealD5kvf4H/T3u3B2cAzckzzn0fv1uT7
	 8P5F6hW7amtWDq3gkOaitewFKyq2jl83130e6qROOrxwF2PTIXOigFwfKEJADEsI4+Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 209851F031E3;
	Wed, 28 Oct 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226268;
	bh=FOjUM1QU/65yJdqKRUJpV2huVdJI9vszG3TaDRFuNvI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=EsiGnW4kCfzwsRYQWArZpz0X9Zm9LKuQ0tVrMXUQR69CVK6xqpIxU0jND3ciWfkwu
	 UEl9fPz9wp8JeWarsZwIeGkRBOBXxzh0UYHjvmdPfzx+B2B2JAbMXWvrEpxSWKhnFd
	 YG8xqn1mVQAAgYDInRHweJ9C/Lia9S5lS4AGjJFZ0CSQ00xFVP7TC5JJZuZS2D/RcI
	 R/OiVW+5q/zIywYJm/+C1nvXm7ZtLp1281ScBpBz3GK2R+aIrk3wkA3PWM2okQhXv6
	 gzNf8R5mK5ANUJEKgYIhjJBtOSut2ntlKBzEOIxHKx3bpE0cBNuQtW3MvsmIPqtGN8
	 H/so/QZxQ/Vqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 75980455D7;
	Wed, 28 Oct 2026 22:24:26 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Subject: [PATCH v3 0/4] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Date: Thu, 29 Oct 2026 00:24:25 +0200
Message-Id: <20261029-submission-ltc2493-support-v1-v3-0-c7dd5f877c3b@analog.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABl24moC/43OQQ7CIBAF0Ks0rMXAFNviynsYFxSwxbSlASSap
 ncX6kZXmszmT37ezIK8dkZ7dCwW5HQ03tgphXJXINmLqdPYqJQREKgoIRz7ezsan2t4CBIYL9N
 qnq0LOFLcVIxxrTQrQaFkzE5fzWPzz5d3TsBNy5DR3OiND9Y9twcizb1/b6UhuFRCUcVaegBxE
 pMYbLeXdkT5WIQPDuAXB5njVHHSKGjq+otb1/UFngVSSiwBAAA=
X-Change-ID: 20261009-submission-ltc2493-support-v1-86449ede432d
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793226265; l=3174;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=1eElcDBdYH6U/ku61R6dLZL+jxyUrre0O5/3HdquLhs=;
 b=yEFSNN9D24qKQqM56ZbWt8NYT5yfncSvbb2L3PTHannAmja4yUc/CCeEHsPfk1ItZwoHa6w5p
 YHzLTQxydd9AhzvDp858mrV5p4ZXE+Y+Uoxvvva8EJa6tn5/RZDGcfZ
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

This series adds LTC2493 support to the ltc2497 driver, and adds FA/FB
line-frequency rejection for the LTC2499 and the LTC2493.

It includes:
- the LTC2493 device-tree binding,
- FA/FB line-frequency rejection (50Hz, 60Hz, or both) exposed via
  filter_mode, implemented in the core and enabled for the LTC2499,
- a preparatory refactor giving each supported channel layout a channel
  set in the core, referenced directly from chip_info,
- LTC2493 support in the driver: 4 single-ended inputs or 2 differential
  pairs, 24-bit result, same command format as the LTC2499, the internal
  PTAT temperature channel, the 2x conversion speed mode exposed via
  sampling_frequency, and the same rejection selection.

The rejection patch also adjusts the conversion wait time for each
rejection mode. The 50Hz-only mode takes up to 163.5 ms at 1x, while the
previous fixed 150 ms delay only covered the default 50/60Hz mode.

Validated on a Raspberry Pi 4 running 7.3.0-rc4, over an IIO network
backend, with a DC1010A-A board (LTC2493), a DC1012A-A board (LTC2499)
and an LTC2497:
- LTC2493: 41/41 hardware tests passed,
- LTC2499: 36/36 hardware tests passed,
- LTC2497: 24/24 hardware tests passed,
- all LTC2493 rejection x speed combinations were exercised without
  conversion or I2C errors.

LTC2496 was build-tested only because no LTC2496 hardware was available.

The source in this series matches the hardware-tested tree.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Changes in v3:
- The channel-set selection moved into a preparatory patch, so the patch
  adding the LTC2493 no longer touches the chip_info of the parts
  already supported (Nuno Sá).
- chip_info now references a per-device channel set directly. The
  num_inputs field and the keyed lookup it was matched against in probe
  are both gone (Nuno Sá).
- The LTC2493 patch is reduced to the device-specific additions.
- The binding and FA/FB patches are unchanged. Nuno Sá's Reviewed-by is
  added to the FA/FB patch.
- Behaviour revalidated on hardware on all three parts; see the
  validation summary above.
- Per-patch changelogs are under the --- of each patch.
- Link to v2: https://patch.msgid.link/20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com

---
Andrei Stancovici (4):
      dt-bindings: iio: adc: lltc,ltc2497: add LTC2493 support
      iio: adc: ltc2497: add FA/FB line-frequency rejection selection
      iio: adc: ltc2497: select the channel set per device
      iio: adc: ltc2497: add LTC2493 support

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   7 +
 drivers/iio/adc/ltc2496.c                          |   1 +
 drivers/iio/adc/ltc2497-core.c                     | 208 ++++++++++++++++-----
 drivers/iio/adc/ltc2497.c                          |  47 +++--
 drivers/iio/adc/ltc2497.h                          |  44 ++++-
 5 files changed, 243 insertions(+), 64 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261009-submission-ltc2493-support-v1-86449ede432d

Best regards,
--  
Andrei Stancovici <andrei.stancovici@analog.com>


