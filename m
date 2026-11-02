Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607147;
	b=izA5TPGY3B2saHH4Hyp9S+GXHXg1zUZhUgzHAXKd0MbAqOUEw+oAG2aiJDQVSckaJVNm
	 2UjUeYqa2hCvl6qXEG8hM8DRuLYJOI5BHe0tT2ydP8zcDLb4PtNJgqN49f9rZd1uFZGoq
	 4f2TPt+2nOSBIsvN0YjrjzeGBDLOZCn+MfTqjdJmHzE8SJpjjtF5zSc/PKB5QVJHItY4K
	 6GtOqdM7ja1abnZwGpjGxThn3wf0MdaTFmCncfXo0nRnqhQCpw/aAO1QPvVaCu6TFS3Yx
	 0luFV/9FuH+BB4pySfnULL7M18MbpJ/JEFGBMJgFGvVhlqdtjkxuPMnvxenIZDczxzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607147;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=b8qnclNDeg/wBRBuYo+vPDPmKmVssLsKQDXuSd+OAzs=;
	b=a2URQtyIfjwTBuQOFqE/ypyaz8btS8e/OWz7/A5FM2CP5cI5tzoOlE7c/ykrA9HnVIic
	 3uVj+c3/F+EMMa9glBQ8zTKb5jc4zDfOYOQFXSdwYGBhOqOtUg1dV2aIHRUVmkVI4a+d1
	 HhaFHPUmdzOGrbKYLRqNU7M33vUacwdRUq3mjUj9zoWYFMhg9dpLJgmuM67XgmZV9rUmJ
	 l0vjzXDIHoATr+qVpplgLfcBRyR5dgf12KZGdmUVDpVEMskQOZXH99EJR6TXJaO6wUmJ4
	 WAb4jUrcZencv9DB3a47Z/sYyDBu8MlyReOB/6O0WvePQGdXbGKCFTpHLaJA3nWDKVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jMk7rFxU;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PicmO23v;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0C606A32D;
	Mon,  2 Nov 2026 08:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C0C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jMk7rFxU;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PicmO23v
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A27mnQE3524861;
	Mon, 2 Nov 2026 03:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=b8qnclNDeg/wBRBuYo+vPDPmKmVssLsKQDXuSd+OAzs=; b=jMk7rFx
	UfEDFDd0KNkYU77C3N2rr5s6sZH/VHF3TvTkvEVkArCUJEql9aqWbpbx0N93OOXp
	pe4jpZ36cAILDee4IMJ8bGBZTIZZGgMKWNSVRfOOuIBjWo6MbbaX4jIIB4xX6Yth
	nHpPklwbSw2MI9rCWZJANidDW5/wP0aFS4mroYAEC5VgPZXFqy5AGGveXPzxhdlx
	iyeDUUBhbOMsAvS5HGJEVUurKQI2gS2fIz5tGOq5IjepwTmvkT8XcLyjIAfNmrIk
	fGHTYxzJ8wAgwXaXRl94VjnSHKU01x3Gibv5MXPSu2YOTAgJvvITusOIYPTUgTnd
	fTlo7tuy847caEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b8qnc
	lNDeg/wBRBuYo+vPDPmKmVssLsKQDXuSd+OAzs=; b=PicmO23v0JH2n9PVzW+Pn
	sAwhofQwK0ZFG0FobRBr2ImGCGDdZWu3UJzR4sRsHQi78LtysWYaFtOleK0hb8nI
	3EoubbtmzE/0YxdzCjRiMgSXHuJIETqOCHorjAEZVnpITumRsWcsiavctH0mO+eN
	QE85qhtAGSTEt9XZsmvg2TjYVZPePKm4Q/zRbL/xhZFqbptGhWc8nh4AQe7ShKTw
	YNlZlmF4QqeLaO/BcXPf+eWjv6WZ87ztrmXCmnvAnnHzf0q38LeObNXZDcOZWbKi
	YcYXPgYHf/pUw3TRE8z+PS0Wwb/jihtNedib2MZkTqMaLrhjl0U161drg46AR1d4
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hpjhas310-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 03:12:06 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A28C5oo030130
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Nov 2026 03:12:05 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Nov 2026 03:11:30 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Nov 2026 03:11:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Nov 2026 03:11:30 -0500
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A28BHNn011201;
	Mon, 2 Nov 2026 03:11:19 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <conor@kernel.org>
CC: <sergiu.cuciurean@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Date: Mon, 2 Nov 2026 10:11:10 +0200
Message-ID: <20261102081110.63080-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030-scientist-puzzle-ab2c668b6e27@spud>
References: <20261030-scientist-puzzle-ab2c668b6e27@spud>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfXw+kGYmMo6zK3
 a59rHiJXijEmFHIIzsI2Jd06tocgZBEZWPmYiw4Z/+NFqCCdK5hbq+EzDNo3Ci/LgZh3cTOeIcR
 1J3zJQGrcWkqPdCN/rnrwuE49kOJVLW90L00NmeUGinT5zYsWi0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX7ufdS/bZGGeg
 To/NP81RU4itvXdvuk0hWuCDO0KIP8hQniLfsbor6YaMkjN2wnRFxb9CYqRWSUwrq4Ecea7YPDb
 5Zv9Ja92NkRdQjMeBL4Yqe8p6OAe9TR9hRJRfuMj9hbiCnHrenDGDy6/2uzHd2KsL27JETdjgC8
 klpI9mG8NZMdQTDQJm3HFUbwGULTMOi34YuzOa6goQvFhnqn3AkSpXYcOcSqFSamQHEvOaxz2x9
 fIFrYCYPVBK8WOhuYA7LEwlFDUhE1/bxtVqwru2STsbJf558ByHPr79b24QMFPBVXM5T6a3f4N+
 vLx6tFrYRO9XzaQEd1E+Z1PaIyZO9T+Gq9p+6eMzQFHG+SmtrUpqIb9oVzb/8Cfobf/i39h2ydv
 rtX0ULy5Ex2LIXxxg4s4vj6Xv5Sr76e8yUmcIV11A3graQOCpzKshPNbBhDWb7gS9BoxKmO95wr
 ZG8OHuR+2ioA+HXiWPQ==
X-Proofpoint-GUID: Qw4vW1akE41VlwZQPjS8voaaOraAbAZ4
X-Proofpoint-ORIG-GUID: Qw4vW1akE41VlwZQPjS8voaaOraAbAZ4
X-Authority-Analysis: v=2.4 cv=cbtHPXDM c=1 sm=1 tr=0 ts=6ae845d6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=aO8zKRK-4mKEMOeOSlUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

On Fri, 30 Oct 2026 20:50:11 +0000, Conor Dooley wrote:
> On Fri, Oct 30, 2026 at 02:02:05PM +0200, Nicolae-Daniel Deaconescu wrote:
> > On Tue, Oct 27, 2026 at 18:28:34 +0000, Conor Dooley wrote:
> > > Why are we getting new devices with linear vendor prefixes?
> >
> > I'll fix this in v2. The binding file will be adi,ltc2387.yaml.
> > The -x4 compatibles will also be dropped, because they described
> > four devices sharing one AXI ADC.
>
> Please retain more context than this, it's not enough to just have what
> you're replying to. I see so many patches that I will have completely
> forgotten what you're doing by the time I get to the next day.

My bad, I'll keep more relevant info in my responses from now on.

> > > Hmm, ltc2387-16 does not appear to have these signals?
> > > Well, it has "cnv" but "cnv" has "sample clock" as the input name so is
> > > the clocks property above and pwm-clock can be used if the provider is a
> > > pwm?
> >
> > The LTC2387-16 datasheet has these pins: CNV+/CNV- (pins 27/28), which
> > is the conversion-start input; CLK+/CLK- (pins 23/24), which is an
> > externally applied clock that shifts out the result; and DCO+/DCO-,
> > the echoed clock. There is no clk_gate pin.
>
> Then there should not be a clk_gate pwm for this device.
>
> > The part needs a burst of 8 CLK pulses per conversion in one-lane mode
> > (4 in two-lane), starting t_FIRSTCLK = 65 ns after CNV and ending
> > within t_LASTCLK = 49 ns of the next CNV. So the CLK input cannot run
> > freely: the clk_gate PWM gates the host clock into that burst. [...]
> > The clocks property is the reference clock the PWM generator runs
> > from, and the driver needs its rate to compute the waveforms.
>
> Then you've got a "layering" violation of some kind here. If this clock
> is consumed by the PWM generator, it should be an input to the pwm
> generator not this adc.

It IS an input to the PWM generator, The ADC node references the same
clock only because the driver has to know its rate to compute the CNV
and CLK waveforms in clock cycles. adi,ad7625.yaml does the same.

> The second pwm should then just be called "clk", because that's the
> input(s) that it represents.

I'll rename it to "clk" in v2 and reword the pwms description. ad7625
uses the name clk_gate for the same signal.

> I want to see what the dts you have for a complete setup of this device
> looks like, including the backend and pwm generator.

This is an ADAQ23878 on a Zedboard, two-lane, with the AXI ADC backend,
the DMA it uses, and the AXI PWM generator. The 120 MHz ext_clk is what
the HDL provides to the PWM generator. Supplies are fixed regulators here;
VS- is 0 V.

/ {
	vdd_5v: regulator-vdd-5v {
		compatible = "regulator-fixed";
		regulator-name = "vdd-5v";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-always-on;
	};

	vio_2v5: regulator-vio-2v5 {
		compatible = "regulator-fixed";
		regulator-name = "vio-2v5";
		regulator-min-microvolt = <2500000>;
		regulator-max-microvolt = <2500000>;
		regulator-always-on;
	};

	vs_p: regulator-vs-p {
		compatible = "regulator-fixed";
		regulator-name = "vs-p";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-always-on;
	};

	vs_n: regulator-vs-n {
		compatible = "regulator-fixed";
		regulator-name = "vs-n";
		regulator-min-microvolt = <0>;
		regulator-max-microvolt = <0>;
		regulator-always-on;
	};

	vref: regulator-vref {
		compatible = "regulator-fixed";
		regulator-name = "vref-4v096";
		regulator-min-microvolt = <4096000>;
		regulator-max-microvolt = <4096000>;
		regulator-always-on;
	};

	clocks {
		ext_clk: clock@0 {
			#clock-cells = <0>;
			compatible = "fixed-clock";
			clock-frequency = <120000000>;
		};
	};
};

&fpga_axi {
	rx_dma: dma-controller@44a30000 {
		compatible = "adi,axi-dmac-1.00.a";
		reg = <0x44a30000 0x1000>;
		#dma-cells = <1>;
		interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&clkc 15>;
	};

	axi_adc: adc@44a00000 {
		compatible = "adi,axi-adc-10.0.a";
		reg = <0x44a00000 0x10000>;
		dmas = <&rx_dma 0>;
		dma-names = "rx";
		clocks = <&clkc 15>;
		#io-backend-cells = <0>;
	};

	axi_pwm_gen: pwm@44a60000 {
		compatible = "adi,axi-pwmgen-2.00.a";
		reg = <0x44a60000 0x1000>;
		#pwm-cells = <3>;
		clocks = <&clkc 15>, <&ext_clk>;
		clock-names = "axi", "ext";
	};

	adc@0 {
		compatible = "adi,adaq23878";
		clocks = <&ext_clk>;
		io-backends = <&axi_adc>;
		pwms = <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
		pwm-names = "cnv", "clk";
		vdd-supply = <&vdd_5v>;
		vio-supply = <&vio_2v5>;
		vref-supply = <&vref>;
		vs-n-supply = <&vs_n>;
		vs-p-supply = <&vs_p>;

		adi,gain-milli = /bits/ 16 <870>;
		adi,use-two-lanes;
	};
};

One more thing, on the cover letter Andy asked whether this should be
done in an existing driver with per-compatible chip data instead.

On Fri, 30 Oct 2026 16:41:27 +0200, Andy Shevchenko wrote:
> On Fri, Oct 30, 2026 at 12:08:08PM +0200, Nicolae-Daniel Deaconescu wrote:
> > On Tue, Oct 27, 2026 at 17:56:43 +0200, Andy Shevchenko wrote:
> > > Why have you written a brand new driver?
> >
> > ad7625 is the closest existing driver, and it shares the transport:
> > CNV PWM, clk_gate PWM and the AXI ADC backend. The converters differ
> > in a few ways though. For instance, the LTC2387 is DDR on one or two
> > lanes. ad7625 is one bit per clock on one lane. Also, the ad7625
> > clamps the period to 100 ns (10 MSPS). The LTC2387 runs at 15 MSPS.
>
> But these difference doesn't explain why you need a brand new driver.
> Is hard to configure this at run-time by choosing the respective driver
> data based on the compatible string?

On Sat, 31 Oct 2026 10:36:27 +0200, Andy Shevchenko wrote:
> On Fri, Oct 30, 2026 at 05:07:05PM +0200, Nicolae-Daniel Deaconescu wrote:
> > On Fri, 30 Oct 2026 16:41:27 +0200, Andy Shevchenko wrote:
> > > But these difference doesn't explain why you need a brand new driver.
> > > Is hard to configure this at run-time by choosing the respective driver
> > > data based on the compatible string?
> >
> > Looking at ad7625.c again, most of it can come from chip data,
> > like the driver already does for max_sample_freq_hz. The lack of
> > en pins could probably also be parametrized.
> >
> > However, doing it this way would risk clashing with the sampling
> > path of the existing driver. Keeping it separate would make testing
> > easier, as well as isolating drivers for unrelated families, which
> > might be out of scope for this.
> >
> > Ultimately I think keeping them separate would be simpler, but
> > I'll integrate it if you believe it's worth it. We might also
> > need to consult with the authors of the original driver, as I
> > haven't worked with the ad7625 before.
>
> If there is no big differences on RTL or programming flow, no need to create
> a brand new driver. Even if there are some differences which are minor, we
> may quirk that in the code. See infamous drivers/gpio/gpio-pca953x.c for how
> many similar, but not fully chips are supported. With your elaboration above
> I believe we may join these drivers to the existing one.

Andy would rather join the drivers. If we port all of this to ad7625, the
LTC2387 and ADAQ2387x compatibles would be added to adi,ad7625.yaml instead
of a new adi,ltc2387.yaml, and the two PWMs would keep one name for all the
parts. Would you prefer that, or a separate binding for these parts?

Thanks,
Daniel
