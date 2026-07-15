Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126E3CBE84
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103841; cv=none; b=ujSvanh0w6c52iQhR+FqUrXUrhA8qGMavS6fyr3fKQTKHpmcI0y5bA6k2ABUEG6xYHYk3MrIOIRrJi2pH5o9Zr+UpJhgYAfsjbVv+9z/XCP36J17w1qw4Ca3vmtP54XAf6jIMV39y5lzOrpPMBnOoBkhERDQQHgKAeZEBHfRTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103841; c=relaxed/simple;
	bh=ISJBKGJ7uSFseLhyCH5QRJqorkE7h+r0Ey2aHLG/b9Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PCqYGaOAuoUZ4/h6Jm8Hy+g7PurHbhhyUT8cwRiaRk4fugqF18/WXYSUOQHJQESHAd1K5MBqLTDv18kglqNwoNeVodUxx5MaU/saR41pTqqnnAGtfYDGQX0YEE8Di4VKTLsLIdYVKFz+2HusfcrX8TXlmKUYwYMRucqVzMzCbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tB7mvfhf; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tB7mvfhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784103831; x=1784363031;
	bh=unDUrRWYn3Y987s3XbMj+BF1h22T+O5Je+Wh+r3sqXs=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tB7mvfhfItEK+LX8UNjZtIhVIn+I1DuyuzSAH/Yi5W06p664hWPtTAtLbSGTsYysg
	 H3u2YJ750TrnV+Kqs2AZ69Ez695GLLQ/NK0VS7ooqTP1TvYcu+2IQmmOWCY6HYQyi8
	 8u3sQMK2aozww2Vv06PnPBB+tY9PkSrSntEgRJLd+vh2kEKVHBNoHWjDDBz8n8f48e
	 /pskK+IEff41/exX0BIwzRUVCtMNLmbZmeB8JDzVCESG2Wj/PbvjIt3kDphxxSBrnD
	 iGU0zRdb0C+9jrIIBAY0OlyGhpHU8RTt6UO/hMi3L6kNYHlT8ZO+YMPLXu/wwVTX+h
	 G889lpqf0zK3A==
X-Pm-Submission-Id: 4h0Tj12L3Hz1DFDy
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH 0/3] iio: light: ltr501: Add ltr329 support
Date: Wed, 15 Jul 2026 10:23:47 +0200
Message-Id: <20260715-liteon-ltr329-v1-0-31f027051594@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDUxJfVzFbFQBiNS0pZIxN0Vy
 2/x3gWOLJODKrrA0sGOVxOAcQTd1JqRBPfBIBOpkhxRLOxpNWLxNpWlaFPSKDPMCqUgNJulgc/
 vVze/3a5n6vw7gft+ACSCfFxxAAAA
X-Change-ID: 20260711-liteon-ltr329-a3eb12414866
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784103828; l=764;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ISJBKGJ7uSFseLhyCH5QRJqorkE7h+r0Ey2aHLG/b9Y=;
 b=15+tw1F66c9jJ9BzSEZHWHsr1nvGfQGkTuGr+/uoTvdVCFK+itYLyzacKbJiK5ryQwaYPdS04
 R6SHbn1mMcKA/CybZH5PNUxn8MRnbdYNHz5KidOnhH02rYovE2NZIbw
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
interrupt support and related registers, which LTR-329ALS-01 does not have.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Esben Haabendal (3):
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
      dt-bindings: iio: light: ltr501: Add ltr329 compatible
      iio: light: ltr501: Add ltr329 driver support

 .../bindings/iio/light/liteon,ltr501.yaml          |  2 ++
 drivers/iio/light/ltr501.c                         | 31 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260711-liteon-ltr329-a3eb12414866

Best regards,
--  
Esben Haabendal <esben@geanix.com>

