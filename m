Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C196035E926
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372532; cv=none; b=i964kfUVRkxoV5kOXQ70T8QqqdRzbrxt+KKZZUeIotEy99ASVDNlNznn6LOyl7pKzUy0XdsYNcm/8qhm+8VqoewbGpI01MOu4A1OhfMlPjsUtfE4QC4j4Vi7fIfOQBqtMSwS2yC8jILPvpVUrd27FtlMZFUI0I4URUYIzyTXqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372532; c=relaxed/simple;
	bh=LAkTCz43UQEed8AC0yIlC6VyfdlhXSIUwdiaWS2qlqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKbf37JZmsZVLcyefmgz2F5yx7COssce8W+pFxCFty4/lP9yU2Q38fN5/syMAJ+B+Jth4ntJN1xakF/FZMOuX3UuiIvkDHxF+QBf3I1GxaqzHb2ZR+9zbg7ze3khBtVYUvlhedIcKHC87Rl6MPMxt782YBlBEP+Dcf4aVnLc7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcyTnzvv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcyTnzvv"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-672beb5c6dfso162491a12.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776372529; x=1776977329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FazoiNohDzQZ1nf68a/PLQwtU5f7+/5H8LcJBdU4co=;
        b=hcyTnzvvs8cQsom4xVgAHcWFxPBRyX+t1iuSUUMshGp+fQTaur9Srm9VI2V7Yw7Cl0
         jplC9hyRVzjOz60fKGnKIEGWUq328H1Uh8tiUAF8gys3R1SAQHfXQHmQqPVbLF+DU2vu
         vkVLDmrM4FQFPFl5A72372kyXGlgwUz7YKcYDWIsqt4HGIopsWvItFqHnOJ93oGip2td
         5i6eXwepktAks/80gOusOQLsUOs/RI/ATwgj9ngalc6w/MhIYlZRZRyEzDvp44vjPVNG
         y0pEFMUQWe7rlY1LoyOdZJpJlOpUFXn0zFcHN9Qng+AkLCwqMOpDOBVejaEfbbTpdzhB
         9Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776372529; x=1776977329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FazoiNohDzQZ1nf68a/PLQwtU5f7+/5H8LcJBdU4co=;
        b=VGMIdfYs3hiMd3J8Pd1JQmcLrwoLD7nDY0mZXdz0PgIjRkKfmhVfCR8SsbKWyWX16p
         tzLJuP6GTAM1BZ7zF52cUP5eMVwYPxNQupfl0ghgojukfgRgQOy1YpjEb0dGvxW/BmeD
         Cgd7e9PF5KtwtMfz5SdAatFXwW0+yFyQtGBD6d+1o5su1axRUfhuCKJWSyuD45f9zhPo
         q0Ls/H6cmLU/8eoznyb/OiVRjdtM1YN/apf0QKbqYgFnTW+rb2pu81G9L+8qYxsK2Lqs
         zcgAu3JCmAq4t3UPWHuv0cTRVVqq43vy5JebCk0ZCj9OpUQdrDPf3ZbTAma1FEcJngMa
         bgpw==
X-Forwarded-Encrypted: i=1; AFNElJ8LN5WquujBK+3g4QWbgU0xaUxyRFFFyDohs+gj5BTH0sCkjtDyL17ovrJ1GAPXHKT9VaI+uQPijMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3sBrSovPk7oxEswvAest/uSt1k2jAxZQHcTAxlCaKANLK36K
	n1A9qWO9nUW/wKqtFT15HiBE4Q0ASHotqbDUxxCEDKz8ZcMOSlkxLdyM
X-Gm-Gg: AeBDietgK3PJ9tziXJ84FcZ89aXwfbX2XGOf1hZXp+SBOOhWoIpoQ1xW9OVxVnl5ZTk
	ObCl8yH+s7FW1/eDWlO6FdK2FFUng2xNDdhpK+Y7JxHMjnzen+8685O3JROayccPCzQeD+Xw+UP
	o7VvPRVL1xwhOKKYpTZ2H5ZWX2tmncazyWX3a7b8ftFR3BPZ4LR3ww95O6+zUHLVGhlBO4QlV0o
	ReNBDw4mDXgkwER+iMaikR2FPjIOL2u4pHktU8zxFu0dOo8jJTEGHz3za/+iSNzJxo0j5AXXP9c
	/Q0VNAaPqWFMTS5G4HJcQiSD5wAApWjvtKlBphg//jjD2ixq1ZefVd9ndmnNxLWr/MOjRZFQIml
	stWazgoVeRub//V0IfDlYK6BrmVHKX/YYTdhq3MNoj2DR0vVNLdqmFz3PQyZEZEyEvB4yxc7c7i
	12SAKfAtjE
X-Received: by 2002:a05:6402:1d54:b0:66e:37b0:f802 with SMTP id 4fb4d7f45d1cf-672bfdc74c4mr98819a12.21.1776372529025;
        Thu, 16 Apr 2026 13:48:49 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::d908])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6723800b6f1sm1437962a12.26.2026.04.16.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:48:48 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH 0/3] counter: add GPIO-based quadrature encoder driver
Date: Thu, 16 Apr 2026 22:48:16 +0200
Message-ID: <cover.1776372319.git.wafgo01@gmail.com>
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
already in use.  It targets the same use-cases as interrupt-cnt.c but
provides full quadrature decoding instead of simple pulse counting.

Features:
  - X1, X2, X4 quadrature decoding and pulse-direction mode
  - Optional index signal for zero-reset
  - Configurable ceiling (position clamping)
  - Standard counter subsystem sysfs + chrdev interface
  - Enable/disable via sysfs with IRQ gating

Tested on TI AM64x (Cortex-A53) with a motor-driven rotary encoder
at up to 2 kHz quadrature edge rate.

Wadim Mueller (3):
  dt-bindings: counter: add gpio-quadrature-encoder binding
  counter: add GPIO-based quadrature encoder driver
  MAINTAINERS: add entry for GPIO quadrature encoder counter driver

 .../counter/gpio-quadrature-encoder.yaml      |  69 ++
 MAINTAINERS                                   |   7 +
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/gpio-quadrature-encoder.c     | 710 ++++++++++++++++++
 5 files changed, 802 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
 create mode 100644 drivers/counter/gpio-quadrature-encoder.c

-- 
2.52.0

