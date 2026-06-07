Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71533F5AE
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875933; cv=none; b=EMkpKulxfOqpyl0z7NR1Fk3ffcb8o8aLT94/3sxvq/KNgCKTy+ovwHth6ZLqoA/hy/afNmQzUEhZhywz2muIt1MGEZYvc84YVCDZp8B3IuB2A6DiDcgIONJ8F6vXh+pUbBli0OUmdrhNc4VeS10lA1iCTX6CbBbnaICdz9Zoo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875933; c=relaxed/simple;
	bh=Io7D5KkHYqvenZqIL6Z7P+QZrmOBRoracJ76uWfi0JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfpk8hJHdANnBgF0xap1rzDFrEiW1CHom7l6gO2WF/smSwS+n9bQC3T7tnRqEnooum7hwS0PdbujylWvMTrQ0GlHELstdENLiak+P6Bwp4oEjFalagLMf5CqiguCuuaczYX6afcK2cHfvriIjPKLpKyIQyftyZxT0y17EAFqeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvvgAz8n; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvvgAz8n"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so2474653a91.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780875931; x=1781480731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5OiZytJs8xCHWwIF7i0RCUYGoDtUsdsRhvMvvj/Vak=;
        b=FvvgAz8naXUNVfwWOhxdTpGzgl5nfFCrU3tbfBrRCrRbNy4Uhq5r5hmo6BGxt/rGxN
         HWkJY7otsUGfN6nFAW9f0eOV6kBVj3deIHXi11F3R2RF4RXLevcnG1aQlMzjieams9vJ
         xVLW9f9hkRbQJSr6Ugxli5gKwWXuKQNlPn6quWyPfMbgu1xNBBNIkkqrJYBWQY8fcoFq
         t85yA/0sRdIWx0TNaDU7o8VsRIXihAZiFdUqTxGxVk55Ujve/1wmD1hCoXiSw1zrhsWN
         DcMcPWC8aEZaxUaAtenWQaxdAC/NZvRnCm+r2TVje1pHmp6wy4BR5S5iUGQek9CZS5I2
         RfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780875931; x=1781480731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5OiZytJs8xCHWwIF7i0RCUYGoDtUsdsRhvMvvj/Vak=;
        b=Tot3Ms1aTrp7xIkBmIr4BhKzZUC965EL98IlOcYcSedVa+TE67d4YkHIf6tMyFFPM/
         h3+6DlEZQT1emAbJWN0bG5W123ys5/YY4+KSbPR1p4+msbeyx/eGAvNv1lQMw+2z7HAs
         t2+NDa1gNv4aJqOL3BrdRXHv3tp97kas5hWsTdldg2USpM37hH43wI9O2w8K/HHz5Hx4
         H1I7wopGsrgH+5zC0O3X4C1RqTWzVtXEE8jrMXh5985XYiCUrvTMa4aPTiLLJ+5HoTCy
         zkko+esg4insrQoDE6dxOQ00IuUn0ic+QjKPC3PkpuJ5F38oB9iiOD7VpmIvVQDPdYSq
         Zfvg==
X-Forwarded-Encrypted: i=1; AFNElJ+Mos8+J49hFi0aMCmjjVluvBRTokTZgOjX4KVKyXLP/cQsQj18q2VktHrfiE+uuIJh4etvgEGXdX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNrQY44r9wGSJQzBS0lmUI2NhNtpVI+9sJiOaCHkmmSl/oGrh
	+N40+q/hxjIDjeJZN3LsZN48dZXkjn+hC9fjsTAgsjx5XcouAudiAeN1LoQT/YxVEAQ=
X-Gm-Gg: Acq92OGTnXzA2i6pgt9gP38XOV+RMdNzA4t+aBkJUBHARMfwl1rG6CwYKrQTa24fFqG
	pabxvuVU3wsceRBnn8ypouZFilmYpGkoW2gmJAO/sYvyY8G3yEE/3yeaTFw4Vh4wRzmN+HRPNHn
	h36FQmK4c4iU149NQ8lbFpzjAq3zkLiG+shtJpdS8IpUyEnRvCV8SmR89pEjBVtFYINGtPJmuZg
	pKGKj8z34NohHFotR/MQv68k8cFOKp6Pij5bR1shfUsRMGoYhNv+AxrtaOLl6G3WO6i14QzE9XQ
	4D7r7C31M9tZRAucnsjdKxviJ10FIqlUcraUaQIZlTPwnvpnS9p1+Q860Itl9p/Ai0qwRAAW6uc
	s0iqvq29ZubqF/pjNAryCUMrY4uzC7NbSRXp7eVl0nu9cyNehxBBAFW2GymwkXHRjAk5/yrwOuS
	HKDC5WRqR+sTsMPdidpkTs2Kvj357AVI8V1URWPDxQJiIiCiOIXICtIb/8x6cHEUsdAJ0akFnbs
	jUnkgazoMaewrmv7fsFCczquOoQa/T61Le8n8MlNhikkLKU
X-Received: by 2002:a17:90a:d003:b0:368:65d1:893 with SMTP id 98e67ed59e1d1-371306869a2mr10501438a91.5.1780875931310;
        Sun, 07 Jun 2026 16:45:31 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm19257732b3a.44.2026.06.07.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 16:45:31 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH RFC v4 5/6] iio: osf: add UART transport
Date: Mon,  8 Jun 2026 08:43:42 +0900
Message-ID: <20260607234343.22109-6-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607234343.22109-1-kimjinseob88@gmail.com>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the generic Open Sensor Fusion compatible.

Avoid board-specific DT compatibles.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/opensensorfusion/Kconfig      | 4 ++--
 drivers/iio/opensensorfusion/osf_serdev.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
index 957caed2b..8b9376d28 100644
--- a/drivers/iio/opensensorfusion/Kconfig
+++ b/drivers/iio/opensensorfusion/Kconfig
@@ -10,5 +10,5 @@ config OPEN_SENSOR_FUSION
 	help
 	  Build the Open Sensor Fusion UART IIO driver.
 
-	  The driver receives OSF0 frames over a serdev UART and registers
-	  IIO devices for supported capability entries.
+	  The driver receives OSF protocol frames over a serdev UART and
+	  registers IIO devices for supported capability entries.
diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
index 1ac93548d..fd36acd1b 100644
--- a/drivers/iio/opensensorfusion/osf_serdev.c
+++ b/drivers/iio/opensensorfusion/osf_serdev.c
@@ -91,7 +91,7 @@ static void osf_serdev_remove(struct serdev_device *serdev)
 }
 
 static const struct of_device_id osf_serdev_of_match[] = {
-	{ .compatible = "opensensorfusion,osf-green" },
+	{ .compatible = "opensensorfusion,osf" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osf_serdev_of_match);
-- 
2.43.0

