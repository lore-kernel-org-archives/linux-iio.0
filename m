Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6A3168EE
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161453; cv=none; b=Hr1n2vhr/LyyUN7eM6txqtIsiUAK+wOVA90UK6dO5oKCND3i/Y18L3R/w0DN79R3N1n2IpD+IodCFAlXrj8TCbc/JIVsKuIZFzcWf+sV8xQ1gmwThWO2wmoQLnka8nPw7L57bOs/DN8pXhFsJ4H2FOok0KZb0cVpiebEH4j+afc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161453; c=relaxed/simple;
	bh=De6ssdhNfQ9IVvR2e2HK7O1ncS2xZ97aRo8J/f/MU+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iD9/4Qn3Y6nolh7FbeueKmp49IV2qAnA9uMxu9Kvv3r47iEwWPA49Q/MaQQFgLuF6B21LaKu/xb3B1WVypSzdJXvH0eNiaa2QoJgP6KSkmjQlzZOao6Ar5WTa1jcKiPVrlyfJgvCFbR70HrK6HwAXrDxrRvs3//ji8bXsSPhv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WePlSP7Y; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WePlSP7Y"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6ab077379ddso808040eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785161442; x=1785766242; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0IF9xqTFiQ4E0NlZSx0j/NVzt/YFh372McZcqmHxOjA=;
        b=WePlSP7YfCVJFjZo+g/x4Ozz5kHTsLOO4wTGOha22OqCOKKLc4BuGU42E+KM+xa+Mp
         OI30jTShdL7UCIqU+ZEc+diN/P6d2JgwspNCbzshaEKz3/F3/ePQZx8RlBzQprcpjiaT
         fa0wMsj3i98vFthbiYlfWGWatSJHM8FZcNdWcrpeB1EoNKZLVYkvvtOB6qqaMchiX6Ka
         /tvno9RXlDV2IubBPc30d+xg1LLxYoSOYA40Cs9KrpL2trXw4YYRcKBD6nOE7HjJq13h
         Mdk7cASLbwbjbBks23rKT/2j2Osls1G+cm0eKPsPMiynhCZzA1WCIFD1uwkAWkaR3oUV
         2X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161442; x=1785766242;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0IF9xqTFiQ4E0NlZSx0j/NVzt/YFh372McZcqmHxOjA=;
        b=pSbGbbOM5rViYwUbbtlm0z9wDqbkn5kYsIBK83waBdkxdvSgo2xpevphIGbXzLgTN4
         vIBBH9pcDQjp+BwbAwb2AC2YKOD2t+kWdH75qhB7L7kqoORsXGpKZh21kLdYgYJ4rfUm
         9c29EpyfVuHmLwfEMUfDrrYXeIWyRczJ3Gobj9S4u9FDvLEGwszkP/E65Lo3DwCVeEJf
         3zFokEDd3TyZrOyF2hA+aghL6gz55P0EVApk0iu3Q/l2t8Xtbif0bRIXjdziBLiP+qFQ
         8eb+SRgDjSXVzZpXcIX3i8J0MRfYMQNoE5EaCDOTh37TJOSX4Ee2nIXpa/2pNEts/E16
         MSMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkIC6B8TGaE8D8NCR82M0WSA67NaTW2aLMuoXWrRRu6Jlk8IZBmJxZXXVbnckss5qgtKqrZk7xRGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+23yuUHOO7ybe5WwbpTkyfv8zm3D73IDNaLdHa0QJbrIRml5
	CFgzcvCDDJnNE+BNwYrFIp8XTA3N0wGrJ4tB+Egd86q+c6lS9PTwXJ15twUsmcy4ziA=
X-Gm-Gg: AR+sD12hQcpcwYk3zTpyUVFDDahMLeiklf5VrQprrihoSMzCdWwX79xjxoGtPQDq3c3
	CQ4dlmjoTB+g8rjw6L36dpW7TqBrgS7sJO07YPwlUSxyrWBe3Bv7CyO6RS4eVslf6Ciq7BsiuQz
	4cAjZGldazXJJElt0d7ubSA8/zKyJLQrA2i1FjzNZdYRoSJ+JsmwHrTglpBLzjBeYw+nzekzRFm
	sGl5ftbaKibkLfo+ICp/B1crUqba3+CtnoQlrgE6pS7mGwX3jZsT0DST/0doep1JUbwjTLDlw9d
	wFJCid2oNFjD4Cx8eC6HpEi5ioJOqmgddU0KOCBfwDaL3VKID4UAqMasjF/uFzij4RUyv16G7Eb
	dNrCg54PjtpFwqOxM+ePrnszKAZ8wxh9nCuk7osd4yx/J7ZBdAE6Bh8SAiLLbp+23Q8Yy6jXYC9
	VZscLvXYY=
X-Received: by 2002:a05:6820:1994:b0:6aa:d6bd:f6f5 with SMTP id 006d021491bc7-6aaffa040e4mr6614445eaf.38.1785161441897;
        Mon, 27 Jul 2026 07:10:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:41b4:f2ef:8a0a:2104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45767486cf6sm15998645fac.15.2026.07.27.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:10:41 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v3 0/2] iio: adc: ti-ads112c14: buffered read support
Date: Mon, 27 Jul 2026 09:09:49 -0500
Message-Id: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WPy07DMBBFfyXymiG2E/Loiv9ALPwYt4NIXGwno
 qry70xTFogVrEZ3HufeuYqMiTCLQ3UVCVfKFGcWzUMl3MnMRwTyrIWWupO9aoEogvEOCnHJSmn
 HTbuEgAk9JDQeWoVPXjkjvWsEg84JA33uJi+vd50X+4au3MjfGwk/FnYv9zVhTUZwcZqoHCq+z
 3XCKfK05gA110LzUdxoJ8olpsv+war24/+EXRVICNihcmOv9DA8W3N5J5vwke13h1X/oOq/UTV
 Tx8HKLjS+7f34i7pt2xegqwkDewEAAA==
X-Change-ID: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=De6ssdhNfQ9IVvR2e2HK7O1ncS2xZ97aRo8J/f/MU+E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqZ2ayVlFDodSZUnd52COxutKuFQeVQO1zg4CfR
 kzm86gRzgeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamdmsgAKCRDCzCAB/wGP
 wPCRCACFqUHfDe+eAf7NJjzhqjYIMp6hYNGSEB7UCIthJzeAdOYGw8ihsyJvRkn1XplJpN1fLan
 XGRch8YAk5389Lf7VPeHyYFBlwkUrrza9mgAjEtW0Hz9JysxJAkiZDZcpNAuGggJMDSqDm2nnQC
 54tLmj928Wfovl+k+cglkF+RbcQFS/iibajiwJIHbMX109sLtYReM3uCA2TlknHe9wCNCuvLH+5
 5/5LYdRmatxIQmBHkQFW3Xpd8qCTRSYSUxGKVqdNKX0vmLShstPItDQ4NDqqA3YvH2+jO37USVG
 iQv41nQyAOZxZhjC2IT1rrZljXGaVImbI3aDfdo+0ElxXGXO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This is the next phase of ti-ads112c14 support after [1].

Some design decision notes:
* This just includes support for software triggers using the single-shot
  mode for now. We will follow up later with DRDY interrupt support and
  a new trigger to allow using the continuous mode.
* We wanted to enable CRC checking for data integrity, so it is just
  always enabled. This way, the buffer layout is always the same. I
  don't think we have an existing control for toggling CRC checking
  anyway.

[1]: https://lore.kernel.org/linux-iio/20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com/

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v3:
- Fix bugs found by Sashiko.
- Use regmap_set_bits() when possible.
- Link to v2: https://patch.msgid.link/20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com

Changes in v2:
- Dropped debugfs patch that was applied.
- Adjusted for tweaks made to [1] when it was applied.
- Made some clarifications in the last patch (commit message and comments).
- Refactored the index tracking (`i` variable) in the last patch.
- Link to v1: https://patch.msgid.link/20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com

---
David Lechner (TI) (2):
      iio: adc: ti-ads112c14: add support for I2C CRC8
      iio: adc: ti-ads112c14: add support for buffered read

 drivers/iio/adc/Kconfig        |   2 +-
 drivers/iio/adc/ti-ads112c14.c | 254 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 243 insertions(+), 13 deletions(-)
---
base-commit: e2c4207d8eee17db9b09eb36f0f5edfafb223bd7
change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

