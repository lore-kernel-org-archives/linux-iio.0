Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662626;
	b=gusPeUXYyZAdpwD7nbO2kx8eJN1Yyt4d82WeNSgQlVwoYOCcX8278vC/UoDZQWEJr2YM
	 iQfTBTo7982TVk4ynOC+jTFHJ3STmJo947ydEz9EVBn+9eYWHvd2kOyaXvweNqJYhuiRq
	 e31+fI4ezKdo0Q3gsM+IuHmpkBHSEvXhql8cgOu+C6L+X/k/3wByjA94H48PzJijXzW5a
	 CfUuU84IBoVTUeVZZG7E8Da0LXMx1gvoQbNKQoZRSs+dcBMTHrYLprWlbl0/xlI+vJ+/f
	 HWmAzeaIRx0TSIAdz67SVuv2acl1dyhJGZtwsr2XDlFb3F7vO2KrjqQWJlAAlmw4U9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662626;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=R1azQkrM7pzrYlRnZKU6r2/PNRas9qh9xr/YT+lwxZ0=;
	b=PkvAejtxDZ4x+LjAkqOuTyW5UlNiNy/WuI2KYj0Fr6SUo1bmoh6CWmEiWkft92GzOczn
	 djXkkbC1QWnlt4XKkAtHbgqY804o1RK8u4tZmpam7ZlaQT8T1rwDSKShJTnY/a8HnEHFl
	 A71uTe1zpRY1/csJDlfvISgqVYb/wvSsKmVhxSEDXKbr3Y7l5i2z9UzPHdQh5YrSThiD7
	 SAk+x12GQ+R9tUGf0ZgV4VCgPQLeq0GQL1oZsKLqGNIsGjF7vXqmqE0joObvZ0C5PEM5V
	 dkiZxYXH6m9HoEZ85rBAMnPO0UGsxGSyimO2U47gGEj+XGqJtP4mfMuaV+slNM8JL/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEvfVHqP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52705606A689;
	Thu, 26 Nov 2026 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEvfVHqP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662626;
	b=VGfNXKU8RTzxKMTeAq9nna78K39JGcGGLkVtlfJ1aSJKr0yNRhpHvqDVOuZGyXUphyis
	 hWEWYLQ6Zu9CGWvXdCIwwd2Vr4ewQiUu6GfDweZhPfCIm14iH916QVE8gTjImA2cTFtlg
	 FOSec3hnFsn5oxXV+0MKhrajAGtRfW9ZAC6FOUD6yAvdPypPGsAIeztd6yuDvYHRKHnWA
	 n7OvhkzpNmraqzIIeaUW7bk47GhKtY0LFF+CPConBdRTTpOpOnX1ucAbUtEwaEdJqTWiF
	 DGrr+lNbW3fHRhIKW3JBDBn7ZE2lRjsXysL5Debs2Kibp8gAAsiVEzxI+3/M8RDpwdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662626;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=R1azQkrM7pzrYlRnZKU6r2/PNRas9qh9xr/YT+lwxZ0=;
	b=JDNIJB/QoAMrDVJ+5nLQXds0d7/HUIDoZxFJ49/4vCog/NIX31QVkAqV6Rh+8kVagdbI
	 1Y8r+hlLB9Hpu/arLmbYO88S09RLNmDDU5u1lG6/TnzvGDohGh1aWfNdvgTEnMIgKrb3m
	 tq9cHy5bg8tDuy6DxjfiWTDrM1VSmB2Lm82MaFmW34G+ilLMjKDnTV1VCsvEddWEDhimy
	 UoFFlI9Bi5GFjN5zyIpONApvoITVsTFdi+cJ9gzJu/61Bk3dyWrziHQfkHHL4J86kRCqT
	 /ECY6aEs0TMzFZ0S8QXt+tUkSpbbiaZZrIGNaft7IqrYbUPwR97dWMkPuaEgcOBzY1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 883011F00AE3;
	Thu, 26 Nov 2026 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662626;
	bh=R1azQkrM7pzrYlRnZKU6r2/PNRas9qh9xr/YT+lwxZ0=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=KEvfVHqPdK0gbSGRVwnv0amP8UYTF/zAk5oratrVV1fQTIrSrAguhUDA+03/OobPi
	 NAU79WDk2KdkD8/Xk8EkGHsFSrJVvzAw4KtaneMPmJACBHeoyVzPPQ75JISX85yNM1
	 ZWOSqktGfH++lcEHspTHvQwIdeCY0t7MQmWRF8agiv0hts2EtuDUqhcHPGJ6Cke27u
	 4XSkI3mKxsxi/NN+0opM3N8dkBCrkceTkEzT/hk9uHZSXjSCLnkLAUvHEmqx5yOYka
	 U8AUYzQpKecy1DidOcEcWaBqt1ha2zfplXu3y0sqZ7H7I6dfBJf5YVy0yvmzEuW3qx
	 IZBqmXJ7BBy4g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1862F4D1E1;
	Thu, 26 Nov 2026 03:10:15 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: adc: mt6359: fix scale divisor, request bits,
 and MT6358 VBAT ratio
Date: Thu, 26 Nov 2026 03:10:13 +0000
Message-Id: <20261126031013.27701-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662614; l=1327;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=OJBJnrsWEBcdIqX9tTDRPWz8dYrgSAiAenBKdUU78aQ=;
 b=WjH7t30eM0qc/rABAntiZN6AkXBDKMP1DypfOyz3kKvoHJnBeV7WfvVDnaztz6JLw8Wl9L81M
 lpDermSM0wVC9VeAKu3VZYFgBy4p3AeKsBXrMKi84/6ToDqn/mByunj
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

Changes in v2:
- Move the AI coding assistant note below the --- separator in all three
  patches (per Jonathan Cameron's feedback on v1). No code changes.

Found and drafted with an AI coding assistant.

Ilia Snezhkov (3):
  iio: adc: mt6359: divide scale by ADC resolution
  iio: adc: mt6359: fix MT6357 ISENSE/VCDT and MT6358 VCDT request bits
  iio: adc: mt6359: fix MT6358 VBAT impedance resistance ratio

 drivers/iio/adc/mt6359-auxadc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.54.0 (Apple Git-157)


