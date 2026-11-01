Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793544378;
	b=S/WMrZ2tSuaS+gsR7/9W/Jz38nl6lGK0ypwKhpqzscvMqO+s8HWfTWZvKd4EILTNwY1P
	 7rUSwEpef2UaCD8WeUq+GSUPOE7jkkihwTqiIb1Onch+hBekzo2ykbomtoG5NSsiTvW/R
	 gHOR5mQV37sOtT2pdct95xDTvVeKs3khRuVS/qjx5PmH7chTK3rjV8RT9U0vVeQkl589T
	 5Fmb7roLWNhhP7RSQKOJkcB6C1lny6lDw7oJv4Ye6qLoOtNkC/VZdCRmbgEDed1WYfSgC
	 Ctn9KS6/LdXbpG75QyKWPajiBCWIkb3wDLF5Mhu/F7McAikol/oUSJ0f8xlqL+F9EEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544378;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=qLvnDgA84z9nfP6NpzSUeIPvKSq/UfkpF+aJ8OXFSTM=;
	b=X5ADI/GR99iqYNZZy3yNNksqgI3BFTPzS3BkdEJZdxVrYgzXMncqfpZ0GVdN7EV4dC/q
	 MrYp4v3P+PpcUhnXqErI8GrwKrQVxYoBrZE68vAmkV0MYzwgytzPuBe2e6TW4mkL0EnEe
	 kkguUr/llWGyv5Y9YRaFzYpd1/Smakqg/W1UbeYSKTAMQnctWkc96rDv0VVRJcIm099oV
	 ShvmwXDsbBabmPo2OfRa9uaNwz2y27h07TiNYbVYkGth8SKnCIERR5Lg621qFO3gVyi4k
	 cMZRG30PP5fF+gu4vFMacuuant6p+86TAEAC2Qg9yeTcF42e6Ze4XF8i4WvDJW+e2IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muKB4dQQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E1606A325;
	Sun,  1 Nov 2026 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muKB4dQQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793544377;
	b=PbhxnzjYkXI5YilhyRElFZqRvdZmayZifJ12RRg7i0kUFWQlMsrBrzDx8knBxh1oRnPm
	 lWAF9ehFE87QLoJJDRM+rx7apV3mmppqZIlpoJ2jTGTkdoJ0zbABYIkosCrqKaUElFzPA
	 UBKVWv5aNXLQMZBsIHauszMQ7gl5CtodlQGNblqMPfQvTXwQol1+H0EVdV1tSd+6ihgGg
	 4o+O1rFxG+ag0YillChOP9Avl+vKIsGaB5xehYBFOv1QQ/yYXif65yBPeLiy81DSPjqNs
	 g2AjTXPFawYypF2ofpqiaWS5ek+SPfyrCQ3i/CoK8z3xUiVm16SIBz5dHozimZjELPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793544377;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=qLvnDgA84z9nfP6NpzSUeIPvKSq/UfkpF+aJ8OXFSTM=;
	b=BzjvDXLWXy0SK5MsPWVlKtcXttl7t81VGw3nHXFaQnswkvynmcOG9Pqys3L2sYXEOq2V
	 tNoD2g53NyVHaw7RVVcPNeFYZszo8SLKdlGNJLPE65AsCWjS2wL/I8Sy/viMTH8xh8r3W
	 JPkVs0QRHG1yP76jrIknVLaHCR4XT7BaVzpxPhd9NT8TyhcSR6VqZ/Jl2QW8pePVChDWe
	 /78Jf2XPxTvrsyo159eIKAJe9nDtvqWCSVID2HQElGWXUZILzY3k4FCDWXVphTkPGcdJL
	 YwTvOQLIXYRQk5Q3Hd438YTL1eOj2ml2OxmNvuzHXPGB673IlGrR4IEj4EpvXd8a57w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A7B141F000C1;
	Sun,  1 Nov 2026 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793544377;
	bh=qLvnDgA84z9nfP6NpzSUeIPvKSq/UfkpF+aJ8OXFSTM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=muKB4dQQKHmL7Z4TegJ/hU7ExzkXKevW7wNogk1g3JM5gDeatqgVbQjn+/lxHn7ci
	 fiiQav5gEss0vkS0X/B7qawlPb/ufyLk5Mamt0RopDYQqEfJdYagvwuKbkrbUCakg7
	 XWcO0qW4+jkup88OTCNfXZW4LLbJN3jt++CBLYk+L2a8o/kkE+bCZbAhbM1qxsWOG8
	 ojtksQfTdcIZF782OD2gKbjkiw2ZR+YwGhD3dWPCenY9tfOWIPu6wCLuNpA0NL4dr3
	 QCYq0E3a5enSv9iuBFnVVuz5MdI2BtszXHrgg4SYw2wMwNSOXURYmxFW1MiAawM/HV
	 LqDFXb78Q57Mg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A336461B2;
	Sun,  1 Nov 2026 14:46:16 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Subject: [PATCH 0/2] iio: light: Add Capella CM3217 ambient light sensor
Date: Sun, 01 Nov 2026 15:46:05 +0100
Message-Id: <20261101-upstream-iio-cm3217-v1-0-5e1724cae7b7@tsv-stahl-riesa.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqDQBBF0a1IjVPQ1RqFbCVkoO1TK+CHLg0Bc
 e92zPAM7t3JEBVGj2yniI+azlOC3DIKQz31YG2TyTtfijjhbbE1oh5ZdeYw5l4qRt5JEYqqdLh
 TKpeITr/X9fn627bmjbD+VnQcJzWhECt3AAAA
X-Change-ID: 20261101-upstream-iio-cm3217-e3f14c4760e5
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793544375; l=2609;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=Mo11z19nSNgy7ItXum4iHRm9VY1mxiDs5BKUIlg3N3U=;
 b=In/ftypgqPOxyWxJtKXzOYdb9VGTNhF6O8/9pTpkdSVPeWMohPHjNQKkRYp4JGpvcpMFDVtsN
 cL2ad1JrZrZBZDnsH1YWBNUGaGwUEE6oOLlLvvA/xrRUWOUJ3wJssc4
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de

The Capella CM3217 is a small ambient light sensor without registers.
NVIDIA used it in the Tegra Note 7 and the Shield Tablet. Mainline has
no driver for it: cm32181 and cm3232 expect registers and an ID, the
CM3217 has neither.

Patch 1 adds the binding, patch 2 the driver with raw value, scale and
integration time. The datasheet is not public, so the bit fields come
from NVIDIA's downstream drivers and the scale from Capella's published
detection range. Patch 2 explains both.

Tested on a Tegra Note 7 (P1640) with v7.3 and the driver built as a
module, the device created through new_device. In room light all 32
combinations of integration time and scale gave the same illuminance
within the count resolution (6.0 to 7.3 lux), and the first read after
each change matched the second one. The raw counts scale linearly with
both fields. Svyatoslav Ryhel also tried it on the P1988 variant of the
Tegra Note 7.

Probing through the device tree works with the real supply (vdd_dev,
Palmas LDO6), and unloading and reloading the module twice brought the
device back each time. Next to a phone light sensor the readings were
about 7 to 20 times lower. NVIDIA's Android HAL for this tablet
multiplies the count by 2.1505 at the same 2 T/100 ms setting, which is
7.2 times the scale here, so most of that is the dark cover window. With
that factor the tablet was within 15 % of the phone in bright light but
a factor of three lower in dim room light; I could not tell whether that
was my setup.

The device tree node for the Tegra Note 7 will follow with Svyatoslav's
tegratab series.

Tool use (see Documentation/process/generated-content.rst): this series
was prepared with an LLM coding assistant (Claude Code). It read the
NVIDIA downstream drivers and Capella's product data, wrote the driver,
the binding and the texts from my instructions, and ran the build and
binding checks. I reviewed the code and ran the tests on the device.

---
Patrick Fischer (2):
      dt-bindings: iio: light: Add Capella CM3217
      iio: light: Add Capella CM3217 ambient light sensor driver

 .../bindings/iio/light/capella,cm3217.yaml         |  45 +++
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cm3217.c                         | 383 +++++++++++++++++++++
 4 files changed, 439 insertions(+)
---
base-commit: 137ca6e5de3bd4e1056877d0b82214e82143efa7
change-id: 20261101-upstream-iio-cm3217-e3f14c4760e5

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


