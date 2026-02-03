Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582F2652B6;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117859; cv=none; b=ADIQmVSNsvcQ06OyObksDJ68j4Q/HUQtvZ1vqUtoDWH5hhYin+O7SKt0Kn5c5MCLjaJ3BCjcCgfScvknksH4uISYrp2JwW9tgIiBa5HFwG7CtYxaHjHKysOlhJI4VLZpJI9WU2fQ5/pRR5VwfXYE4rfNtwJD6mvWFtJ+2BsGHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117859; c=relaxed/simple;
	bh=o3bvt5IVoPOuC7CuBgSGeBwzgK4Z/m9v9mxJ/tknRCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fT0ad1SMCuHhbOar1lU55Z7p7HGTC7wkEQHAGdh+vrOQNklKi+OT3PCU7WlZcsj4wsmXjeS7mIxStOONI800ZyfqI+nLi9aesv6TPKsgjcMUdNYMlYg79wTXpj/ahK3pnBufcOb6T6znDLvf5AXHLB6NptjLkqM7NntSEHd+LYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFnhsOG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFnhsOG2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DFF1C19422;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117859;
	bh=o3bvt5IVoPOuC7CuBgSGeBwzgK4Z/m9v9mxJ/tknRCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mFnhsOG2cjRfSBUBPBqR9mCYNj8fOs4ZITMNRiTl7xaMbofIyVKTt3lzxd6U/vm8k
	 KS8nmGkjgMDEZfQm4kLqY6qUveEsWVoGSHcIP5bFZBfxiZ9RfnAiioj9eRUyyHL+V7
	 jMfybIrm0w9shhxR2Rae6sc/kZCDwaIGh9AyTbSz80FwBFDU2hMr3fUyxTNYC0Zo+7
	 nGp1R06fbB3/FiOfuSGTn6oQSo8UxUaIEw6YxzqrwDBfEHz28KmUCxhJsVf43x3FqG
	 HE0AW0Aqx44hcxp74J0P5+3ZeKDh2s0HGyX+dEYQiTZhpE1FYuFMBqsdPuO2KDPA+/
	 B7r/vEtRsjL+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A669E6E807;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Feb 2026 11:24:07 +0000
Subject: [PATCH v3 1/9] MAINTAINERS: Add missing maintainer entry for
 AD8366 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-iio-ad8366-update-v3-1-5d5636b5181a@analog.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
In-Reply-To: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=890;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=IB6nsbVkeaHwQfGZNvFxArIH7f6StXcyc8CEVB24Hfs=;
 b=Np2u20H0RWI9M63yBaqwlqKY5mgZF4mY77FQQ8nqYhbiowkUHpZoBb8llNwUtdE6KmrkuQmzp
 ZdDinUBGHxzD7O4LDazec5qQojIHu4kn6Vq24/lx4/qpWu8g7A0udUF
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add maintainers entry for drivers/iio/amplifiers/ad8366.c

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1251965d70bd..ec9a6beb7619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1583,6 +1583,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD8366 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	drivers/iio/amplifiers/ad8366.c
+
 ANALOG DEVICES INC AD9467 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Nuno Sa <nuno.sa@analog.com>

-- 
2.43.0


