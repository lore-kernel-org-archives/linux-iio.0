Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF893BED17
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941918; cv=none; b=OlALMjike/TTlzGejG2ByeLL/UOdD9R1EJkjwyEjyto/dgf/UUcAc6IORli3YNmo2JYbF5q2XC08o3Q9J0Mhz32ksWb3keNOV5TNLvb89kTa3e3755p8zuB94aS4hsX3Gs0s/vj7UTqVAMazkw8X641nr5f4vXfnAZdgBKcEUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941918; c=relaxed/simple;
	bh=jpBKCvDwEnaAHQaDSndjz8ggTnXKApeWpvM7bXUvWIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGLdX6S37PIAf2aPL0Z7yh6Y0e8vUCXPgtnf+XdleXcWDCeSpSMntAX/zajPTusUMg8LghK4AQ29Yfikwi3S+WF0c+nwD91idtQjoCRfqv3y08Qo2xGVHBOFJhtNOioaO9pico8tk+QCzWXid6AqJP7+Y9+2YYxjO5c4ZGUQFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUlHni1X; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUlHni1X"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2aaed195901so23236795ad.0
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774941917; x=1775546717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kDomBRu/WaObDoJzQS7Tba3JfdUuYrLrhSQ1OKlEw28=;
        b=iUlHni1Xw9mrDeAxMYJD6CLfw5ORdPvHPVC+TpkVhBYBTY4rKtXpnSVJABRRtCO2xX
         JZMrI45AW68LeqwmD4HOIIz/Xq0msuYK5367J5fTjbj4ooD8Kd+1xGAilleG+Y7J4xjF
         o/f3ZNRsizPzg3E0pCwUoicePtwtHcAO58kDAH2vD1WXWTSnd3YmYNYCF6kSvzTgZZF9
         tbXOm4/9tbcaevvMAKqBO5i7baPBJfad0NvCIfFDh0tJOjsKPwGqsqbIcp9aP50zM/2J
         BgQuTxzt9YGv/cTfw6C5M4R1RWioS/mfCV/mMrbaENH5MYHOJS6FEn3XK5+mnF9UNg3X
         RY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941917; x=1775546717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDomBRu/WaObDoJzQS7Tba3JfdUuYrLrhSQ1OKlEw28=;
        b=nOEz77UdadWIybkmoJEk5GuIYgJpwP7R/pRgHBl/FsAmsGiKhfinDKuwEugkbZX9f2
         rLVYnO2kW3UGxjBEyQ+7FgD8xVl4Io8CvS3wHsfH/Klyev4Kyx0t3osU1XbyXcytaga4
         IcKZjBBiV6egeYH32qNJqpSpjERZeH/OGdFvShFaKx5NaxI7rbs//yBDROSqSlzVeFiG
         jS9xc6gwJoEgTS7FQRcpyC5dTyQNOJQnSkyfw2CztkrY7d5tGM2l6++2wA+Y0d8EYAYR
         v4dSyZJepO2kYhhscJyH4AyWlbOTsacGMc4LA/cdfinpQ6d6nBahLOJ8h2Ft5eVtx5mh
         k/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt0Lf00xrCGdtZDegnmMDe5WGyAY7uRXI+bcbiVJ1hxFIjmkjmutg1aEY1/DE9Lw732jBz4MPvCCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Y3nZ85S5aVzWiIq1ImOi+diadrCRXZr2NEtCTyOjcJly+GIf
	DwPpAf3Y0j4wf3ltJ/COkmIfiK1MRtxJjM3w+k++p7IoQzWZrpFuzJPm
X-Gm-Gg: ATEYQzxDbvv9ns4Pip3KfAh9Q1uym1tBGN5ENJ8IvktKbA1kxOfhkznYCcU9BNPHb18
	5StIbKi3kIRNeGjH5hmPa7sOcBS+x8n6fF0TzgO1wDiS4bQkaumsj5DW6Ox95WE9v4X/NJzhHk4
	wKODH/TBk9kI5USv2XQqB0Qh8AKSBxzpnEdiJt7+Al9ify5MY0wvkit3WjVAmAd9F6mKJs+ts7c
	tCNpxXapTLnr161laayEtKeuGlsSnmrA4LaUIKklnVyEOrmUKJI04Q8cWWhD8X2I3oS1w8bfuwV
	07Zxxff5jRufW+w3CiAGt0/8bpJM5K87enNBRQG/1cUNUDgQ3Yuey0tuDM9ipfWBZ7xafwX/dwC
	vURsD7j5gAjbvTalc7gCq7Ey145Cc5eqYarh3CtS4ECgSwFtmvd5HNmQ4+M/Z93OaZCTWGAuxw4
	Xg116c3i3eCp1KZxQIM1d8nRKpoWpLNLRMiZzvc50=
X-Received: by 2002:a17:902:f650:b0:2b0:65e8:4041 with SMTP id d9443c01a7336-2b0cdcb73e2mr156323595ad.36.1774941916962;
        Tue, 31 Mar 2026 00:25:16 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:5412:6527:d590:8704:ff8:2ffd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642956sm109272495ad.6.2026.03.31.00.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:25:16 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v4 0/4] staging: iio: adc: ad7816: code cleanups and modernization
Date: Tue, 31 Mar 2026 13:24:49 +0600
Message-Id: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses feedback from Andy Shevchenko to modernize and clean
up the ad7816 driver.

Changes in v4:
- Added a blank line after the AD7816_FULL and AD7816_PD definitions to
  improve code readability, as requested by Andy Shevchenko.

Changes in v3:
- Added missing Signed-off-by tags and detailed patch descriptions to
  all commits as requested by the automated patch-bot.
- No functional changes since v2.

Changes in v2:
- Renamed sysfs callback functions (e.g., ad7816_show_mode to mode_show)
  to satisfy the requirements of modern IIO attribute macros.
- Fixed usage of sysfs_match_string() by removing the unnecessary 
  ARRAY_SIZE parameter.
- Fixed vertical alignment of function parameters to match open parenthesis.
- Replaced sprintf() with sysfs_emit() across all show attributes.

Md. Mahmudul Hasan Mabud (4):
  staging: iio: adc: ad7816: redefine mode constants to start from 0
  staging: iio: adc: ad7816: use sysfs_match_string() for mode selection
  staging: iio: adc: ad7816: replace sprintf() with sysfs_emit()
  staging: iio: adc: ad7816: use modern IIO attribute macros

 drivers/staging/iio/adc/ad7816.c | 112 +++++++++++++++----------------
 1 file changed, 54 insertions(+), 58 deletions(-)

-- 
2.34.1

