Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0B3BB9F4
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884525; cv=none; b=cuBZ/WmxJ7NCQn4HNUfxqA8zo0EH+VzskEKJvat0kjQKvZoiHzeHoYlfzPmJRqP1jUoLM1Z6In5EvqOVSABBsYkKcEVBI50uoisQyoX+QeE9X54SOuw45KySvKbtoSUBdg/ULWiTYmJhwN/2ter7A0r2DpdetyWvj16X6xkJSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884525; c=relaxed/simple;
	bh=zUM2wOenAfrn2Fmei+pYD38IoA5GEz/48kQRat9fedE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiuHbeVd+FGy/5SJCUipRjJ8o5OZACNaqUfxr4bzCTU85xRAow+6h1PM/M2izveGJjetNhAl8kB8GwbmYwPh0HDS96dvxr9HSAGf+gB5XcTPHPWDS9VDcIdYy3xYMhQQwEFdjn4hcFRKroMRqE/f1OryXY4j8utvX45Ej5HYrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=W/8iA7ys; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="W/8iA7ys"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490c1915793so18254565e9.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884518; x=1782489318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7Wh345iWMgIb6aXL9ijFnHcCnn36TyQ+2UrcAp3HmA=;
        b=W/8iA7ysIJZrdqePKo8rlznKqoeKjtPOL8qw+hRmuoiZXwAAWpsJ+BY3OBehmI5Wiv
         U1gHSzBesdOKbeV6lgo+zF9i4xETofBXKLrWX/StV1PfNFkUKCACIBlExIIZgXawYprA
         cNIr7VzOYpeBmv450veyAzZ4+kYPQy7dD1PYDaLqQ/58baws1NKlo2VdIPxWO6c2xNXI
         aYz0KEbsBDmA5kwB3tl/xb0UtFnoAX5KSGIiXuramAU4xyCI1JOwWAGMie6rriZLQ2/1
         gJYEsW/FLgcOBumUigjCBAa9EEM5h4Rlg4rd664tlSXkCoJmLVeltL6eLtQKDprJbqZZ
         wb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884518; x=1782489318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r7Wh345iWMgIb6aXL9ijFnHcCnn36TyQ+2UrcAp3HmA=;
        b=S9QuXX3Am1/Alh80P71SxXt003lNmM5gLdqtbMPt38Qm36wlLH3Qc7jasfmsCG1SfB
         y+58g3ZfgMjasIOTPMvwEeg/d7ALCxycJjNlciRW+8YdT+3dY9qhQL3DRjniCzNkM1Wl
         YnGRG5kaEPYQv/NHsoX8sCSWCGMJmjnlngw2Mu7J0A4cXC3fLmEyH//nUaKoNK89anhF
         2CVZPQadlHL23jDXI31Cf+uGrL41bM6cy4yoPYsTVvtvMYf7Q+1igx6Tq2XYoRORo+ca
         VaZbpvdYGKXEWXg2mEGgKIBBP1rWJffHD1cU8Hmlyq19oqX479aQ9ARVsf+uwvoKIm1y
         SKLA==
X-Forwarded-Encrypted: i=1; AFNElJ+tA04FbDbMZG7S0NWmxbvuz6ykAjEH5Re+g90w14Tz4QOteP/BZ9h1ZJ/KHw16COkfDqoWqskFn5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKD25gCTbF5zK6vyS4XbC40l2ZDWrzbQspZn1ceP0Kn7F/IDr
	ZZLfHuwHeh8FjuYn1f1QbAlUxvYGPq/yXiPbQyySCI3yhoDIip/1cft67PP9hwBXI4Y=
X-Gm-Gg: AfdE7cmZHDXIssTs5mAdA3ToDoj1R7700dYr3ATxnYgRwtMm4ikZfQ1MTrwu8WzgOBq
	7gMUhQGF2Vv4HcKh7uJ7I4I/Zws8AiunvIynGLH472gXr8T+M3Uj8TzP1MNl9hxaKNotG9RvV6v
	E4ws0llXMK36RORQ5M6mxcuEoPT1a9AQxkk/jqiAh/4DzkhpxzXZzpD3Oex+4KLO42I+yakgOT2
	+MrkCGERdtBBxK1NFI3+WeK4M3688l1HnS6mDCCDYpHerWazzDc18SsIXTLlejbeWvsNeDet+5c
	C6g5h6IZjeu/EDHa6TjrLnXxXm4x9jncaocd/1XYUdqau7xKsjm1yHguiRI5o5NnPaIx7bwplZO
	KRWxj0GP33vSFMTRSWYLK4gApLk0ag1zWURjiqQ5G1A+ba5Ecd6HZLaj/xgQcALglAy2m9lHMJ2
	Ue4P01WZDXRYNpZREx/ue8oi3GaYvrDjSA6x+SEuUljyhHYLvuf4r/G/lw/oAc3q0QET1eneTa4
	wI=
X-Received: by 2002:a05:600c:4ec6:b0:490:c2a3:3302 with SMTP id 5b1f17b1804b1-492425964c3mr51490165e9.35.1781884518162;
        Fri, 19 Jun 2026 08:55:18 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466643f4e93sm61199f8f.7.2026.06.19.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/13] iio: adc: ti-tsc2046: Drop unused member from private data
Date: Fri, 19 Jun 2026 17:54:31 +0200
Message-ID:  <f90ca5b6d8b694ccd0649d36d590e5d64ae52d9d.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=791; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zUM2wOenAfrn2Fmei+pYD38IoA5GEz/48kQRat9fedE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWY8665MLHJ/qkC5RD7NQbzcgl7m9xsz8vWbz H/rj7gWwGWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmPAAKCRCPgPtYfRL+ TjTsB/oCUkPNHY46E65xoyJVdR69Idr45/mg0jo+L6jCUdhzIhXXkH+eYkzYdzkuc905WweCNs0 HMDGiuxL/AWOkf0XsvxqXaVidiF8KB1CrU3PHNAFgMF9sqWYyL0s+MsZKYw+A45KcQDfo5DSV8r DIZfqWIX1zQ0KHYD3rx42WTpT/CamB7a6A4NsLnCAYqQfxAbAJ9Lw11f3HIZboiCySPkuu9p4j7 XRiL4yAv2j0sPPESqI1seB65WiaeElm9THqwRVqJYu2PZttCL/fycnuKlLxDXc9mp+eyZPfVntD TKt1aB6q+WWu9CNAXaX9ERwJBapXlIpLa29ChlntSCsRVif0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

.dcfg is a write only field and thus it can be dropped.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ti-tsc2046.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index a2e92ce363fe..97ecc429db27 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -141,7 +141,6 @@ enum tsc2046_state {
 
 struct tsc2046_adc_priv {
 	struct spi_device *spi;
-	const struct tsc2046_adc_dcfg *dcfg;
 	bool internal_vref;
 
 	struct iio_trigger *trig;
@@ -763,7 +762,6 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	priv = iio_priv(indio_dev);
-	priv->dcfg = dcfg;
 
 	priv->spi = spi;
 
-- 
2.47.3

