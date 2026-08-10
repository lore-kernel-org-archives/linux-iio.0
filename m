Received: from out-2uec-a123.jellyfish.systems (out-2uec-a123.jellyfish.systems [63.250.43.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028023B0595
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360626; cv=none; b=i2qiaAt0xwV2aljkHEU74Gxv20FdSNyREII9GG00Kr9e/utVZ1rc+OHf3KSGayWte3z6fPOgm1MTT3sTwGaEWtdsmoDgS4jJv4HoWSuAmHuap5Ae7PcjnWfGcZi9TRX8Shr0DCCv5ZbvK6WgttH3rw2yXGzqRM+lwWb4h5VpFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360626; c=relaxed/simple;
	bh=xEotutBdJQYLpzZm2hh3OQS6aWtWKdQIZQbIhB8QHVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FplOR/nzd1J7P1SXRzLxQYNU7JR/AgmvtbP7+kHugi/+BZV1SHYX467E/ic4nR/b2aJgpz5MhRWkJf8pn6mVsCY12HsbOCvOBSqR0Ipm7BjvimK/1U0a81vH3foQinqsZjTb7lWzXYet4lJ0YiY8frOtc0Fnhy8gxWaMLBl5yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJX2W3b0Hz8sWP;
	Mon, 10 Aug 2026 11:04:35 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH 0/3] iio: light: stk3310: per-chip match data and STK36C61 support
Date: Mon, 10 Aug 2026 13:04:20 +0200
Message-ID: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
colour sensor whose register interface is compatible with the stk3310
across the ALS and proximity data, threshold, gain and
integration-time registers this driver uses. The part name comes from
the Fairphone 6 manual, which lists the component as "3IN1 ALPS/RGB
sensor/STK36C61". There is no public datasheet; the layout was probed
on the device: chip ID 0x95, the stk3310 STATE/FLAG bit layout, data
and threshold registers, gain steps that scale the ALS reading
accordingly, and an RGBC data block directly after the ALS data.

Tested on a Fairphone 6 running a 7.1.2-based tree carrying these
patches, adapted only to that base's older style for the bulk-read
size argument and the i2c device-ID table initialisers. The stk3310.c
delta between that base and this one (chiefly the PS-interrupt
suspend/resume rework) does not alter behaviour on the paths this
series touches. A board DTS node using the new compatible follows
separately via linux-arm-msm.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

Jorijn van der Graaf (3):
  dt-bindings: iio: light: stk33xx: document the Sensortek STK36C61
  iio: light: stk3310: add per-chip match data
  iio: light: stk3310: support the Sensortek STK36C61

 .../bindings/iio/light/stk33xx.yaml           |   9 +-
 drivers/iio/light/stk3310.c                   | 151 +++++++++++++-----
 2 files changed, 115 insertions(+), 45 deletions(-)


base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
-- 
2.55.0

