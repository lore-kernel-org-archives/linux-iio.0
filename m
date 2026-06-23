Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FF318EC5
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232994; cv=none; b=G5glqZweS3XaLKFzWQhwQkOHwserFm2vlwcjP1+B7RtZ27Dn6Fl5O+nmtGirwkBXNjCK53pcN1YSjpM+tj9O8xUX0p8xhQ2+wm8NZr03Eel2xvOsJSqoQvpqRIkNS0mx8XwfpP+gAjgNwpiQdVrLatbbKSH1z4QqEHNfQLUiEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232994; c=relaxed/simple;
	bh=xNswZJYh5b/Ede+KIyYO5pGtAKQtxllC3UhvSol0/G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvTO+mSrytPgr7TkvleeuvFLTg+pTO8G0kW4oPW0puh18C6AufhIbFEHVLQh1NdT/pDDlPN9260jeuOVeeu6kKQIBbs3rV8Ys34YySuJezBXoyWamqltNunzJOEvvycxSHkDAhnwLzhMketo5ptU9timM+gsLnKp9uulWn8B1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezg2RpWI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezg2RpWI"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3967726bc47so132301fa.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782232991; x=1782837791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0yI2Uf6lQchn7JnjjvlzdSq8rfVwOTJS98JnlTU//8=;
        b=ezg2RpWI6XGtIGh67R1fKRjeerZqYM2NVUqwBdKeqkXhGfIzYrottkdaJk62Ps9DIq
         iJ7JBW/Wt5uNs2mOfmkUxxVDc3KvYHfodaEiwdPoOWtA1w8NrM/0yBqR8roJDdQY+iuZ
         QGZo2mYFwQGSoyLO1l9Wttma8kFa0P2SqgzJ8+0Y5+eUbObAGkKfUpS7K9THexQs/I7h
         qzSjeSTHoNwTyVNbaoNUk64kIu278LXc5l3n7omJUmcoIb5THaXK42MtGBZTkiuKOVJL
         ceV8KVMfQZjlux4mD08/yYYDdRA5lmi2XwdtqWCr5b0JekpHhY8CTunEEtbGgKdWSM/b
         nwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232991; x=1782837791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0yI2Uf6lQchn7JnjjvlzdSq8rfVwOTJS98JnlTU//8=;
        b=TK9VA194msvJdoVTzWdV3qu6ZxpQnwU45GfJQkv3k8IHkiaJZGXGdGA2EQoVdS9sGg
         gVXgMF1n/5HIiL8UqTcBscDvprWaZxuWI+rh/WflaSkotknzrSzfvzbjz/U9u5OweRxm
         DrdMp/+idTfZAjhz6Yf1vQ8RTVONOgqOLx6aG7wG6x4fsG7k901ZAyVsMHTI0pVWWj3G
         lfLA0HO4epyhPVtokUuITSrQcBnbZlqK1gD1jnrw8pg7BHGX83RNnz0tCEUes/jnFZun
         ym23DTjFkXjPQjF6z7VDTZtlxu2vx3jxUJtqH6qUz9WZnxvE5hwedoBmqB6Kn6rVZj8x
         cuSg==
X-Gm-Message-State: AOJu0YyOqdp4Mzdv2aSvlVGLfKv8wo6DXVb4EgGHt3EHQjRmS0nPYicV
	N+j40xyIPCFppOWKtij9cOZP1qTyCiG94ZLzFkJwou9GqAaTkb+W4vH2WsWGZc2/+WYC8A==
X-Gm-Gg: AfdE7ckepMv9oSeyIqJ4rOuWkNdV/1rd6FLN9aWe5pSd+kbY74VQKvYku/Ny/W2VcrI
	VP+bgPcYGkYPqxQsMqqwDJ5ipM4c8xEqaxQmKOrnRS4IZOzC3lPRKhFmWMtBlOTcx3HjFMujXYF
	/3DwtkDzYkHWhNg8brFbiPWld6ZcDOEjUM2Wze7NHMPBN60UjJXS+TGYxVnJND+KZfI+4UITkNo
	vpOSuy+xSgMV6j22rkfUXVbmvy4OUqFScISPlyNjmP6RgAFMSTjPVgiJ/fTHRLUnAuZBC6Dx2eY
	JqvLXw+FFntY0OEasgG2WUcdKwmo+U1vJAIB9xuuyPPZHuQyNGbvPg56qbipz8Dh8dr0g6K0DVW
	qGke/Pv9Cmqqv//5IEtt5NARBNffC6nBteT43J9UZmqccVIihNr//qiPWUNteNYB1Pzephj57RN
	mLrcJjzlaLIIDdbvPyUqut4L6JoTFRwy1M5b415GcVjHQFCA==
X-Received: by 2002:a05:6512:154a:b0:5a4:13da:fe8 with SMTP id 2adb3069b0e04-5ade4746d9emr893499e87.38.1782232991289;
        Tue, 23 Jun 2026 09:43:11 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69555c45sm948253e87.36.2026.06.23.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:43:10 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v3 0/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 19:43:06 +0300
Message-ID: <20260623164309.16452-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623140113.12574-1-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX86150 (Maxim/Analog Devices) combines two PPG optical channels
(Red/IR LED) and one ECG biopotential channel in a single I2C device.

Changes since v2 (addressing Sashiko review):
 - Move FIFO read buffer from stack to struct field (DMA-safe for I2C host
   controllers that use DMA for burst reads)
 - Remove redundant devm iio_trigger_put action; the IIO core calls
   iio_trigger_put(indio_dev->trig) in iio_dev_release()
 - Remove IIO_CHAN_INFO_SCALE from info_mask_separate until hardware scale
   factors (PPG nA/LSB and ECG uV/LSB) are implemented with register
   readback in a follow-up
 - Reconstruct per-sample timestamps from IRQ capture time (pf->timestamp)
   and the configured sample period (10 ms at 100 Hz) so buffered samples
   carry accurate, evenly-spaced timestamps instead of all sharing the
   drain-loop clock reading
 - Switch to devm_regulator_get_enable_optional() for vdd-supply and
   leds-supply so probing succeeds on boards with fixed (non-DT) rails
 - Zero data->buf at the start of each FIFO drain iteration to prevent
   padding bytes from leaking previous sample data when fewer than 3
   channels are active
 - Flush FIFO (reset wr_ptr, rd_ptr, ovf_counter) in set_trigger_state()
   before enabling the interrupt so capture starts with a clean FIFO
 - Fix file permissions: both new files are 100644

Changes since v1 (addressing Joshua Crofts and Krzysztof Kozlowski review):
 - Split into 3 patches: DT binding / driver+Kconfig+Makefile / MAINTAINERS
 - Add MAINTAINERS entry

Md Shofiqul Islam (3):
  dt-bindings: iio: health: add maxim,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver
  MAINTAINERS: add entry for MAX86150 IIO health driver

 .../bindings/iio/health/maxim,max86150.yaml   |  67 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/health/Kconfig                    |  19 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 651 ++++++++++++++++++
 5 files changed, 745 insertions(+)

-- 
2.43.0
