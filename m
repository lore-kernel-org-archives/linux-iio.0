Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634655;
	b=2spOFlwbdzbkpQ+1M2M5Ty1HB3cP3jJ4XWFEN68a/dbafHWLPX0/bFmxKaSUy55JEd7S
	 szQRHgPjbrlN2d5PeSF4OAOwV02j5fP9M8m8C9NC+CGWFdULLTiF7zn0pVMPplWgIwhQs
	 BhTVuawy5AyfXfcN75mBZmba028f76TiGe79xgbkWpTEi88YFBnWac7mGU4zQHdYl+fKd
	 P3nfoQDWWLv3cJg4NpNoYsM4uHRtfX1pnoqtAwKn2jc2Bj5ThoB1IxzH1u32KtpDTR2AI
	 0JWJemFj0mC+zq/Ua74vEteTzBFQsRV2CsKR3/ZfvJvWNBuHu+HPbq0iOYgXVwbr4pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634655;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=uCLa1k/IfrbBunHCI4MgKXkjcTb7zjCaMIvO5SODz7I=;
	b=roMtEueQF67zv5yXS8MXS8kC5MUVH4YiZ81QUCHomBA1MsU9BEQO0qE+gouVel1U51DL
	 yLniEDOI2ajZVRHjs/Rt3VWLgWTTkHL5BbZP284M2jD2oM+nCdh9eFTXAa4ZqmaiGBNk3
	 t2o2V6NrHCYVV8cVYSFPpD8Y5rXf1Dklek9jScXB3jx0Dx0W537dNIe/bXNU+p7jY8rjT
	 jv7TSNMraKJeUpLduYu+dnHLDGZTO6I2X1vua+lFT59Ga5sfdatdXN9/eFfqqZQ8Bjd+X
	 51pUfVu/+eS+TvjCxW8OM13z93vhw/elWg6k07VXK9N79VI7nbcOFZSsYym0KK4GK1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5kzqELo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87411606A323;
	Wed, 25 Nov 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5kzqELo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE81F00AE3;
	Wed, 25 Nov 2026 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634655;
	bh=uCLa1k/IfrbBunHCI4MgKXkjcTb7zjCaMIvO5SODz7I=;
	h=From:Subject:Date:To:Cc;
	b=A5kzqELoJMfIoygMjb1n2HEv8qtzD8dOcUw+uhQu1FEI6clFpVzl7phJhMHrAVw+p
	 c6JS94H3VN8f8eV4PoY80DVbZgNJpk/dB6c0w5vnYA1sBiY4pSZJtYt/ADyHFuSS23
	 lHMfgsh+HxJTfyICHGehGRlbYsUAVDju+zynldlxAR0pXHgoCr/8miLPR229HN5wm0
	 xBeDBifNj54t/Cc6K3tFooaP0UzfSTJex0Q+/grogFl3uLiR/krrPqC9+iMozzrVG2
	 O5niZXNLqCXyTdV9EM3U9Dx17m6mgpeSjiC0zQN58uiPOltBgsKW0BA85XQjumISU/
	 AR0PbPU8bLoeg==
From: Joshua Crofts <crofts@kernel.org>
Subject: [PATCH 0/9] iio: gyro: header cleanups
Date: Wed, 25 Nov 2026 20:24:01 +0100
Message-Id: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBAF0KvIrDuQBIziVUoXafzVQU3KBMQi3
 t3Q5du8kwpUUGhoTlLsUiSnCvtoKM4hTWAZq8kZ5611hqefZl6gCSvPCCOUFVvew8oduoj+7Y1
 vPdXgq/jI8c+fr+u6AbTlJ59sAAAA
X-Change-ID: 20261120-gyro-kernel-header-removal-7e7ce8b60656
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nishant Malpani <nish.malpani25@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=1336;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=y/a1CS9ZmCqxiLPkJ+iG0Fp4J47lKCIMscsVCSN3/2M=;
 b=2qs+TFMRjx88DL2QxXO5id59v40F6HO/f/T2pLJybLpUPM9/3N6VWm27ZG+Xrt/Bj4N9122r8
 w1EOCws5+uFASXFpLvvcW2f5lxAEMVl8on1zppUxLjWyfAaX9fYiaEk
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove any kernel.h occurences in gyro/ and update the headers in
accordance with IWYU (at least loosely).

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
Joshua Crofts (9):
      iio: gyro: adis16080: reorder headers
      iio: gyro: adis16080: apply iwyu principle
      iio: gyro: adis16136: apply iwyu principle
      iio: gyro: adis16130: apply iwyu principle
      iio: gyro: adis16260: apply iwyu principle
      iio: gyro: adxrs290: apply iwyu principle
      iio: gyro: adxrs450: sort headers
      iio: gyro: adxrs450: apply iwyu principle
      iio: gyro: st_gyro: apply iwyu principle

 drivers/iio/gyro/adis16080.c      | 15 +++++++++++----
 drivers/iio/gyro/adis16130.c      | 10 ++++++----
 drivers/iio/gyro/adis16136.c      | 10 +++++++---
 drivers/iio/gyro/adis16260.c      |  9 ++++++---
 drivers/iio/gyro/adxrs290.c       |  5 ++++-
 drivers/iio/gyro/adxrs450.c       | 17 +++++++++++------
 drivers/iio/gyro/st_gyro_buffer.c |  1 -
 drivers/iio/gyro/st_gyro_core.c   |  7 +++++--
 drivers/iio/gyro/st_gyro_i2c.c    |  6 ++++--
 drivers/iio/gyro/st_gyro_spi.c    |  4 +++-
 10 files changed, 57 insertions(+), 27 deletions(-)
---
base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3
change-id: 20261120-gyro-kernel-header-removal-7e7ce8b60656

Best regards,
-- 
Joshua Crofts

