Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA9352C52
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490883; cv=none; b=hn40uli3KWv7AslSCmDUETUyREeLoy0tA1PQp/DquWNtlqL2P6FIYiweKxnnngM8E51htrlgJmt4QkM+nrdn6k+HOWmy3MxMzSzzjewNXB0Nyl1NEjk6/6tnYVh/W2Yf6oybLmK51Nr2LKscl6Zn9YxPGSnsLyfziGlT+kxukxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490883; c=relaxed/simple;
	bh=FeFn6njPzl2/Mdha/Y5PAfNF3Ezbr009VYn5zcyqx0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kq73N1vzlKLTjgR8KPuXw7zr2PJ7tf39iBb/Ix/bZZJvNJ2ll2AEbM/qypIaduC05OdXbQFHvmU3OrfMmWnXuG7BJ2OcyIX9YuKDLDJ0kQxdxoN59jNiScscIouJ3hqft4EMOBhXop7aGFWuNkrKigYAT8D/4uBB5ypypiets5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=a6sh/laJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dkRpCZpd; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a6sh/laJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dkRpCZpd"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g5S4r5TJNz9vJk;
	Wed, 29 Apr 2026 21:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777490876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WIuvsREO/IaAitzS6HvRbkjBEIe7pUKyrSQ57/hQ+bw=;
	b=a6sh/laJYtsbCgKdeAVQU3JX4ESohtP99bz4+aEEoDyXREj1Fj20zaTn/IGf/+7qjFYcl3
	iwzAzHuAg1NjC/SNZ1bK3SssnNWfoC/jQwjnImLppcwZYG3prlZhH0sx/2iozSmp4KtjAS
	///45LZ5RSxYrRuaWsxlHIyQi5f+lPGED89rcVZWwkEUZ5mITVVRqjSu/ZlSXmTY5vo1BA
	TLlhue2sz7pUeUNWcvAM1bo/iLTB3xSA/H7H4P1ab4ZYAl0FBKRiKS/lqoBzdVkOFTKq9T
	WATSMsBlchyZqyf0JB8/ABxq2YfCDco2NEZ1k83mH0MObhNjWnVOT1NWPQ0zVQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dkRpCZpd;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777490874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WIuvsREO/IaAitzS6HvRbkjBEIe7pUKyrSQ57/hQ+bw=;
	b=dkRpCZpdi5ZmvbWVBTEjUC0UzdkBUMYjvwvswykotDFSRS3IMci7OfOOuT6R5V9JetIQzm
	EdXa4a0e/BnFawt0oQf2dt46Y/5UWZpg2g5feW8tkQXOI2AM4kWCHKYTzJJB63ZLdYAmPS
	ZR3K8orMxKBG3wa69opbWETwIsFbrfg1GealFTGDrdGCO1kOOPP+GUE9YLqpvm4CYFS+b+
	9yVt9lZZ2LHOoyoX3qORAUksWTQolChbgSdfCQmlzIWtv3nO22GLrGj/y+2fu+DitRIuV0
	OuR518Noz+DYzwD9CEBzUtw/zbBqbH+7CorCJx6XbxrviaJ8DLI5QayuVjE9qA==
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: adc: rcar: Fix up Marek Vasut MAINTAINERS entry
Date: Wed, 29 Apr 2026 21:27:23 +0200
Message-ID: <20260429192751.543190-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7cpz3dcz1iib7n4juipok85j5fjkfu7y
X-MBO-RS-ID: b2baaf06a84a43162f0
X-Rspamd-Queue-Id: 4g5S4r5TJNz9vJk

Use up to date address. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ea8e7212e992..c35e103243b4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22600,7 +22600,7 @@ F:	Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
 F:	drivers/mtd/nand/raw/renesas-nand-controller.c
 
 RENESAS R-CAR GYROADC DRIVER
-M:	Marek Vasut <marek.vasut@gmail.com>
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
-- 
2.53.0

