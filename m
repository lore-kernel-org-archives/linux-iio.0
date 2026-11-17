Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794904898;
	b=DVuAbgN7GyfPfjZxtxN/8GZupXAZNHgtXGomre6zIPxS0Scy9KROYkUEktfgPE2ujYOa
	 UFSax8s6X8cGuGjEWzmioHQwW7tIqLaTnPyLVNcsxGREEliOcuf6nFjS/n5N5HN054kmS
	 ZveuefaALPTuXyU96KmREs/tHA+LKwdKYiAXB4ngqYyc0XUt5kW9qBexZCi7/CJsq8uwk
	 VomEQ0SZlJDzAG2YyTO4vtcnR2po5VY+q+SwEcqm1oUFijrdh5ZN21nsFcX0gxVQ8/sr6
	 ozW9l+Dj/xUP+JKyFixifQoujRXfQxmR+1oORgMFDs+JN6LZ/cGnIb5s/MsC4hQRsgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904898;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=CVfYoaBNObrkp80HEIdRTSpIjFPTdVaCg6pMCfg6WxU=;
	b=YC4WNgGWi38WlOJoTF+lXkNZSj5XLOTq7KayKu80Qcllqixxt1Zf9MkUpRgow4wAVQO/
	 76hg1DMugfl30ww0SSlnvWyzlECaZs1cIvQXq1Jbafv6YhWEiAjczX3Zs2xTSm8YIIlzr
	 TtaFmA3Fyw73+C6IDqYGa/gdvMdNmFC4vNo5+gcLGdx3syJ0XIlnVbhQxwcTorYC9Ql6i
	 NgkcVdJZaJ7qBqv0GAGaiGvHHJCy6E0CWAaDCNLb+CDO9vjvGnw8ojszyHhXK27gsfe0q
	 +KJ0bQDDcQ9SwsSI+k7kOMjgHHlem+XZnsHeJ8DCmpSGt5s/5DTyeULrHI8iA1jaM5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=catcrafts.net;
	spf=pass smtp.mailfrom=catcrafts.net;
	dkim=pass header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b=UBxHGU69;
	arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
Received: from mail.catcrafts.net (mail.catcrafts.net [91.99.108.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42768606A33E;
	Tue, 17 Nov 2026 08:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42768606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b=UBxHGU69
Received: from jorijnpc (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.catcrafts.net (Postfix) with ESMTPSA id 37F5CFA9BB;
	Tue, 17 Nov 2026 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CVfYoaBNObrkp80HEIdRTSpIjFPTdVaCg6pMCfg6WxU=;
	b=UBxHGU692K1X2THNUDVohCpy1G93BAoi+dlgrAcqZFofWbhkitjxSmlDiPsXWZ1EwwvFH9
	wyI6hjDjdbbkoh60igLztrV+MKz0VG0dTmBwbmU9iwEPTzuylHODKq0kkg1UeJagE7jBom
	uVGh1SngGCK+elFSShWMULasRcZy24BsPjf0Ovz1oopQgGaRxCsVkUGxp8LJEWn1X7GT99
	3wXAy5b4WdJV7VSV59mxNvalM32z9b2NPZ+cXEz7Oo735xdRTK3uf83NNnZSAqR9d0Ulai
	K9o4vWjGsXRgXNDe4EaTNPoFHPh6T2uThbdVWpyyC5/8mTUR7uqPiPi/t41U8Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Seal: i=1; s=mail2026; d=catcrafts.net; t=1794904888; a=rsa-sha256;
	cv=none;
	b=Sp5dGIFGY6ZJLNhdo05xcDdgOm5766qJwkCkpwWGKvcYaUm6T0L+1dY/dmQ5/yupSmHTm4
	T1eaeu9pm/loRgzp5XbdpK7waaCCVsSCnOPuoD+qkKe5rKrxxcSn5fld2ldD584Ol1QAb9
	swYGPEDai4Na9935PGZYbagJmAReE076I7FgR7WMIarWKt4s+V2cvGYX9rE+4zxRFdRfji
	jDIozUQlrKQ+yhg93X7D+WuvnAZbLtG/nw3EWXjZPJDtN+Od3IxjeHfSZnGe2x59Z8b+bM
	u3wjMxvwwetLwQyzerujuo1XY02v88R3UyJorj3dx3GQmRwzgbp0CQnM88WymQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CVfYoaBNObrkp80HEIdRTSpIjFPTdVaCg6pMCfg6WxU=;
	b=BrxyVN/16ak+XLMM7XAhXNGJXNhbuR4RDzHPrmRFtDqTSCSIcxnGVXntedFFgMtzJty9rW
	wa3Ixoa03GhptON4t9PMJ7alzq3u3d6NIs8aWiwJSv57+stDrl2P2jZJcIX7b8DAhdgW1X
	OM2bdcDsIogQbRsrmmcHy2fYaJk7HJ8P6y1Anarg7m+etfvMMHrCAOlb5kRK7A2jm2knmJ
	e9BaAyuwM2Ug7ySdJK/iyKQvYhvbtv2Wf05HJSJpy0gbS0KEp5PetARdVEzdpLju4vQqbv
	F8RadySCqTJ7/DutDW1WhrxT0FGPWnb+M6r42KAdGX2Hnt4tV998h5WI/stWGA==
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Joshua Crofts <crofts@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH 0/3] iio: pressure: dps310: add Goermicro SPL07-003
Date: Tue, 17 Nov 2026 09:39:51 +0100
Message-ID: <20261117083954.335814-1-jorijnvdgraaf@catcrafts.net>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Goermicro SPL07-003 is a barometric pressure sensor that is register
compatible with the DPS310. Like the Zilltek ZTS8032 it has two more
pressure calibration coefficients (c31, c40) and a rate bit where the
DPS310 selects its temperature sensor, but it packs c31 and c40 as 12
bit values where the ZTS8032 has 16 bit ones. So it needs chip data of
its own, and neither existing compatible can be its fallback.

Tested on a Fairphone (Gen. 6) running this series on iio/testing, with
nodes for the sensor and its I2C bus added to the board's devicetree
and the driver bound through the new compatible: in_pressure_input is
within 1 Pa of the datasheet formula evaluated from the raw and
coefficient registers at every combination of pressure and temperature
oversampling ratios from 1 to 128, TMP_CFG reads 0x00 after probe, and
at 16x pressure oversampling buffered capture through the FIFO and
through a sysfs trigger averages within 2 Pa of direct reads.

The series was written with Claude Code Fable 5.2 Max.
The code, the commit messages and this cover were drafted by the model
and reviewed and edited by me and 1521 Opus 5.5 Max agents
over 7 rounds using Crafter.Review.

Jorijn van der Graaf (3):
  dt-bindings: vendor-prefixes: Add Goermicro
  dt-bindings: iio: pressure: infineon,dps310: Add Goermicro SPL07-003
  iio: pressure: dps310: add Goermicro SPL07-003 support

 .../iio/pressure/infineon,dps310.yaml         |  5 +--
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 drivers/iio/pressure/Kconfig                  |  1 +
 drivers/iio/pressure/dps310.c                 | 32 ++++++++++++++++---
 4 files changed, 34 insertions(+), 6 deletions(-)


base-commit: 94921bc9eb214f838481faa847cda5c42e486013
-- 
2.56.0

