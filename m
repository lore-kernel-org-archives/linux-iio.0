Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233304;
	b=0XrQMBxxezz+TKNs5h93JbKeVeqa80GKoxbtJ0NiI0aTdQjj9P3q9duPDmTx+sqCaFf2
	 v1HmJ4xTn4arvLBgJswDGoeF7cpBpJzJx6bsX5rodUVu2iyM7Nigkoo8ZuNCslLDwKLZY
	 UGe+iC+4zvVeL66q2vo0aCHdxQ4rOL2+WxyK7mx8n0R3zhGriUYG7x7ik+YR1DjpapE0J
	 t+ZC2MGdeGEcka3yP/Vmf/jb9HeeZLHm/EGo56+67kJAd8LBuYns7Voc+9BzN7EO2M5K5
	 RASFs9BO4mcChEV2g5kbfX3ui90ukiPZDP62tqKt0ApgxPNy4FxXNOZ1dipT4Gy0wGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233304;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VpGEIhEQq4GvGXIOQ5z1g2qtxYMt46SzWA2+7t7AT44=;
	b=3dEIDZnURRVjWw19b+s+7vAOZ58Ba0rPU1XBfQq4m20XhtLWgdKYVk3HaZs3moKAiT60
	 oU+4kcocXWrHLmphD8dWV/SuvE8Yv2Fvtm5j5MCFEV3ZLpKQTCvezw7DaGmxvIXMecJY1
	 4rG3dVOJj2BRFwRF0/4O/C4Hh4K4XtjA8zJF1VY9hyGIkGkewdMPtivzfIoQcbLqos7e9
	 Pl+GNUvWd7z5jE3vPG2mMCczzPDRtg70aGWX+E8FcgGs0T111wdajSce4ra5qpusGYizD
	 FttByadozrR13+XBgj17fRQ/AoZ1qAjNOZeO4N40B2KiIWmLj7TgCy4Uy6mzLtJEQPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dzGI9MRs;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="E/HkI6lo";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DF606A323;
	Mon,  9 Nov 2026 14:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944DF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dzGI9MRs;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=E/HkI6lo
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DL0ns4062706;
	Mon, 9 Nov 2026 09:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=VpGEIhEQq4GvGXIOQ5z1g2qtxYMt46SzWA2+7t7AT44=; b=dzGI9MR
	sFcJ+guVObGtu35P3iU9tBcE7fFYgEMzBtBW6Wc3uRvmmozKfAeKJvmKN8W1x4CX
	exqkyfxXgX7lukxi9jSF+NK6qFvtRWCOc+fIA85r0W5vVW5WKSndEP89VTNh1xtZ
	Dpqzilloc0aQPAuPJw18l4NxSGP+6Ha5KQwbh8i35DErtI1SIDw/3ijqdxsyaaxz
	YdVqbZo92dtPfyxgoQ9t+ceZ1AbSfCWnwbUWT9vfzkFhwxytooopieXRFAqazPgH
	il4DbWJUmd6FA90xHMZwCoxJEHw37dHpbOPES/Se8BnwXFhR3DupYvlQcvoNw+Lm
	dmtbTfdwOVox2ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VpGEI
	hEQq4GvGXIOQ5z1g2qtxYMt46SzWA2+7t7AT44=; b=E/HkI6lo+sBuZs5FGyaSE
	wyWa+6FyaHm/5BGg1ZGOOVl4CUFRCK0X5C5IxdN/XDfRi54MI5OTbxy2ctb0Z1e7
	3uMSNC7MDJasvxHfOJ/5vqrkGh8YIB1Q22V6cQCLM8WRVDJSrRfDAy8ewfmEUcgY
	VPNG5bRz7+NQUlnNgq3PMoppbscoxY8TZzkNYgWVWI8jQN+fCpum7qD4ZNpQqW1R
	RtOPXFtzcBzJkbtff0BWoDlxBPUj5iFx/i/Yr8s9WAjXV2hzl4YCNdKP30KKzB1J
	/yKJnH3yKDSmAuVfhcwL3Z7q6zjlUJhkvjCrZFLUtXeK40uOVogeyeaVvwu4Xun5
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hues9rdq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:08:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A9E8JUA064680
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 09:08:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 09:08:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 09:08:19 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A9E87Ae024983;
	Mon, 9 Nov 2026 09:08:09 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Mon, 9 Nov 2026 16:07:54 +0200
Message-ID: <20261109140754.36985-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107022006.32b72f38@jic23-hlaptop>
References: <20261107022006.32b72f38@jic23-hlaptop>
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
X-Proofpoint-ORIG-GUID: XBhuM-36wdst4n9S8jyJAsTb0Lbol5kv
X-Proofpoint-GUID: XBhuM-36wdst4n9S8jyJAsTb0Lbol5kv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX+nTg1WTHmsc7
 zOWTuPJwbABsfQOAzCHeEj/7ux4WdB/ijOQwrBXYNb/DpHT6z1dpCVHugQVJV+tMxgU5e1Sy5/e
 NiNHHWcMHQCmSFW84o9pJN5i8NVESEn9fVsSG4kdXyV0NTb+bG2sR+RH5O2mVIp1wCfWXkM8n6B
 NImEpqjG2FysvzJNlitoLDFtiZlFGdZ90SsvMIKBbu7R7VmVPi7h4umRgXGdkV8yUn+20z1OPFV
 4ETiS0lb2VRE1LplkjVv4N9g8OL7oHH60MDBUo9SeUk/pUxzKVuiSPGMxHdkLjDxO2GQz+N9Y6x
 U8UkXP2TsGP7w5qiG3l3d/98Y4T9Ftx/2azmMFIARJvV1OTPcr06mN7uLAEXdm3b5Z/jct/OuvL
 7FQs9Ce11PPhViBGfAFeBBCXYxYTBk9AHLKWa/pG+q6o145p1k/wloLtDz7i4OtRcF6LAZpAgVF
 TR9kJIVum/qnfPJU13w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX2OqWDUgR4vg3
 L6m4IEIsSOFf+72E37FgQYvhqxwjInJlReVqdBuhkzGwH7fRPC6gWWbGokkUjx4Ey+zhuubO076
 nC9uRQ/h5EpaSI1DdY6GHtewhZPvAVQCaT1/pB4AgSm+9g5RJyGn
X-Authority-Analysis: v=2.4 cv=Wuu+otfv c=1 sm=1 tr=0 ts=6af1d3d4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=ZOXs0ZbiDrg4RRa78-IA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090056

Hi Jonathan,

On Sat, 7 Nov 2026 02:20:06 +0000, Jonathan Cameron wrote:
>
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 as chip
> > data of this driver. The same two PWMs and IIO backend read them. Chip data
>
> PWMs don't tend to read anything. Rephrase as something like 
>
> "The same two PWMs and IIO backend are used to read from them."

Will fix in v4: "The same two PWMs and IIO backend are used to read from
them."

>
> > and a few quirks cover the differences, see the binding patch for the list:
>
> The 'quirks' here concerns me.  We want everything to be covered
> by chip data even if some of it is 'apply quirk' :)

Agreed. It is the same point as the scale: ddr_timing stands in for "the
new parts" in several places. In v4 each of those will get its own chip
info member (gain for the scale, EN pins, second PWM name, supplies), and
ddr_timing will stay for the DDR timing, PWM step and lane code.

>
> > - Set the backend number of lanes for the new parts. Skipping is allowed
> >   only if the backend can't set it and one lane is used.
> > - Limit the default sampling frequency of the new parts to the PWM clock
> >   rate.
> > - Skip the EN pin mode setup for the new parts, as they have no EN pins.
> > - Include math64.h, minmax.h, property.h and types.h for the new code.
> > - Add the new parts, sorted by part number, to the Kconfig help and
> >   Documentation/iio/ad7625.rst.
> > - Make the Kconfig prompt, the top comment of the driver and
> >   MODULE_DESCRIPTION() generic, as the driver supports more than the
> >   AD7625.
> > - Add new maintainer entries.
>
> That is a massive list that is more or less describing the patch.  Trim
> it down to just those bits that are non obvious or need to be highlighted.
> No need to mention everything.  I'm going to guess perhaps an LLM was involved?
> If so they need poking to avoid doing this sort of list.

Agreed, I'll cut it down in v4 to what needs highlighting. An LLM helped
draft it, as the cover letter says, and I'll keep it from listing the whole
patch.

>
> > @@ -4,8 +4,9 @@
> >  AD7625 driver
> >  ====================
> > -ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
> > -devices. The module name is ``ad7625``.
> > +ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, AD7961, LTC2387-16,
> > +LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 devices. The module name is
> > +``ad7625``.
>
> The next section says what is supproted. I'd be tempted to avoid
> repeating that here in a fashion that is churn heavy.  Use something like
> 'and fairly similar' to avoid naming more than the one the driver is named after.

I'll change it in v4 to: "ADC driver for Analog Devices Inc. AD7625 and
fairly similar devices. The module name is ``ad7625``."

>
> > +	st->step = step;
> > +
> > +	if (!freq || freq > st->info->max_sample_freq_hz ||
> > +	    freq > st->step.clk_rate_Hz)
> > +		return -EINVAL;
> > +
> > +	cycles_per_step = st->step.clk_cycles_per_step;
> > +
> > +	/* Everything but lastclk and burst_end is in steps of the PWMs. */
> > +	gate = ad7625_ddr_burst_pulses(st) / cycles_per_step;
> > +	cnvh = ad7625_ddr_ns_to_cycles(st, t->cnv_high_min_ns);
> > +	cnvh = max(ad7625_ddr_cycles_to_steps(st, cnvh), 1U);
>
> Similar to offset.
> > +	offset = ad7625_ddr_ns_to_cycles(st, t->first_clk_min_ns);
>
> Maybe use a different local variable for offset_cycles just to avoid
> the units of the variable changing in two lines.  

I'll do this in v4, for offset and cnvh:

	offset_cycles = ad7625_ddr_ns_to_cycles(st, t->first_clk_min_ns);
	offset = ad7625_ddr_cycles_to_steps(st, offset_cycles);

>
> > +	 * CNV and may run into the next period, but has to end within
> > +	 * t_LASTCLK of the next CNV. It must also leave the gate low for at
> > +	 * least one step per period.
> > +	 */
> > +	burst_end = (offset + gate) * cycles_per_step;
> > +	min_period = burst_end > lastclk ?
> > +		     DIV_ROUND_UP(burst_end - lastclk, cycles_per_step) : 0;
> > +	period = DIV_ROUND_UP(st->step.clk_rate_Hz, freq);
> > +	period = max3(DIV_ROUND_UP(period, cycles_per_step), gate + 1, min_period);
> > +
> > +	cnv_wf.period_length_ns = ad7625_ddr_steps_to_ns(st, period);
> > +	cnv_wf.duty_length_ns = ad7625_ddr_steps_to_ns(st, cnvh);
>
> Perhaps set the whole thing down here with 
> 	cnv_wf = (struct pwm_waveform) {
> 		.period_length_ns = ....
> 		.duty_lenght_ns = ...
> 	};
> rather that clear it then fill stuff in down here.
> Maybe also explicitly set the offset to 0 to show it's the baseline
> (I assume) for the other one that follows?
>
> > +
> > +	clk_gate_wf.period_length_ns = cnv_wf.period_length_ns;
> > +	clk_gate_wf.duty_length_ns = ad7625_ddr_steps_to_ns(st, gate);
> > +	clk_gate_wf.duty_offset_ns = ad7625_ddr_steps_to_ns(st, offset % period);
>
> Similar for this one.

Yes, offset 0 is the baseline the clk gate offset is relative to. I'll set
it down there in v4:

	cnv_wf = (struct pwm_waveform) {
		.period_length_ns = ad7625_ddr_steps_to_ns(st, period),
		.duty_length_ns = ad7625_ddr_steps_to_ns(st, cnvh),
		.duty_offset_ns = 0,
	};
	clk_gate_wf = (struct pwm_waveform) {
		.period_length_ns = cnv_wf.period_length_ns,
		.duty_length_ns = ad7625_ddr_steps_to_ns(st, gate),
		.duty_offset_ns = ad7625_ddr_steps_to_ns(st, offset % period),
	};

>
> >  	unsigned long target;
> >  	int ret;
> > +	if (st->info->ddr_timing)
> > +		return ad7625_set_sampling_freq_ddr(st, freq);
> > +
> >  	if (!freq)
> >  		return -EINVAL;
> > @@ -239,6 +469,14 @@ static int ad7625_read_raw(struct iio_dev *indio_dev,
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_SCALE:
> > +		if (st->info->ddr_timing) {
> > +			/* Referred to the input of the ADAQ front end, so divided by its gain. */
>
> Why does something called DDR timing have anything to do with the scaling
> here?  Is it being used as a proxy for parts that happen to have some other
> characteristic?

It is a proxy for "the new parts", see above. In v4 the scale will use a
chip info member for the gain.

>
> > +	ret = devm_regulator_get_enable_optional(dev, "vs-n");
> > +	if (ret && ret != -ENODEV)
> > +		return dev_err_probe(dev, ret, "failed to enable VS-\n");
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> > +	if (ret == -ENODEV) {
> > +		/* Without ref-supply the internal reference is used. */
> > +		st->vref_mV = AD7625_INTERNAL_REF_MV;
> > +		return 0;
> > +	}
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> > +	if (ret == 0)
> > +		return dev_err_probe(dev, -EINVAL, "REF voltage must not be 0\n");
>
> Obviously it's nonsense if it is 0, but why do we exclude 0 but not 1 which also
> ends up being scaled to 0?  The function succeeded so I'm not sure we need
> to check for 0 explicitly unless it indicates some other failure path I'm not
> thinking of.

Agreed, I'll drop it in v4. The call succeeding is enough.

>
> > +			return dev_err_probe(dev, ret, "failed to set the number of lanes\n");
> > +	}
> > +
> > @@ -699,6 +1047,6 @@ static struct platform_driver ad7625_driver = {
> >  module_platform_driver(ad7625_driver);
> >  MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
> > -MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
> > +MODULE_DESCRIPTION("Analog Devices high speed LVDS ADC");
>
> We tend to keep some part indication of the first part supported
> in these because at somepoint I'm sure another LVDS part from analog
> will come along that is too different to roll in here.  Designers
> are a creative bunch and tend to eventually manage to make generic
> drivers impossible.
>
> "Analog Devices high speed LVDS ADCs similar to the AD7625"
> or something like that.

Will do, and I'll use the same wording for the Kconfig prompt and the top
comment.

Thanks,
Daniel
