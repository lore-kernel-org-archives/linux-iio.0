Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFB379C3D
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659749; cv=none; b=KDGkhkzcvVBM4S1oA+ysiTLUfIglpRUWpjKMSIBhtGKbjNUFnC1QgkYfGX5s0eA1c2H+d6gZyW+xauw+Cx4nt9NMhpTjsK26XUhlwaMCIuoUWjqeMbaV73VflexwkN+yXf47lYwsXVANwobMlUGoTcOoz0dI0p3nUf09DcJAvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659749; c=relaxed/simple;
	bh=6cU1utVTOBgVJVUtxCofcenB3rOuCBtz+uM6g9cjRG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lYdBAsmpkqlGFDOkwIFeKE4Ef4cxQTSZbB32ULKX0XmLcR3cnjnwkhYrgW4O370LVcuId6ZN3099i2MSxS33GbPVLMsZx9MlCZG875W4jE2RS2uBXWcOcxlzs3dDMvetbQDWi6RDxUThVq3pIz8KyxWtPS+ixlFk/ZL5cv1QQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc6WF0b/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc6WF0b/"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso12750338a12.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778659745; x=1779264545; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hbw67revHUjmNsphID1mbAlYMpamHh2eKQtH/zH6ok0=;
        b=mc6WF0b/6s7L0krPqEyAnQhH74q9O+gFvoLSgLpy1S1oc2xu91MThgam57Ql3wwTuh
         knwPKmThSTv7oqtfdTEmDb8cZ+TPcqcfxnRERU1BUCznQHUalOd5f2TY6hSqHfaEEsQ1
         KV2g9J3mi2YhXWzISkJ1zGCiQVbUxmIwUOINNmve6SP2pY+klBuUS0PPyHx56IZsV5Jw
         aVmTkfS7Hr2hEO1CWgUkzDaHN5sNLm/Oh3p4FZ9uYY7W66UR7uNS5pxw9K1tQqTG99SO
         wAx1HgzvQ3Xz+LBo36LqDbrCtEMZeYaiVi8FHtuggbA8rVC6D9eWQICaFKfQlkCC594l
         3RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659745; x=1779264545;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hbw67revHUjmNsphID1mbAlYMpamHh2eKQtH/zH6ok0=;
        b=eyEFRBrEHNeo4S7lnyStR3crHetdiXRwW4k1E/vp3crTFcxdxbgwA6jwa/ef02UGq1
         7g5nv5K85Mmujn+GwJ18yIYs378xUP9BKZwjtYFDIBCftNDY/Jj6zXj8X4xxDAZBiw+H
         h4TR3n7QuVmojsQxr3vuNQKy07k6DQTvpNStUc+yA8n9t4Jh8OEBvtdrQSRConUgSk/h
         VcZMrcUeyPirH6CJgCkvTK4zLS/eUqtaQjaz+xKzd0jD+1P1rTEn/9DPWM982107+MCB
         wYyyKq/YH+QJRtx0IstkBSk5FEhmdY59Z2jU8aOMobYYJqtYifJdB5UOuKzRJgmNIo/S
         upog==
X-Gm-Message-State: AOJu0YxmUOayMuEAxdp9kwUX3WaUSVqmqRlvGLzLoT02fpNISlzUhzXm
	KRPKioXMrN9XQPlTZB+vneLsxhEx+dTzDAp95VTv88LmBaPMcGGqnJ3wXDIiFj2B
X-Gm-Gg: Acq92OEm1qtwSiZ9jVGW94UuW3wNybiRA5uXPoIncIgGYqBbQqLKSWa8FJy23sOT8EQ
	XVH5dqDIbwfHCRqciw/VxztUsPc1AwAPPY/cBfuoW0iloJhiAejj/w8qu+z2dpRWkfrRnxuyPja
	h7SaLVLHYbrhN96jWnPX5/gAmakISCVKsa+MmDCJ/r0a/hlghubHIWemAQZq+QrmUR0bkyvgTDD
	EBL9fgr9vQnqmDSP34Cb3M7PTssMpySUpwdSDErDF+LxgiVBgm41+377NihfFmodn51xLTcWb2f
	1Pe4MMjiWECYFKLOcismA/LVHsc0eraiCD2u6U10KmEtViBg3sNi33UW6fiDHUdq22gsk5G4qWj
	vn9WlZUrP2CzYtTkilgSpYLPWDqxLuaYTNkB1Kkv1WlzrKKVKk1fNu8ezHzxwBnlf0eUGZiFQ45
	5S0qf+s+vJwdDFO0klLzyM9Fpi3YM=
X-Received: by 2002:a05:6402:e0f:b0:671:121e:dd4a with SMTP id 4fb4d7f45d1cf-682a6e08183mr863286a12.5.1778659745229;
        Wed, 13 May 2026 01:09:05 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b6a3f3sm5852447a12.10.2026.05.13.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:09:03 -0700 (PDT)
Date: Wed, 13 May 2026 10:09:02 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [RFC PATCH v2 0/2] iio: light: add support for Broadcom APDS9999
Message-ID: <cover.1778659152.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add IIO driver and DT binding for the Broadcom APDS9999 ambient light
and proximity sensor. The green channel uses optical coating technology
to approximate the human eye spectral response for ALS/lux measurements.
IIO_INTENSITY channels are also provided for red, green, blue, and
clear/IR so userspace can compute its own weighted lux.

Questions for reviewers:
  1. Is the green channel as an ALS/lux approximation acceptable given
     the datasheet's claim of optical coating to emulate V(lambda)?
  2. Is the IIO_INTENSITY channel layout correct? (red, green, blue,
     clear with modifiers, no scale)
  3. Should the binding be merged with avago,apds9300.yaml or kept
     separate given the extra vled-supply?

v2:
  - Added IIO_INTENSITY channels for R, G, B, clear
  - Switched to guard(mutex)(), devm_mutex_init(), dev_err_probe()
  - Replaced remove() with devm_add_action_or_reset()
  - Don't fail probe on PART_ID mismatch (fallback compatibles)
  - Replaced manual shifts with FIELD_PREP() / GENMASK
  - Used get_unaligned_le24(), sizeof(buf), NSEC_PER_SEC, fsleep()
  - Named gain register values, explicit resolution enum values
  - Removed section comments, grouped bit defines under registers
  - Squashed Kconfig/Makefile into driver patch
  - Split MAINTAINERS entry across patches
  - DT binding: added vled-supply, interrupts, required vdd-supply
  - DT binding: fixed title, added blank lines, full description
  - Dropped "DT binding" duplication from binding commit subject

Link to v1: https://lore.kernel.org/linux-iio/cover.1778491503.git.azpijr@gmail.com/

Jose A. Perez de Azpillaga (2):
  dt-bindings: iio: light: add Broadcom APDS9999
  iio: light: add support for APDS9999 sensor

 .../bindings/iio/light/brcm,apds9999.yaml     |  53 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/apds9999.c                  | 344 ++++++++++++++++++
 5 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
 create mode 100644 drivers/iio/light/apds9999.c


-- 
jose a. p-a
