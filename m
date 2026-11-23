Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417284;
	b=H8E+9HUKhvZJVarXbbHUNrTG6hMtcI/zOYqsyfR6J7fyiUdLzApFGCJ4XecFbuvgzYPH
	 38SePCUjV4LZRMrXcL2A0MJZVJ6KNvV95ScqeIutROONh5X/XictTwnucRCFkefrozlIF
	 8NfX2+lp1+Au946+RziDG0yUmhtaj6AMT6eLR8Qp8w8ofu5co014b0yJPr4W5U08P2lk2
	 OhlSeStlmybfuxUmHPk8jrV/HXw4vTwrN7QIyt0O4gvNXY+PbfBYwIpguk+H/xC8FhnWn
	 YUxgUIsQvK08/O7vIWQPK3LtB2jaJjsddGqO4INKTxbdwuXjSj0GYSkmFbsj1QfWlOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fgm5ZvS0zUq+ILWdJEIWmTetdq2Cml8WgKwtmZG127A=;
	b=juu0+aP2IWdq8+0KqEspqI5ME35ARNe3FOaKwc1mNO7Opz/T9Wg8FSH0MPIByBXw25gQ
	 WUfU1/NWd7HYKX4x6sosIHqfnL864tPd39KmmDxC4q1g6QAwuB5CLvU5aGRLtoMEGUZ25
	 Xil8H4402eht1IIKju3jgjeF9dxHfaSV4dGELs3wV5ThY0N/88LMFqQguYvn+/HLLSTJV
	 qG7ib4Pv9LwxtYMjC7JzCV+/zSzDXYRaoBAXDg0Y19oj1eJ/FzZcp38HNtV32KDh0kA2K
	 Q/Pj8h5mdU1DQTE2fplhw34xXfixr8Ib3iUmxt8qPPjs3abmu/l/aDiKZVfbGQTxO2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+45vGMx;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EC606A31F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 299EC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+45vGMx
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso1624950f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417282; x=1796022082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fgm5ZvS0zUq+ILWdJEIWmTetdq2Cml8WgKwtmZG127A=;
        b=u+45vGMxjS42cM2492e89L5UWBsfoUxgsiUha3+nrcTgxNCcxkU3AzU9iGK/z+J7nz
         cwU0LEl7S3RO4Ae5PFR7gp8Rzavocr8HFfXV4/wuSZwB6YY99Aug3CcqLCZ2w6CaMrmU
         qwtmsOHv0NNmq71p5XL2aig8ljxJO5WpPAJS3os63gUq00+hlkJq7vtxf7AuQIw8aX8u
         RuUqnJVGa/5Q/ygbXDHAXvTw7A0n04wJ1aOx3tFuat6sZcfNO/zfLzp2GD0WMtedkg1y
         GAV/QHAOvQp0Q6xsedABhEOXtoy5BMCrz2Xh7oG8ohplTq2iHqrXPylyYFWKovnngXx+
         D+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417282; x=1796022082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fgm5ZvS0zUq+ILWdJEIWmTetdq2Cml8WgKwtmZG127A=;
        b=FWBANSYhD+4aMwLSp65/mahZNH2XPyP0iN06+flIrytStxa+ZsorZpUYlwoqlEv4Fd
         tQHq02EjJNM+GpVLX+mSJaaKItYp0Istim9xssDsSgeGvBclxRrNeKBcmO2CSq3LXohm
         9VkljHju3gZ7VfqBbExZvNui6kBd7jUr51dBqtnwbumzF3knp30Bm02QYirWoSLaa8NX
         t/WVyGs+tdsWkQHuzneEVc6qucXKxAMYG5SJSYNnu78GtJgfiMTXiAwxk7bJqUgbm96w
         a6UzuWpOzj2QPJ4c47aMMWmJtF9S4EMJrjrh9y3mwPnLCuyQds1azsEl0+QF5wO63i1v
         SYww==
X-Forwarded-Encrypted: i=1; AL+hErH78iMvkxXir8fvO3ynPX2NQLn2NWIk3bVknb2GzxhQQDVT9dcOLOcfyy08NfnW0lo5cmWhTrL8+mU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tO/sTd2izuN3BGDD/VNIcGL3OEvgMIDmSjWDu27xuBWqHemLM
	+LWJGD/v6BxQyA5ZjDoK9e60SzQrj88pUODejllAVeqnInvYSAXv/dlA
X-Gm-Gg: AZFdTZdpQLGUEhUiObq5D/u2qlMM7lL9RpZ4QZ3xlXs6Mni8KRwG5qtnvmRy5oTvrqY
	JiIv8aUyUT0nqXxhXG7xPEU1QxSHQh1Fxm+mTseNg+O0tLj7z1ikRsdlh5SKD92ZbcnywfnakEF
	U8e+zoyBBpAtKPsmzgQR4M5L0R5kveeWkEEPU+TiKGuMBVwuENz5AoYFn7HQNPMHK9y3/9Xi7xC
	YKm9M3dkTIoIigkAzglczE4dnSbDEaL02USzMubCaVjV8kihQFm27nPmmKqDjmCUKseosIn494G
	yUS152E2q3qyJsI6XDJI0x1A1MuuikjOx8iUAK/vGLUHDqtYYHgG5tpDPD+pWqjJwlU4x/i1YdQ
	NunPfsYyF+9oWPdpfesrwMsetQi/kf5PvvqLLYhrrCK3TGHeEgSHo0jIwD5dFKw7DsaecfWqC9s
	EBkw2uf45c38lF7viqc8PR9oi6Z2wlx1uHeZKtRiWDty8Xkzo1/97owhHaf1r9yR3Gx2MAW6XXi
	zB6yeZU2ziCycHBagUZow/KwHSXTX8u11evNqi6gB346JfuyR8jqUz1I6bOBFpjuG/6o6qT8bZu
	by8apj99/8NpYP0cT0G8dA==
X-Received: by 2002:a05:6000:258a:b0:48e:720a:ccaf with SMTP id ffacd0b85a97d-4abaab633d2mr21602958f8f.5.1795417282236;
        Sun, 22 Nov 2026 23:01:22 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:01:21 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 0/8] iio: adc: at91_adc: fix NULL trigger dereference and convert to devm
Date: Mon, 23 Nov 2026 09:00:53 +0200
Message-ID: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
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

This series fixes a NULL pointer dereference during trigger teardown in
at91_adc and modernizes the driver to use firmware-agnostic property
APIs and device-managed (devm) resources.

When the "atmel,adc-use-external-triggers" property is omitted from the
Device Tree, at91_adc_trigger_init() leaves external trigger slots in
st->trig as NULL. Patch 1 provides a minimal fix in at91_adc for easy
backporting to stable kernels, while the subsequent patches modernize
the driver and convert it to devm_* APIs (removing the manual teardown
code and the st->trig array altogether).

Changes in v5:
- Patch 1: Keep the minimal NULL check in at91_adc instead of modifying
  iio_trigger_unregister(), and explicitly note in the commit message
  that it is a minimal fix for backporting before devm removal (as
  requested by Jonathan Cameron).
- Patch 2: Drop the redundant dev_err_probe() message after
  devm_request_irq() in a separate patch.
- Patch 3: Switch from of_device_get_match_data() to
  device_get_match_data() and check for NULL in a separate patch.
- Patch 4: Convert of_property_*() calls in at91_adc_probe() and
  at91_adc_probe_dt_ts() (renamed to at91_adc_probe_ts()) to
  device_property_*() APIs, removing the local device_node pointer and
  dropping "in the DT" from missing-property logs.  Since no OF APIs
  remain, replace <linux/of.h> with <linux/mod_devicetable.h>.
- Patch 5: Introduce local struct device *dev in at91_adc_probe() and
  switch devm_iio_device_alloc() to sizeof(*st).
- Patch 6: Pass struct device *dev instead of struct platform_device *pdev
  to at91_ts_register() in a separate patch.
- Patch 7: Replace raw 1000 with HZ_PER_KHZ from <linux/units.h>.
- Patch 8: Convert the remaining buffer, trigger, touchscreen input, and
  IIO device registrations to devm_* APIs, use unsigned int for the
  trigger loop index, drop the now-unused st->trig array, drop the
  redundant input->dev.parent assignment, and remove at91_adc_remove().

Changes in v4:
- Split the series into 3 atomic patches: (1) standalone NULL trigger
  teardown fix for stable backporting, (2) local struct device pointer
  cleanup, and (3) full devm_* conversion.

Changes in v3:
- Address review feedback from Andy Shevchenko on v2 (drop redundant
  -ENOMEM log, use local struct device pointer, scope loop index to the
  for-loop, and convert error paths to dev_err_probe()).

Changes in v2:
- Drop the simple NULL check approach from v1 and refactor the driver to
  use device-managed (devm_*) APIs as suggested by Jonathan Cameron,
  removing manual cleanup functions and at91_adc_remove(), and inlining
  trigger initialization into at91_adc_probe().

Abdelnasser Hussein (8):
  iio: adc: at91_adc: skip unpopulated triggers on teardown
  iio: adc: at91_adc: drop duplicate IRQ allocation error message
  iio: adc: at91_adc: switch to device_get_match_data()
  iio: adc: at91_adc: convert to device_property_*() APIs
  iio: adc: at91_adc: use local struct device pointer in probe
  iio: adc: at91_adc: pass struct device to at91_ts_register()
  iio: adc: at91_adc: use HZ_PER_KHZ instead of raw 1000
  iio: adc: at91_adc: convert to device-managed resources

 drivers/iio/adc/at91_adc.c | 266 +++++++++++--------------------------
 1 file changed, 77 insertions(+), 189 deletions(-)

-- 
2.56.0

