Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3383A451A;
	Fri, 22 May 2026 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456244; cv=none; b=dE1tOKfrKdcLmUuQDJZW8z1wQQXR1E6zBIgAYqoSraXv5Y2tJ2vERXjfyw79UE71Lx30dx9AZV1RUQzHLebnn0ZHtPdXw0hSW7fqmLlA5ocIvi/ul7ZESQLddSkNswpzh/8d5e37dnj76BmuhmYMmTKV+wKcirBprgopqbJPmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456244; c=relaxed/simple;
	bh=98lXYgzuALJsplkRY1g0rzBDU0Q4hW2YVHKM+yAMOyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwhS0yguR5r1RVu3Otn460f1JVT8/aQXgEx7OwXFTwFzt0eanJLJuHOpV7Zz7/YyoEFkf1QsKmJOSrGwttluxMt5SrR1R3AOasRiFVMszvprxIvl7e5dP22UMZIHVUIZ4RWVKDaJY1gDROiWyApmn/AymOu4HsOVk+bJ/MynYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zw/34b0Y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zw/34b0Y"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MA4avU1374815;
	Fri, 22 May 2026 09:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a5/GI
	x9xd4Nq53b9XkoIxTvSeMsVky+u8snehgl0WcY=; b=Zw/34b0YYYLjEqVnyb7KR
	rZfu30pLQkd6wI9dY0VjQDcV0daK9Q3qAYmqnMW5MhhZIcLzdAQWUX5oeGYIBXhj
	iVImCMBqw7w6/5y/uBKomU9895cU7oTzspJRM2h+m9p+cbRZDAVFf3nvjEKeW9+G
	/jvdZnSXc/BSIUW0lMIaTKefEUaaqm8cm1zzZx7du/Y4lqBO/oG4GDDmb/2Gw5sX
	WfjZPR6ZBkcm5Q53uw3KCgOe24SGQmLnhX/vtiv6B3pD96Pyo+/INkB7iGzIotfF
	YCYTFKV4iArXo/kl4B+4zoBcJQZSyhLqIWjJX+raQbpKzBMxLXuiEvs8LFF5OtP0
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ean2t8jby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:23:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64MDNvJA031179
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 May 2026 09:23:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 22 May
 2026 09:23:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 22 May 2026 09:23:56 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64MDNhTU017866;
	Fri, 22 May 2026 09:23:45 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 8/8] iio: temperature: ltc2983: Add support for ADT7604
Date: Fri, 22 May 2026 16:23:18 +0300
Message-ID: <20260522132321.1641-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260521191828.F20931F000E9@smtp.kernel.org>
References:
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PqOjqQM3 c=1 sm=1 tr=0 ts=6a1058ee cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=6kk19GDRn8FKenT_814A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6PDJ9hYF7qLCjr6Rpiz1wpAv9IE0xoGm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzMyBTYWx0ZWRfX2U0ifAfiZ67P
 vnaCykZvEnXuDzoYsSPGq6J4p06fVqXQQOKC0u47IelcEgfJxCS6nvvbIXB6uMNFajfYfJ0FsO7
 j0zn7IwIMsOIVEwTcxkBRhpWzWMLe6LMV6t8imBxlP7MvnJGRerbU++Gx7UHakPzMjoAEgXHsJg
 xOY4JbYlcFnXA/DGXFsjO6syxgyFv1DeiFJXJA6wp5YXb0ALhnj3Jor6rmSpaZFOL9yBmBZ1l8G
 H4cH/IoDqVKqCvkp3ATV74OUYNYEKx2RuNebQRy9kt0+9Z0carv7l25Pwci/eoNaGPCquGS2Xbx
 nmaCqkE70WE8b43DYwASj/hiLEgz467+45SshwHyR4uvPZiJQQWDxd7yu2a3vNDy/zB5bA07wPH
 JJUXcxlYXYVBBQ2ofnb1Jhst+apzxDoRTnrR1oXGb8SBc+48k7I7BW4SeQWNj2aQv4jZ/KzFfcA
 Ujk/igcvdWuFmmNJA1g==
X-Proofpoint-ORIG-GUID: 6PDJ9hYF7qLCjr6Rpiz1wpAv9IE0xoGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220133

On Thu, 21 May 2026 19:18:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Reading the IIO_RESISTANCE channel bypasses hardware fault detection, causing hardware errors (like broken sensor traces) to be silently reported as valid data.
> 
> Pre-existing issues:
> - [High] reinit_completion() is called after initiating the hardware conversion, creating a race condition that can cause spurious read timeouts.
> --
> 
> commit d382a4cbefd41723ab5ddd91fd399d716c8faaec
> Author: Liviu Stan <liviu.stan@analog.com>
> Subject: iio: temperature: ltc2983: Add support for ADT7604
> 
> This commit adds support for the ADT7604 temperature sensor by repurposing
> custom RTD and thermistor types as copper trace resistance and leak detector
> sensors. It introduces two new software sensor types and exposes a new
> IIO_RESISTANCE channel reading from a separate result register bank. The
> ltc2983_chip_info struct is also extended to use a 64-bit supported_sensors
> bitmask for the new types.
> 
> > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > index 326f843f42713..e2ffeee026eef 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> 
> [ ... ]
> 
> > @@ -1205,7 +1502,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
> >  }
> >  
> >  static int ltc2983_chan_read(struct ltc2983_data *st,
> > -			const struct ltc2983_sensor *sensor, int *val)
> > +			const struct ltc2983_sensor *sensor,
> > +			u32 base_reg, int *val)
> >  {
> >  	struct device *dev = &st->spi->dev;
> >  	u32 start_conversion = 0;
> 
> [Severity: High]
> This is a pre-existing issue, but can this function experience spurious
> read timeouts due to a race condition with the completion?
> 
> Looking at the rest of this function:
> 
>     ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
>     if (ret)
>         return ret;
> 
>     reinit_completion(&st->completion);
> 
> If the hardware conversion finishes very quickly after regmap_write(),
> could the interrupt fire and call complete() before the CPU executes
> reinit_completion()? This would overwrite the completion event, causing the
> subsequent wait_for_completion_timeout() to spuriously time out.
> 
> Would it be safer to call reinit_completion() before initiating the hardware
> action?

This is theoretically valid but in practice, the conversion requires at minimum
two 82ms cycles (167ms), so there is no realistic window for the interrupt to
race with reinit_completion(). What do you guys think?

> 
> [ ... ]
> 
> > @@ -1236,13 +1534,23 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
> >  	}
> >  
> >  	/* read the converted data */
> > -	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan),
> > +	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan, base_reg),
> >  			       &st->temp, sizeof(st->temp));
> >  	if (ret)
> >  		return ret;
> >  
> >  	*val = __be32_to_cpu(st->temp);
> >  
> > +	if (base_reg = ADT7604_RES_RES_START_REG) {
> > +		/*
> > +		 * Resistance result register gives a plain unsigned value,
> > +		 * D31 is always 0, no valid bit, no fault bits. Read bits[30:0]
> > +		 * directly — the temperature result format does not apply here.
> > +		 */
> > +		*val &= GENMASK(30, 0);
> > +		return 0;
> 
> [Severity: High]
> Will returning early here bypass hardware fault detection for resistance
> channels?
> 
> As the comment notes, the resistance result register does not contain fault
> bits. However, hardware fault indicators (like Hard Fault, Soft Fault, or
> Over Range) are stored in the primary Temperature Result register.
> 
> By returning before reading the Temperature Result register and calling
> sensor->fault_handler(), does this code silently ignore sensor faults? This
> might be problematic for sub-ohm copper traces, which only expose the
> IIO_RESISTANCE channel, leaving users with no mechanism to detect a broken
> trace.
> 

First, I don't understand why Sashiko wrote "base_reg = 
ADT7604_RES_RES_START_REG", the patch has a "==" there. Second, the temperature
result register stores fault indicator bits for temperature reads, not resistance.

Thanks,
Liviu
