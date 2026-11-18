Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007018;
	b=siFm0A//D/TmQ2SAOOEFo7WeV5kEtEoGvxbd8zey8qTPcwqNl2qooHQX7RfWmkk4zPZ3
	 czVvRLYe/LY91IX3eiMkwKipH/WcfhQI6DWJus8OcLVQIMTNOqfA116v7iE80KMPj5sC0
	 0vc5ZPoB2kZRTD5e2m5Eq5RBBFAsou9fUhzD73H5LJi0r/ctt4fcjEY3lfqbhObUMwYBd
	 FZSGXM4uwvEPuzubnm67Oy/luKQ+iMXC82XxLHaE4HR+jwTIhiHIvIu9sJhDCjzXtcjmr
	 CovZlUdPiZ1WrBkTLr9PRcIe1NAqN8NWnGEoaTw5cKBjD7KYIjFztSwl3HqUVi5p6jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007018;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kgZQEASUBP3ntLbkT5Q29W5UYqyrJ8I1D62YoxotWP8=;
	b=hiyyXvQA2xNL5o3OJkEA/z3mVZuzr/5wRG4kNEpol9+yv1xRU8q0n9J7KIuuYIHDdnay
	 +y5SRoBlbgZ+wsaILxfBJrzfv25y9Dx64WMzr/ZlGdLX1nemx+jSIouXp5nGZU4xDL9Wk
	 MjQwR1v5aJcyYx3lH2cN+OrwFVlZrNnDv23jeuHsWdyJa3SvyNFjBwojsog08q/Vzpi1B
	 1A2vRkyLDPk7kyOThGQHAhZPqridf6bc1s9yFbDYWFRb3hB5UzALaXikt7HgnRUjZbVUN
	 PHlCf2oq3xe3jWeWr1e4hLDtcl128GIAH0orc69hw6I71ZFOzdM/tAWb1tXbcFK3dJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=G3sDCcFA;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Yf5mQL14;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB8606A320;
	Wed, 18 Nov 2026 13:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FAB8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=G3sDCcFA;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Yf5mQL14
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBKjci2662548;
	Wed, 18 Nov 2026 08:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=kgZQEASUBP3ntLbk
	T5Q29W5UYqyrJ8I1D62YoxotWP8=; b=G3sDCcFAzsTSmqQduOGBCo5PQ2eHbGiw
	4/UMSqTJEmWumFuwMH+NWc4rUm0jtr85picjt+EFSxgCyYmm9NrolO2/ezhISazi
	iSqui/VsNGJbpvXNV289W78NYq38r4tiAGJK0Rd2/hKUmlM3iJTYsxsWVXElaw7y
	ycnBC9G5Wl31wwz19UdtcWLfiB7jj8bDKTXe8djyEAEAdU39UzVn1XBhYFp+Vr/h
	jEUqggWxYm57O+AuQF+JRCqXsYB+DD3OiI7ZnXc+bEVLevWVX7zt3jak9SZyiDfH
	zwrYrEbi2ykd4d6TZKeQWOtXPP7wxH2uwk4qmw/31SgepZ0haUpKJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=kgZQEASUBP3ntLbkT5Q29W5UYqy
	rJ8I1D62YoxotWP8=; b=Yf5mQL14U06eHk6cf0MA6BRNQ6iKpPcWY3jY/z1VHhI
	w0Y15VI+jCbkrUmUTKPZN8OlXweXgAGcujNhvv4/3nTIbVpoGUcusqyxpUZnDosG
	Y9cphz0kAc8YhDjiUgmRy2j7H7MyizZYHi/MPdEIEH6Ifq7nj2uTeND5ogdO4C6q
	lXDWBkUkg40GSB2XZtoqcDcMtdAU9tjBVZGZQZvDlHEFktY9ij62uE+gUjJCOxaA
	LewJSq6zm7AYTDowt2cfp3VgcC80w7Y2bWZSGK9iKhkm2ZubRtkZDBYK8RxTkM80
	bJU34ej+M5Vzx48z/6kr4c9ykv8AEUyq46oEj7WoVbw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j0yucm6wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:03:17 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AID3GfQ057486
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 08:03:16 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 08:03:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 08:03:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 18 Nov 2026 08:03:15 -0500
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AID30NX007207;
	Wed, 18 Nov 2026 08:03:03 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 0/5] Add support for ADA4355
Date: Wed, 18 Nov 2026 10:02:53 -0300
Message-ID: <cover.1795003864.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: U2wsWzrRILtkQ41ZMb-ohuinjELmTuvs
X-Authority-Analysis: v=2.4 cv=TILQ2Fla c=1 sm=1 tr=0 ts=6afda215 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=qmOXhYLVU3f7kz68z08A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfX1aqHzrNNskBo
 VRukDYnqAKqYlD/SvFKrLcnGWZ15dJGImzj/Xuy0kJ7Ksdp05CCSrSe1BiF80I8OHoBpNUzIbVf
 XHRqEG/jWZwh14DtIaPTY7pMRWY6gy1HmQkO2x3MDZTb8KB5P6hCTT+wqeBYw4ySJsvMmO32x4y
 lf+dGXpzkNXIpqth5Uj27lBQlYkU9bymKKUkFHe9Dz5D+X45GhLd46QsP8x5MXtq3lfZcwjoYF1
 TVJrxrTwHFatUrisltHUjad5DUHTqbUGDgmAqQSmQdK11Cn0480lKNOS9jj5XtOQoPmsPG6n5N0
 tHekmaA35OKnQnQwvB6p/3FjS8J3GTZmspJQxt9ZN6yLn0XcI0rFDLClwsgzDpe9nG3V0Hr1lDU
 NNGTuc6S45i1S9AKq3794ihKI3f3n2itCET5sCXYb4M+quWhY865ppmMFBhB9FTuXJ6iCzqV4x2
 yLy19rO+TLcJhVm40aQ==
X-Proofpoint-ORIG-GUID: U2wsWzrRILtkQ41ZMb-ohuinjELmTuvs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfX2YHYTZJywCJY
 We9MXVjQA/NGWdBcn6ERT72aucxvGxL2u4d45vMHKoLBSe4vFEjnqlPRg0jkRSTpLl7RQH6mGjg
 ud0L1IR7Rk2DjlVXQYFFGytu3RaUpFDs+JpjUoYG0r6xpbZ/abGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180051

ADA4355 (and ADA4356) are programmable transimpedance, current to bits receivers.
ADA4356 main difference from ADA4355 is the set of configurable transimpedance
(Tz) options which result in different scaling to miliampere units.

ADA4355 is partially similar to AD9467 in that both chips contain high
performance ADCs and output data through pairs of LVDS data output pins. Though,
ADA4355 is also different from AD9467 such that squeezing ADA4355 support into
the same device driver would probably lead to a lot of rework.

According to LLM, AD9467 vs ADA4355 main differences are:

┌───────────────┬────────────────────────────────────┬────────────────────────────────────────────┐
│               │               AD9467               │                  ADA4355                   │
├───────────────┼────────────────────────────────────┼────────────────────────────────────────────┤
│               │ A standalone 16-bit IF-sampling    │ A complete current-in to bits µModule:     │
│ Type          │ ADC                                │ TIA, LPF, ADC driver (FDA), 14-bit ADC,    │
│               │                                    │ LDO and all passives                       │
├───────────────┼────────────────────────────────────┼────────────────────────────────────────────┤
│               │ Differential voltage, 2.0–2.5 V    │ Single-ended current. Linear range is      │
│ Input         │ p-p programmable, 530 Ω / 3.5 pF,  │ −80…+800 µA at TZ=2 kΩ (scales ÷10 per     │
│               │ 900 MHz full-power BW              │ gain step), survives 40 mA, 2 pF           │
├───────────────┼────────────────────────────────────┼────────────────────────────────────────────┤
│               │ SPI: reg 0x18 full-scale (2.0–2.5  │ Pins only: GSEL1/GSEL0 pick TZ (01=2 k,    │
│ Gain/range    │ V p-p), 0x0F external VREF, 0x2C   │ 10=20 k, 00=200 k, 11 reserved), FSEL      │
│ control       │ AC/DC coupling, 0x36/0x107 buffer  │ picks the LPF (100 MHz / 1 MHz). They have │
│               │ current                            │  no pull resistors and must be driven      │
├───────────────┼────────────────────────────────────┼────────────────────────────────────────────┤
│ Bandwidth     │ 900 MHz                            │ TIA 43 / 18 / 1.6 MHz (per TZ), then LPF   │
│               │                                    │ 100 or 1 MHz                               │
├───────────────┼────────────────────────────────────┼────────────────────────────────────────────┤
│               │                                    │ Offset: 0 µA gives +0.825 V at the ADC,    │
│ Transfer      │ Bipolar around mid-scale           │ and full scale is 1.65 V/TZ toward −0.825  │
│ function      │                                    │ V. In practice the signal is unipolar and  │
│               │                                    │ inverted                                   │
├───────────────┼────────────────────────────────────┼────────────────────────────────────────────┤
│ Applications  │ Radar, wireless, instrumentation   │ ToF/LiDAR, OTDR, mass spec, optical        │
│               │                                    │ sensing (10 ns pulses)                     │
└───────────────┴────────────────────────────────────┴────────────────────────────────────────────┘

The most relevant differences at SPI and register map level are:

┌────────────────┬───────────────────────┬───────────────────────────────────────────────────────┐
│                │        AD9467         │                        ADA4355                        │
├────────────────┼───────────────────────┼───────────────────────────────────────────────────────┤
│ Chip ID        │ 0x50, plus a speed    │ 0x8B                                                  │
│                │ grade in 0x02         │                                                       │
├────────────────┼───────────────────────┼───────────────────────────────────────────────────────┤
│ Start-up       │ Nothing mandatory     │ Mandatory sequence: 0x00=0x00, 0x05=0x02, 0x22=0x03,  │
│                │                       │ 0x05=0x31                                             │
├────────────────┼───────────────────────┼───────────────────────────────────────────────────────┤
│ Device index   │ —                     │ Selects data channel, DCO and FCO                     │
│ (0x05)         │                       │                                                       │
├────────────────┼───────────────────────┼───────────────────────────────────────────────────────┤
│ Test modes     │ Modes 0000–0111 only, │ Adds 1000 user pattern (with PATT1/PATT2 regs         │
│ (0x0D)         │  no user pattern      │ 0x19–0x1C), 1-/0-bit toggle, 1× sync, one-bit-high    │
│                │                       │ and mixed-frequency modes                             │
├────────────────┼───────────────────────┼───────────────────────────────────────────────────────┤
│ Analog-side    │ VREF, coupling,       │ None. The datasheet says the registers "configure and │
│ registers      │ buffer current,       │  control the ADC only"                                │
│                │ offset (0x10)         │                                                       │
├────────────────┼───────────────────────┼───────────────────────────────────────────────────────┤
│                │                       │ DCS on/off in 0x09. Digital reset (0x08 = 0x03 then   │
│ Other          │ —                     │ 0x00) is required if the clock was not stable at      │
│                │                       │ power-up                                              │
└────────────────┴───────────────────────┴───────────────────────────────────────────────────────┘

This patch series was assisted by LLM and introduces some code duplication from
AD9467 into ADA4355. Though, my estimation is that this is going to keep things
easier to maintain than adding ADA4355 support into ad9467.c.

With best regards,
Marcelo


Marcelo Schmitt (5):
  iio: backend: Add calibration source interface
  dt-bindings: iio: adc: Add AXI ADA4355 IP CORE
  iio: adc: adi-axi-adc: Support AXI ADA4355 IP core
  dt-bindings: iio: adc: Add ADA4355
  iio: adc: Add support for ADA4355 and similar ADCs

 .../bindings/iio/adc/adi,ada4355.yaml         | 104 +++
 .../bindings/iio/adc/adi,axi-adc.yaml         |   1 +
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ada4355.c                     | 798 ++++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  66 ++
 drivers/iio/industrialio-backend.c            |  23 +
 include/linux/iio/backend.h                   |  22 +
 9 files changed, 1034 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
 create mode 100644 drivers/iio/adc/ada4355.c


base-commit: 94921bc9eb214f838481faa847cda5c42e486013
-- 
2.39.2

