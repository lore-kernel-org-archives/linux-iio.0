Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637283;
	b=dHQiKeCaTA8h/4pFr92BWQTfHFWoW5agFMe8qJjfC9P5FHYfzCuIiO9fG+4L6L3F4UhT
	 SLEPZ1OMPPQAMGaSXrliK7FNU03UVGDwxD14kLSLWbkiEwe1mqou1WGBUPQAuiXGjEpVL
	 8QUqbAI+y1RLIzLcE4t+zC4VbamxrB8O14iE727ZReY9gz1kT9PLb5CZs55upEOLTD7PR
	 8ypAvZcNPz3iqae62+0SahGWqJIgJbqjpeD7B0Y6XVlgNbv97RGWMPa8z8NxNqlzFqGK1
	 nkLwURFop/bxAjnIOv2a75IObcw1WPMb0nxySqGG7TQ5p9siOBv4sUUJkElaBol3bjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=abVHe5Yq8xpjvjNcf4nXdIo33DFUomEvkrSWJnINeGU=;
	b=Vb2pXhKeggLog61+5qH3yQVVjqk6qe5sJML/QslwNnHCpFvJJrw0KCOL9DCsEPMkkMZ2
	 01ivz2yQOPsA/vO+unL364CdpQhXQa/PoQbNtBv6rrwdgmqyUu79ExdZxQrPIODuc44Sj
	 LSjXg/up5G7+zCJYvJAMhQxkREkSyK2CNd+7pmqNMOBVQwC4er2gVwwuU+r45HEVlnzpP
	 z5nvjZZ/N31N0z+67ZtnEqE6/I9u0YDL+2rVepOBnHIKfDoni8wwD2q+QEjeZe9hGmzCe
	 59avIbXvtUeeTc2x2EBHFKUGiH00oxbmM8ZjXiOhermr4cyNQJk/dh/A+rJFlKj44Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMrelVvG;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A7606A330
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 06:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 394A7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMrelVvG
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1269273c88.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 22:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794637282; x=1795242082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=abVHe5Yq8xpjvjNcf4nXdIo33DFUomEvkrSWJnINeGU=;
        b=FMrelVvGEGRP9SrqMgasxA/KJYJ+/JFNu+5AbzinUjZAP+nbyaLR9aiDX+md5Sdrsd
         Wi8Xqw6tVdzsLFP3SVg/U73LtR3JsN6AIR/NFrraNGV3XkRlzseGQqVCjT795A0etIfb
         FTQRXG+bKfIVWPnI3VDSygtCKvvE+B1nPcBKLYUq4O08dmdgQqOiPU6eJADwLq2itgMH
         yunKcMQGgfTtCA3giaRuWaNJoOpdJ7I5fc7+NrB4YKBINky0c5rnrRZK8Iv5HMAEehUt
         P9YN4KIQrsPRoT5sAuc9Dw10TPCWZoHvt5h/lUamhw/DPXMtg4w0dMcdp69EN7/Q88HH
         GMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794637282; x=1795242082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abVHe5Yq8xpjvjNcf4nXdIo33DFUomEvkrSWJnINeGU=;
        b=nwApF7H6bXPLfuD+cyOqPb1LmeqbUb3b7FFEpojxTRJzju49RMat4XQ7V1OlL9au0V
         HPCDaKeYCsATXgs3+SU8pkmk86JFvaeGFOCUy4zDEpKJfjXj+hEVwVJrPG36s4co4YE3
         N9Bjk2X1mwhCJGFvGQqpehpbLkjWvl+ae9g044YAdVwgO5gSVZWQHtCIvAYqR/NCn9yT
         Iscw1d5asdj9LqNjZH5G4Dg0MJ4y7rb5YxdjJDwDlc5HAZ/rAJMDidRUt87YtrHf9XsH
         k/8yvqLYSxWKrcrBnoU3PtdHEGwCoMMYWS4hSrmgca4841FWHt5gvvvp4SmLJ8cAlnHb
         KfBg==
X-Forwarded-Encrypted: i=1; AL+hErE85d6OyMqTKv/L+csS75P+hRt/8MOgMW2qwksi9Gi+A2GwnKgtL75WFAWuFhHtk8WHedusaNAxJa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VO+noc5UnzTeX8mtPtoU5RiJEjuafbjfBYb5arpW77OP6FivC
	sfYL65hvUxLnZJdyCrmTGWKqF1mX3agMyCN894NwyBr0xtak5leC/mOo
X-Gm-Gg: AYBFou3THVCycxOoayaXvyjcAqBI+oDf9ybGp559XJTQETO18M2mhLMVm8CRfEztTNq
	iN//646jSzSz4LdShsHpTDn7U8FoZGGPJzKTdA5mw3PY/b52g3OVumsgU5D2EUJyagJbrm07guB
	cDNLZgMz8RviRXxuKipwHJlEIItN7hl/mGFjIytsg9HGwO/E0yFVn6sFu4qZPP+VoHS1YV/+PGl
	akN9ZGsOYYUvHDJKI282PUnQIxiUZQTKKF6u5sNBg0XXI/dJ/aPGrKO1TOKu306lvlj2OSnjPKV
	I1a1XEdtJ31Wi4WUwzhxzDYkqOe21D2C94KzZYzCJ6hsEeMvERX4g1zdOVUDrLFvYM6wMEyrZgv
	V4f8JgEnecLsSO8X2aqlJh2AH1nuV4sTwBUzVAttMLPnFFcYZG4wpYZHSuJQ0V4R9K0XNRXprzD
	VXm3KnpRZU/brPp1v+8ry8Gy4RVucnjAtXhQm+cAdc17016dPcshPs2ZcRs6IaFsxhhaMXdAv2N
	d2eApRycBS/ER7dMCidS8ARm7/BF1nhZ3ae1FzS4n1Z7JatzvEbw5Ow0feCcEtlv2c78ycGjfSL
	OEel9qxOClUmoAJqUN0tAJ66EXF0GQJBMYh/+Lov8sCF2jpQhAN5wjKDWorSTN0gHPoC+EASHpY
	ZSAeC1A==
X-Received: by 2002:a05:7022:7e84:b0:1b2:6b17:28e6 with SMTP id a92af1059eb24-1b505b6c46fmr3635557c88.9.1794637282100;
        Fri, 13 Nov 2026 22:21:22 -0800 (PST)
Received: from kdev ([131.179.133.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm15468809c88.4.2026.11.13.22.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:21:21 -0800 (PST)
From: Niloy Meharchandani <niloymeharchandani@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Niloy Meharchandani <niloymeharchandani@gmail.com>
Subject: [PATCH] staging: iio: frequency: ad9834: use devm_mutex_init()
Date: Fri, 13 Nov 2026 22:20:21 -0800
Message-ID: <20261114062021.142296-1-niloymeharchandani@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Initialize st->lock via devm_mutex_init() instead of mutex_init() in
ad9834_probe() and propagate any initialization error. Since ad9834
already manages its remaining resources with devm_* helpers and defines
no remove() callback, using devm_mutex_init() ensures proper mutex
cleanup on probe failure or device removal when CONFIG_DEBUG_MUTEXES is
enabled.

No functional change intended. Compile-tested only.

Signed-off-by: Niloy Meharchandani <niloymeharchandani@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 3d97502d5909..9cb1fcbcb1ba 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -412,7 +412,11 @@ static int ad9834_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	mutex_init(&st->lock);
+
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->mclk = devm_clk_get_enabled(&spi->dev, NULL);
 	if (IS_ERR(st->mclk))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk),
-- 
2.53.0

