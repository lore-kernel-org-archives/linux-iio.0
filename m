Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1827C162
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781057108; cv=none; b=UM2Oo/AU/QcuFxlfHD1l4r+WR3kuidHCGBMHmIg9FBbhSms2BijSHwJXsad+oCGrKJ+UDR3ng0kZz7KVrCEFDjwVamE1hSP7mtIguIehAofmgWxF5BeVv9c/7+r2hoglJnuKyMpIfBjdNy+8uDYmkk0utPIH78St41xAt1ZkuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781057108; c=relaxed/simple;
	bh=kHL6K4ZLeELDuszBbDoOYeeWsA/Tnp/43gjMSba75pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7gAvFtWPN6hihAuCxWPEHGI4AxG6gdxELaILtXD3ROeqKDq2FdxKpalGK9rL5baoSDZ9dA21zOcBvNwKJWKlwb3h92LmJjgYTgTeL+u/If4KF4fOcePjX7LG6QuerrBD08CCKxEaHRIKSv2GFoqpIBvqHH+/rocxSGEZJXgKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEsk21wC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEsk21wC"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9157ec935c5so945655985a.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 19:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781057106; x=1781661906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+xGOAkYk4QnjImnBeAxiWKERcgISWjEuIc16pmSjAg=;
        b=iEsk21wC1WPlQrDAKuuRPO4qZwIoIbHefARBPdR4AVGaHXIy6olAaFs7uuZr24IGbx
         pZDo94SRVTVt7CR3fvTZdMNDUWqKJpq/buZFY2DqdsPM4LENVztnB1ctFyWtkOdiuwdZ
         977uElQUV90yJDvN1tm1jXHsK87+0Ojip25AWARG5+P42gsHY/mbdg8xYxu1w+QkmbP5
         xrnC1rt+8QrKOl9uV+00kL62y8rH1rNcMkGCeKpYzvsWDDlEHfigwmfIcSoKwkdrkfUt
         k36j8+ZxkokKH/LRj/gR5C2DVwOsls57/gl6hLgF39Ks9dnLgMIZs0BIaoQA7ZO4+kt8
         5xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781057106; x=1781661906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+xGOAkYk4QnjImnBeAxiWKERcgISWjEuIc16pmSjAg=;
        b=lM56Jyy6GCU2dOmZBe1dVrUVme+AEfbqWV1UXbDUoEG1OnzlK/l/ljb/xnsnhHKsl9
         fhFurNKCcbiF1W7fxpYOmKufb6QtckEHTuR4+teTKdauNSwHrBZhH4JNed0qIkY7lDhg
         M7nrp5lQvnkRoYCbDfcGSh/3MqTqJY8c8rgyjHESX8XAs1QfSV1fod495tAIFdYkKufl
         3AmfoKqATb6Hp15XREzNoihkJs6jbGrIYHHieHAE4tPHz8rhgzZimhAxhvImdW338nD9
         Y9QD50X0eaJwX1Sq0O8fhABEb9arKnGEokBdzCGvgquFWEgAICRPbeHB/r52OvyReXAr
         CfFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VpPNqsCsnK4B6q8XARrGYVMnG40empm2zVh48apJ6ailATHTckM89SvN+Z8fp7tHTyKtY/RMNk4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuT/gJaVMcSJ8aXlImAxSyBneszrodI0r2UPCSuC2Ck+H9sCpM
	Y+cKuwDCuW8oVwaGSBeLYb3UV7e2moapktcL00/frJHVKGscbpjgtuhB
X-Gm-Gg: Acq92OEZECkX9gwS3ADQoQd84Iia+mxy0CSQhhR10tuQPVXkZz92Fa9QiGg15fom7Wo
	RYulgGpLP9erbmK0bmsKS7F/6flSvuTLyqhJkYZpB16WuGFEBiVrGeV9vAACfusBT2hj6ckZH43
	jw2D5pMww66ugTohzjoexlW0y+fMxAtDMu08dfCKBygq9r2UlAgKmFYdOY7UHOcM/SHefKC2mpP
	Lrdiuvnje7lWo9AzB/wdfJEG4pxEOM9VVNg/a13a94fRV8uxPIzrpQ1pFo83IvkOPYN6thk7L3L
	jBrobIdp9oSGLuu7wB4qlMukPm1MrY9TitrFqiHBRT0OohpzXjS2BUMdSE2EzadJK6Cx4EH3uWX
	5EYpDX/WfVicvn3lJTmcCPDPPc/YUEy3i31yuvjNv15SDQCtoNEX3ZOyvMPs9FZI2W19SWqMkuk
	DmU8aKtb0pfh5545TQOw74yPO1+ND/4wsCUUgxnko1Fq7aHgs=
X-Received: by 2002:a05:620a:454b:b0:914:9ecb:9adb with SMTP id af79cd13be357-915a9dd8eb5mr3417975385a.50.1781057106318;
        Tue, 09 Jun 2026 19:05:06 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a40d566sm2267004985a.47.2026.06.09.19.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:05:05 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Adamian <adamianlouis@gmail.com>
Subject: [PATCH v2 0/2] iio: pressure: ms5637: Add variant specific
Date: Tue,  9 Jun 2026 22:04:56 -0400
Message-ID: <20260610020458.104818-1-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series adds temperature compensation and pressure scaling for the
MS5637 series (02B, 30BA), MS5803 series (01BA, 02BA, 05BA, 14BA, 30BA),
MS5805, MS5837 series (02BA, 30BA), and MS8607. These all share the same
temperature compensation formula, but the constants differ between
devices. This series adds a ms_tp_comp_consts structure to store these
per-device differences and applies the compensation.

---
Changes in v2:
- Rebased on top of the togreg branch in iio.git.

Patch 1:
- Add SPI bindings for the MS5803 family.
- Add compatible strings for the ms5637-02ba and ms5837-02ba.
- Add vdd-supply as a requirement

Patch 2:
- Fix the sens2 calculation in the 2nd order temperature compensation.
- Fix the pressure scaling in ms5637_read_raw.
- Add datasheet citations to each compensation constant structure
initialization.
- Addressed automated review feedback from Sashiko
- Formatting
 - Remove unrelated formatting changes.
 - Change ms_tp_data struct initializations to match the existing
   format.
 - Sort i2c_device_id alphabetically.

Link to v1: https://lore.kernel.org/linux-iio/20260526185612.35048-2-adamianlouis@gmail.com/

Thank you, Jonathan, for the comments on v1.

Best regards,
Louis

Louis Adamian (2):
  dt-bindings: iio: pressure: Add MS5637
  iio: pressure: ms5637: Add variant specific temperature compensation

 .../bindings/iio/pressure/meas,ms5637.yaml    |  87 ++++
 .../devicetree/bindings/trivial-devices.yaml  |  10 -
 .../iio/common/ms_sensors/ms_sensors_i2c.c    |  62 ++-
 .../iio/common/ms_sensors/ms_sensors_i2c.h    |  48 +++
 drivers/iio/pressure/ms5637.c                 | 388 +++++++++++++++++-
 5 files changed, 552 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml

-- 
2.54.0

