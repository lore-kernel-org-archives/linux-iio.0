Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502E3C4542;
	Sun, 23 Aug 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488606; cv=none; b=NRvFX5Eic9Dsb1+ltASDL8TX8cwvu95d4/9KgNPP57ROytrZAfkD0SE7seqkR1l0wb6ywVN3cI7lrl7dQLc3/OwDIEo2x1pLHMv8bk1U0U71i0eaCR666/vWECMOY0Jzwe19klUh8AHo1c5CKNWWGs6U9H2JQiROICOtEWohH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488606; c=relaxed/simple;
	bh=vHcUTHxbjq9L/EEi8ogkaxJxALe1CbKi9lbw++lf/G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHawclVeMMOBm9P36nqn+uW11q07we05kilhFt99vayF+WdxFqXIQ/WsDnJXT7bkcI8hGxqBfzk34NS0ATbbdqgJJJ3hURqyyVh7PI80xwy36wyqlUJXQqHM7uB5bgsRgYy6dYTskDgKWK5PMieiZ2oQZccBiMzqBSnN+DqegUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=DAlm8cdY; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="DAlm8cdY"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C87C4BFA3E;
	Sun, 23 Aug 2026 15:20:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1787487683; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=YNzmqgx2JrhC19R2F03I2usSj37mqXg2pKwRXbSer70=;
	b=DAlm8cdYB1Z9nEhom9POOic5Kscz/H9yGWX8k5rCpjvkcfbQn/VOqPvQV8S7R5FEGJStcj
	LwhaOgVM/cyaQRNTXZALH1C2qVrg4o0dU9vB9xjnpnBk211ybFKT5ttb1VDylm/MQze5+Y
	YTWIaxUFrowr2xgd8ocfxBh6bcIoK00WBSfaRyIKglorxEtdQk/r36DZQq5TtMULL5Q+B0
	iyKCRGQkHEEc1zbRiJukyZWjL9r8kHBxGjZ6k984VqeFkwZVU7S+yyLoedXUymYdG81GDB
	iwcGZnd01VMphRCYCTaCPeqBZ7aQfOxJ0IITSlBBmWRS/FpdkIBl8ZlILUYJKw==
From: Vladislav Leonov <vlad@zlab.su>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vladislav Leonov <vlad@zlab.su>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Fix RV1106 SAR-ADC support
Date: Sun, 23 Aug 2026 15:20:31 +0300
Message-ID: <20260823122039.20831-1-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This series fixes the support for the RV1106 SAR-ADC in the
rockchip_saradc driver and its device tree bindings.

Changes in v2:
- Combined the driver patch and the dt-binding fix into a series, as
  requested by Jonathan.
- Introduced a new patch (2/3) to group single-entries into an enum list,
  as suggested by Krzysztof.
- Added missing Suggested-by tag to the patch 3/3
- rockchip,rv1106-saradc compatible moved from the
  single-entry to enum list in the patch 3/3

Vladislav Leonov (3):
  iio: adc: rockchip_saradc: Add support for RV1106
  dt-bindings: iio: adc: rockchip-saradc: Group single-entries into an
    enum list
  dt-bindings: iio: adc: rockchip-saradc: Fix RV1106 compatible

 .../bindings/iio/adc/rockchip-saradc.yaml      | 18 +++++++++---------
 drivers/iio/adc/rockchip_saradc.c              | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.47.3

