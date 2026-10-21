Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623279;
	b=vcEFwRxFN/2miADu88zyoQCsJcIhGDGTVBNmv7chSBFPZ1NnJWJfimiCpIwnlq5p+z86
	 kABx4xY2/9+ofVXGfzHv7iNCj3NLKiQULVpygktVq5Mflmgg7/GLRqlG6w9GZzw3mzgDe
	 hVjelHv/U31qIzuSOcJQOXTj6cNS5eLv2PBIvT1mBYWw0FMJDXkjLEK64UY4LfB2kaz5k
	 eYBT+NxOSzNgpkuqsZK7gsKiL6xpT0So0nT6YyZ4X3vQ+j4lK8qCi/AY5iVRQLpPXus/I
	 ckvn3xo7hDEINUpyjHJUNHbsSd0OmTiSeViBf/Tsh8R3RFlNS0axTNHDZ977tiEakEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x7MyieQXbBbx4Xn5YipQkBiUdTpW0l+4A4LlRi8x/Iw=;
	b=WDbPuFWAZVMEdOJAOcNpjppDEulOuLg6LCQUc7oTBQOEqpT7G52fRBgM3Id8ECKrWuSv
	 D3hoyyCpE8G83zD/R+5xDa1CK1VDQkOnhdMzIY18EuIODuKfwaXHfRLUqK0bP2CV/Gs3g
	 t4q6hJkad1vA0c9q+o0MIUYAzWP7bN/YwmWIvoPOMrO7+7GmcZV4g6qI1oOo2pRBdmcGu
	 V3s3Gq+W4qT8hxrUbl6mPq7eBHoCUhl29nsM3/mjZpLXQEPqxDjx98ARIj8l/NuVWTKBD
	 bTGcPvJ58kZefa1pvERsf0+47uamS5aSY3DA95XNKdcPcj3HqiZhWdeIdJ7gsvZgGmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CBdUgxA1;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114A606A319
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 22:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4114A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CBdUgxA1
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35c76e9614aso2246071eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792623278; x=1793228078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7MyieQXbBbx4Xn5YipQkBiUdTpW0l+4A4LlRi8x/Iw=;
        b=CBdUgxA1QC/+MlRdYyQ57PEEqWsDnPwgCiASzIPjVnvMS7nIJIVFIVTHXQS5IcTB45
         HHD/HydzPIUD+9nlsDMhIRczbD1qH/TmyuIn+D5dlL2HVPq4GL6AMJ4+utIVU8ecjdzH
         LlCGMZtvUPzEKjOV94R7zG15odG8K29B79STt9MaZGfaiaYv+wuariW1bSh4JWBrLWhA
         cwsbNWZwMeDOcOSztnptVRZ8KTXBzf+yEqfVW3bP3FfrkjFiGtPUKR286BdTb2FK0P+t
         Pj/s2PAcYCYKLt/Gu7Y3eAFWXtSuFubPOfDQt6F62KB+GzgNjtF0LZAeTfu2EblX2NBD
         Kx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623278; x=1793228078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7MyieQXbBbx4Xn5YipQkBiUdTpW0l+4A4LlRi8x/Iw=;
        b=r2fBwsnK2K6KFufk4ams0KFFNSf4I9TrdBEKtzHz4YH0eBnpjEnq6rpWFVvrknJrWH
         D4fh1JrwQ7H+xZIi6wnyRa788yatWqXlkWHsdasODineIwfvZiVo1WVYAAd10nw3V+eh
         6C9czVKe4FyROnVYXr8c6OERsHOt24Lu06+2opDF/CD5aGfu+k1Z3GVyLB8Y7u/kgzM5
         vWm4VprHsrwv0lbHotEirXbxGkC9wBH0S1zJIi3Y4QR+u4Zs0uwApIHbgFwRMnCjN8Uu
         NpZtcJK+uZNfwwIKEoT5fo6cp6uU57GGLigf4QYRa47oLRovE8v4r+fb+LZP26YjoOIJ
         sdMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKvVK5cfl863nviD8nN+0bv4dA64UVg8QylEB9g6oa7Lf/RDNaDH4bMr0zSSE7N2s8IBAyVA8pa7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiC4O4NaXJmOvNtgjWGu4DVXMu+jTVC7WF05DgahVrBb49QUH4
	OF7AEH3IigB1H0tMcC64m2kAlXJtkBmqm8n+CDWyJlFgwSNBKNIMM4cW
X-Gm-Gg: AYBFou27zWmRi+tksTybiBxbGKg64uwHS+Gpt+ftBbIZg+G6XA2AojDlq/o/fhVls2W
	AJZqZ8/hKiuh0HZiop1FkqFj8YrY3TfSEmEYdF7DPvUH2SCZVGOoG4TR+XJUPPdptU8T5CxwNkJ
	wVgpiFpAODQLt+XdoYVLvpsNa/yc4M0v6qf1MGTl1KN0dqL8OOfg+ExvrBnxxu44/BdaEKOut5y
	PD+8hW74fgSixXNTXKxy9Wu7yfsLzgziLzo/uxrwVsRee9m38YY5x0FYWb6Vmy7obiZSZPB6mqs
	kiVcoxZcx7bdyxLhSNAYUsUo7zImAtOkHZQwYjJPRJ0PfMV3j3twDuqACZNmh/27MRuvS9+RsIG
	RjzMk+Vj4+LiFxWGMa2zzatpaQbpYVWOk3B3LfOl5+4mw5Mu5zW+KeHc253lukQi/BCYRtdOxzs
	LxrzIyra+L5iQQ06gixXuMvwA5gCmIoln3VAYblEjQ/FNMtS3kglUTuTT/bDc+RFmtT61etrcJ3
	obNLnWcoeLkVmwTuRFob4nrovJb/KAUq9qQVmqbnsVCsclRXaJpkG1uIQ3+01oi0pnoj0dK0v8F
	Tu70jDHSfHCtGiRsl0Cn92FDIXg0DW60IcEHpx5AALderOAgzGg9jl+weEVG8lsMFvUoj3pgNb7
	+QR27AXpYXI0=
X-Received: by 2002:a05:693c:8942:10b0:34d:96cb:d75e with SMTP id 5a478bee46e88-3674e3571bamr4690949eec.27.1792623278344;
        Wed, 21 Oct 2026 15:54:38 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1cdsm11859529eec.25.2026.10.21.15.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:54:37 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: mcp3564: reject devices without match data
Date: Thu, 22 Oct 2026 04:24:28 +0530
Message-ID: <20261021225431.627718-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The driver identifies the chip by reading its ID registers. If that
fails, e.g. for a newer part number, it falls back to the match data
provided by the device tree.

spi_get_device_match_data() returns NULL when the device is bound with
the "spi: override" property, as in that case no match data is set and
the device name doesn't match any of the entries of the driver's id
table.

The driver dereferences the returned pointer without checking it, which
leads to a NULL pointer dereference and a kernel oops.

Return -ENODATA if no match data is available, like the other IIO SPI
drivers do.

Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/adc/mcp3564.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 259ac4ebdedf..91796a47e412 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1204,6 +1204,9 @@ static int mcp3564_config(struct iio_dev *indio_dev, bool *use_internal_vref_att
 		 * try using fallback compatible in device tree to deal with some newer part number.
 		 */
 		adc->chip_info = spi_get_device_match_data(adc->spi);
+		if (!adc->chip_info)
+			return -ENODATA;
+
 		adc->have_vref = adc->chip_info->have_vref;
 	} else {
 		adc->chip_info = &mcp3564_chip_infos_tbl[ids];
