Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981486;
	b=uPWhkOnnZgQcWn0Mu68GqZipEVJv/wRQN9uADPAfl4q2QWnkMd1dVdZMZ4eiGRLeQEmw
	 J+vaNXZ/AJC0fJsMOgW05nqKm3pgx31d2ZpRDb1Mz1wop2HyhgOs1KkgijiNOKDSeD24x
	 OYiaGnMepONsy4yUpJgK9LpN+9itRYx/Qv9lhXnDBdgjrxhtSamUdsilV3Rd8Gnw5IUR8
	 OsSuDjpmTnhCEGgv18CcagdkVK+AWVBcILVCajn5hRXojFW29KsZTQf7NWvot6F0WlDnW
	 V7iVcHycSRWWWTdqV7XRxk+uDv9LGnQDlNR6HYikS2SVgfEvJAFUnOPsL340Hx3LIBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981486;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qLQjleeHa2p/VOqmolCbfB9XpS0Zw2ZDIzHnBRMgVJ0=;
	b=riWY3CPVewFCClw81k+Tu4rBJ6yIFvrzxN5aC0Ex7tuw7TD5iSJ++gCF3J6e9gjiUih+
	 s2snWUwXCrdJTkZewceW5habp1M5IEkMw87t0Rk4n3gGJzRgfx15aKOLgregJgHiKjOjD
	 6HteF0P+S/dTT7FUIMhikISaX3t1w5/ziMgsuEYCM4vkzZIONutpDMJ4DJ/m/SjJHTTHT
	 H24YlBsfAe0lFBf31mwSlSCj1W55p1+01ODLk9LPr69MWUi0qWFxBKhr7xCNJ6/jXJusC
	 WYXWjee33DLSatJGrlXNDYXMxfFmd4v4QBv/rcNHCNk1R4MS6aUeWKUX0M3TLRs3NSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EoD4BYGc;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gceRvpSd;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B1606A32C;
	Fri,  6 Nov 2026 16:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C4B1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EoD4BYGc;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gceRvpSd
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4Dng3366252;
	Fri, 6 Nov 2026 11:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=qLQjleeHa2p/VOqmolCbfB9XpS0Zw2ZDIzHnBRMgVJ0=; b=EoD4BYG
	cwo75qAhPfm7K1X6yzaon8XLPQNm3SjGZaf+lgwXrKJblsmy1netowINHwwRKItX
	xzcUUlH41BDVzjRPR7rCVCE4WDFZXHVTQDE/NCSB8MlKnCo5zhp/T8UXKn4vkpqH
	GmatTju732e1ttpfVc/pKfdcnWA6PAQ34aPzEnzfydFxA6ZVVBJsgZ8JfR6rSaV0
	y27pXF74RZvoi5qNmfy+1hD1Uze2FIoAKqZmwqbg0IYfrWS8tUvj77GyVUH/cWeI
	bYqCSTNmUOBnnWlWL57XdSo321twyFFL91BWUxdX9e6zm6KoKVE/B+GHsTiikeQP
	cvf/ucjCZsIKlCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qLQjl
	eeHa2p/VOqmolCbfB9XpS0Zw2ZDIzHnBRMgVJ0=; b=gceRvpSdgbWUXu5yhQb+N
	2FSCfjk6Nsa+cr1I6AvYSlw5znDnWMVMGwOGljUnX5cr4PhuE/iqlEPdHbmfE23h
	RqZFFa7PVhkR4Yv4K6jjcnAq1sVxBB0tQSUeao+cHH62u31JU2CAKw5bKOfDQukS
	k+ma3FlzV8+jhNgIndr8X/XpFTH74eKbgS8hpGrDBJIbUyadKbA28g0V6JHv3lQJ
	GSovwm3AstHFwP0t58Oqp4R3IzxqNdgkUJ7ZgSPiJ+xrcK9FYd0ldX+shwRVKt4x
	03M9OprUXYsp2Qvwrc8blfDhtQ0P2/gvyxurAzWR4tIcZVAMIyigmw7uGlQkDAJm
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3qad13r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:11:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A6GBJwE036760
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:11:19 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:11:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:11:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:11:19 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6GB3qa016468;
	Fri, 6 Nov 2026 11:11:05 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu Cuciurean
	<sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Fri, 6 Nov 2026 18:10:54 +0200
Message-ID: <20261106161054.879339-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <auuT754d-bwSeL1Z@ashevche-desk.local>
References: <auuT754d-bwSeL1Z@ashevche-desk.local>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfXxCvW69pyGnSR
 E1Uozl2HQwUFTIU/hTKt3o9/SoxkmzqURayTszo4aF0/dDMdfpb4fPBve7sblgj3Pxz7LQxtPO5
 q+o1JSO9Mreq1eGnTTHkBjdHDcIlepJ1JCVs4NWeU3Oe9DuzGxlaJDymHnyYhv4LvuzW74snqex
 jazY+HMxUfS/4whNMNJddLaOI21MCT/W/lwGWf3vqWGf7MtgdICy3GEzZhU9e4vpzLEv7WyPxva
 9jsGvfjo+MDKBqseUCY91KXGU5nZ08oJSzniFNJAM0ZByrfWWd7epYZ1Q0ZrTUcK82ofWl76zja
 r8d8u6t3xvqcvADcOW5BPWsQzzWXjraLdI2peSAS5QjqeaHE5BobMwJhOJEmHUzhXpr+N441AJF
 TB6eFUTpzH7JPurf/OMSKZAPZZ4aRUpTc8cVRIRprFokQJ2BVEsaC1PVTDY1QpuftKT96vlj6ib
 JseylDXJGSwwIDgQyGg==
X-Proofpoint-GUID: bmwDZ_hPUgz4m5pm1VaETP31EBQUcb9Z
X-Authority-Analysis: v=2.4 cv=NbBzRGD4 c=1 sm=1 tr=0 ts=6aedfc29 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=O00lww03gr23ivMrccAA:9
X-Proofpoint-ORIG-GUID: bmwDZ_hPUgz4m5pm1VaETP31EBQUcb9Z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX3LgR0amVYTKd
 0Jl/aXwOUesU4qet9fpCLcXW/dZ2Wq48rY2T1feT8yCLDhQfcYtggz3jaW2a1cWObzF7xNwb4D1
 CDMX0M+J+lSmwBfcmB7v5EUsbnzVtJkPVS/JPFFk1mVno9ieslMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060064

Hi Andy,

Thanks for the review. v3 is out with your comments addressed:
https://lore.kernel.org/all/20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com/

My answers are inline. Patch numbers are those of v3.

On Wed, Nov 04, 2026 at 10:22:07PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 03:21:43PM +0200, Nicolae-Daniel Deaconescu wrote:
>
> >  config AD7625
> > -	tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
> > +	tristate "Analog Devices AD762x, AD796x, LTC2387 and ADAQ2387x ADC driver"
>
> This does not scale. Please, make it more generic and make sure the text in the
> top comment of the driver along with MODULE_DESCRIPTION() is quite similar to
> this (maybe without "driver" word).

Done. The Kconfig prompt, the comment at the top of the driver and
MODULE_DESCRIPTION() now all describe it as a high speed LVDS ADC.

>
> > +	  * LTC2387-18 18-Bit, 15 MSPS SAR Analog-to-Digital Converter
> > +	  * ADAQ23875 and ADAQ23876 16-Bit, 15 MSPS uModule Data Acquisition
> > +	    Systems
> > +	  * ADAQ23878 18-Bit, 15 MSPS uModule Data Acquisition System
>
> Why not keep this list sorted by a part number?

Fixed, the list is now sorted by part number in Kconfig, and in
Documentation/iio/ad7625.rst as well.

>
> >  	const unsigned int max_sample_freq_hz;
> >  	const bool has_power_down_state;
> >  	const bool has_bandwidth_control;
> >  	const bool has_internal_vref;
>
> Side note: What the point in const to these (plain booleans, integers)?
> Chip info as a whole should be const, no?

I left the existing members alone to keep the series about the new parts.
The members I add don't use const.

>
> > +	 * They are the parts with @ddr_timing set.
> > +	 */
> > +	const struct ad7625_ddr_timing *ddr_timing;
> > +	const char * const *supplies;
>
> Again, why the second const here...

That const is on the strings, not on the member: supplies points to an
array declared as 'static const char * const x[]'. Without it the
assignment discards a qualifier, and a non-const array gets a warning from
checkpatch.

>
> > +	int num_supplies;
> > +	/* Gain * 1000 of the ADAQ front end, 0 if the board has to provide it. */
> > +	const u16 default_gain_milli;
>
> ...and the const here?

Dropped. The field is a plain u16 default_gain now.

>
> milli is multiplier and not a unit. But if you think it's better this way, I am
> not going to object.

The C names are now gain and default_gain, set with 1 * MILLI. The 
devicetree property keeps the name adi,gain-milli, as ad4000 and
ad7380 already use it.

>
> > +static const char * const adaq2387x_supplies[] = {
> > +	"vdd", "vio", "vs-p", "vs-n"
>
> When not on a single line, add a trailing comma.

Fixed

>
> > +static const struct ad7625_chip_info ltc2387_16_chip_info = {
> > +	.name = "ltc2387-16",
> > +	.max_sample_freq_hz = 15 * MEGA,
>
> No, we have HZ_PER_MHZ for this.

Fixed

>
> > +	.ddr_timing = &ltc2387_ddr_timing,
> > +	.supplies = ltc2387_supplies,
> > +	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
> > +	.default_gain_milli = 1000,
>
> As I mentioned above this multiplier without unit is confusing.
> Simply
>
> 	.default_gain = 1 * MILLI,
>
> ?

Fixed, for all the added chip infos.

>
> > +
> > +	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
> > +	if (ret)
> > +		return ret < 0 ? ret : -EINVAL;
>
> Don't nest branches, you can just move ret == 0 check out of that in both cases.

Done in both rounding checks: 
'if (ret < 0) return ret; if (ret) return -EINVAL;'

>
> > +static int ad7625_parse_ddr(struct device *dev, struct ad7625_state *st)
> > +{
> > +	int ret, i;
>
> Why is 'i' signed and why can't it be defined inside for-loop?

Fixed

>
> > +
> > +	ret = device_property_read_u16(dev, "adi,gain-milli", &st->gain_milli);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to read adi,gain-milli\n");
>
> 	const char *propname;
> 	...
> 	propname = "adi,gain-milli";
>
> 	// Why do we even need the presence check?
> 	if (!device_property_present(dev, propname))
> 		return dev_err_probe(dev, -EINVAL, "%s must be set\n", propname);
>
> 	ret = device_property_read_u16(dev, propname, &st->gain_milli);
> 	if (ret)
> 		return dev_err_probe(dev, ret, "failed to read %s\n", propname);

I dropped the presence check, as reading a missing property fails anyway
with 'failed to read adi,gain-milli'.

>
> > +		return dev_err_probe(dev, ret, "failed to enable supplies\n");
> > +
> > +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> > +	if (ret < 0 && ret != -ENODEV)
>
> Too many ENODEV checks, see below how to deduplicate.

Reworked with early returns: -ENODEV selects the internal reference, then
an error and a 0 V reference are checked on their own. I did not use the
else-if chain, as checkpatch warns about else after return.

>
> > -
> > -		if (ret)
> > -			return dev_err_probe(dev, -EINVAL,
> > -					     "failed to set EN pins\n");
>
> AFAICS the above can be moved to a helper in the separate patch and moved as a
> couple of lines only in this patch.

Done. Patch 5 only moves the code into ad7625_set_initial_mode() and the
patch with the new parts adds an early return to it.

>
> > +		/* Without the op, a backend can only be left on one lane. */
> > +		if (ret && (ret != -EOPNOTSUPP || st->two_lanes))
> > +			return dev_err_probe(dev, ret, "failed to set the number of lanes\n");
> > +	}
>
> Same problem, too many (hidden) branches makes code unreadable.

Fixed

>
> > +	/* The DDR parts reject rates above the clock of the PWMs. */
> > +	if (st->info->ddr_timing)
> > +		default_sample_freq = min_t(u32, default_sample_freq, st->step.clk_rate_hz);
>
> No min_t().

Switched to min().

Thanks,
Daniel
