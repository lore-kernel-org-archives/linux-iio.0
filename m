Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329053;
	b=ftiOSGZtl8BVPU7i1Xia7QWxruYRKtH2ZyAvRr3D0/w7HcoC7rJd2L2TW/IzM5ZKwfd0
	 7oMAT5JwY0aNWbegAc+tvR62yQrusw5rpp/xOTzRsKD/YPtP9vbDb89pbz301eX44BW15
	 +zdewdoRrNprJ1JQwtv/mfwCrGKqfyr3f2oaVgjLNz5GxDTi/47jR62g47BxAykEbgTCK
	 6Kjd1Bs5rgAVV/WtLBwiU96E1G+G9QuZj0mqp7ucaQZvIjJDgCZvoDGTLbUs2vYG0PDsg
	 ISQz8Zq5efiyYidSeHpUq1CFQgrSp2swOaCJIJVHDdstdT86HxY/EaeszQnCJ8Es1IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329053;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=9SNgwiEjpXpdL0MUMhS19ZFeEP4o8lMFcQpCLGPkxOs=;
	b=k7+IJAFQhI+Nmuvu/Fbj+uTBdt7eWU0fbQJAN3eznvccvnKoJTv/DWOq1fxgezzhOKwG
	 vaald48PbwoHRjrHo3cJ5Gt9Nu258TLmiO0XnVMxLyKlIdOz/vJ1Pz42fvIHiKpAYU8c1
	 x8PMFpDDaEIGshfjEXRVdRj/YGe1QYct5TNQ1P55up7AXSoyQF4JPvxQ76P1FfhRZqnA/
	 b+AK1/Pc2IkcCUMlLkfp/KtHK0r+dT1ItDy6bhPA+tOXOgpqh7c1aDhWfHWsKFyAssPwQ
	 wIwR1quZYQctGLG1698DDZIJG8wCu5JpuYyz6DIeQAsNr+Bbs+PZKG/TyUWrNCDBmJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YhNzZrpQ;
	arc=none smtp.remote-ip=91.218.175.148
Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEC606A330
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 06:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AEC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YhNzZrpQ
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rEm/n/NoaYAE0zuiKeGG2cf85FeHzG8S1ai+3/IdKPU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795329049; v=1; x=1795933849;
 b=YhNzZrpQNTOrBdGOSOGgMTiERFBKAYXKjW3545SyiQCNsvZXxwrwa1v5xKMcwRxBwEXAx1Pe
 /kx98GQZdtJ4Qy2YQ9GajTzvRtaCK2UJjWCfRsMf/EU5wM3tb7f8hcdtqFBPDZ/NxlNpdYoiLPR
 KTTtsqk16dUzkJhQqhKhMNpY=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 583ca260f1c69be2;
	Sun, 22 Nov 2026 06:30:48 +0000
X-Mizu-Trace-ID: 583ca260f1c69be2
X-Migadu-Flow: FLOW_OUT
Date: Sun, 22 Nov 2026 06:30:43 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: jic23@kernel.org, andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, conor+dt@kernel.org,
	joshua.crofts1@gmail.com, maxwell@maxwelld.cc,
	u.kleine-koenig@baylibre.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	akhilesh@ee.iitb.ac.in
Subject: [PATCH 0/2] iio: chemical: Add driver and bindings for acd10
Message-ID: <cover.1795326744.git.akhilesh.patil@linux.dev>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series adds support for Aosong ASAIR acd10 CO2 (Carbon
dioxide) sensor driver in IIO subsystem. 

Patch 1: Adds bindings for this hardware
Patch 2: Adds driver code for acd10 under drivers/iio/chemical

Quick overview of acd10: 
- This is CO2 sensor based on NDIR technology.
- Can measure CO2 concentration up to 5000ppm
- Supports serial interface over UART with 1200 baud rate. 

Datasheet: https://www.es.co.th/Schemetic/PDF/ACD10.PDF

Protocol: 
acd10 defines 4 types of UART frames - read co2, get software version,
get instrument number and set single point calibration.
Frame format: fixed header, length of data, command code, Actual data,
checksum. Response from the sensor follows same format. 
Total length of each tx and rx frame for 4 commands is fixed and defined in
the datasheet. Driver uses this information to write and read from
sensor for each command over serdev interface.

Testing: 
Driver is tested on Texas Instruments am62x sk board with sensor
connected on UART5 on 40pin IO expander. Additional 3.3 to 5v
bidirectional logic translator is used to interface with 3.3v IOs of
am62x. Values are read using iio sysfs interface. Also I have blown into
the sensor to observe sensor output increase due to CO2 in my exhale.
Waveforms for read co2, get sw rev and get ins num commands are
validated on logic analyzer. 

Slight deviation from datasheet: 
For command get software version, datasheet mentions frame length of 16
bytes including D11 reserved, however it is observed that sensor sends
15 bytes with length field 0xb (11 bytes of data), but actual data is 10
bytes. Hence, this is handled in the driver.

Driver supports reading co2, getting sw version and instrument number.
Single point calibration and preheat implementation is left for
future contributions.

Akhilesh Patil (2):
  dt-bindings: iio: chemical: Add aosong acd10
  iio: chemical: acd10: Add driver for ACD10 CO2 sensor

 .../bindings/iio/chemical/aosong,acd10.yaml   |  34 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/acd10.c                  | 365 ++++++++++++++++++
 5 files changed, 417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,acd10.yaml
 create mode 100644 drivers/iio/chemical/acd10.c

-- 
2.47.3

