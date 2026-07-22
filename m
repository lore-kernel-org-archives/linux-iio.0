Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADF41D134
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737379; cv=none; b=PCUp/pcJdl2qxKY0Zr+gviSdiaKWy7V6wLSaLMkQMuVIiPcCirRB45bRVuCoXRMQVlQ+W8MW+c+atSfW/fTcJdjk3+6J3hOjk7V0kwyh4+QBG28xcF9/X05K4/H81y5+Zl1vzVN6EWE0N7oQQ38SJ3yMMoR3Ibiag8YZpeqRaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737379; c=relaxed/simple;
	bh=Bh80QIUsMcjVvqkk/S1K+dBLA6lgW2V3OlqH4ilfOAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXaXZ0+xEQFtUTQWGLrB1+7UiUm/eLm5yP1kjGzlRdi1ufW3E+x7t9WHM2fuWd++gkhg4U49B7KK4hMT1zD9GcMcanEFayogPbEHCYbivUhSS0sJrxr4wSMLr7dXZtRQ+gS59aXMI3l2Aw+7t6iLot05++66ejwp+xB5yFof0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKsvUJ5n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKsvUJ5n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc73e322dbso151539175ad.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784737377; x=1785342177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1waP2JIJ8dP/NAS64B6HZCiGC7Uix8ac6PtUU+oMDLc=;
        b=WKsvUJ5nowu+FcpRwx5ABZI+McnW3CTegw64ieacoMSvdUVMrCeIqzd1K1lqTfqwtU
         fXwI0Nvt73eZJhKruu/pNv4lWbFOYBM1is75PYm9FpT2OofFGxaNc8kevdVHDpka2Eok
         I4MwGOG31+pRrsfGHnz9PI6x033XeLast9vwCSjl/Inyv8I6dAqV/+BSq5HzM2MVHV71
         Xm2voHUYLEKtEBx31cebyshHWcN0qsrkE4sBfSCUIytckeKJA8Gpbx9xEj0ZQ0F70rrQ
         q8Oxk8h5aT7FVXNJ3qoloDmEQvhuR1qZuvEamK/ttBsbyUPKelEfzSK0XN/DO9hCrHyV
         sgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737377; x=1785342177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1waP2JIJ8dP/NAS64B6HZCiGC7Uix8ac6PtUU+oMDLc=;
        b=nINOkqrrtdD7sT5ZUp+nqlrm97Vm5hPHQn/QZLFof7Bv06FIPpssSdU4E97nwAwj98
         pVb82XGPFF4/K/KQ0L04DmnfBYOwwP1CbIgpIZY/uxVECiHRSP9e/eRgizzjcjmTHUzr
         xkp8ERy8xpcmsMt8a1LnL7BUxXBj+qgsadW9z+3iNMnwPhZq2Y7ceS4icxdsR3DTPrYj
         sEVWR5EwqnoAHKjGm5mHBVVA4IRNE6iJ28MM6G5zqKR4DW/gqwZbxNnXBhDOz+Tzy/Dj
         d7N6+h/BKUzHbX+tOR0ty8a9vjb2pdAWGVMRd4Vsug37PvV9AgUJp8EHIJPt4ABVGXER
         PiSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBxRSFyHhwVhtZ3KRisjRqIQk1EANMT+bAK9iFXY7OyqHcFu6m3/6kpArFTIWnPjnmHUXuT/RNt6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3etamvsymXeofpAk6xGgDV/FqAcFQAPM98WoqIgNCNgnZDlYi
	BqetAfAUZVy05VicwZMEEclgvxClcbOIDXDgVV41qkq4WDPSvzjE840=
X-Gm-Gg: AR+sD13Fbrg5jrqYguhpODqelCCfoxkU7s1kHj7NdIHu8NFy85bQAvx4vM6UaLDfHqa
	obyhF4A8JEMmAkokYQEvFWATPm4l4x4bOaOdjuFDJpUvJ81CAA4x9mK0+XSjcarXgikadp17hAc
	QJc1Dbde2JtpuheVsXLpGFkg58WQFB/HuHSMfoORvC8rqw8ANDBoCnTvJejBu/lmb63JszC2//P
	tyTf719cEEAKV0hjvbwy/J/Le5KzCt7HeAiv6tr69XvvakFk9+8zcu5lTQ0+eyZE6VAUX69G+93
	XIoyV2yQkL5qSf3biTa3iLWaT7zXMjX/HlTAGHLye+q3r7d0rrg6fGxC07Uwc59QdCvy0nFV3AO
	R7UNmcqa6BZ6Gj3cOfqa5cVGHnNNWsz5+6M0fG27mkz7/a/H/BHt43oQ1slwsmnBNvW+uL9DZ8f
	LkD/YaoinX/wp2WvPUhiiTb8BMGcS0xrv/RPJdonFm38qN2/pAlVAh
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:66c5:68cc with SMTP id adf61e73a8af0-3c3ad7aa9famr25980729637.21.1784737377060;
        Wed, 22 Jul 2026 09:22:57 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1e3d9sm9260471eec.5.2026.07.22.09.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:22:56 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 0/3] iio: light: gp2ap002: runtime PM and error path fixes
Date: Wed, 22 Jul 2026 21:52:44 +0530
Message-Id: <20260722162247.8229-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes three issues in the gp2ap002 driver, all present
since the driver was introduced.

Patch 1 fixes an unbalanced runtime PM reference count reachable from
userspace by writing the event enable attribute twice with the same
value, as the IIO core does not deduplicate such writes.

Patch 2 fixes the runtime suspend error path leaving the IRQ disable
depth unbalanced, permanently disabling proximity events after a
failed suspend.

Patch 3 fixes regulator enable leaks in the runtime resume error
paths, which matters as the supplies may be shared with other
devices.

Regards,
Nikhil Gautam

Changes in v2:
- Removed new lines between Tags as per Andy's comment
- Removed dup call pm_runtime_mark_last_busy() in
  gp2ap002_write_event_config() as already handled in
  pm_runtime_put_autosuspend() as per Andy's comment

Nikhil Gautam (3):
  iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event
    writes
  iio: light: gp2ap002: re-enable irq if runtime suspend fails
  iio: light: gp2ap002: Fix regulator leaks in runtime resume error path

 drivers/iio/light/gp2ap002.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.39.5

