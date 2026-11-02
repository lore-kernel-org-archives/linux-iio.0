Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650394;
	b=edU6Y5bqtA2p7Y93GkCp468Lh+Nfi/uT9aX8PeBZyTnBfwD5zRFTE4XB2GqTArNzJegc
	 nvw9zBqmERMSeGze7r5YNtE3GTMBXlbqfoF7BEl54tiOJuLZfDLOt9bTtsHnQiPidWRiX
	 clDHOtoUWbJDPy/0+I5R4XYdpOFTLb/lFBeL43Ygn+k0OKUxoVaMsHbukitUEk9vxQz7p
	 bDrlwUj64KaqDka8JNjWvwRKsL79EGEinVgI3LReC88boVa4SL9SXki8y2MJwCYhQAicK
	 UEPD3tk8cQQqMr8Igyc8dXQsCCqnaMkaKbuMCKKaAgs66rPEGoVVxeiF+W2c5EwO9kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IrzQ/241oZp/Tq58QWudEA2sJDuknSCKqwtJBY2LTNg=;
	b=l7Rb+37SNyDL1TLan11FaTYIjXzcgN01c9MZyNwecgH5Aewg8eAx5SLLB12QeJvn9NAB
	 cvhzrWOZycvQ0FZ3Tq9MZMtBTPwgiEDDs4Kdamw3QUu5oPxd70QlouqFy25uQ5GRKBc1C
	 0NIfHA8S5UlQD4d9750quJkslDGCclF1NJLUjaKjBaZtVzoLrRmi1WIXo+H4Y9CSMnU23
	 vaAJ9Ao+ETWKnGlR5ZM5hNb47uTc7gATRf5PH2ph4DeX37nZJAeHMN6zYeH4lZHm7Y8dY
	 gYqB2URDOhXQBLnmJZJbk8Hb5dnahvCdY4/OguwF4p+bjCmts0O9nWZIv9r6JNjSfuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XsRgzODd;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397D606A329
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 20:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4397D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XsRgzODd
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso39336855e9.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793650392; x=1794255192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrzQ/241oZp/Tq58QWudEA2sJDuknSCKqwtJBY2LTNg=;
        b=XsRgzODdBUT4XXjpIUPRjkJblHJube1dhFufvnWW8HeEn8qJcmxkZkk0w1uK0fhN8z
         9dbQSp1dM546uDhKZOHSl0Zm23FuoC6QRi4Ob603V/sF7oVbAadbLNyViF/0ugfhKeEX
         iKIuqUzLcP+o1oa7J65p3rfwAJ6fxWhvUeclO/ZN+anA4SbR8KcCXTnClK6DcdnULRJ3
         XuNcg3MP0neOjUw2Di4n/gW4ZtY4i7FY85TFhj6rRD8/LvxSnrWZR0CSmR6V6EGW1qWC
         ol+YLt1tYcYhIHCw7t5RazdexhSQGt5KYfcKUKqEZe4dmy7hy9kwCIO4TXxCDYjYuf3g
         towQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650392; x=1794255192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrzQ/241oZp/Tq58QWudEA2sJDuknSCKqwtJBY2LTNg=;
        b=1ZaOGdZ3VTbispZKRsiAhvBbEH8IQNbQML+6xOaMyacu5NlYQIhdwarGlGzGrD9mv0
         YZevzYIVyr1rA/aiC3aAk50IyH0yDOgVoafk01ZpvTFdgPJ2iVxdTrZD9YkYqwDTPlKB
         0s+l2/eKRV2CxbNKRwlgbDjAz8pIZuu1ul/eSL0XQYV4DAwjzv7Fg3/Ksl5xKZYZMzLG
         Asinw59q5RGflPfXyo9pzR7OVSVBuKNVVeXGSatEMzQr5381x/XOeyo33ZF0aeH+IORc
         dUj+oSGAu25Om6u9vfnRy51Ku1ct3H5B7JkaYFQeLI1nnGsoAfbEGIC0ATZmrE4+bj9N
         jaVw==
X-Forwarded-Encrypted: i=1; AKwUvByKToKPsaeR0/gsWu8Iv84nBDjQroz/hkK6EyMa2H1eYUmEe0GR4Y/I1uLL07XoQbtAYrGVjHyGUAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqdUfjvwRpxjZab73pnNyQJMLwrBjVFNuxZj57n1e4SbCIcgHd
	Qn2UZv1dwSWazAQyQ9TVhD0kftHdxqLn7tkxWh2vGK2FUdDdMo6IQxOKJUdXYxfUMOY=
X-Gm-Gg: AYBFou2hydHwJoQF4rjcnVkhrRprELakaCel/EVUK8MMMUjzgRCGLcf8DIIoCRfUPHn
	FJMayANHOR3A9nEvYXcd5ufVQq8KyZqcI1ryQK7RZ2xTUVQ27jb+oj/5HKK4F5WD05gAs1Xue7n
	1bcGVgrsclFEN0NWBXEbOOL5XoAqxyDoBv/FoGn4otEIusr57FtO0jt+vhZKgfWjgPtGhVZtSpO
	l7MOvGAwtUegXe/vEwZJTgkOCYrm2LdbWn6RYLFWAtKk9ODYnrmbJM0OVB+ZVXnSnvKymamUa2O
	n8czdXQbl6REtNtuSAi645dgxGYl1R85bhJ9kxFvnJ0a5z9dp+OeAU6RKSs/0l+HhzY+jbHxyTL
	ytGHGoHaug09Of1BhRl0FWErwz7mi+yq2oRkZNZCCY/g1/o8TXi7OwY7wxXxBNIlV5mOsIMu6Xc
	T5fjq9PoRxrzVMC7ENsii/+jZ+fiWfwXXqUJmxmwPNazP0cCiFI0HWOXO6oXUAdC+lQTTh1eVnb
	2no/Y1tw3BAWlum+hY2AYkyVg2e7yP57e/CC/je01WHw26ce95r/jPEXGhb4tTfTxwkFKtj+U8m
	R73W2P5ymz3lduTJyuJ1Tgz+vkGcz1a18+2Kup6UZ0DkU0NbQZkSvjRzOlJF
X-Received: by 2002:a05:600c:46d2:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4ac1980118cmr242926285e9.33.1793650392480;
        Mon, 02 Nov 2026 12:13:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6412:7406:ded:3229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a82cf248sm13969155e9.2.2026.11.02.12.13.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 12:13:12 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v4 0/2] iio: adc: Add the Ingenic X1600 ADC
Date: Mon,  2 Nov 2026 21:11:53 +0100
Message-ID: <20261102201155.10948-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

A driver for the SAR ADC of the Ingenic X1600: four auxiliary channels,
12 bits, one interrupt per channel. Tested on a HiBy R1, whose keys are on
channel 0 behind adc-keys.

As in v3, this version is X1600-only. The X1830 and the X2000 have the
same register layout by their programming manuals, and a chip_info with
the channel count and the resolution can add them later, with a test on
either.

Changes in v4:
- The Kconfig prompt, the header comment and MODULE_DESCRIPTION() are
  the same text (Andy).
- The read computes the data register's bank and half next to each
  other, and the two macros take them (Andy).
- X1600_ADC_CLK_RATE_HZ (Andy).
- Read and write helpers that add the base (Andy). Plain MMIO rather
  than regmap: nothing is cached or shared, and the only
  read-modify-writes are under the conversion mutex or in probe.
- The device clock rate is clamped before dividing (Andy); the divider
  comes out the same for every rate.
- Binding: the description's last sentence and clock-names dropped; the
  driver takes its one clock unnamed (Krzysztof on v2 and Conor on v1:
  their reviews and v3 crossed).
- Joshua's Reviewed-by on patch 2: the changes to it are the points
  above, with no change in behaviour.

Changes in v3:
- Cover letter (Andy, Joshua).
- MAINTAINERS: no list line; the binding's path in patch 1, the driver's
  in patch 2 (Joshua).
- Includes for what the driver uses, copyright line, MODULE_AUTHOR(),
  reverse xmas tree, open-coded return, no message after
  devm_request_irq(), a blank line (Joshua; Andy on the return).
- fsleep(2 * USEC_PER_MSEC) (Andy).
- The ADC clock divider is now even, as the X1600 programming manual
  has it; v2 wrote the divider minus one, as the vendor kernel does. The
  divider fields are named as in the manual, and the two clocks only
  repeated sampling uses stay at their reset values.
- The probe comment on staying powered up no longer names the keys
  (Jonathan).

Changes in v2 (Jonathan):
- The comparison with the JZ47xx ADCs dropped from the file header.
- No mod_devicetable.h include.
- X1600_ADC_VREF_mV.
- The status declaration split from its readl() in the interrupt
  handler.
- field_get() for the channel's result.
- fsleep(2000) instead of usleep_range().

v3: https://lore.kernel.org/all/20261026083631.48406-1-olivier@mgcrea.io/
v2: https://lore.kernel.org/all/20261024041357.34346-1-olivier@mgcrea.io/
v1: https://lore.kernel.org/all/20261023204209.48556-1-olivier@mgcrea.io/

Olivier Louvignes (2):
  dt-bindings: iio: adc: Add the Ingenic X1600 ADC
  iio: adc: Add a driver for the Ingenic X1600 ADC

 .../bindings/iio/adc/ingenic,x1600-adc.yaml   |  53 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ingenic-x1600-adc.c           | 257 ++++++++++++++++++
 5 files changed, 327 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
 create mode 100644 drivers/iio/adc/ingenic-x1600-adc.c


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.54.0

