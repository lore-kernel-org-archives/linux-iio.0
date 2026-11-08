Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794130998;
	b=Ao+NUpSZsLpn0ThAl7jg6fZGGgaCMM2Yn5aPO1GF9HHarf3rwy0QCgOAK9lH955f/jrw
	 MRuFuLpUNsKN2hClvW4qLHWSo9PRzG5372L59cuUPcy8Uki1pt/V3Daiye859V/Wxawap
	 bhw3nsxKHYLn9Ub1CmDEw4+F3XQh7xQFIV1w/QygnexMs7essiu0OVNuzTZrfrlDipM10
	 06Iul76x5OVMmp2ZGYx8d2XVaBAhIg/ChybDP14EP3KxiIgc90w2J3d8OtgArtLPFRAyF
	 0VKoeS6Im2J7J0503bH4WyXJ4aebvkpjSmeWDVs8utTjmKkQNqeg2QgBCWgS1XRxzMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794130998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GfUzsQqkjBFZnftE07kc579ADex8ACNapCg4XsBJkV0=;
	b=OYpmKxDo5Wsj7GzSVf2iChjFq+cFhCNOJEoW5yFA7xviwVRL63Hz43/3kUrAk1mPwJ9D
	 At223rj8M7MOe1pGgnQIBEFf3giFmisM43qT6peUEKfINoJ34nrVkXx/L9MhLYJ0oxUam
	 o4cI0AmYEAsD6Atj3oPvM5t7yUkExs9rWkPubbRFPIT9LlG+Ng8KNeT3W5oQrwjU0lUEj
	 SKITuOD6O6zT//CFOHXrgm/LsPj15s/N5a+Ai6e629c9zjIrYC8TBShyBpW+WMzoEj8jy
	 C4RfkJ3W0DMz2i2YdYiT+TrggqD3eeWG97M1z5JrfmneHxdYOKIAkojD5eWz9pur6aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CBvCECDt;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B400606A332
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 09:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B400606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CBvCECDt
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so11328a12.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 01:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794130996; x=1794735796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfUzsQqkjBFZnftE07kc579ADex8ACNapCg4XsBJkV0=;
        b=CBvCECDtMZ21MHgiuUBGSs384znpHFFtpjSrrAQkXfe85KqphHgLSFvfxAvdzrkMqp
         lPQ6YLRo5/91Nah7agor6YI1kCUC13rbeClY8J5ktIkTBElwTG/IvI1ssJmrKYzwXeUX
         BtPFXQfmZxkB8M4Os8xUBPTbuToUTi9YGVoIvI5RJoUJUJMO3x2zm+NRjeRvi3/Oub64
         Ow3AXEq7yS97bbF7xquCHLnHJijBuaFnb3xDUTY5L0w4IkfIrjmUpdDq1OqHaVA35Z+h
         URnmaCgOKTw9zoeybRl6ij3S1WZkzZ8jnUaa57gvI91NJ4v7a8i1Ja4Ry+1J1ohmkme6
         vekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794130996; x=1794735796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfUzsQqkjBFZnftE07kc579ADex8ACNapCg4XsBJkV0=;
        b=BqLotgcikPqtDAdHY8Xz1KPhvNzm9vjLBN0viNgpcQNBZuz599HfEgde28PO6H32PU
         pSu7052PA0fdLROpwrc2Q0xjYZjUXbgaHEuWnEaYowgZpV61jL5OPi9vAlCBVLPYOdyN
         neB890OU/AGDDZk2jS3kAVG/hWoCFm7dzhZIq5iTKU2IZdOjvIgoc/KKC7zLsnTyu3Vw
         sNG76JrwW06XNG3mTGL22LJyfkqZF69J152JzD9rR7WQhURveVnuGpj+OOGhEl5CDWVR
         tKZH38ALvTi1Frwn8DvBQoxJqDyWuFY4PT4MaBwVVtJN3vNd+gbiWtvnW3XuN9Qt2lG2
         rkKQ==
X-Gm-Message-State: APuU4Z+kzuAxTjsoTmjHa5W0hvbbt/uCIEjbBDalHWVcZkFtAc+N315X
	UFK2+OiKA+0smPfb/V8D4VE5KZoMcnHIfLIH5vE1ALuGt4EyFG4bLZdn
X-Gm-Gg: AYBFou0Th6Hg1jqO23bv6iH6oQuIRf5BtuSI3crDgWrSav8J0l91TvZD+Qcm4myy1QJ
	q6eUSoO85KhjQ6jLmo1VS2H1cArYkCMFzRTA/aZ+ZhSejpmkisKz/c2AedkkFBryqV1XuXxOiKJ
	idSWOsw7Phi8mIUMYdOO2TERPTLsb50aG/haao7nr8CC4w29LfA4KWnlABbU9ghnaBT2dnNc92t
	d4CWQCJjGFvr8J6r4QTpMaQQ5VPhRuGbxbAmi1/Gz1oDd8bTDHhqbzFbzcyp1EP1rn9h5ZZMFdE
	OJE0je+TDF+tSz84b7rJZGQjWVJJPWtHLD6f5gd8eGcTCCDhmBmkk7Z0Oc/MLkx0mAgUZjcA4Dn
	4MvnmpNDQ4wteEoesRPIy2L0KCKaNfKZzuNexavRE+TWfYGOl6uUML++t4BwUU4J20VRrRrmgUf
	pj9CbMCkXaEKUDfcgG5MdnFU58vEIaeCnscVr2gfDA8KzcHpFEWEmPAaNshXFxVMc0tDP5XlKrj
	UQr9hv113GnF7ZqLsYmUl2EsZb/ht9pqWnZbLOxd8tEkWodUrexFwdZWRJ8yon6f+/IMjF0qmKV
	Uebq+2qabH0ciDUsmkUyR7uCCOdiIkFd5plCjLeoP9HCzLzjOQQxrWUZh8OmB/SyMn67PDaciOO
	NRdoeenFz8w==
X-Received: by 2002:a05:6402:4010:b0:6b6:f7f7:dd88 with SMTP id 4fb4d7f45d1cf-6b72246afc1mr634054a12.17.1794130995645;
        Sun, 08 Nov 2026 01:43:15 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea56f2sm436321a12.8.2026.11.08.01.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:43:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] iio: light: ltr501: Add LTR-659PS-01 prox sensor support
Date: Sun,  8 Nov 2026 11:42:49 +0200
Message-ID: <20261108094253.83899-1-clamor95@gmail.com>
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

Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
nearly identical to the LTR-559ALS-01, but omits all elements related to
ambient light sensing.

---
Changes in v2:
- set IIO_PROXIMITY channel to scan_index 2 since driver will not handle other
  id properly
- add IIO_CHAN_INFO_SAMP_FREQ for IIO_PROXIMITY channel
- isolate missed ALS register calls
- add commit to use read_avail operation
- convert to use modern chip info match

Changes in v3:
- LTR501_INTENSITY_CHANNEL macro adjusted to set predefined info_mask_shared_by_type,
  info_mask_shared_by_type_available and info_mask_shared_by_all_available
- added info_mask_separate_available and info_mask_shared_by_all_available to
  proximity channel
- fixed IIO_CHAN_INFO_SCALE for IIO_INTENSITY since table has -1 entries
- fixed indio_dev->name asignment
- dropped ltr501_has_als_support helper
- fixed channel finding in ltr501_trigger_handler
- isolated more accesses to ALS registers if no_als_support is enabled
---

Svyatoslav Ryhel (4):
  iio: light: ltr501: Switch to read_avail() op from manual attribute
    registration
  iio: light: ltr501: Switch to modern match mechanism
  dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
  iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor

 .../bindings/iio/light/liteon,ltr501.yaml     |   1 +
 drivers/iio/light/ltr501.c                    | 424 +++++++++---------
 2 files changed, 208 insertions(+), 217 deletions(-)

-- 
2.53.0

