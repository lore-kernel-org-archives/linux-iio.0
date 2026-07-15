Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1A4611C4
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118468; cv=none; b=KI8rmu/pwHSDQO4Zz9ETszzCh4/dYbUWuuz6EFS6ensFVCJteZKDlxAdpKts8tbNBBK20r1nlpg9JBhNVvaQxHPh9iJia5W/Qo4zVlWKW61EUl69iegL1UB09uiyLWgcXJ6uN//OpiT9nsSrLftIXFQtPCsSi7L5yZsP554pyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118468; c=relaxed/simple;
	bh=HSkBV62gTnfQk0fzdYs33w4+DFEeZcx/yMG6CthYx3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eKfR74NTgM5AZyp92XfbFP3/WuP+naHqdMN/0Nss28tTKNx36Ypf+f3fNDsf/ojGa2RIY/aBkNExnS/PB484uiAvWVUEIbMooYNPCx9xYo0YaH9xhsMV0vR9S8iACqG1y+Yx1IbeSkWZnyRYkUCNbf2rWayY+RDvrkAPE+U7rag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZAbEby1d; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZAbEby1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118463; x=1784377663;
	bh=WsODtZ3bCIubFnV6uDHT0L1koWPcqlW0YbQBATmuADc=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZAbEby1dO0+Tp09rAjvd3TLdb2UFbHZKkGyuItimQ/YN0zTgFqKVTpm2QQIp03GBZ
	 wAkN1rilRvX8Fe0eS+m9yIPMEWoROlkuYBBnb9z9DX9afPw1m8Oq8g2IAHJnOhynDe
	 vEp243Y0dKt552POw9hTmg7w/+dFUIxbDPFEfH1icl3iIDNXD5NymzD+prdhfhDowR
	 UTetUvBCDKUK7N2yqCr4d7jDPZn+qb4a+jwJNA3WYmti/Ip4Cs+emyIj8Cer8z9B28
	 L3OY6H7OpOFCVx+2HjpQqM7vT5rKPwQmZWPz+WjrbH9SBhHf+T8sCpyBq6SKLDuBF3
	 dVs5wRNXuPzmg==
X-Pm-Submission-Id: 4h0b6P1hN3z2ScmJ
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v2 0/4] iio: light: ltr501: Add ltr329 support
Date: Wed, 15 Jul 2026 14:27:22 +0200
Message-Id: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBBFf4XM2ppOeYkr/8OwgDrAGGxNWxsM4
 d8FjBuXJzn33Bk8OSYP52QGR5E9W7OCOiSgh8b0JPi2MiipClkiipEDWSPG4FJViSalFlWG2ak
 oYN08HXU87b1r/WX/au+kwxbZjIF9sO69H0bcvF87/2tHFFKk2ElVyhzzKrv01Biejto+oF6W5
 QPMzcx4vQAAAA==
X-Change-ID: 20260711-liteon-ltr329-a3eb12414866
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118460; l=1761;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=HSkBV62gTnfQk0fzdYs33w4+DFEeZcx/yMG6CthYx3U=;
 b=qT/b3G6l5O1nqhcpqQZMCzeEi8mKyaA9V/8H5wBZTtvh6RxrcaUzZQ6R5JxrrDcws8YGmOR4i
 X5Xo/oJX941C3TU2QpgMSyA0VEEZoX5diwBsQXmjKnY1v1eDST05v8k
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
interrupt support and related registers, which LTR-329ALS-01 does not have.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v2:
- Fixed error handling when irq is defined for a chip that does not support
  irq, powering the chip down again.
- Added simlar fix to error handling of devm_request_threaded_irq() error
  handling, powering the chip down again on failure.
- Added explicit #include <linux/array_size.h>.
- Link to v1: https://patch.msgid.link/20260715-liteon-ltr329-v1-0-31f027051594@geanix.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
To: Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (4):
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
      dt-bindings: iio: light: ltr501: Add ltr329 compatible
      iio: light: ltr501: Add ltr329 driver support
      iio: light: ltr501: Power down chip if request irq fails

 .../bindings/iio/light/liteon,ltr501.yaml          |  2 ++
 drivers/iio/light/ltr501.c                         | 35 +++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260711-liteon-ltr329-a3eb12414866

Best regards,
--  
Esben Haabendal <esben@geanix.com>

