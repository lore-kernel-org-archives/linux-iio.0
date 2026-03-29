Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E622FBE1F
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824433; cv=none; b=LP8JL/o0Em3TLJUcIutyqS/ICiBklX9E+fZo2bYXQk+I4BGHeJ3+8FivknF7fmA25/rWjL2gE5WIomlso3IysswhExPxa4HNctIGFghw8PWClchc3glFRKMYPntaMLhh9SKzErcnqAkjkvRooKvFeteSXTcnvDyNfBxCl2vdWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824433; c=relaxed/simple;
	bh=zq6gDkkgz0EgiEfb/l1u6tCsi5Cu5yaY3sZxVmtTF4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EqesnRA2UZPvMtoNvZV02YlcHQj/ZY+Byx2CT/AP82tsv49UrU/mv+3RfDnbpWEREHhk5QSbzQ7wkLQMRoaembxCQfzTLfZX7YRmXkhG4M+8BiyxBj+utKsj1XHnDpTvHAYGd0+SIcCu0cUDCzYB2CRieoNmYUQWFWN44Wq1bV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE+WXEZC; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE+WXEZC"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so7680823eec.1
        for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774824432; x=1775429232; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApS/GEmTLQev4aIUqsAr4eNKyPgGdrlmvrkZf5VLHGY=;
        b=AE+WXEZCBEzTTwAv1tNdXveSUCCiNmIJBuYJiSBEKSfmWtq34Ncix7QQw+9WI4FH+S
         rlJgvXaZEc0NmiPRN1+4OAvh+aDWt81Ht8HQrGQPjSMaEulstGilJGqyJOdFlZvlw+ja
         zhtlFFeDZkcTH0mHsffUBHPPHEQvc0eElji+12Ayo3bApRMvHeagWVlQ2cuGAxMk38Fi
         OpSLTCrjqsNlzHp5K9hpinNa5x2mC002O2TcTioijI1XLGAqmNyGv+V2044FuC5XJNIP
         ZdUgt1BPKglqWG7q73gnkJuWWiwsa5qDdUDv3c7iGfSQ95G/dYMuLfE3cH2lHEcrBglg
         Gbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774824432; x=1775429232;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApS/GEmTLQev4aIUqsAr4eNKyPgGdrlmvrkZf5VLHGY=;
        b=GAAdlV1h9dBoTqmSaDiOZzQ+DsRVku+u9FdlVkPHNrE/R5iFCB1l47Zbh0tnRy2eTB
         tcglzt30Wt9f8HqaNOvcHSUdhHRSDtTd1hzvS+EOMizbmqyyy3HUM1zx5qa6On/JHUHS
         F+OEwNXxCUufhKF5Gr4vgh4+EyuprPKeLowNKLZQAVwWKgA7gudMuUyHh7jJZ+DR6Nva
         XRJjWq/UVwNQCIgs43XJpX2YAKbWFQ/th3glx3IyGXszzLFkDqxVTSvRT7XqyGTsEi6w
         iUWf0h0NsNbjq4o6YuT1cJk664KFlCH1dYrEmvtOSYG/18BJ6EwoSlLNahDgQqpQQz7X
         8OrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2tusGInbPh/gIR2MotxvheURNP0DLc8GFDzew99cDizjQtBmngpzJc5YgrTWQLBAZj5mu3GlsJYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxilutmAwEZA7rII7BKVNxFDmh0n7Tukuv5C4b5cpf21r7cids+
	+xcCMaqEntbuMWeEx0lVhk9lyJb79DVVtOM9IV76HOOWWM5SYvWkxF48
X-Gm-Gg: ATEYQzzrXCXBYjV2C657ztkXJ0EcGrVtmW9IXs9BzhB39z48R8GIobLrP+HtcTJcCHl
	0jv6BSDdziH1a8UJ1Wh76UoHzYSHFAVeNaY59trjyjO6g/PY21oliHDPqcaXgfk37RwjE3MKV6r
	cXgX7WCpqYpTaLt5fXheUnzEnEMdyOuJQbWGgc/fRUrCLmOR15S9Vwbv/kaNjXdRwi7cJ0GaBg9
	z2BPUZZpgc0YpU1By2+QdjPuIBxqW6bwtSwoMIAB9CkWIRq59Yij9zKuGScv7UNn+eEjSbs3z71
	AwU/Je8ZUmIuKsFgW55j3cvdnZ53AJd+HxcrQRaAwwhGgkl13BcOoygn34XV/ABzpzU4CD0ypWs
	CoCsOzAyXX4fx1lI4jkXvHm87WmfX51FmV6Cu+vGppwWIdBGHRWaEq6SdQimsXheT5v1P8ai1N9
	cXrMvgpVvbYR98yRxdP128ATBI5YRYm4mrAGA4+2qfPsmd+xT48v62d/PEwvU5sW1hdi+gVyMm4
	7uhxBbxYfSBxhA=
X-Received: by 2002:a05:7300:6d22:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2c185df79edmr5833234eec.13.1774824431654;
        Sun, 29 Mar 2026 15:47:11 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm5840295eec.30.2026.03.29.15.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:47:11 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v4 0/4] ti-ads7950: fix gpio handling and facelift
Date: Sun, 29 Mar 2026 15:47:05 -0700
Message-Id: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOmryWkC/23OQQ6CMBAF0KuYrh0ytFSoK+9hXFTaykSwpm2Ih
 HB3C25YuPwz+S9/ZtEGspGdDzMLdqRI/pVDdTywttOvhwUyOTOO/IScIyQCbWKtJILTre3JpXx
 o7lIo1CdZsdx8B+vos6nXW84u+AFSF6zeWaXKnuKqEFI22JRQghkohalIPvhn58fLY9DUF60fV
 rSjmB/TtnQUK/2DBMq/o0YBCJoLZ0ypsVZ2x92WZfkC2NJDtPsAAAA=
X-Change-ID: 20260220-ti-ads7950-facelift-ad8b5390a654
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-a6826

The original reason for this series is to make sure ti_ads7950_get()
returns result in range [0, 1] or a negative error code to comply with
gpiolib requirement.

During review David noticed the fact that the function also clobbers
gpio state. Fixing that lead to adding cleanups using guard() and devm.

---
Changes in v4:
- rebased on top of latest next
- dropped the 2 already applied patches
- restored inadvertently removed mutex_init() (Andy)
- stopped calling devm_regulator_get_enable_read_voltage() on ACPI
  systems as it is guaranteed to fail (David, Jonathan)
- removed call to spi_set_drvdata() since it is not needed anymore (David)
- Link to v3: https://patch.msgid.link/20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com

Changes in v3:

- Added "Fixes" tags
- Picked up reviewed-by tags for #1 and #2
- Dropped the conversion to "error" variables
- Avoid using scoped_guard (per David)
- directly return results of function calls at the end of function (David)
- Split spi_sync() error handling into a new patxch (Andy)
- Switch to using devm_regulator_get_enable_read_voltage() (David)

Changes in v2:

- style fixes in #1 (per David)
- fix to not clobber state (#2, new)
- #3 and #4 (new)

---
Dmitry Torokhov (4):
      iio: adc: ti-ads7950: switch to using guard() notation
      iio: adc: ti-ads7950: simplify check for spi_setup() failures
      iio: adc: ti-ads7950: switch to using devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads7950: complete conversion to using managed resources

 drivers/iio/adc/ti-ads7950.c | 195 ++++++++++++++-----------------------------
 1 file changed, 62 insertions(+), 133 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260220-ti-ads7950-facelift-ad8b5390a654

Thanks.

-- 
Dmitry

