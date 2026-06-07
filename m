Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B731328E
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857438; cv=none; b=RtFANAStzIzolkhraU9Ln84sUXUtQcTnxdDJGpUApOadQ+9T5T9+T1M3u7s+i82fMd902GO4iEsm821I72IK8LqpDX24qZyAE9Nm2opokmevUlo6j8waKcxz//diVkKAv9wUp4dfRoLuHK9NhldQZ6kqE0THRimARkwPWBb37O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857438; c=relaxed/simple;
	bh=12QKhw9u5pwrqF99zfY9pLn7KRj4JE4SboM6uGGpOj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5d8GF4Y4RDN742wo53ad5BvZ7bbTi34A4lgC9rAqzI6hFGUW53S38xOMEN+bLYnZtWrbknC/uzuw35KqO2LXKjf/PjZhM4Oz0giNgVwaYTMfh77myEi8sfgTwZfajUeogZZF+llPTVWFEpQpbpsSQiQRliEApUmvXuT40zgbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSGRj76Z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSGRj76Z"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso3582595e87.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780857436; x=1781462236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sn+CljYu5ixflRA1SgmEgER7JwRLqObGFjigh04bFJg=;
        b=mSGRj76Z6JoehNOsk7do8eQvZQKuC72DhS4gRfVbQt4YfEz7SxXWAlHftwSjMHIWZp
         fcMSw0/sdzFSCMweDWWhVlSpjuN4ZpUoNZQ2zC9mwPdwyAr5OfwW1aEliN1L4Q1o/jnn
         V3ojSd2N6e6GUJPbZ6w/ZskxhRpzL7otVqoMx2Wq1aMml6gvYn5wVKAVXkk/spFuo11Q
         qd5yfROiB17NA3PiX4fOyqGAi4wmPPptbSSD8uSjlYOV3eYjK/Nl6HZ55NHsUAsu2oZu
         uK42PLVbMBl5mGv49jAsXo774LhTiDqBHu6/3POSGz9pQ4PFhsUmr9bZ6H7MxnaVkbNT
         MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780857436; x=1781462236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn+CljYu5ixflRA1SgmEgER7JwRLqObGFjigh04bFJg=;
        b=dCwVYxGn6h/mDswnhOI4pPpSK728U8tiRS1ZXsPKCcoYI66uFD7Yy6RYDnQvjzR+aP
         0Vu8lkw+y0/E1cA+UEPQucTLY1X65SKTiKQg8T5wY97fmNpcNcnH2iYseRP+llL/ectT
         TC7W/alo+zi7i4On6iYiOTe+ZcgD0M+f+ttB/3oOLPZejYPCbFdEjanzmS2Pk/bQEPGp
         0nsVD0Z6akMpusnLK4XoHICX1PxCgpLazNAksppX33PjPuj99tgdvNVE+r1pZOZ3FXgY
         L8BTv8ulYMR9EXoaRpy7QwgL80Qrc2IO3LR4nui2bYYlUdrwSJxcvo/fuff/JE2nn7pi
         1iqw==
X-Gm-Message-State: AOJu0YxNt0inh+liWKl8I8f+7q+ej+HEDXJGgqYJpG6ERMnohdDxezJy
	3Yo5vg88Rni905MEovQ8mesapNHa7ZbeMBOgFnfk4SZmMjEGrh7gyK+R2uYVVdsb
X-Gm-Gg: Acq92OEqNgqKX8aQPVmodFH2lOhOqyzYmJT/MXgkvBXLt8G9gfxanUnjFp4AaaMu80B
	SAiHzN1tcytIHVC05Lt0FPs0ZBkTkAXokmrpSa0pUy0olhz8YICrDdUeSv10AKHsDo19fl7/3T7
	lNxRZTDxPCoMubhmNBc32efbZy2Z4tsCXMHr0PkzY7diZEubo/d4IyQL1Hqh7Rl4MmhzY/181v3
	LVJnL9bJ6n56KBo+R+RMZdOUKQjFWpidiEXCww7LUTrvQ2KJstOZd65o6IlD+af7LPmSqDUZ7lU
	RNQQW6JvhcBEM0phzUL5/cJieIMeRAkpbH1AfizBD9i5Tfhs/7WMFbK7mOk+a7aR28Q9KXIgdKf
	iF9sJnPGVlxFh2+p/8WkZCugn2qciZcyum3TelHd1QWEtqpLEHAbSucrPV9AMPkxw6uE4w2CaWq
	EKPWnKUbEwu4ofQ0p3ujWWgGtvc7eb5KZUNXra5G+Ij3ing8hrEFAc2h496fXrCkMOj/0=
X-Received: by 2002:ac2:51c9:0:b0:5aa:265f:acd0 with SMTP id 2adb3069b0e04-5aa87c1a006mr3168512e87.39.1780857435867;
        Sun, 07 Jun 2026 11:37:15 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:efe3:f920:63b7:5b7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc426sm3240809e87.26.2026.06.07.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 11:37:15 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jorge.marques@analog.com,
	antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz,
	wens@kernel.org,
	sakari.ailus@linux.intel.com,
	linusw@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 0/3] iio: adc: Extend ti-ads1100 driver
Date: Sun,  7 Jun 2026 20:35:39 +0200
Message-ID: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend ADS 1100 driver to support ADS1110, which is a pin-to-pin 
compatible device with higher resolution. This patch also updates the 
device tree bindings and Kconfig description to reflect the new 
supported device.

Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
---
jszczudlo (3):
  dt-bindings: iio: adc: Update title and enum
  iio: adc: Update Kconfig description for TI_ADS1100
  iio: adc: Add ti-ads1110 support to ti-ads1100 driver

 .../bindings/iio/adc/ti,ads1100.yaml          |   3 +-
 drivers/iio/adc/Kconfig                       |   6 +-
 drivers/iio/adc/ti-ads1100.c                  | 165 +++++++++++++-----
 3 files changed, 131 insertions(+), 43 deletions(-)

-- 
2.47.3

