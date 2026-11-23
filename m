Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471616;
	b=tB/pmHgPrettIVcHmir7Hun5RwQmhw/qfAZ25mQUAxuUxi4oJvWvOmzv6CikrKLUWC0T
	 c7koLBs30ZPgtCufVjVkdOo6exfFcVIB5pIJuJxyvX8z41nm/MeroFU4x5DmmRSI+GjGQ
	 rvAc4lfJysqUl0WsvERTg2f79QzLyTvT1wdq4H66R9A98TdvSzkRFg3KHETkZcoL4eQka
	 Ssfl1LtmttGmvP1EnZBK7I4ovTvGOVtg20vF2EEo19Dnoyda2RcAlS42JYu/XXUgBj4Nq
	 aZI2jHkYQw3reXqC/hDhTfmxfENkFtScFK6G2iOxgu3vnQKkmrvkA7OksgwTWzgIQEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CM4vCsnF7HcDuCEgaN29fcizBuIpSO0EC7NoP3CO4/g=;
	b=mnT2iZAS6hPsruiI/ewCgXdLYD/4Cc4irIqgAbRvmbpMtYvSQ+lynJB+J4BJcMShnT9O
	 /xyHuwSP2iEALf3Ezvtcar/T9bQ5XrsOF66BC/INuV+SGoixcItyseRYOAWnYC66DMRBc
	 kNytzcHyjlPAg3t3vctbgDm60cU1CEPPRQ/qC2iWHo2C4MKVHqUofLbriozZ+9iCuAnql
	 k8c6RIyuoedqlnrN9Ih4WzP9/074Op7tL356grmg/9dwOg3lHvxFKFAZjSxujH8BtSyTN
	 MptJBy0vHH8PYRratEiAbgk0lIKEjW/+3iE8zo43wts6RU+s+jP6oqm2RE/iFnIVKpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ahSJVIkJ;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7D606A326
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A7D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ahSJVIkJ
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso3607949e87.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471614; x=1796076414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CM4vCsnF7HcDuCEgaN29fcizBuIpSO0EC7NoP3CO4/g=;
        b=ahSJVIkJui5LzCFbgJQkM3ZcJDNC3C8BKkGUUWMNKZ0bgHurEsVPyc6EOtDL8akxOe
         eqSgEX60Typ1a29S3SqI9ws69PmTGOfPrEUMmRT4DvImCWt3SzSTCqRWIY1XDxxbaTJn
         m1VdCWeBM/pdBms0aGuOa6Q2ZGDC1jWHrVVeK3JcfJS6GT1CpINtWf5mrXCHZV61dmYE
         +jiTMGcUHKSaVXBHO28kdxACX/1X4M/qFrEtzw/XF4oYLufkNOZSeE9S3w6iv/ajHjoc
         Uy71Y2PK8PVo9K/BGq7NSbB0DKWR8X4NcbWZfAlZhyVqnBVXYrp/dAvFV/8UDnMsMqaJ
         I4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471614; x=1796076414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CM4vCsnF7HcDuCEgaN29fcizBuIpSO0EC7NoP3CO4/g=;
        b=0rJyKvkYPDZ9mQS+HLDjE3TMkXFBVtzq0hi/4QZi/rZFVi/3td84xNcrVgiboPkDaG
         ZX9Af3oHt6W0WwP0/O8D2IBGaNuWqpkuUC+SQrnXm3i8VS6VHwh9MpTy+1lrorB3l6+z
         YM2a7nt0Hjm8K2hvBG7AAytQbjTh2NvuAXPg7WNcbdTG0UaGzNyYk6Bg1+hiWcYOgNvj
         VdPWSww4mPRf3igZOyOfmE5rGQ9jmEsfLp6qs+Tuo7IqkQ/NvyM4c+Tdb9QxepXRtRvU
         OyLReIhf5SeCUJj1n5fe9eEIc5leid/chKlCozvXWHJvU8QYnBMAj1nO6CbEPvtJ24bo
         wgJg==
X-Gm-Message-State: APuU4Z8jofyoVebqexdhwQdRMWJ5juKCNkikLoEVxpR+QtmyEnQI9Dvp
	Xji6pSkHuKk9aAAtb7Hh0SVVbN1qhjRZ5rhgrBU2DteQmbClRuzcCdAq
X-Gm-Gg: AZFdTZcZRKRMe4Ls6Ne59zeiz/vE6gABy5PGKGFCzSmet7aOblu1h+eICVbcajgVdDU
	PGrVmkrZ2hDkNcQ3QAaRoWKgcwjWWOIeUGRwlkxD/537FskIBZtdfNyI3y1ZmDKZdGt3fRuiP73
	woZU2uCAo5uam+Y4s1bDQupgKTeV60xLfF83++XbbkNAyk7xh34ZMZ7m5VvxyLmDx8iTuRhgmmm
	GqCxEGCTdFHZmGaGiOei2Tn2+vWaqVOfdFrGAV3xn+1rHn1IcQPC3xS55wdRh5u0YpaKPj2YaUW
	54cCcrJorHf3IhHVA7T1IELeL6ZrFBjYIy+JQo73Ttwjqq1NTRfDBdrWUMqRd04Vsx9/1zlWBhf
	LLGXr+EnKnAM9hytw03UGcNTUHvpQxzZpcUkhKN5kA9lVXN8DYChb+e1QckyyRBAxsWB3ttl5tP
	LAwgA+wMcJFiYUym3/Zn97tfqcKGTUDGrs32d+9b8C/47FU+8UQ/rCSUBhY/P2OTDk6Y8gLi+0H
	Ua5bzf9nJ/IVbEGJ1eOhb7pEx6JIU/r3b0Wf+7ZNE9dJN9ZU8gI+gpA9MsCl3Nj5OC0e3jokooz
	8derkp/iXCeD8UYjN6kBlfZQ0s+b69HZNtW2aGuMbBkzdW6Bj214ul4nq316DY96PRwDeDfHwnc
	PnaGWKXkIAhMGHeWUvyQW0We8qQnD4PFYoXgieCMyL2EE+MAy0HnEnCRGnMI=
X-Received: by 2002:a05:6512:2387:b0:5c1:4a79:b9c1 with SMTP id 2adb3069b0e04-5c1bc844b9dmr3838498e87.22.1795471614301;
        Mon, 23 Nov 2026 14:06:54 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:06:53 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 0/7] iio: pressure: dps310: cleanups
Date: Tue, 24 Nov 2026 00:06:42 +0200
Message-ID: <20261123220649.36887-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The cleanups promised in the FIFO series cover letter [1], plus the
rest of Andy's list from his review of the ACPI fix.

Patches 1, 3, 4 and 7 build to the same object code. Patch 2 gives the
same coefficients as the old parsing, checked on random input. Patch 5
shortens the longest wait after a reset. Tested on a DPS310 on a
BeagleBone Black.

Based on iio testing.

[1] https://lore.kernel.org/linux-iio/20260921183132.233136-1-zoone.rupert@gmail.com/

Rupesh Majhi (7):
  iio: pressure: dps310: sort register field defines low to high
  iio: pressure: dps310: read the coefficients with get_unaligned_be*()
  iio: pressure: dps310: use min() instead of min_t()
  iio: pressure: dps310: use KILO for the Pa to kPa conversion
  iio: pressure: dps310: use time unit macros for sleeps and timeouts
  iio: pressure: dps310: drop the unused i2c_set_clientdata()
  iio: pressure: dps310: include what the driver uses

 drivers/iio/pressure/dps310.c | 95 ++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 52 deletions(-)


base-commit: f2cbef9101b9fc979a324bb1242b8b802a2484b6
-- 
2.43.0

