Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330117;
	b=yN9ZDPTJhPkf1yxJAgN/LUafLX7bL+SBn7xMYkFrLkN05xvcvG2tVsCyrgA92+htDswO
	 ij50tQcRXsyx3Iwc+9JiFZs+agkqtJS6rYhJbytCWdpd84eeOfH5sopPc5axdgBMprYaC
	 Xmhf68Dn8R2YZJt1mTahaLQ/cWnQWtBHpvcNQ1uS/tunp1lzw/kmsoH10SYCuin+nprEE
	 Iovcpk6QMR7wyBc+Yi6DZ8uFc8Zypdzr1VZGUSyoj1ZK0383iSfGAZ6iraKxiSE0UArbB
	 8GPJwf1vPwypbU/auuFXVWoFen+hOAQ5xdicpVT3AGKioRlF1Lg8IQXKM6ya55uOEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AVQv90cVLZ+qJuF4mQ4kF8CxT7gJb59j0c9vMsRIsuI=;
	b=xZHxKHyWkpMf+5Nf625K7cFmg2v4vb5yZ5gc0d+l3hiIAoZon5og7tfUlGakVJDVFjEP
	 T1/2IZ7ecM8gQj7FhEi4KMNMx9Uhgr9ORmwPAh+KW0K4hRKl4Lq1SNMZJ3pvD5r5wJb1M
	 um8RLi/H9zwUz1mkXQQm2d/KzYv8jmcnvrV4NmBu2dq7HEJEQC/DfircEk5MwMHppbWbc
	 S/SBVeSZvjQlUBpALcsXwfWGh3NDxaSzx8+qEvVzBjmm2mPedrIjplu152oFRNVSwdKwv
	 rq32YmC2rdlWClhWNjbXHN01vBKhg607TKsjkFBJ3KuxvSy/7AJgV6L9nFOSzLv8Fkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aaSqiqk/";
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86A606A321
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 03:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E86A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aaSqiqk/
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so108188a12.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 20:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330116; x=1793934916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVQv90cVLZ+qJuF4mQ4kF8CxT7gJb59j0c9vMsRIsuI=;
        b=aaSqiqk/H1U8WEQGlWNsFZOX7aajgQfKPp5EL2DyY++KF2L86/T31dba7vVN0KR10U
         vv/GFiQEWjtG7RT/O/22jpjh1SOyfq5ljVTJ9dNEyc4BBf4IIKvTqVQaMOqZffXrmC+7
         MGQ7ZyZbdPgBafeq0sPoYsxHX7UER8ObJY4OvnEXCwkuq3zzLEC45mcLdRFgVwcqBWJK
         7ItWZtYxRqpwdGgUlpIhyiO1wXqPrISF7TmVtrxAQLRxewvRdX+s+udAPqo8POMS/PQC
         G4QFEcrRFME9cUHGKm0JmOa+gD294hUYUXV5GNRe2dD1ly5x3LtTmytlxRzTi8Cgqn4k
         jf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330116; x=1793934916;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AVQv90cVLZ+qJuF4mQ4kF8CxT7gJb59j0c9vMsRIsuI=;
        b=a2HwcQq5zzEaw4sQI2v/6u6IEUBf9BcrqfYsPpVu8sGCoxWHLsWq+SEqjsVVuF9ekN
         pYIP+kcZbR58fU9ddP7hjXA/kYxI7P/dyTB4/90b/JSqyqOut3VMxAQ4YxIC9D96YHwv
         y04J4LXkVuisGrgSEJCTsIZixj8UJ2cdKQnzqnxSSSmyfLlaMj+1Qk2pUodRInHqC8sw
         cUeNST+SazZRhQjBZcMj5iuzK4gawR5C8JfFAwIF7Bk5mZ8CgoND8rrP2unI0/662KQL
         Uvf2Phv3VActSBw/r87Lpar/YJqXF0pzWlW2d5egzCsj81Bea1eAaDst4/Bli95F5R+l
         vItg==
X-Forwarded-Encrypted: i=1; AKwUvBxtyQRxZHCfu83OFTfEC3NXioVLx6awnqLl0tvEGoCKP1uxIYaDxruFAtvbIG1Eja2QP1UmRJvHxrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtbqH3mtAMhqV+2P3M6Ve+yC8eS5vfQGPFDYBK6owmfZbAy1Tv
	rqWs5aq1NocNMLSK0xncUmqDHPKXh2VE6KSP5akm2RJ2k8TOCvlXJKvL
X-Gm-Gg: AYBFou0QU2ugB496JcKSsWmn4fPIeDiIQs0EABeHIdS1izOJGd9QI2OHxfCResHD5us
	V8XiiCuXHNs6PUxu7wdPYcXDVerdiFd8n0Ofor01GOLl5MC3NKl/vA7u1FRfCA7JuWFcjbNvGoD
	hnedrhpgQX157k3QFIhtGSqBCb2XuGUw7g4SkfB9H1rfgopKGKwe9YqkNlO9mNSrzLXjSN2+qrO
	9cw8lu5nRfiBm2+26bXD7LHESS6XbztDa4I1tVNWRmpr9ANgEjPAdPVnocDYPtab1jVDyeQADlF
	3Si6QV19q0zIP/JMY1KxO8O7/2kJz5piv9wfZzSX6kpn5nS1RPr0jEI4PSDHa0vTkoBWa6OQ4vQ
	aQ4wo+aXhs37co4cPz0nD8AbmcrAyQWFOZCk4ZpXWIdAj5i+0mzieV/cbXhF0aAWcg0xKl1S5/+
	UnHvIuIKl/jvNsM/EBV+Ac4X/VVRiRpjKLkAJPkT1l5zY+2eotLdGSAw8g/7vh2qgQObZ9nH1CI
	omYKdlp7lpuFX+ZA00u5cIt8lCcAIgGEtglSdu8d4cvA1ctIjZ449D0PDsrZTinIYcxd+KIVwfj
	RXDiFs2B32LGkbcjAfMJToBfWAzohtwGv6wxmEsjjQFi8Sm58ZTrUcPuOKzF181Qqa30ml/6akd
	/GeNjjbgoGU7NsDA=
X-Received: by 2002:a17:90b:1845:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3ae8974d028mr473136a91.24.1793330115599;
        Thu, 29 Oct 2026 20:15:15 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm6590630a91.0.2026.10.29.20.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:15:15 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v3 0/2] iio: adc: Add Nuvoton MA35D1 EADC support
Date: Fri, 30 Oct 2026 11:14:59 +0800
Message-Id: <20261030031501.130290-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add devicetree binding and IIO driver support for the Enhanced
Analog-to-Digital Converter (EADC) found on Nuvoton MA35D1 SoCs.

The MA35D1 EADC is a 12-bit ADC controller with eight external analog
inputs. It supports single-ended conversion and four fixed differential
input pairs: 0-4, 1-5, 2-6 and 3-7.

The controller provides four interrupt outputs, ADINT0 through ADINT3.
ADINT0 through ADINT2 are associated with the corresponding conversion
interrupt flags. ADINT3 is shared by the ADIF3 conversion interrupt and
the ADCMPF0 through ADCMPF3 result-compare interrupt sources.

The initial driver uses sample module 0 and ADINT0 for conversion
completion. It supports direct reads and externally triggered buffered
capture. The driver supports an optional external reference supply and
uses the internal 1.6 V reference when no external reference is
provided.

The binding describes the optional DMA request and all four hardware
interrupt outputs, including the result-compare sources sharing ADINT3.
The initial driver does not use DMA or result-compare functionality.

Changes in v3:
- Document all four ADINT0 through ADINT3 hardware interrupt outputs and
  add interrupt-names.
- Document ADINT3 as the shared conversion and result-compare interrupt
  output.
- Remove the redundant minItems/maxItems constraints from the fixed
  interrupts items list.
- Rework the channel binding for the fixed differential pairs and use
  single-channel for single-ended inputs.
- Add #io-channel-cells so the EADC can be referenced by DT IIO
  consumers, and define the cell as the logical channel index.
- Add firmware-node channel translation so sparse or reordered channel
  child nodes are mapped by their logical channel index.
- Restrict unsupported generic ADC channel properties including bipolar,
  common-mode-channel, settling-time-us and oversampling-ratio.
- Explicitly configure INTPOS for end-of-conversion interrupt
  generation.
- Explicitly configure the ADINT0 sample-module source and clear unused
  sample-module routing.
- Reset the EADC control circuits during hardware initialization and
  clear inherited ADC interrupt enables, result-compare interrupt
  enables and sample-module trigger sources.
- Add timeout recovery using the EADC control-circuit reset, followed by
  IRQ synchronization and stale status/completion cleanup.
- Use iio_push_to_buffers_with_ts() for triggered buffered capture.
- Avoid mixing cleanup guards with goto paths in the trigger handler.
- Add ARCH_MA35 || COMPILE_TEST and HAS_IOMEM Kconfig dependencies.
- Drop redundant linux/bitops.h and linux/mod_devicetable.h includes.
- Use direct regmap helpers, explicit REGCACHE_NONE and
  regmap_assign_bits() where appropriate.
- Use fixed-width register offsets and kernel time/unit helpers.
- Use size_add() for channel array allocation.
- Request ADINT0 by interrupt name.
- Improve system suspend and resume handling.
- Address review comments from Jonathan Cameron, Rob Herring,
  Andy Shevchenko, Uwe Kleine-König and automated review/testing.

Changes in v2:
- Reworked the driver to use regmap.
- Added optional external reference supply support and IIO scale
  reporting.
- Added optional reset handling.
- Added externally triggered buffered capture.
- Added signed differential conversion handling.
- Added fixed differential-pair validation.
- Added system sleep support.
- Added optional DMA properties to the binding.

Patch 1 adds the devicetree binding.
Patch 2 adds the IIO driver.

Chi-Wen Weng (2):
  dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
  iio: adc: Add Nuvoton MA35D1 EADC driver

 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 175 ++++
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ma35d1_eadc.c                 | 849 ++++++++++++++++++
 4 files changed, 1039 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
 create mode 100644 drivers/iio/adc/ma35d1_eadc.c


base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.25.1

