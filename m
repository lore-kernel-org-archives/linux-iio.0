Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4295233938E
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926188; cv=none; b=idGHXP2MfhE+QfNvxXbLwemvOQ/RUWCu99x7MBoFqThtjOIXsHMJHpnzpWDFdB26dkY90OVq1GP1N/15ogGfRekwn8ag0Rrjxx6qh8yVVuZHl0rc5KjraP304SCxfWGHej77Qjl7tqiiMaIZFNtO57AAUDFxRcUMjoF+KQLhS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926188; c=relaxed/simple;
	bh=8hJyHYw/rE+dTCvhZpQoJoUywl50GiNMK7WNfrV5KtA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n0zajfVvPljo90xhYXAIF2lbzkD0wrK3sAE0RIgn4nMuS7hdueogLFU9uQGL2o1szDThl8t2A7X9QGQ6cXcDmqzYXbwVxqoMKibi34RKFJXt//IK+OHIl/aNs5JV/xDTy0nTCvm3maVqSTApwIvrY8+BWG3JbGOumXrFDVJWu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OepGxdut; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OepGxdut"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-455ca262ccbso480060fac.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784926184; x=1785530984; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6pnlKNadGW00nMEoH6DTsPxDvjGOA4CBzkmVTviW8os=;
        b=OepGxdutbEYOzyON6+cVtE2H5eJogP89cviKJHw1vEGFFm2ANaA6hw1Nl/nurS2OvI
         GyyhsW4Q4tzF4YSnaC1hXmfX3Qr2+yfCp0FnRBwnkDiDEsJ1yh30DTRRej6Arhi2Oyub
         onmyv3QOXahnRu9a0aQVqtbK7UWlc/FWYASA+EAzHv3agVcR2VGivjleJGReB/+WZ/DH
         MtMqbxkG1JYwXmrkfUU/DOwKumEgZkff8abao7c6/zoqm7ivR5BlMwHG7iNrZGRdks3C
         NSmoihiv1Gt9HxvDS3WZKpbo1vbIr3uoJK3eAwtbTqso2D15IRGCPXJ1MtpmVh0u5e0h
         gMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926184; x=1785530984;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6pnlKNadGW00nMEoH6DTsPxDvjGOA4CBzkmVTviW8os=;
        b=kOxDFtZ2DCKqcm37SCj8LrEKlRhOPFiw3Kk2ILw/Z1UfD1jxIFTCbvEtvs8yWokMs/
         bIBFAMA1vlDUvd4Xk41oUsAt1z3aGL334fT/NTbdXqJCK1tH3Lagvr+c3plWdRxYRzno
         jGWjbPjAxcoJD2AgG118oU8XQrCIhKmyaiOxOFrL/dDVCrVypTegZ9/0HwYqKPAIPR1W
         fOdJXSlFEAyDZefa/qt1BdWsdq8GAlArXXXvUfS8ns5rYKWipELQ8DP6vzs+UigVEt/M
         E19Nx2Ko5xJRo6i+Kyyn2GrGB3mclFcloDDcZoDi/CV4n+7MewjCICMqaZXJEzu7e1QL
         naOA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4hAG4LCUGtNtOAR6BS5SqOHnu60J93KTOhXbwtb29oWZ38DtEtfApA3k+JUNYHU6U9MIHAcUto7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt3aX/0eVS/xrjq/xZvZNhwJalFBtAk+DmBoSFj8oXyI9wwvs4
	gHBVBPvElj+Y+2LDu2HfZyaPzJZMiQ9t241KlUMFmAQdRIJjcD3gKKorMqqo3VkOfel0xwayioO
	raTD8
X-Gm-Gg: AR+sD13GoOmxd6O5SDT31ubMFaiKb/2dcwQjnEVPtmL4VZXxmfg9XNaMVebWVIlt8kU
	abOFXWkBE5W6YHoQzuWJUpBy9VWDkEhHNUW3x1BLhZWEV6yAID+row6Hoh/MHVNuBNlp9WHhrkB
	luZ+yKoVNbLVQD6UXGLF9sBULy6VE9WPK8LRn7eYaCoxQ8s3Lzylcwc6Q5ZECR/o74cUF56Aw0O
	pL5M0MZtUrcAQZMmyoEwqRK8n7x5V1UJ04GZWkF+dv8z8MvktUOtKwrawH3DNRUTv1wtdfCOuTw
	u0B6JBbu37VvgTCbMrt6Ede5iUpjiiraR22sG95aTy4p4PqryD3bukeXvrCNapF18EYyGtPZ6AC
	IIu6Gr05BKHoJGWMwg84DIEebShaBMF/atkzOifnPHRNDspB5zLNXNXmFoO298otm0tzth7y5KF
	mt8paRiw==
X-Received: by 2002:a05:6870:194d:b0:440:67b1:b59b with SMTP id 586e51a60fabf-457f1ecd9a3mr109227fac.0.1784926184037;
        Fri, 24 Jul 2026 13:49:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e66674sm7255201fac.3.2026.07.24.13.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:49:42 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ti-ads112c14: add burnout current support
Date: Fri, 24 Jul 2026 15:49:16 -0500
Message-Id: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPzW7CMBCEXyXyuat4jWPAr1JxcOwNdaXE1D9RJ
 cS7dyFU7YXTaKTZb3auolCOVITtriLTGktMCxt864T/cMuZIAb2Qkll5F5piDGBCx5qZCmIyqO
 GseUltQp40DupjTmiGQQjLpmm+P3Av582X9r4Sb7emc9Epq/GvXWL/dXabivFl6XTxMcBMrkAG
 mkI6J0MfmdXJf4P+CW9et+npcalpVZgToEgBBwOcj9oI492xTtrdIU4N8+x2o5XlT7TnPjnnok
 9KwPO4nS7/QBQNLk6UgEAAA==
X-Change-ID: 20260724-iio-adc-ti-ads112c14-burnout-184304669165
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=8hJyHYw/rE+dTCvhZpQoJoUywl50GiNMK7WNfrV5KtA=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGpjz9ChF/9wNnY7q+0GTvHSZpazzXwjFU6bHy04Vi6At6/RY
 YkBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqY8/QAAoJEMLMIAH/AY/A6I4H/25e
 dhv8PKgIffJvU0RTuohHRptTzxxlB263KjHLn39SmC4Ov4jXqybJM10FScrFLNOmWWT6/eA+aGf
 9u60WDJDwqAF8IzMcxSAU36ryFzldjf8HmZZucTr8NwrPGIIJSeDvjFZMwXJpZ8tX0JPwwNRkE/
 krY0MrQ+dZrHNCsCaWlmZeNtYWxKhWVLjDBO7NT72OXC/6UeiscZSgt3l6+/VdMjd/X7JVLSou+
 7alF4KwKxWPhlUVdxZEcaCRLVV4EVys3jTtqhPdnSIdHduOyhfkxtXV7hl3l5uaY9SUiEpSzaMu
 eOTUOEEhdPfJTzqcwDpGOOywlSWzzQWJkgl9T9o=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The TI ADS112C14 ADC has a feature to enable a "burnout" current when
taking a measurement. This can be used to detect open/short circuit
conditions of a connected sensor. However, enabling this affects the
accuracy of the reading. So we add a custom "burnoutraw" attribute for
this. This works like the standard raw attribute to do a direct read
but does so with the burnout current enabled.

If this sounds familiar, it is because we discussed this on a similar
chip recently [1]. And this is why I put the ABI docs in a common ADC
file rather than one specific to this chip.

[1]: https://lore.kernel.org/linux-iio/20260622110223.7e854dde@jic23-huawei/

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
David Lechner (TI) (2):
      iio: adc: ti-ads112c14: add burnout current support
      iio: ABI: add sysfs attribute for _burnoutraw

 Documentation/ABI/testing/sysfs-bus-iio-adc |   9 ++
 drivers/iio/adc/ti-ads112c14.c              | 126 ++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 9 deletions(-)
---
base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470
change-id: 20260724-iio-adc-ti-ads112c14-burnout-184304669165
prerequisite-change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3:v2
prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
prerequisite-change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609:v1
prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
prerequisite-patch-id: ed5d4c1628ef60ed542339fe5fb490383ee8074f
prerequisite-patch-id: b92f5609fcf39e958e78b4dd74c3d323ebb6a161

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

