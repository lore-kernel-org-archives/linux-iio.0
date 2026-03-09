Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D882836A6
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053137; cv=none; b=uWVkK88rVwkdmCtjyc+fitG23p0+D+749sL8zr4upl7krBg6UWvrtf0E2sVwkuui8FpbelZuujKsUolONtXNG7OW0TUHjSuVrC/9hDeHwdqOK6HqddznHlT+R5S34O7S03OWLXTuJyuO9AKpqZnhq4PHtUyCMfLhczUl4P41HXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053137; c=relaxed/simple;
	bh=OIpSpY2iwWSAFmgX0Ki5wldv0Q5nlosco6TSkhZBaB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWJ0NhQoZrfh5UgBrCjRxjRVaPahi5eRE1vrenR10yijRgv1NX+p4nCOb1pQwTX3SNUK0yKOGmmHppweaErG1qi0e9/JDUvjJkkX9+0LxEyIAm4tpKYUGP0+6B7ySB+WWd2Dy1u6ze568WSXWIUg+cNEWSMujRBQWctgPUgcILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMwj993l; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMwj993l"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82990763921so3683149b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053134; x=1773657934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cj47UP+gDZY830WPpnsAzOHTkhrY93LbsnsifiN+hw=;
        b=RMwj993lT/8A/wEvqtud8YRuPTbEuEVa8RA2M/Kv6MQUH7x/SjbUlKZfD3drP2WPeS
         VdZc4ZqjWrtZJblpA9xlmc/C57HOg1z7uxg9D9wE++DCd0MjjQTCHbgn9ksH37ovZSBv
         FsiZweb0SwCjO8MSYjNzDNuDVunXpMf/vF73iVeMVLtAblrGr2QRVc38ajaUw4GE0+HW
         OZvtlDP8Fwk6X/c3Tw3PjQHb00by31Ii/fk9eou04V1sxyh3sUiN3VCUGMvMW+PcO6Pi
         y34zX0mzAPwZ4CyY285YNqFTKnDvvdpSBxpCGcV03kVuMpx11+ksYRJKiV5xeYLjUhcK
         nvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053134; x=1773657934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Cj47UP+gDZY830WPpnsAzOHTkhrY93LbsnsifiN+hw=;
        b=aJfAlRrj8shgS/w3DdB8lPctWWDKtJifFMPAC5AU7++zo1iBkCdqNW7J++DyLlaF8y
         kPzgi8Odg/ZoDxmNJA3TC4m46+G2OhM1i0gZW/dBs4Du5UQ8Cf/zUKlevQVN+NVA74T9
         ewyPOEhEOoaVBn7vwDqaBVxNq4NlD/wq42vcrE5dXxgq4ief1rNyBj+y3BCmezRS7L1x
         t+2F+Gemm5ZfjxQCM7g9Nohy7QbiI5ruF5EMLwZdu9XTEfVF9WomNdxFm+DXhttavBS3
         QDXhPwDkxWd9bGsQh9+5F87jVAmPEF8jxwNHzDCtYMUHsRA5ZWw4sfasnvDSnomEUFw9
         Cwow==
X-Forwarded-Encrypted: i=1; AJvYcCW6C6IPtRI2O1Yud7PmW/ghj93W2ymSJQRBTYmfOmQgh03/lq3BS/8KTVQbSf9jDeY+4s1XdDMsdDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uXYUmSjsMeoI7GLaRrupTMPGIk3pczKAcbX/P79ExkiFbRM1
	v/PGECSt7conHgxqQ880lYiVUO685a7s+1Qf1DBh5DSPN5Pvvk3+s9B+
X-Gm-Gg: ATEYQzx74LzJzLuwuqx9m8IMWk+yd8t/s3Rc1g8t2y1cS21WllwuNigwackBTdHQ4ST
	9o/xiAkN3I99pW/t+jpO62XV24jJTRgdBMYY/jH9KcUGjmjib1DPXL42il0oQQhoNW90QTMwr16
	32UhvcVCpXZXMvHIscYNFx7j0giSAvV3dMg+M+TwqxP7jDXtesl3phoPm3bsgYu7tSLuPrpG7Wk
	K4OeyvSP/6/SqUcgPB4oPupGZo8jaRWxhZ/n81WxGwQN5rpWt6kXwJhRXJikJ32yYKJyzQtDJJa
	4RYXPr4QAno7uUzoDYQGbSqlfqnOgs4PdGJMi6XtGWAfyirpzp46SeIi2HVKEzgjt+wwbU5FsYh
	T3w+9Uq8fQusktTdlkRFF1wV7obUEmxlZNFJCVASi/1cCKqlB2f1fYsntl0/V+3HaqcwfdsK5oY
	ytSWO45t+k0eGUs3iQOYJQffowgle7UyOKlEs=
X-Received: by 2002:a05:6a00:1581:b0:827:26b0:58d6 with SMTP id d2e1a72fcca58-829a30bf515mr7928189b3a.47.1773053134255;
        Mon, 09 Mar 2026 03:45:34 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:2ea1:a1a7:f2aa:545b:3c1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm10276143b3a.17.2026.03.09.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:45:33 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v3 0/6] iio: fix spelling mistakes in comments
Date: Mon,  9 Mar 2026 16:15:07 +0530
Message-ID: <20260309104513.40359-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes spelling mistakes in comments across
several IIO subsystems to improve readability and code
consistency.

v3:

- Change commit subjects as per changes
- Capitalize proper acronyms (IRQ) and Celsius
- Fix short wrap in commit body

v2:

- Split original patch into 6 commits
- Fixed commit message formatting and typos
- Added necessary tags in commits
- Added more fixes then previous

Shi Hao (6):
  iio: accel: fix typo celcius to Celsius
  iio: adc: fix spelling mistakes in comments
  iio: amplifiers: fix typo Curren to Current
  iio: cdc: fix spelling mistakes in comments
  iio: chemical: fix typo insuffient to insufficient
  iio: common: fix spelling mistakes in comments

 drivers/iio/accel/adis16201.c                          | 2 +-
 drivers/iio/accel/adis16209.c                          | 2 +-
 drivers/iio/adc/ad4030.c                               | 2 +-
 drivers/iio/adc/ad4170-4.c                             | 6 +++---
 drivers/iio/adc/ad7380.c                               | 2 +-
 drivers/iio/adc/ad7887.c                               | 2 +-
 drivers/iio/adc/ad7923.c                               | 4 ++--
 drivers/iio/adc/at91_adc.c                             | 4 ++--
 drivers/iio/adc/max1363.c                              | 2 +-
 drivers/iio/adc/mcp3564.c                              | 2 +-
 drivers/iio/adc/men_z188_adc.c                         | 2 +-
 drivers/iio/adc/npcm_adc.c                             | 2 +-
 drivers/iio/adc/palmas_gpadc.c                         | 2 +-
 drivers/iio/adc/rohm-bd79124.c                         | 4 ++--
 drivers/iio/adc/spear_adc.c                            | 2 +-
 drivers/iio/adc/stm32-adc-core.c                       | 2 +-
 drivers/iio/adc/stm32-adc.c                            | 2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c                     | 2 +-
 drivers/iio/adc/ti_am335x_adc.c                        | 2 +-
 drivers/iio/adc/twl4030-madc.c                         | 2 +-
 drivers/iio/adc/twl6030-gpadc.c                        | 2 +-
 drivers/iio/amplifiers/ada4250.c                       | 2 +-
 drivers/iio/cdc/ad7150.c                               | 2 +-
 drivers/iio/cdc/ad7746.c                               | 2 +-
 drivers/iio/chemical/bme680_core.c                     | 2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 29 files changed, 34 insertions(+), 34 deletions(-)

--
2.53.0
