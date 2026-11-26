Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680730;
	b=wjJyVn71/8jUJXotvg5KFI1jt/EvztYqcp4FIp8L7NNRMfJt2L3x7RlyOK+2I7B2BnlG
	 FatXf0xt7zSffeockOi0H2Juf7tAm7bBUobxgygs42lgiSgi/cky2q/hwnjAVevWgCqi9
	 KTeDPtewq1JI2hI9eABFDn/2XGtgUDUywAyLwOz4+wiYsjOdcF2RuaR21wWjgQcS24vRx
	 dZSOZEBxi6rQ2VLnypa11dR8SN02LPPcwYdX84oGKg9dXBEtv8uVV2PG8Q2Rlm7NPx/A1
	 Vi/oUhnUtMsy/Y8VYq0ANkOCkWyQMYDHOv+Ecyu5RxYOdV5s+5JGBhgQgcHVEYV1zPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kdVRaDN/T7vzdcCEg4HnPSMiNJ7B8TDs5/yJohuuJeU=;
	b=vFd+V8ijOmj3WiDCpRsykD7fE0FvTaIxSskMJOuDk5NQ5K303QHKB4ZFeS5TMJsuEPfN
	 5TNDcp4eR/6Zxmzhe3eILSchtWGK33omzNYd0hNxVDu6GIAw1UBpjNvDAl36BZDBZUN57
	 X5RRy0oou2w8Mu0k4SX7xXXE4e13S9MisR+KkllMcwmCDiqHB13lYbS/ZprABa+R6QjJx
	 LLJhU+SXfS69mGkNqDRM+YioGx45ucnHXSnnAF1L1ygVLi7tFWJMXV85oHOL5Mj4dNThP
	 9460lHl0UDuFLIkwrCbtTR8AzNe8m4uPv3mn1TejpfDvNMYXnyLWfM4dy41BWeOqWzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dERc6wBt;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB7606A31E
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 08:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCB7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dERc6wBt
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cde1479f76fso3732068a12.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 00:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795680730; x=1796285530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdVRaDN/T7vzdcCEg4HnPSMiNJ7B8TDs5/yJohuuJeU=;
        b=dERc6wBtCSnHzaDqt96zRmZ2vdHqF9+v0cSfmz5negKeazrLKeu+xbEzVSkLChR8Kb
         WhL9JcSes56BAz7atdGPm8u6ROTAAp6puz1OyS/d4Kj0uTtEjxvpumqeXcV1S9d7gi+t
         39pM5d2r3TB9TsjItygBA3Xj9jRtafYy08wdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680730; x=1796285530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdVRaDN/T7vzdcCEg4HnPSMiNJ7B8TDs5/yJohuuJeU=;
        b=E+kx3gdtnt5T2f1A7HBIM59H9AAb/W6SFCGrW/FIWP4JzstIML850juAwM3Oai9sVr
         oRMvoxHwGGXAUJ955uTFPIybd3RColIeksQQYB2KEYSAfs9RQjItav9jUZxLQtMfh88V
         X3UKaVekQgaeJ8GkVcWcsW8iHdi8P9EraDBAgZ+y5HxpRFT8/Sjb7rXi5gbwFQORVhBW
         XEWmxYHlyU3Fcx4npIwdH9FSY8mlkyd5mstLa/eGltBD0Vvudfc0D4DBob3Qy4wNRFLL
         d6S4t0uxWGXv3LCH8bfADQDvyxJOWLkX/8VyGJ3h82nsg/7yWMDQJ3xWMknpCs9T2i2F
         P3DQ==
X-Forwarded-Encrypted: i=1; AL+hErEz/7efFW2xE0lr4SfKalVAalcLGgMytvp8BAaBuwVRWrJbhOPKpjrD+yiiQ+DfGZH9AaWuKye47N4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/riglqK/prd2sdhS4fW1qUE87p2N7AqYUpLzTsdI9tCLcpY/Ha
	iIgptgLqcotaT3tKI9zpukyb3/CVi4a9NDOP9waRhSrCACml5F8qNXRkLyJGNDb9gw==
X-Gm-Gg: AZFdTZfd2oXNhkHtT6avKWKq64VA0MXbbHN1DTt7XgoVh9oyVnYfWvFNnS3KCvBk7GZ
	xCCFzK6BTIf3cbxcJN1HSOzu3nN2SJesP9WLyPSTilyFNHWf9xCZtfTOAwCP+6rImtzPMdu3Icp
	w+zgDe0Wcyp3ZDKUo4ul62WN+Sc60gVXMceD8fQB07H5i3+khBza2apOtKvT2MngPLy8YY5emv3
	jdIBiRMjAu5ezkoQaYaganqoausI4ppMRjPzOrzUEJ0OqTEKw77yMXGAhghQ2h7yy0eB3E9LWfl
	P9yYwHtk+mEIekLXFTYNFmQZ3b1iJoiAkrkrAvP1SyQiCL3ma9ad5x7n9FmxEPgIPPPwh4YPYRg
	ARTrDXI2Hn+ddpJ4t5OyEZ4q4xIARgEqi9jXUDFxRIRDDtSJxPxa6/e8mGwqJn50HQZ9Tgf0blI
	f3TLK3xrXezvEls5KEnntEv12vvfnNfg2Ue6uFjFWJwhrXnbuer65b+rGp19giLgEmxs4Mmkng8
	KjlQH5FHHRKxObPpxfSplX/x+puUHOAajuvPdWa+xXbyFLDf1kn+cJbLdLCj13iFY2yCPkQGP8G
	xKAV3/SKeAL5Inb8p2jDTXasNS3Ducg3WUOUzj3cue2wDThyKLJIXD0A9yWE
X-Received: by 2002:a17:90b:498c:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3b41c902f3emr18704680a91.28.1795680729913;
        Thu, 26 Nov 2026 00:12:09 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b44b7a8c64sm14084752a91.3.2026.11.26.00.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:12:09 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it
Date: Thu, 26 Nov 2026 16:11:54 +0800
Message-ID: <20261126081155.501493-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126081155.501493-1-wenst@chromium.org>
References: <20261126081155.501493-1-wenst@chromium.org>
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

Commit bdfc454e8567 ("iio: adc: rzt2h: Add support for RZ/V2H(P) SoC")
recently added usage of the power sequencing API to the rzt2h_adc
driver, and directly selects POWER_SEQUENCING.

This new Kconfig select causes a recursive dependency when combined with
the in-flight power sequencing integration into the USB core:

	error: recursive dependency detected!
		symbol USB depends on POWER_SEQUENCING
		symbol POWER_SEQUENCING is selected by RZT2H_ADC
		symbol RZT2H_ADC depends on IIO
		symbol IIO is implied by HID_MCP2221
		symbol HID_MCP2221 depends on USB_HID
		symbol USB_HID depends on USB

Power sequencing is not needed for RZ/T2H and RZ/N2H, whereas RZ/V2H(P)
and RZ/V2N do need it. But it is not a strict build time requirement
for the driver. Change it to an optional depends on.

This also requires a change to the pwrseq stub functions so that the
pwrseq_{enable,disable}() calls in the driver still work without a
power sequencing descriptor with POWER_SEQUENCING=n.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1d6ed49041ab..7874d0e78e9e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1631,7 +1631,7 @@ config RZT2H_ADC
 	select IIO_ADC_HELPER
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
-	select POWER_SEQUENCING
+	depends on POWER_SEQUENCING if POWER_SEQUENCING
 	help
 	  Say yes here to build support for the ADC found in Renesas SoCs:
 	  - RZ/N2H
-- 
2.56.1.839.g22a8290db9-goog

