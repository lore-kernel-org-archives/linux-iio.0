Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2824A05D
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601037; cv=none; b=qNMWrVS7UrR+2pK01I77yNGndTyY2D2PlD8aTt/vXSIkJ8K8thdmGvBS3hWGH7UDTBVZvaDU19ucWs1pe6iJExgqAhJdl/WARA9/borMfDofzeuTRswaiPfyadMIP1gnBROsQ8IpywJjSZNUFUo8CXxTqbqIW+qoJnGJwrAvKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601037; c=relaxed/simple;
	bh=tQy3e3cd404IH7aHwVXCZjBfpap2WUWtbVT76HQTigI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbClpBxSd0Nj8sDo7kXQnrl86oZjxFx1d5JMmCW+lKtLYJpKbsqpTmNOdcCKn4TM54T0NbqspTuldmW0OdCswmRmiDBep+jL6773vEA/xTzXpcbtndfPfZBb2BnVO1RXpz6rTYM5lATy1UE+BdhAYtUWO4aRgRVdGXDvdryJLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOfK3VP/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOfK3VP/"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1318283a12.3
        for <linux-iio@vger.kernel.org>; Sat, 05 Sep 2026 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601036; x=1789205836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRA+96YLaMc6tCnYBwn+B3DVe6jv3AYL6noHLa2o+KA=;
        b=iOfK3VP/hM+212xQnHKlbMSpEEFSfjkRISQ7FZ/Z050rf5AQbOfjwoKWxVd40ClSCm
         zDboHkbrD0bL6OWedVi13UktRDmeqC8PYwqN8IWh1F7SQaB1XRPGNMq5/AWFrx3U1HxP
         S0klQ9nLG+ixEl6UkH54rZ1L71tN3Dw1q4iE4hdF8O58k35K2+2GpqSSeO3n0zndUmLF
         hrfEN9LlgUy/McG9mDURc+UqfYTAUVBhSCLzcZGlRdkWCLNCOGmyK9hzGAr4anJ+M4u/
         of10pX5Ju3RCEDqQT4n7Fe9hQBL0kctTt5g/5b2f/W9jUZgECd4nKk4ApfbeiwzYnC+b
         Wy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601036; x=1789205836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRA+96YLaMc6tCnYBwn+B3DVe6jv3AYL6noHLa2o+KA=;
        b=ox6PfNVD9+Q+BpUl/+wnziDigBvW2HOWIs1MtPxxuQ/inqvMGHO14at73HXKFPpQWi
         bvrvRNeupw78cH24tDth1Mo1nXoyh1Ki/FmMsdFWSJ5L6vvfaKua3o/uo9m3DBLtRaOz
         AK75PuQG+Yc5XwnTyySxjJ8MtWOmu5917n57o1H20Xn+A2SRPC+dWuzoHYwzSsdvpUVN
         9gR1nyvxAhN6qxwfcTRUt4IW/+SlNlgdQEx2Fawq/asF844zNXoPXNXnVHiRJSeyjVW1
         CvzoTRL4ePL9qtxta8dEH1y/vmhXb0GSrav9t07TKHV0TtJfGi1ZFnhhQ7xTfemUoQNp
         4lwg==
X-Forwarded-Encrypted: i=1; AKwUvBxPYJznk46sDCzv13niOQyJXQt0zIoCAnwrddMJHR7kHAi6Y7A7XLdmjNsAxgyJm2toesmrB6fDhFE=@vger.kernel.org
X-Gm-Message-State: AFuF++kY/m/7ObafCwrevL/Op4pte/PocwnBA144BjAJ+IFw6cnn/8SW
	4yAztcHYbAmNn5KNEgMy/K54GKrr3TqumXHn4nkyYPFkroVHwKV+28xm
X-Gm-Gg: AYBFou29m22N8df6W2HOVK1PqjNmtF/oJpUVnSUJS43+a0EXoVYuga5gvRkYOlIe396
	QdeH2/GMUzVWEqMcklBoQDS4CRFhrAxeHipWBikkEZGuOQseubUB2Y6QmExGFbigY2iPPsbbgGp
	LwqKaWA76GCAhRGYzSLjYVHagcwOuQ/4SZEH4k+ZxaUkM0Pdno7DzFEJsmbzvopnJq9FxBJ6n0I
	WBxUzOZ2urakVVwVmZ3OIetshJfFRbwf0VhtjZSyVJ57KBhsb3rV/S5RRgDHeoYjPx7N7phtNGq
	1++7Aj6uRvZ2RMfDJQHdW8k93EI+ObBrYwyD0yrxNQfuDJyv7jV60LTLTwXmxw8NZWAwLKz8AkB
	7VjDGkB/HTrjxSOM7Gd9gtiodG3ffscQrTOj7FIfPPTFE2ft8gJIT/BI4XfbwCnw1P9wFH9Aky2
	9zxQ0z3C4eCwRnkLZnVvSpwSXi/gyzgzgbgRSconUYbtAP43P2gZSy5HJNgQ==
X-Received: by 2002:a17:90b:1a88:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-39b2619138bmr16464351a91.8.1788601035821;
        Sat, 05 Sep 2026 02:37:15 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5b5:60e7:9f67:1689])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm15763353a91.15.2026.09.05.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:37:15 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 0/6] iio: adc: bcm_iproc_adc: convert to devm-managed APIs
Date: Sat,  5 Sep 2026 15:06:25 +0530
Message-ID: <20260905093631.48667-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Convert the bcm_iproc_adc driver to use devm-managed APIs to simplify
resource management and cleanup.

Changes in v3:

-Add the missing direct include dependencies.
-Split the clock and ADC cleanup conversions into separate patches.
-Use devm_clk_get_enabled() for clock management.
-Use devm_add_action_or_reset() for ADC cleanup.
-Remove platform_set_drvdata() and the remove callback when converting
 to devm_iio_device_register().
-Simplify the devm_iio_device_register() return path.

---
Mohammad Shahid (6):
  iio: adc: bcm_iproc_adc: sort headers alphabetically
  iio: adc: bcm_iproc_adc: fix include dependencies
  iio: adc: bcm_iproc_adc: use devm-managed clock
  iio: adc: bcm_iproc_adc: use devm-managed ADC cleanup
  iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
  iio: adc: bcm_iproc_adc: use devm_iio_device_register()

 drivers/iio/adc/bcm_iproc_adc.c | 67 +++++++++++++--------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

-- 
2.43.0

