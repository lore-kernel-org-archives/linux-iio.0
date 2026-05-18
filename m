Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA33783C6
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117599; cv=none; b=kPWKtM/E41pQEQqF9AXCDrMKexgdBjN74nS8khyuMqsMV7DqBv2dHimUX24TuAO4/MEKocuwqDEwaTfe9JPfgLj8t17ElFMzz4cslRrgCopv9mpY9Pc4QRjeamNzRMh+P0YnT7k6sP47wsmuU9Gm4k3wpCUbgYgh8HVnwN4TNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117599; c=relaxed/simple;
	bh=CnS2o1zT8hec3jI9u+cGMmxRIi/jhSnQ8LXjWXp9mxo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NW/7p3jZBFl8IecHHgXTOB9jYLsF97nvx+E+V/iXlxzsoB4QsYZnkQvU1JnqyqcK1BUW44hlfMssFp6806CA4W9QFsbcyC/nMgIksD6xj1gxD1v+AR5RDj+sLarXcg0kaYWIDCU7qFP7z4Th+DhI0pDaFXzVdupe3qugP9JG5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK3d9tuM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK3d9tuM"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fbd79350dso29169341cf.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117595; x=1779722395; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bG7TbCRDRMYHiwznaFM1XuX97H+EAdoqdi/i2/8voRE=;
        b=bK3d9tuMRCwqy9LaEfV3u3vb+WklUKMIgBeisFXtSaBRupAGDFyDjVbo+olCDc3MWd
         VEWVJ8FWfd96zDRsD5Ej+ua1pozEYQg5lFQMl1bedhy5rOC/wktBpH4jjYP3r7SmG18B
         +wQNyrXkiw5pufCeU+32qMXLXiRL5b8dVB0jrHAt35HcVqejA4qqEBVDlG7ynfXtS6/E
         xD/hZ6sXcrRbiO+PJU79DBKm09OyV+yy6NarSiS8IFSIlBozWzIaAAEKGC3AOPgZzQi0
         QJvyT6Zg7MTEVIjZN5nFXWWIt1WXWUpq0W9WX1Y1JGUea/zAsxNUlRJMkZnA/x61ATqO
         KppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117595; x=1779722395;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bG7TbCRDRMYHiwznaFM1XuX97H+EAdoqdi/i2/8voRE=;
        b=N8AyOaOK98204CcNT8Ip3RVwcOGCVm9pwRks4xhZQdUhzZOQzKw/PFPSjR+Zd6EmUe
         TDeGaNfGDTzEF5L2ZPvwxLaxFFAKEej/PkJMx25Pr9OX1t4FxeBxuGH2Eokes39YqTo7
         hiXs6mxfLcJVkWoMtPJq/L+NFs6xH5rUC0WeHvvL3E5EYsp5kdYC824/HZyARUqS111y
         sl/iFx/sjy2RMeCWzEJxg0DgQsAU9CPYiioSOFC2NrASMQNRLUJvE2nGA3k2B5MqJ0qv
         +Jf4PDDRUsmLkCpr1ngjVqjXNZlT5VZKqdc6E14HcwZMpeXP6ITxFk1B8mRhVfuyjZ36
         sTjA==
X-Gm-Message-State: AOJu0Yw++j/kx0pM4EwNrnV960rhmWRgjN8NGsTzEcz1ORNkdnvlyTU0
	lDZbpN96+V3eL68ejfHqGXG9DbGFp/FkI7bxxusifGwBT0Jkc6yluMzgaAP/vyOrkeo=
X-Gm-Gg: Acq92OGwirvo7cNDrVt2QsxqJI6rCl8SXij3Ob4MUBcbM9SGmCi8YO35imJzH+2q91F
	01pe+j0+kBGgaJS2u+qOqUW/CIkmr7ZMkAsa/yejEKP0dLs5hioNrFQubfUgS2wcpZtBAGLn2CI
	6qp3+Yg9oZ/YODmjcqE9xf2FeNUCP7z7E6EGd7aKbMfvKcZ86elUDYAtJwNJdQRtqbqzFimPlft
	jYRVxhR0LYvlBVS4YfqRC6g9+Q6Bt93l0upnEsHtxheZdyNbmRam9n5QTk2i37ICue7mx2BFEZv
	wRqhpMgnQBd+FuuPladuH1xeJ8jbXrrTZwDzPZxt7u++U2l+UOuuwXLFv8CbJetGXzsG/3Yu7/E
	nfOrlFY704MHU34FXKroqFffNLKW8rL1dTyzmRpfc8arFJVW4lnGyFtsY6C9dA904V927PiVRc7
	ApUQHlHotQB8hK4HHJZ1QYpcM2kePqF0jU
X-Received: by 2002:a05:622a:588a:b0:50f:783f:31a9 with SMTP id d75a77b69052e-5165a1d9f12mr198110901cf.34.1779117594823;
        Mon, 18 May 2026 08:19:54 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5168c968930sm45070691cf.0.2026.05.18.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:19:54 -0700 (PDT)
Date: Mon, 18 May 2026 12:20:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: [PATCH v1 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Message-ID: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

This patch series adds support for LTC2378 and similar low noise, low power,
high speed, successive approximation register (SAR) ADCs. These ADCs are similar
among each other, varying mainly on the amount of precision bits, maximum sample
rate, and input configuration (either fully differential or pseudo-differential).

The initial support patch enables single-shot sample read with a GPIO connected
to the CNV pin.

The second support patch enables high-speed data captures with SPI offloading.
The setup is similar to AD4030, with a specialized PWM generator being used both
for SPI offload triggering and conversion start signaling. 

The last support patch enables running buffered data captures without SPI offloading.

Some structures and variables are introduced earlier to reduce diff in latter patches.

With best regards,
Marcelo


Marcelo Schmitt (4):
  dt-bindings: iio: adc: Add ltc2378
  iio: adc: Add support for LTC2378-20 and similar ADCs
  iio: adc: ltc2378: Enable high-speed data capture
  iio: adc: ltc2378: Enable triggered buffer data capture

 .../bindings/iio/adc/adi,ltc2378.yaml         | 131 +++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  25 +
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/ltc2378-offload-buffer.c      | 297 ++++++++++++
 drivers/iio/adc/ltc2378.c                     | 447 ++++++++++++++++++
 drivers/iio/adc/ltc2378.h                     |  82 ++++
 7 files changed, 992 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378-offload-buffer.c
 create mode 100644 drivers/iio/adc/ltc2378.c
 create mode 100644 drivers/iio/adc/ltc2378.h


base-commit: 8678fb54958893818ddeccd05fea560a4e1fc759
-- 
2.53.0

