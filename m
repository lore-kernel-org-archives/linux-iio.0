Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A7A331209
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666075; cv=none; b=WkzRTLvwnzeOixc9Ny5t7PYNzvEfcZ6g75okWzWXzbqwAOAyrYfM9lFwtU0jXfxHDHGbPjR6segA4P48OO41X5YDde0dmlSVWBLMW+w7VbMC1prxZskLn0+G81PBYZgJ9qalRIBQzPGbqYa8SDeSRWqyecfN5I18rhqg0SUttmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666075; c=relaxed/simple;
	bh=s5uMc9KDVuu1RbBuzJ1/G61PpYFhV7uKAfbrxSf70rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S97PDFEELSfzLjbKtiCZP7HYpaYdZHJxvbZTa+BXTth23C2Rzcwf5ME5wvrf/fu+CCt98hW7a0eTR00hXVq2hhX9xNkYTgyWgZwklAXKfmIPs9Xd297mdEzYvpRZU8IyIhrS4og9gWiOKj5qjATfNStOatxFfWyBur9hyJFEo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO/wUGrP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO/wUGrP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891f625344so23481485e9.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777666072; x=1778270872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tXZjRzLDEMalEOoixvymciaYgP38pfoNJeJznChLNM=;
        b=dO/wUGrP758ZnnVexyM1Vt4EWGoqZctvbiIhVbAzDaZiYSeI03K9ZwSpzKCzefM2FM
         jA27gZNMIKuGfgXLGz0UWMZRtijmY/4fFqAVlgIrV3RixWUtvnzpkgQoVK8OrJtgVJDk
         bEbSk926rSSFWWuRz0fkKx3hoYM/D8tm/nN6Vp8yR3VJPi/TFdwS+08gFPmc3i9U6Xiq
         qechsKTK2Eb5pFOPshrRpHdzHdH5MDmNDuj8VVeD2qbUSf0dCWLgHQ8xkryxGYkJj2gZ
         SQ4jzswQrnjhqEgYrXwiAM/oQwkPhynSeyyT9mqzkuhVPObDlGynzgutI1Ml/SN74pEZ
         pO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777666072; x=1778270872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tXZjRzLDEMalEOoixvymciaYgP38pfoNJeJznChLNM=;
        b=WCmeYn3+1pLhWKFud6nXu4MrFn0puujP7xgRuj14URNjvZPrhp+0Oob8gvrT8tZhxc
         tVCG4MAxqphc8z/5naD0KjlnProjhtZ2v8+Z/R7Bd/xYisTGXxMIKzm+u8CV7RYEUtK6
         qB1lczsU6WCNW/zlSVwz8pC/Pwk/K3la+9DN6+J9Wns9LhWXFmvvB8Z9mjyR1WgxdO82
         bGLEGelBqlovfp7k++EotFpWP7jK4Cg2RCXlcgLEnpZZexNeKs+5XAV6LL/eVU4yxWKL
         EsEXFmrS0L93P6+kUdA8cSHOAQZnU3lw+RiWGLJmlQ49qnQ1B5xktxP5Dfew0QTbdIHd
         0Zaw==
X-Forwarded-Encrypted: i=1; AFNElJ8h6aDBOXFf3gN5oLUP7rsBcGC+fr7rKZHOBXCM0hI8F+hPKxbfJldLhmwPhDbOaVmlNY7s2LfFKKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdR6OfdtFVLyerCfMruG1H75U0sNRzeF/+IoplBFlA0ndoAGd6
	bwx1O2X0bqOzhIWpor6ZW9EPSl+xJciPCvbi7CAhOWRDW4NhP8aRf1Vt
X-Gm-Gg: AeBDietXGgxo67SMkOSVWZfnvgUmOTeMxv7O0CBTlZ9aHLGLpz7kRatRzGjOJQZvfMu
	uOxKD8HqhUAIImjy3AXNV8Bv1D/ALh1aeMs+qipy/PLXcsRV41pvIFRW/I9vI2eLOiFFeok41bP
	NtZthgjuF1kjPf3oMQUi9gK1LryJSwZA0LqGOPYHKKGVAqpfxhkCnLEFI1+kY3RBTnnIgpQIrKD
	IWCm6dZGRkbcVVKdlE1vHJZUbZFatC2RwbFXdrpqcWGxlyVMvrnqe/VTFl540YsdRT5watRyTGi
	O4tF9w0gMPq/k2m0akcb4w9lfqGzKqKo5iFAtf8bXnuRfTNDkFBkY3VcpUm7y1FCMx8dbIpsd/7
	cqt9w8BRPaXY2toIIn9tA2M7kg+Ls8GDPye3FU/W7FaKeifomHTZWESQ2YHqspPAmh0iwWDvkgw
	gwHxua+7GT
X-Received: by 2002:a05:600c:46ca:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-48a97098a3bmr12021485e9.3.1777666072150;
        Fri, 01 May 2026 13:07:52 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::3323])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm26829325e9.2.2026.05.01.13.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:07:51 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor.dooley@microchip.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] counter: add GPIO-based quadrature encoder driver
Date: Fri,  1 May 2026 22:07:46 +0200
Message-ID: <20260501200749.20029-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new counter subsystem driver that implements
quadrature encoder position tracking using plain GPIO pins with
edge-triggered interrupts.

The driver is intended for low to medium speed rotary encoders where
hardware counter peripherals (eQEP, FTM, etc.) are unavailable or
already in use. It targets the same use-cases as interrupt-cnt.c but
provides full quadrature decoding instead of simple pulse counting.

Features:
  - X1, X2, X4 quadrature decoding and pulse-direction mode
  - Optional index signal for zero-reset
  - Configurable ceiling (position clamping)
  - Standard counter subsystem sysfs + chrdev interface
  - Enable/disable via sysfs with IRQ gating

Tested on TI AM64x (Cortex-A53) with a motor-driven rotary encoder
at up to 2 kHz quadrature edge rate.

Changes in v3:
  - Pick up Acked-by: Conor Dooley on the DT binding patch.
  - No code changes.

Changes in v2:
  - DT binding: rephrase description to describe hardware, not
    driver/sysfs behaviour (Conor Dooley)
  - DT binding: drop redundant example without index GPIO (Conor Dooley)

Wadim Mueller (3):
  dt-bindings: counter: add gpio-quadrature-encoder binding
  counter: add GPIO-based quadrature encoder driver
  MAINTAINERS: add entry for GPIO quadrature encoder counter driver

 .../counter/gpio-quadrature-encoder.yaml      |  60 ++
 MAINTAINERS                                   |   7 +
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/gpio-quadrature-encoder.c     | 710 ++++++++++++++++++
 5 files changed, 793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
 create mode 100644 drivers/counter/gpio-quadrature-encoder.c

-- 
2.52.0

