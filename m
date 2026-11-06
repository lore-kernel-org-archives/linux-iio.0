Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002437;
	b=rXQf/z+bAH06fBRf28XK5yjOv1hsYqzATwqM84rQaNNpDpDz8rqXUYC0jZgi4qRNuo+s
	 PwKIXcNlUxiJ4Ih3vLCuaZvTnizZP9TlulcLZD/trM+hg277avJwZMCNhT5xs0tGjdKGt
	 iSIyqAXxI3PQrb6qZevoglvYXYueFQOHOsUAFS94RWYIlcE8KLSMsUuqQG+lgHbS85Ver
	 uwxnhli+v4tTPjjR8CCAm5j4Ach1r3p4L6objmCtqaoSoaBDfDQoMDJCjCygiEldOiWgt
	 0bM3KE3YZi7+h6DlNyaIltTumYdi2B23QqJrty319Iq8r3VYoyzXaQ9+2CG0Qhd8bFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=QwdyqSAwt9ZXHa8EQmpcI9Z+hA8Eo7G2vXgq9LpZuac=;
	b=AibXh5J7GUN+QmHPaAchIBnVcYUW5Kwb4CXY3Ev5zj12fJAKu6wdt4SKrjs3bELBHVS1
	 LrfnKI1en/HwXGQzRXfqyM5WH6w+VOFn5CfMKvmPDc9UkxezRf/VmwVpMbV6/7ZwGpLwJ
	 BMWvXbQFmpywQ5uO6LBZ3+p2cT+le6snt9731s1M3/rEc148VC/OK6QCF9Q8ONpjLBABs
	 RsiNaqw26OT/juDUWp/iswWunMrkO3y5/1KGvLK3ol+jUmSX8KxLpd9loBR5k58lvJ333
	 IgeGdxj9tG0dawMhMTYWn0UMB0HdvoEuDMTwyryFj5YoD5TSnL3wJaziJmEurOrCkiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nTBEYaHo;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E178606A32D
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 22:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E178606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nTBEYaHo
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f48d91ba7dso720150b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794002435; x=1794607235; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QwdyqSAwt9ZXHa8EQmpcI9Z+hA8Eo7G2vXgq9LpZuac=;
        b=nTBEYaHoVkzmnBAHvYI0qR8FPBCAJQ1DiFUscEZsjBiIRAnNsXpQ2nc+3X4mA6shXz
         JI8KBzlPNz5NRQz+VzI4vg4qHPK1UH/PcxZgUKn8tCIDaWchOxGAkljMoStGDHn/Zgyx
         GttCgSxB6uNoC/k+p6/P/qoPE1wkI+U4Mk3V6CHpsJkvh1vRPUIP03ApW0Wwh7iitMAF
         lQoIm81NtdqfiKxiYo4F48bYGw992KUS1e5MvXHVUUgKXwkbmfd7tXLYn7wTii2V1Cgv
         J+vxKG3aZjZVhlbeowlDHGAKOsE7p8GwQBMTe4xysyFBzd858K/wi8C/Hpol0vtvRAws
         LX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002435; x=1794607235;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QwdyqSAwt9ZXHa8EQmpcI9Z+hA8Eo7G2vXgq9LpZuac=;
        b=PqHk2/QJ6pr7aXfw6eoNi6WA24nhq25LHK9N1khlB+jcP/JtbrhghXss6sUKq/0YIX
         BDjW36/MW40t2dWegmCxB1Mt0EBkwD3tJ2rk+iQ7bJSrwIasg9HTXLQnLydyI5JVk4KB
         fYDxmdee7Q+OHmqm7vl3iiz/YeRVa3/6/e9n+BNxhihXffRtWGtmq2Y7ZCwfQ/I7d5yb
         C2fNGz3+7SZKoju1HIeEzl9uvrsWxfrl9PALDgnt/T9sJrAmNZvLM9Mw+N4SHdIzi6Xb
         kUxMdREWsuv6Z0q90q94djOTJqWmpXZZl8/i82rO8wEue9ci26cOO8tOkjxYCeeSfcU2
         gLOA==
X-Gm-Message-State: APuU4Z93UZCP9IXeaH+gsjMHUH3rKDX4d8FFbMsvlXhR6D1/Li3CTDCU
	9EfBY7jl/NjD2R+v801JzViiLVjtAwbms8cR6C8dP3srxgzAYkN/0xVhGq4DpdT9ODopiprGly/
	wI19cDDI=
X-Gm-Gg: AYBFou2tYI6R93HfcgxW4VOvC0ODF9t8VeThQpW/CQPzFm2eJ+OkgXTJMH7KTL92Y1X
	V4jaI27TGrI/AJqlD+ZgIs0V6vx582cow1RIKtNKLSz556XxPLNvnnsWEQbEIwxiklIW8fYmQQ7
	SL7JKzwxG7Vbx9/9Mw8K1gSKJ/ocwKWQ/n4hkmXfMJh5JZRZVK8ibdxQKZnqqirk3XTgSH2oQA6
	3IRW9Rd6pF8MWNab8eicumCkFFuKqTwoRso8qHePZmrFoclMQ5vWegdgvhetHiEYRFCqKubGAWn
	yhpzlDHfI0PwgX+MhsAAUk2ASYyc1sLmpRlQ8FtZwAVNJHkuJgFGNHyHsxlBh7Ysx1o/TrdjfQ1
	EHylgkN3H8iF3LCHCEumLY7nseT/TWK4G+2VxBFPEkgh4CcUMc6WKShkZ55ikomxIRLNNips9hb
	wJc/AzbyprHdr6TO4Nz6GlHaBonIvgEY7ncHH/abpUX8Yjxe97TUopQGYU4ZgsuICxXLxXg7HiM
	73SxWgd6GLTxU8I0x/WRrNPHULpJm5Xuqt7FdWWfOr93z+1UP6ETVj0WCSVAt0F3hhmYJ97q5Tm
	R5+XSx3gr4KMfwHuh+PVPp+vNd4fyed0cMQ=
X-Received: by 2002:a05:6808:3501:b0:55b:f88d:6ebb with SMTP id 5614622812f47-567e13d24e7mr3005347b6e.54.1794002435026;
        Fri, 06 Nov 2026 14:00:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7f010e4sm2432116b6e.14.2026.11.06.14.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:00:33 -0800 (PST)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v3 0/2] iio: adc: ti-ads112c14: add gpio support
Date: Fri, 06 Nov 2026 16:00:05 -0600
Message-Id: <20261106-iio-adc-ti-ads112c14-gpio-v3-0-7578ae66ee19@baylibre.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42QwW7DIBBEf8XiXIwXnLj2qf9R9QBkjTd1jAvYS
 hTl34tjqYceqp5WswxvBu4sYiCMrCvuLOBKkfyUhXopmB305JDTKWsmK3msWnngRJ7rk+WJ8og
 A0kLN3Zy30DbG1LapagCW788Be7o+2e8fu46LOaNNG3BzDBSTD7dn+Aqb7z85K3DgUksj4RVNr
 /Sb0beRTMDS+gvbolb5A4Oqav+CSV5xJRXopj30+qh+wR578YBfS/6btL+GGR2Rp4DYFUNKc+y
 EcJTKTwwTjqUPTsyLEdFexEjTchX7weYRZ7JSiVyozKpI3gV0OebxDTuvqsaKAQAA
X-Change-ID: 20260925-iio-adc-ti-ads112c14-gpio-197bb4c70411
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 "David Lechner (TI)" <dlechner@baylibre.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=AAn9LaE7F/d4yAucPVkMomfREi1LmOdcpZ2HvlQO6tI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBq7k3rrCL0s3mXdauPd7B7xU2rKla6DHedimNuQ
 lnC3TfJVPyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5N6wAKCRDCzCAB/wGP
 wEs3B/9BmDD9G1FrqSBvCM9bSJQIOTtu16lRWEbQtrzz+603zfbQgh2VsaNCGP6plkHLvAGwpFi
 ubTEJUc1FjhX/xuV5jt3ePJUiblJDPVJuFBYCuJAIHo5FjYOnDzG3tV/VDWBT2zchzmtOb4j99o
 hOSc3ThpDVXpk6YAtMlDEaMv87hkv1XAeOfpUkKx+5XMw9N5QiP5nv0QwHkBpHCajrGkOVxPuPG
 CJJPJckB514j2BQuduOPtZX6cVbghAEYmRSIRlxgL/lqGmTj9AOptz1zmR2Oq49g8lYR41u2IG8
 FSa071Buh5ck0cdtL+h3H9WbdpdLhEPiTwiE7XHclmzbwpGW
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add GPIO controller support to the TI ADS112C14 driver. The first patch
is a small cleanup to make the GPIO register field macros usable with a
GPIO offset. The second patch adds the GPIO support.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v3:
- Rebased on iio/togreg.
- Use device_property_match_string() for fault interrupt check.
- Use device_property_present() for gpio-controller check.
- Picked up Reviewed-by on patch 1.
- Link to v2: https://patch.msgid.link/20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com

Changes in v2:
- Split out GPIO register field macro changes into a separate patch.
- Make ads112c14_reserve_ain_pin() return ain and use it in assignments.
- Shorten names of GPIO reservation helper and mask.
- Set reserved bits directly in struct instead of copying from probe.
- Use non-atomic bit ops.
- Drop unneeded bitmap_fill() in init_valid_mask().
- Add GPIOLIB dependency.
- Link to v1: https://patch.msgid.link/20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com

---
David Lechner (TI) (2):
      iio: adc: ti-ads112c14: parameterize GPIO register field macros
      iio: adc: ti-ads112c14: add gpio support

 drivers/iio/adc/Kconfig        |   2 +-
 drivers/iio/adc/ti-ads112c14.c | 191 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 171 insertions(+), 22 deletions(-)
---
base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
base-tree: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
change-id: 20260925-iio-adc-ti-ads112c14-gpio-197bb4c70411

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

