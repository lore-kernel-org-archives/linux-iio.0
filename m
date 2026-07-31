Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC005368D77
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522252; cv=none; b=OrkhzmwMa/bY+XvQocE1LB6k0XAk1NzPIcmRb2etxyZttTac+BIg6Z6itv5vrMEpDVSeUR/l6DT7d3OjVMCMy6HckDeu3Hlosv8zm6dqk0LKi2whaXfcb626EDmzilGOQxI6Bi5nEo+UPateEfQRL42oApWkjCGO9V6KfiKqD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522252; c=relaxed/simple;
	bh=GAQI9yphhi0unsmoURgfghGnAXS4SX8A071VEaEStvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwS7/i5drv/RwM2A/pTpRw6Dj71F+7td2t720pPsWGzWvuGjCqj5yQE2PPjDGmextqZp3aTD3Z0CbImxgPoCP1a540Jf1/wVTLUy5FvYIVI4LpH3ITN35olyWsyf0n1eodLDRN5kjqOHghj/DNdfM6chXgu22joNDOsfmV95rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGSY+AII; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGSY+AII"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1284529a91.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785522250; x=1786127050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKaPdB4MnlwEF1r+9WMk80Srkg2KM9H8TZMozCmsZJg=;
        b=LGSY+AIIGKtuYtbRTvagK+zZH9988TYm48kD1Ljmy78gUF1hG8zsj8vNUeO9uG9C56
         GxPdetTMMdX0ogb3U8P1z/U97LuRPkUSDdH2T2wRzMO9qyXDXrP3JkxLwvjicBKsSXi9
         o7ECCc4JkHgOP3Adolo5JiwBF57dqW6RVWEQPINwLD5pfotpsvYCdwWioZu7hZQ5lHjO
         lI5EtqofqRdSvDY3HNTxGB8z5S2adEmxI0HX2xi4qjT6KX1RF4ZE5LS4fi87OzCZZpOb
         pFzbTVlA+2klTw0t2NeCFHaHgs5JHwLhnSymfnU/dMo5cUFRKES0BrFIOiWAcMUTFzWS
         Vr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522250; x=1786127050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKaPdB4MnlwEF1r+9WMk80Srkg2KM9H8TZMozCmsZJg=;
        b=RmInhc66CnhllFrz/FCKis5dt7Spl6TqoDYN53O+tz+vOcBbJH8wOKS49GmigFSAT7
         8LNKYBRHDm3kJlmJLhA7/JXW+yoTEejfKb7d5x8d3VBbbga5L17fTYKvPOgvAXKHZQ1O
         ycdp5VBzWw8Ge2whTQONf4Qs9I4pNHkYLNhFTOfdHpdqKExc7i3b1lYedJKZfZFiTfjm
         Meq+96yHpKgqs2TiM1JNUm29BktgJLH7VHvzw6UjUTZV68g/dHk8a/5C3q1qt2jGk/0o
         IQaWAPL4bFtwPFqdvlD892pGpYhNTCwEse/q9Ro/tdFX/ALIKL2h8NfJuuGFEJ+7x7Lj
         UmaA==
X-Forwarded-Encrypted: i=1; AHgh+RqEz0ugGXR/0ZqmVmwxbIj1p+NU1m6nko4ROVNbL9L+AS9mgskPvsfzIER5ECtTDnlQVDI9hqutfAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRL/Co1Lc3A1FTJsClKlkg103Dn9yEDpoRW0CNIlNMeoSiYnz8
	J6olBiI4lWnMBJnsEbQj/0kTnxN0aqEpkT4gxEjQktYBmOYtLbhu4fDe
X-Gm-Gg: AR+sD101wu2dlcvHFZ8bWTCoCd4SMO05ma9F4KzzWjZ92cWR4VCOHweNR3vqZrEmTLp
	kCzARp5bGAdNU8zrCdl8V0ICMfQ6T1rz/SEfopEFqQ1UTpGqW7QHomF2n2Y9oIqhtq0Ei5TVRrV
	I0bKxyeLNVFWs1lf0j49WgMQpiN/pGwAU+gmhdcuY/tEIXxaVDn/+A5WvS+g+iROr8aa0tZeIRR
	3Ao7fURqsBzYPbXEkf51ivA3xSceLf9xJGIHo96rfy2U0XuUvhMBnqhz2BA5IPNvBm3Z16DAzEh
	5RgxymfpT6LsYkshHj+DHQwu9p3xKC5/UOr33GzvRmdlnseLaMOpMHD0h4CmFjXCKdHpwp5X+m4
	8GirQJRxoM+cqRoBDBWVuwxuqAnEWFhMBggMr8XosNKPciLQdQvFTHCuwPbYji/o/hzz4D6FlTV
	0EmYT/pOgoObD/22GqbejvepUy+1L7FzHQK7MrBcJwpsvdHmtIN2Qx4HgqtdQ=
X-Received: by 2002:a17:90b:540b:b0:38e:e9b:ffa7 with SMTP id 98e67ed59e1d1-38fbc51f1e4mr724861a91.28.1785522249782;
        Fri, 31 Jul 2026 11:24:09 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:d69c:7f00:28b4:311c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8400785eec.10.2026.07.31.11.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:24:09 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts@broadcom.com>,
	Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 0/3] iio: adc: bcm_iproc_adc: Simplify probe error handling
Date: Fri, 31 Jul 2026 23:53:44 +0530
Message-ID: <20260731182347.42888-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Hi,

This series simplifies the probe error handling in bcm_iproc_adc.

Changes in v3:
- Split the changes into three patches.
- Remove the redundant dev_err() after devm_request_threaded_irq().
- Introduce a local device pointer.
- Convert the remaining applicable probe error paths to dev_err_probe().
- Keep the original platform_get_irq() and devm_request_threaded_irq().
- Remove the redundant dev_err() after iproc_adc_enable().
- Convert the iio_device_register() error path to dev_err_probe().

Thanks,
Shahid

Mohammad Shahid (3):
  iio: adc: bcm_iproc_adc: Remove redundant error message after
    devm_request_threaded_irq()
  iio: adc: bcm_iproc_adc: Introduce local device pointer
  iio: adc: bcm_iproc_adc: Convert probe error handling to
    dev_err_probe()

 drivers/iio/adc/bcm_iproc_adc.c | 54 +++++++++++++++------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

-- 
2.43.0

