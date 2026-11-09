Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233285;
	b=Pv/xRR7FfiA6ABpY5uDDnjp3XMVKLWsj7Zfd7iZ43oIehICzKjQmAit4saBB+pdwsSLo
	 kGlEgK+IUJ1UjzqskdXLe8B78VD6TNfbF8c2Z9vD2py9dccBCBFCoYHRkxPFY5DYJULB+
	 LhkNomVHoBHdm65MuEdBteEMEz+XZA9VAaURV4/MMvxkRXXVCzusshpswCkCF9CwNpVdd
	 F0YvCIUOXb1haD7/dZytm/yfcUQ4Dw5egUPIBfnEyLV7RrM4JDxmQNy1aW3bzsdfJwMqf
	 RtcU58pbeXYOCHRU4Wok/p2ekHw2OvmFHSVJ5i/rJx1rKIj3gf9RooeslVthyc6Me3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233285;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v3Sxo5wvWrSA6FfjLzGwAiWH7aLSAO1h34wAA8pIgBk=;
	b=36osK5IJC3fFb0c8cPqRjnOfNeWegn1igzZK617tx4NAkOwH0Kp5SeC8zrI0AOQ9684P
	 lJ547+UkCPputNM4qAnHn4jM3S1WeaGHo17F72HJMzCHzr+Kmnk5KLO2WmXG+jnMu5ZMU
	 1G+Cdg9M5pzhk/3hBjkyc3CfiL4U6+8RmZ4v8P0FoKUU1xc0uiGlcDlVjaIH1/hSg4gqW
	 ViylhDvJueR7Z59FTJIpgBBzWC/bGOujc5LHiecWXEQpT9ErPKM9dZ71fD2L63FZa0/yF
	 WdClrqw2KeSO6MDI2XRIzGzxFrd4qy+UIOzJRyBV5v+m8FE7EyzqfuOXkISNVMsJr5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=FCAX493I;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=fyAKiosb;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6555606A31C;
	Mon,  9 Nov 2026 14:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6555606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=FCAX493I;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=fyAKiosb
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DRJF33319973;
	Mon, 9 Nov 2026 09:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=v3Sxo5wvWrSA6FfjLzGwAiWH7aLSAO1h34wAA8pIgBk=; b=FCAX493
	IIJUFaILPB7pMct4J62FCwZGz1X999qaS1mwvnBjrqFhRsMv3PR5I6B0NKbSqMzR
	Cug5tLmjmzR5C/t1pNtNXaxgMwsEHn+SHkhlrRnTKYSShcZqSMUgZCi19jUEXjRU
	Pb/jc1mKsNnZqWkJqgtSxnvMTweKrYws/V5zsc61fS+5RXopjXoqV8FdbfzzwQQY
	VqzS9WX1XCVV9GQlOxQxkfQjYurnMZY7Qs1r2/qkRzSBBUVb8nHfRrYP5U0E9sPr
	aJ1QYh07nALaMjtg+chwKk821q7kPjEw7uJQcKmyoEhE1z63eok6xaPaRRWjwKl6
	eKX2pBP5PTTAFQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=v3Sxo
	5wvWrSA6FfjLzGwAiWH7aLSAO1h34wAA8pIgBk=; b=fyAKiosbYzRZMBkftL8IB
	aRNdIUFXvmsiCEL5LXGTn3sH8Qf/+JTTKCxb0CD9o068J1eAo5XSmOipCpLgaU+T
	2hnNcZBJQ/radCWEYFtYlBZ9XSfX2fbIq9YEPOE2WkEHAiAmx2soCJtl4ACNg3If
	4RnWZQcpRYkIcaSq/0BuqVSBybgQSkEqUceQ3Etai/x/AOh4IeMv4j1ArvpVSgpl
	8WDaeKE71ueia/3mN8U/Pf5CU6Wt0ZYID1iaGg6u8D56M12VsYjFpmGtEieLHjKE
	q/ztz10Bzhyii+LNfV8YCgBcFyH9FBTNSHBa82179QIq8AhytZGooqJcWMXSpw8s
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4huf2w89cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:08:01 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A9E7wxv064654
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 09:07:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 09:07:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 09:07:58 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A9E7lXw024977;
	Mon, 9 Nov 2026 09:07:49 -0500
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
Subject: Re: [PATCH v3 5/7] iio: adc: ad7625: move initial mode setup
Date: Mon, 9 Nov 2026 16:07:34 +0200
Message-ID: <20261109140734.36901-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107015901.0167e32d@jic23-hlaptop>
References: <20261107015901.0167e32d@jic23-hlaptop>
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
X-Proofpoint-GUID: LKUEfWNknP4HkEfoszfaLRcG-PDzCUAP
X-Proofpoint-ORIG-GUID: LKUEfWNknP4HkEfoszfaLRcG-PDzCUAP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX0FDkuZs7rEYy
 nbuhfG0yLpE9K6P+FdPFFSmk7oTSYQ8MRn77FJ8ZYn++Jh45igQ77zPkUk1fIVV6afXYWm7D/Ox
 ty5zNQ6/dvx4uOxUEBlEVB0kUfXpfv8VSdC4iVYV+Qa7xAloJJs2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX68/irZZ1Klds
 5VdB3t1gTBr6tPHZKsoV5Tuw+s1rD/sok4J/y98em6JupN42mxA10m1XDSiUFIvnOlUnkM+9iKb
 raOq7MLKyLNTmrdA5j0y3Wf+Dw8aFhwhNAsMX2Mf1Xis+8gjPHt33Xaj4kAdOSqo0kfax+bd1RP
 mGR27AvDt0VqK/3C4ZikAk9hcwmxZbV6ZtnZX5NoIG6uwDUcWgCS36BSDeeXO2T3kNSyarefUSj
 QdxO6AVJWufAmcXQ1r/4zLwSXuuCGb6tX7gROGcO8Yk2SHi2cv6WemlVDvP+fcpCRkMAKlTWxas
 w1RurOanqz0QASB9SE9XWpC8CiawJ7totv1VAcAf6KTrB7nhZxNUlcrPt2TerlzFTyU1XDmSaUz
 2E0uGDVMzE38SCp2hYV7wWaNx1PMS+ynJJvRtu8IYUWxi/1ytrpjXQifcE1pxpx8xlTg/PajMsW
 TcSmbkqEhcYmmQWkJXA==
X-Authority-Analysis: v=2.4 cv=RpVQvymK c=1 sm=1 tr=0 ts=6af1d3c1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=uJoQCmExfAMfYzx7mGgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090056

Hi Jonathan,

On Sat, 7 Nov 2026 01:59:01 +0000, Jonathan Cameron wrote:
>
> > +	 * If neither sampling mode is available, then report an error,
> > +	 * since the other modes are not useful defaults.
> > +	 */
> > +	if (st->can_wide_bandwidth) {
> > +		ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
> > +				      st->have_refin, st->vref_mV);
> > +	} else if (st->can_narrow_bandwidth) {
> > +		ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
> > +				      st->have_refin, st->vref_mV);
> > +	} else {
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"couldn't set device to wide or narrow bandwidth modes\n");
> > +	}
> > +
> > +	if (ret)
> > +		return dev_err_probe(dev, -EINVAL, "failed to set EN pins\n");
>
> That's ugly given we are some distance from where ret was set and it
> is eating the value.  I'd just duplicate it in the if / else if and
> perhaps give a more focused error message in each of those (I haven't
> thought about what it would be so maybe it doesn't!)
>
> I know this came from original code, but seems worth tidying up whilst
> you are here.

Agreed it is ugly, but I'll not duplicate the check per branch, because the
error can't happen

A mode is only chosen when its flag is set here:

	if (st->can_wide_bandwidth)
		ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH, ...);
	else if (st->can_narrow_bandwidth)
		ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH, ...);

ad7960_set_mode() fails for such a mode only if that same flag is false:

	case AD7960_MODE_WIDE_BANDWIDTH:
		if (!st->can_wide_bandwidth)
			return -EINVAL;
		...
		return 0;

   (AD7960_MODE_NARROW_BANDWIDTH is the same with can_narrow_bandwidth.)

Both flags are set before this point and not changed afterwards.

In v4 I'll pick the mode first and call ad7960_set_mode() once,
returning its error instead of -EINVAL:

	if (st->can_wide_bandwidth)
		mode = AD7960_MODE_WIDE_BANDWIDTH;
	else if (st->can_narrow_bandwidth)
		mode = AD7960_MODE_NARROW_BANDWIDTH;
	else
		return dev_err_probe(dev, -EINVAL,
			"couldn't set device to wide or narrow bandwidth modes\n");

	ret = ad7960_set_mode(st, mode, st->have_refin, st->vref_mv);
	if (ret)
		return dev_err_probe(dev, ret, "failed to set EN pins\n");

Thanks,
Daniel
