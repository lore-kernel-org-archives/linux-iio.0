Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723747;
	b=vB3fyS+UC7Mw8Si/qPYrcdPwH6daTnTsNT1Boo0Pvlk/rB05MNshNQDjjEznrp1CkURl
	 hmW9UQ2tpcGMD3umBYfDhi06FmngMfOu2huNFIFw2bCGrOcZht1irIepSgGP9AbdPWzZh
	 VGW+xjWJ70/2nc31oZGdL3ev6kD0Dv+1z5z+ga1yv8ugVijX3gfVb3Znoc91nMQqo9NBL
	 wsIjeH+lBhRBN7k7vwA8LLn9IDoTxex1CyEPaJ1SenKmkYW8X9svCFZ1NE+VIM0gHI6G+
	 PYH9j5oN0t8Ye574BwWyn77/rY/gn9yW5OoXAPdKf76iexutYd2wZhCRvJ6SY1UeEbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723747;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Q2rTkuHKJkR/zr1Tuxl2mFpv68LPyzfxCs06AgRLmCE=;
	b=vUg4BoMOadRXXXr/aydJZWCXyZ6l8gfDOAiLAT2v+iO5BF8VLC2Uu7FxQ6R4zpO9qJlK
	 pddzW5EtpExfWqvKnD4FIa4kH1acS0kKRJJg8ldgcYwDvplrt4v+r0ynaHYj9xnNQzSR2
	 dVXRCrcSHTpRz2yETMa0F1EFKJnS71qTVAi0n33ZS9Apc+EgUgcvm7mdDazgBELqXd2M9
	 7y1z5+V0cUUShYA7Yj5Lmd94T5GqESejpjKJUfBr0JNpepiKDDAGrmMxl3HoP8EQsh+fx
	 K2K1+bJAyJuIIATQb4GVPod2gfW8f1qzlvo7AU/ilVmrfHEP8VRp6Xcnv+RCKAObPvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M20hHYQW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F81606A334;
	Tue,  3 Nov 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M20hHYQW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793723747;
	b=Jl/ywiu1yknyS4YZS1DRoXuSaLcEfoE0uT5S/f7MxBQTiBdZ5TCQ74owrklb2/QNL43d
	 i+5g4sjyqA+Wb5IBXdrsVVpxz/veFQb9rWWEnMYiiHVaQxpI3OlT4p9eAMYofK5LSteaY
	 5R+bdcxaLYMj6OC9qhtjrrVxuqXwy3annAsQ+6yk6w0LNykClb9kTkKUuG/qJY1fZWKvX
	 P2Su3Gtro9UuE6SyDzhLqAA6v9J2nJ2m/CTJrLk57P6MDm9xAgzBAegP2WgW6btBXL3oN
	 D7XaKesdtkYs3XA9vMn8d4p03b6K7Gvd6CQFC8poqq4vdRxmRMZHNIfUt+clR7T+ZZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723747;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Q2rTkuHKJkR/zr1Tuxl2mFpv68LPyzfxCs06AgRLmCE=;
	b=S2b3bzPmF4Xxu5eWYLlqEnXJ3KxlkrlGfTDHd4ehplfwQe0lcIIE2m4iI/pA6IuS40Ka
	 pt1ppQfuNAJSaKN2kUgJ/Uq182Eibo+qxn/5H4Ijf4yKo7KQ+wZAbCubrqHm/Vzf+p+Kn
	 YF2dPRoQ3V/L68jaQn2mrk2eh/Jpx7OonT37zP8UDC0att/+iSc8Y01WmGDpct5hq580o
	 XbgcUu7TXdEV/rbW+9aoFWcdtGujlmmxpbhhdaeQMgm08CZbbPAdMmUIHmCs444lvoM8k
	 O1IdmYPzXdYSIOH7ZpuMDQo66r67YqzigG4xC3qKrri5u1xmy7iXKFbqb4QaiIffW4A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5420F1F0093A;
	Tue,  3 Nov 2026 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723747;
	bh=Q2rTkuHKJkR/zr1Tuxl2mFpv68LPyzfxCs06AgRLmCE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=M20hHYQWkJqXM5xczjLsyKZN3QhOcQCMcOq8+Q470tPv8+f9cQuVJwUf+1tb4BrxE
	 SICEhRXAX+zRZYjOC6DkexFE5nkK0y5PDkQXGGzezehaiBV/7qRbsCQCw/zKs1pjct
	 RICKhVImWSMRtrv6RkJCxCJf2BekbVM5pQAG3Qf7EQgRjfcoOuJmRBcCjhjk3DZBj6
	 Jj2dkxaMqB5ZUil7Ln4qRyaQDKlq+eaJkUh5CjvImVft4zigOk4PUV0oYpszvJdE4d
	 o3yBHGCH56x5+31oFXyGT0O+p2zMXLH4e2VMw2br5pOEgE9aJ5hGToJNc2oK11xUFf
	 d6nAyyXW5N7xQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A5C2146A36;
	Tue,  3 Nov 2026 16:35:44 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/3] iio: adc: mt6359-auxadc: various fixes
Date: Tue, 03 Nov 2026 18:32:06 +0200
Message-Id: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
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
 vPSU3UzU4B8JSMDIzNDQwNjXTNzMwtdM2NTC920zIrUYt205JRkc8vEtMRUQ0MloK6ColSwBFB
 TdCyEX1yalJWaXAIyRqm2FgDBa7lWcwAAAA==
X-Change-ID: 20261103-6768-6358-fixes-fcdc79afae11
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793723743; l=950;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=doV4JykRzr4qLWTGO3/PJI6VtFZkP4IiQqJpVVNcdxM=;
 b=i2ltcp1uL6i2XvvgCUd1gj6cSYYIA2wrRRRsy5ngfrRObEo6GyY66rDAMj/UvULuGnKd2ynJt
 k+j7WbSQMzCCtusU1GCX49q9HS+//kVCDde493ZyOXlNeUh1BetuHwo
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This patch series fixes various bugs in the mt6359 auxadc driver. For
some reason, the driver had channel types for temperature or resistance,
while the ADC can report only voltage. There were also issues with
battery channel ready bit masking and scale calculation.

Changes were verified on the mt6358 (mt6768 platform). Compile-tested
only for others.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Roman Vivchar (3):
      iio: adc: mt6359-auxadc: correct channel types to IIO_VOLTAGE
      iio: adc: mt6359-auxadc: mask conversion ready bit in mt6358_read_imp
      iio: adc: mt6359-auxadc: fix scale calculation

 drivers/iio/adc/mt6359-auxadc.c | 88 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 46 deletions(-)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261103-6768-6358-fixes-fcdc79afae11

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


