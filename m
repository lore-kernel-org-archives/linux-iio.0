Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233220;
	b=nFRLe+AlzvX0CDokPwij+OG1S54wSxTYt7RWizjBYyZPmsm7eqMtBNk0WtYZFINcjH8J
	 hL3o+SQ/gpG0P9XnHpo/TSOGcbPHANf8PSUx6wS2yNLOoEpl811+xUnNrWnjxHbV9qfhR
	 7tba9VKv/SkbLvPdpThmUmmK8LZsKiLAuWdbxX6QCzWYAokKaomH89//CZ6Q9mn2tgLby
	 MbgLqFu6xY1rOJt3vDmL9yBiXiZ9FPM+4Q8eqWQyIHR85npG+da5OpDO2PKohhFWqcyAO
	 W0Zj0DRLcuyP0szThGM0BBoxY/sS0LLigIisIUGrdQaKWHPNiBVXiKY3ATO4ntjxIug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233220;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ehmTUWBPw24C3fEgkBQf7ImBlTwoj3Fsk8m7czu8HCY=;
	b=vOPLEJMyBlPBjeQqHez1W6ae+Dpoa98tmRxSxsDdhYN3U6dOXnK5WHLxsfWxEnx3WvnD
	 yS+eQTlzK+Evcn+tlomWn/MOuWAssnNRNpn2cyMWwmLpqu1j3FEjK2bNtfWeRzwsW207w
	 ciOZini0ouEJ7lgQSSee+bmvALFDEIFdTp68DejaT9Y6Voac1ot9NYp2MlLGatGnHVuup
	 HeKfUsOlqWUINwqeeX9q03S/fstn5gKa09odUY0iv5q+4xYLiwjTySGuTJGtojyd0nI4s
	 nYveYsoi6MvKwvlHm5br/GmFcasVNShbqUQH3vKqOT9daUsgTB/K/j/Oll431eeR4uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OROVIexB;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dT2cCD40;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141FF606A31C;
	Mon,  9 Nov 2026 14:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 141FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OROVIexB;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dT2cCD40
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DRJwR3319974;
	Mon, 9 Nov 2026 09:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ehmTUWBPw24C3fEgkBQf7ImBlTwoj3Fsk8m7czu8HCY=; b=OROVIex
	BNUx7lcGUAvxcmroqlokRXyehnjpUpVsV0b2+o+aY13Z5l6/EVW8SLCp93hoBHHi
	jxPdFfWdIIKj/vbC3aP0veJTUxhScoSThouQ6OT04PIWjOztKYo6e2AaWXl04sog
	7MXJUi6VxmBjRPgpn7ar/xQb9W9RsmMkvIjSVBw/5NhNPvO/SxLx8CtWED9+eoxM
	zQCBb8CaGDZtzD2THGudEjkyxA+YWfxvpdZJZYCUJld0gFvZI+jwXWEnStIQl4m0
	DbhcJQrsw7/UoAdadTUGYM78ZM+QNwCmT2rCKsN3AT5/DH3B6gOfThKnPtD+ncqO
	QI/Aq+ZtvjMzrYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ehmTU
	WBPw24C3fEgkBQf7ImBlTwoj3Fsk8m7czu8HCY=; b=dT2cCD40otz7jtByiNp4n
	CS6NauAbsKpw9w/GgH+Vn6tN3ETne0O8hGxdDm6jwHZstwOXnriMv5R6UJDLmPY+
	0tCyznbVG0c7hRvTp5EIsI28b/H2S9upLkFK64ErKCnHZ2ckzGgVt2uzyXlyGnOB
	vOTmJVJtqXYlVi5Z0QUN9Sy5UrjPafzi0L38rYMbNYTPWRT9Cy71qWAnpIeRFOXA
	UkpbnMhOYjnjwW9usXzeNmMLr0rDt3sH9VtrZeCoHa9M9eFZ0E89nXahL/mgOJCW
	hwOQGsbYeziLEuPaSML5PUUj9SK9NwzF/sWiTZFCpNjKwy/zePbFFAbWkc38OeG0
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4huf2w8941-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:06:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A9E6sHd018933
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 09:06:54 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 09:06:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 09:06:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 09:06:53 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A9E6fXI024958;
	Mon, 9 Nov 2026 09:06:44 -0500
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
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] pwm: axi-pwmgen: report the waveform step
Date: Mon, 9 Nov 2026 16:06:07 +0200
Message-ID: <20261109140607.36418-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107014755.364d4729@jic23-hlaptop>
References: <20261107014755.364d4729@jic23-hlaptop>
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
X-Proofpoint-GUID: 5Yj6oIvwP9iVIMy0C-2CfWLiiSOIYQtz
X-Proofpoint-ORIG-GUID: 5Yj6oIvwP9iVIMy0C-2CfWLiiSOIYQtz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfXyo68o0ARfMWe
 dCoklNCWPFqNqvtHLS6JzxX6BqIaZD3WPCt92UC0DHEMJuU/aJPQrC2ktkb/w0sYNsPs/jtMRFS
 qO+3ZzdP0LEgNWWc5m5QyLGvmirR1zPR9FSLX9+DfTYX0wAvGsHk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX44fNktTDm5iw
 lFZ+5J6W/3M2hdmlR7Zw/K2fwuzzW/n1DQ5o9XeCGjCQolW1rDAZbqMSZvMdxSkk+IM1e4cBJLz
 h+sU9njtkIB6+E/veYFBPjsWoCygmeLA7TR/fzD5pc1D3yIW7h25ZguKY8bT3lZ37ir+K9HVIS1
 XPHVEJ6Sz6osVwEoqU+I5W1nq91/uJtdxLa7/tChIchrnWUWHDeSGdmudoH/AK0gcnhXxkg73sD
 8ssNv5RBF2zCl+8JIdMSIZBlQP8evdDUimi90g56uwiK25nKVE3M3xl25USTwQPDdYV8unHP2QE
 ZNyai0nfY2J6/rhizQBHs7JHAPkSJx91gLgOteOqEkz1Ymyk71ebXy/P2gOSCDR0MUwTcCG3357
 jjDyoN7wX1CFnVEp0fYKPSV7jkVfckqwrsKlKECk41NchtJ3oclmbV45YUYZ7hGSi4EDBd4kJIK
 DjGunJ6rMTbse/SFc4g==
X-Authority-Analysis: v=2.4 cv=RpVQvymK c=1 sm=1 tr=0 ts=6af1d37f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=NnX6kGtuf9D1FMrsQa0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090056

Hi Jonathan,

On Sat, 7 Nov 2026 01:47:55 +0000, Jonathan Cameron wrote:
>
> > index b40522f01002..6b15244efabf 100644
> > --- a/drivers/pwm/pwm-axi-pwmgen.c
> > +++ b/drivers/pwm/pwm-axi-pwmgen.c
> > @@ -136,6 +136,18 @@ static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_de
> >  	return 0;
> >  }
> > +static int axi_pwmgen_get_waveform_step(struct pwm_chip *chip,
> > +					struct pwm_device *pwm,
> > +					struct pwm_waveform_step *step)
> > +{
> > +	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
> > +
> > +	step->clk_rate_Hz = ddata->clk_rate_hz;
> > +	step->clk_cycles_per_step = 1;
>
> Given the only known user sets cycles_per_step to 1, what evidence
> do we have that part of the interface is actually useful?
>
> I can theorise that some device might need a couple of clocks
> but can also theorise someone might use both edges of the clock as possible
> state transition points for a PWM.
>
> Note my PWM knowledge is minimal so this may be entirely garbage!

None yet. axi-pwmgen is the only provider and reports 1. The field is there
because Conor's v1 review said the code would fail if someone used a PWM
provider with a mandatory divider. It keeps the consumer from assuming
one clock cycle per step.

If you prefer to add it when a provider needs it, I can drop it. struct
pwm_waveform_step then keeps only clk_rate_Hz.

Thanks,
Daniel
