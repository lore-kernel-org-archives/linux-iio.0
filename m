Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924335;
	b=g3cjr9QJENSNl0pxWn4tzazV3zmc3h5c/9dPQeB24s+9bJvEE78cjQTDCOGiQFke/VXk
	 eGRnu3MlE1qsVks4SVlJRCVWT99hkSX7fTtZLT/Mk86NFEH6muQAghtAnbyNWpfwJps2V
	 3WDzTVfb0yb8rHAuSF31SKqO+hjTvPTFx1i2hK4o9BlU4ZBpff0kWaXtwjMO5HfCtSCCH
	 VUCzdXyZjUdbGe035umJCew/19+EUzppkMCIpsx7IKQB3fKB9l51VrfzBpF7Ds/tWf4Gh
	 E/C6vTIrG7G1S/1aOV+xM8gCWZiuZe23tCHZ2GAwurXgeqAIXTeDzVlmfEPmJvsAoug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gwpUsyK05NpebcZHKBuJHcLynXCmkJRULUp5k1SU9r4=;
	b=vkO56QwTdUhHdRnOHZql9HyX2qJZpbNzBjn38X8LhEnYkN4TCFMgEyetXgTm378IH3cX
	 H12izdl2WJQmhDa4GO5WoCAaqbPsbNFo8mFnvCOrd2kD5g5W9A3Z/iC3hOS6EGOwkMwRB
	 gNo0YVEPeU7U7kn4EzkJvrAt3SN7g4IEKgW9F0CXhHiuyucPwNPHbsPsgTMs/8ITbnhC1
	 l/pSmO6NLlYEJm+4hjMzd2jQYKPGYg2kIh42naIAtg2zX552erSUCwql+IAZa+7VRq8V+
	 zvG/KXx+vOfyLP6a9XLcg8lUoi8lsDYfrnZ4BMBQX6cA+u7zMS3ksTmVkKOowCNXZuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AKHskOD5;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBAC606A32C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 14:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBAC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AKHskOD5
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a5506f09f5so239387f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 06:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794924333; x=1795529133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwpUsyK05NpebcZHKBuJHcLynXCmkJRULUp5k1SU9r4=;
        b=AKHskOD5yvtPtNt8uUBx9uoc7lmOQ5mI2ikTE4ijykE+KE5TLWi/ugg19NADcDxYyp
         0s8jr7Ay9ujYOFALwAciOtsazWJQpFMa2ldUigg1sjIOIzYc9OcPAEVBZWBH+e2IwP7z
         5pZYhmh4A9t7wI+fwUNAIj+bXG1XFP1m1FqIOaSweKGB++wliRjCFDdM8PiwGRdJTScz
         QCkXP4B86/RIxsUrNdelmFqQuiMDFp/QHaLPcOk6cMppEN+UpijQGm5b7vL9NG7Gd6lI
         S+mjt4zF+f/+L+x7C99MSn+Qt2qSnMdgbPWwunwMeA4jwew3gQFskiXNvdwschYXakxw
         LdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924333; x=1795529133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwpUsyK05NpebcZHKBuJHcLynXCmkJRULUp5k1SU9r4=;
        b=CscgwanRaLdc+mdf2kw0SnE3kiJGANHNsLhylYvhoRJMByarSmCuFcJJq86Fq9gYvV
         AhoHor1cwcsj4TVNALH9DfHcYaWPHc58FdwXBEX6/Pypscj4STZYTu94lzDC8wzfLvRa
         YUJVevZynyRedxP0lEVlLVD8vS24xPIRA5F0L1KqSR9GQn5LFdjhCDi6M5OGAFxs0Gau
         NOihMl3zuT5Cxc427Z2grer1F3Wi14EEO8Y/IywiJF5IkqyKZ0er27OZ3y7yGXKR9Q5K
         +zCzD7W2YW4HDyvSq6w+9wJjmgnm3/clMnHJu0HpqT1FvCTy2X1BwqyPnEuKqDEA6x+I
         RSRw==
X-Forwarded-Encrypted: i=1; AL+hErFI4jQy0JeDJAcZjWuVVbEDvWDFoJtqgj11L9x6LKkM3U9DjvcXQiEhj+aeWwNgW5UWdyhQqjXTRX8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tRp0k3fBeqAbmUzX3Fq/VHFvOr+ZnPCq3sBtbI8/2Lf6Utf5f
	ynrf7+mYr8mwf8wK/spE0fnVI3d1DdD1p962Ov4vxHMLvOrkPloXEsyo
X-Gm-Gg: AZFdTZf925+oUV5JEZgAGS3hFyUevwzwnNW3dCz1bYlyBzgbP8A9Cod+6RT2wDszKGR
	O5KNVwABnaMRWlCqUJiTCvGIrUMvZXp6dkzRwiBfC31iwnR1PvZOGpHZ3Ok+vrncm8cRz/plBcg
	8qlH8tI2p72WjM4m8g17PNRd1co2jOGEDLLLtY9IzWCXeI87rzn9y6ZcKYXCTmZmA53jIS/2T9o
	pSTCJnCLT4R5ZiH2Stez51TyyGXw1Nye430mpZHFzYehboFBIf/yfLTCzaH/6aUXei3AHjxJaX7
	nrhiUMhodSqxFQY5uI7B4JJwUWKHBaKlHLocxOSZGkkO641VWNfetfpCJe03w8AeuZNfBITG7E+
	Pr6mARDJmcgYtXTIYrO0TC0TSp0i730dIBck/n/3hnisggiKP7TjJXxYkjh1flMtV62loOCUzSs
	2+NPRRLVGVv3cjuJ8NFzaCAMJ987wBJROnnTvI5GI2ys14RsGGmHXBm/Kua1M9aQW6UCLwdo7va
	OfBZGFwwEfuclLUnA8CW/soDJVHnxq0whZYHXpXh4UW8mZ05JRWswphfWUUvFIKluXi/+rvKisv
	ulJZX0t0yFOn+ngIEKb4rBi9uKZzvci8s9kGEQ==
X-Received: by 2002:a05:6000:2602:b0:48e:7476:9205 with SMTP id ffacd0b85a97d-49c71784d80mr30330262f8f.31.1794924333342;
        Tue, 17 Nov 2026 06:05:33 -0800 (PST)
Received: from fedora ([154.183.162.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm2623032f8f.8.2026.11.17.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:05:32 -0800 (PST)
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
Subject: [PATCH v4 0/3] iio: adc: at91_adc: fix trigger NULL deref and convert to devm_*
Date: Tue, 17 Nov 2026 16:05:07 +0200
Message-ID: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
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

This series fixes a NULL pointer dereference in at91_adc when external
triggers are absent from the Device Tree, and converts 
the driver to devm_* APIs.

The series is split
into three patches:
  1.NULL-pointer fix.
  2.introduce a local 'struct device *dev' and use sizeof(*st) in probe().
  3.removing manual cleanup and inlining trigger
     and buffer setup helpers into probe().

Changes in v4:
  - Split v3 into three patches (Joshua Crofts, Jonathan Cameron).
  - Patch 1:NULL check.
  - Patch 2: Separate the local 'dev' pointer introduction and sizeof(*st)
    change (Jonathan Cameron).
  - Patch 3:
    - Remove at91_adc_allocate_trigger() and at91_adc_buffer_init(),
      inline their logic in probe(), and avoid relying on idev->dev.parent
      (Jonathan Cameron).
    - Remove redundant dev_err() on trigger allocation -ENOMEM
      (Jonathan Cameron).
    - Use dev_err_probe() in at91_ts_register() and for
      devm_iio_device_register() failures in probe() (Jonathan Cameron).
    
Changes in v3:
  - Remove redundant dev_err() after devm_input_allocate_device()
    (Andy Shevchenko).
  - Introduce local 'struct device *dev = &pdev->dev' in probe()
    (Andy Shevchenko).
  - Declare the loop iterator inside the for-loop.

Changes in v2:
  - Replace the simple NULL check with a full devm_* conversion,
    as suggested by Jonathan Cameron.

Abdelnasser Hussein (3):
  iio: adc: at91_adc: fix NULL pointer dereference on trigger remove
  iio: adc: at91_adc: use local struct device pointer in probe
  iio: adc: at91_adc: convert to device-managed resources

 drivers/iio/adc/at91_adc.c | 229 ++++++++++---------------------------
 1 file changed, 62 insertions(+), 167 deletions(-)

-- 
2.56.0

