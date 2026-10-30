Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361751;
	b=1ThrdXvG53lCcvgkoOLgB+CeXGUCLwTt9w9z5CwiHwobXuJn33eyDXUq0AWiWFYbpDIT
	 GyiyhypVjJ+6CyNtT9x29iNTmrZEFTPbJegnA+Ti8LIXrLJ143VDPC9A9OOX3AR14QkBR
	 74SKSb8Pc0s2qecWGAn1tir2iyrkWWpN46/c0m243xW8fSrgdkgClGOumyd4q0qcJzCYZ
	 HIgKtSeXQ9ZPuqk/ov23ntY0MeiWLZLSzq7c0jnisQaedhOUzMuO/g9JUd44lRQxl+icD
	 FyihUBaUi0zvH6NDwUsE07tw617/Y7pUydSfcR0PEMKgzU3POuBPEDzsUkh4bgE3kBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361751;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JzqXssl8m3HG14RseNxta+R2J2slfsX+aAyBTx3LA54=;
	b=yQjswSbLB0/Qg7AwDClfKrErv4JaYluuuat9gFAK2d7szn5zz/3tpCtoEVLkWE59jVzz
	 VF/Ad9KM/MwJ2CkuClgluBMFZ3lzFSPWFc4eGUKkfexULK7sJJOC0W9fpUXVIW2lCfbUw
	 /WfUSEZtCT9zAS8m7KMqbFpYK2NcrujI2UT/GKzI7hTL7tBt0cz/5MzlbE6jEs8c7l6md
	 lVMN57FdhkKig+OUC/7W6KlZ2XrqSPXIdY4F7a/OChmFs0gPGzfvQnnUqeoZoX69TrQ7/
	 5OrSgz6aVIrRvUzNofAAxn1lyJ6N0PH1tvoZr3K3kaZHYa1EOd7nnT0CGk86T7nirYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OJna+IR1;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dgBePCZk;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09A606A31A;
	Fri, 30 Oct 2026 12:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C09A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OJna+IR1;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dgBePCZk
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBHePb078296;
	Fri, 30 Oct 2026 08:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=JzqXssl8m3HG14RseNxta+R2J2slfsX+aAyBTx3LA54=; b=OJna+IR
	1GeRkzo+v8IWQC57JPCep6bRdwEaqPMxOrXPlVVR7yW76EB8yK681IminGVxMR7J
	/OZdLgsDGwJAb/ss6n2LOseeBLuYh5eDXgjarIofyuvy9pr0KqaF2YB0c2ZIWc2q
	yF0crC4tBulNquCcTOhH5OAsL0BEd62PLDT7fb9PZrGTuP0o77xopE0SWVV45j2F
	PEROOGjFLzr2zXQ0+JcXG4t9CttUL/xzl8GeDPRYpp69xBRnHST3gZ50QYPOcrQU
	OD+oJI1swydsFSDiaw8MCHtSOf1HOrnsvPuiyoC1SPU2WtEpYK14Ib5vYiaqmqa9
	NiPsS5IJ2wC0HWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JzqXs
	sl8m3HG14RseNxta+R2J2slfsX+aAyBTx3LA54=; b=dgBePCZknftbGBoHAGm0z
	akl/9qKSDsV6lRq4AMD8xVYXn02/T8gvmeksE12uL0oC9uH0Y6AdU41ZO/7PBng5
	jtHnb4m1q/JvH+YQeuzQ+kfNxGE+mytQ42BiIq3Db91B4R5Kl8+KvaDgZ/jY5j8C
	Up3XlF388x+cNDJnKp/kjS7g88Pju9HmKNL7khSX6/h02BcOzrwD9Qe95M1eEVcy
	Z2idy5WiqxFAxFRUAuiB0ID/IU01MOpLtIRwXWwTLZBOMbDT7RVP06LI8TBD3xxB
	1ZFyGIznxO0dzqkhFBlrbuyP0aThKG9SISHNbKHlc0l94RySNZmGgy97ojMzsbHf
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7buvc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 08:02:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69UC2Ovv026736
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 08:02:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 30 Oct
 2026 08:02:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Oct 2026 08:02:24 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69UC2B9E016763;
	Fri, 30 Oct 2026 08:02:14 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <conor@kernel.org>
CC: <sergiu.cuciurean@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Date: Fri, 30 Oct 2026 14:02:05 +0200
Message-ID: <20261030120205.269090-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027-attic-collector-cb4ffdb5cf82@spud>
References: <20261027-attic-collector-cb4ffdb5cf82@spud>
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
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Hk5XRrQC3cZW5DmCILpOZeO_V4L6-Nk0
X-Authority-Analysis: v=2.4 cv=T9AZ3PKQ c=1 sm=1 tr=0 ts=6ae48751 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=ZHbhB2N8C6C_tFmOh_cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfXysXXnu4zintv
 dN4N5XGBfDZpMDCzr3oFQPIecJh0wptgAcs9kuScElrhVvNSSp/bmdht2sCaK4vnTCl56NMv/7F
 PSEMYkYfFF5gO1tVQTzmPBrli/VZfdpr6JtxF3tb7FkkQ5xailaz
X-Proofpoint-ORIG-GUID: Hk5XRrQC3cZW5DmCILpOZeO_V4L6-Nk0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX5dRUpZ5bBQlQ
 woGqepaTM57YpG8bjUWmFGaPH8jFIm/T3MKi3lmGeaBxDMkDRwgyN/7OVbs6kUIAXi/3hiElgje
 9ckhjNvt2+dwmxJMJOUd2JN8OBUP1EQD5/g5krMoFHx1CgckHSC74scpeOLl6dEyWDcZGIOMsSA
 e6SnL7NUloD0+8K9rMpqEc1uvwAbbGwBZ5u904OXKUbqKov3iRTM5+P1opDYoNgyy38J1Tvngab
 wEZPpYrJN7Z4bkILFmqGFAk4ecRt29HX2fO4NRLJxTYAxpepC0/Fx1MpAOCzwE3sH7lFLbzjtSA
 R3gALWwyoUWgrklYcZDALTX5iy83o4Vc0h5vlfu7IVjyvlnEMURNp4SBgmIzA9hQGTxxio4kHJ+
 uU5UWGZbP+6GUYlhf6v3TcPM53VYhso6xVfWPBzir7FknDifELJQf4gfv7FY3f6DqH9kfBHSAi2
 UyWepEAjSnA9VOt9Ubg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300047

On Tue, Oct 27, 2026 at 18:28:34 +0000, Conor Dooley wrote:
> Why are we getting new devices with linear vendor prefixes?

I'll fix this in v2. The binding file will be adi,ltc2387.yaml.
The -x4 compatibles will also be dropped, because they described
four devices sharing one AXI ADC.

> Hmm, ltc2387-16 does not appear to have these signals?
> Well, it has "cnv" but "cnv" has "sample clock" as the input name so is
> the clocks property above and pwm-clock can be used if the provider is a
> pwm?

The LTC2387-16 datasheet has these pins: CNV+/CNV- (pins 27/28), which
is the conversion-start input; CLK+/CLK- (pins 23/24), which is an
externally applied clock that shifts out the result; and DCO+/DCO-,
the echoed clock. There is no clk_gate pin.

The part needs a burst of 8 CLK pulses per conversion in one-lane mode
(4 in two-lane), starting t_FIRSTCLK = 65 ns after CNV and ending
within t_LASTCLK = 49 ns of the next CNV. So the CLK input cannot run
freely: the clk_gate PWM gates the host clock into that burst. That is
why the clock needs a PWM and not a plain pwm-clock, which would give
a continuous clock. The clocks property is the reference clock the PWM
generator runs from, and the driver needs its rate to compute the
waveforms.

> Please explain how this is not determinable from the compatible.

TWOLANES is a digital input on the chip. High selects two-lane output,
two bits per clock on DA and DB; low selects one-lane output. Both
modes exist on every part, and the pin is set by how the board is
wired, so the compatible does not say which mode is used.
v2 will contain more detail in the description.

Thanks,
Daniel
