Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654426;
	b=s5y+e9eVE6Qj8b6P+lOm6WAFSjzRpu2cpCUKO9b2BzoshfptveO6wjMrYwWwxvtIHJyG
	 MtsgfxNaXjaN3xbX4Wfy3F2lhCSeAcRv+zhNNWb0DHMRE+PUOjX7Bt0aXrioqYEQzuQSd
	 iJ5fHDS8sZAcSWEk5QRIGTO/0JtRVecTY8rolXZ1tejN0Dx+C1R+qJs7yKJ3j2qtOZcz1
	 Oar4aLQ6snDGjUUu7up/YHzTP4xN3MoqgB12kwTRsuNGn8/gw3XZNTYaqOQ9Q85euHT09
	 KWb7benkNOOXrK5V+OendEVGIRUQRjNEBTjVFM2H0nH13ASBDbVfuiBr3J1UViQLfGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654426;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8/j2KGNaUueZ6HQz5OAd/x2MDfeXHwBB6zGE9XCsJuQ=;
	b=xVoA3kIp9qoChMgUFhoe3Wu8dxWZz7KE1rwAnf/J60kV5p+DzVUutGXe5xwR8ANsUlio
	 wPUIzssyNOISW4uDhgPQSdazzoN7ZT7kt7+GsjHm2q+Wr8agkCgBbUzb69MseA63mGdg3
	 lCcRkNfJVengY5s/LgDluCNvgGhMdlBQXfwVBrhJ5h92UADh99lzm+86V3OqcjTGq36DB
	 /lnF/U3Uzv60c8Lw6SNfHnzgPxbd1yLNPMTuZGDPRGHY8WHM0LxKerr+rzq6NgZppxPDa
	 CPA2Lz0Ig9cmvh3j7ZJs/gzWGKwDixPaVMquktk05Xdg/3VZvYFlecFq4Hr+CTa0YQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hadKJSGo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC5606A32A;
	Thu, 26 Nov 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hadKJSGo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795654425;
	b=K4LCPvnwCnnEoEywbRH/+m/Hl9FpVxKZf2umq67t1CsWpuniamDaJSXja7YWLVT5ZmQ/
	 VAG51ZUDoHBOclY8cJDv1clW6EQgVKwUZOt36YcExZWzEJ57tNgGFcCjnKRByv5pSzAUk
	 JzVKItVHTk2x/hAvqguYFve8AYWv2TRM1dXAABoceDE2/qCd8/LyE2kFd91uxUGNUPmMg
	 jk9F+ekg3/7lW+V7ATVw90ZSuL/maBUwP5YteMUxZZMNYMR8Eapu+ykPok9lYlG34yVY7
	 XW58z/9qZJJrFJeYo0pfGCgmdhLMO6ArPM+r4wLnm9JDMxK+jMBp5XvCVh0556fGmOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795654425;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8/j2KGNaUueZ6HQz5OAd/x2MDfeXHwBB6zGE9XCsJuQ=;
	b=r7zBADGDw2ZthHaUTPLYplYLJF2EWC+pMlAeUCZKOb5R3408tms1DFRvPzBWqfwHpnRi
	 1qwulXswrKF2cS0HYeq3323WINM0S7VjCuQ6Qpgqeb5NhBqOeSv95YEc1ctnJLOdyCv4Q
	 z7GJzNYowQgBeDxiCHcSmMnqWt0yqMAK7xmcW4PQ1jSFTr3Nq2sAK2a6fZ0AuLmXwNE/w
	 rpiPq0J/+FzGH9tnKgM279OTBG3wpN4SISId5Fp5lmRI7xNYo97sUHL/LYxumksNvdBaf
	 ka+zMqBPhKOniZJ6i1kYskBPmqe7km8aEp+5xsqaQZxyJbtHcSV5d/fKfdvhYRVS0lA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E1351F0156A;
	Thu, 26 Nov 2026 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654425;
	bh=8/j2KGNaUueZ6HQz5OAd/x2MDfeXHwBB6zGE9XCsJuQ=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=hadKJSGo8qESy/3RHz//wg1kcKvfqvy9r3OZ3C6QiXXx9jRgpibGVifTOjBpSvnz6
	 UkCeJ2EM4W7/zRWaA7gDLOcijtBDGm2iaQxHo9p5q2V9vM6ZluBMQpPFlzoeAfXf9e
	 i1oQdmXjjLMX8ZMoYMDOGxd38oqa6+CeU1dALClMwQvG8S8/+hX7YJWK6/gIty9fFA
	 pvSY5/O8KYD/3zaF97EwnXq49ZjCPHQMaXDCemUZia2dInqUtFRG0NBhvP8kmzROkw
	 rtOO7xH9G3UdVSJ3hMoQO/iErq3EqKItyzEStNh+kDWgKYZZz79YP6anKz1HrKMfgH
	 eVFxcsDw551aQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 159354D144;
	Thu, 26 Nov 2026 00:53:27 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: mt6359: fix scale divisor, request bits, and
 MT6358 VBAT ratio
Date: Thu, 26 Nov 2026 00:53:26 +0000
Message-Id: <20261126005326.71926-1-iasnezhkov@gmail.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795654406; l=1166;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=n/bGHTO2cir7J4gLJmLj6ma/8giXqTZENBQlokXLnFM=;
 b=zLM3faDqP9nS67VJwbKUrhhlfrkzrS2+nfQsu7lnjxRY/4w2zOWZK4JlGa7zjPZkg7zztfNmB
 G8gWxAzZTtEDYUMHdtloR8JJPszlX3jrGB5QA3zjkVrkpHo9mZEBeeo
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com

This short series fixes three bugs in drivers/iio/adc/mt6359-auxadc.c
introduced in commit 3587914bf61d ("iio: adc: Add support for MediaTek
MT6357/8/9 Auxiliary ADC"):

1. IIO_CHAN_INFO_SCALE omits dividing by (1 << chan->scan_type.realbits),
   causing processed readings and sysfs scales to be 4096x or 32768x too
   large. Use IIO_VAL_FRACTIONAL with shifted denominator when
   denominator > 1, and IIO_VAL_FRACTIONAL_LOG2 otherwise (avoiding
   division by zero on unpopulated descriptors such as MT6357 VDCXO).
2. MT6357 ISENSE/VCDT and MT6358 VCDT use PMIC_AUXADC_RQST0 bit 0
   (BATADC) instead of their hardware request bits (1 and 2).
3. MT6358 VBAT impedance uses r_ratio 7/2 (MT6359) instead of 3/1
   (MT6358/MT6366, matching MT6358 BATADC).

Found and drafted with an AI coding assistant.

Ilia Snezhkov (3):
  iio: adc: mt6359: divide scale by ADC resolution
  iio: adc: mt6359: fix MT6357 ISENSE/VCDT and MT6358 VCDT request bits
  iio: adc: mt6359: fix MT6358 VBAT impedance resistance ratio

 drivers/iio/adc/mt6359-auxadc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.54.0 (Apple Git-157)



