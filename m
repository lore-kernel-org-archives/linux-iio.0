Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D563A6B99;
	Wed, 20 May 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301210; cv=none; b=ar/9ZFD6oBVNWUz/SLRdydwsAf2bYjQ3m+Ody7FkEtgh+yxuZcEZxiqvap+OK58sbEpQcaRAgZg188xvKDfG6OESU9+r4cfV4pt/99nKJAQqbiJfIhJ0v/cPcUD1aRUBS0aaYHP7TRKy4s/9YkvGiQ39ga5jLgyCF0xWAOuzCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301210; c=relaxed/simple;
	bh=5kKsuOwfJfrcZs58nRlKq2lOcw+su6ViD5dTtabf2/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQqlJ6luDGdXvtyDMM1ArzgOzIqyYfYqqpSayqFDBGzutJflQn50Rb8zIs8kbFeKSuFY0vgP8L1EG1mIJVHYfyrifvSRHKP4djLYymI+92z9g+YpjhZ9LlGtK/tbyZlVq0fpy0LwlKLKaBbgQ7E/PDW6k7CTOYblR7UAPs+5PIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nVeGxpKj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nVeGxpKj"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDopJX416888;
	Wed, 20 May 2026 14:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NqWwN
	kNZZcF7rAIasVqF0QpBlWWMevk4YAQsojXwevA=; b=nVeGxpKj3O9ahcuGhHhJD
	Gexz34rW/IdBQ66oJR/I4q89vRSE52rXdyPsdzWRTLjSXZc3kfibGIBu3cwTl2eo
	VparHouce/2QS5gu8pFDmfHU0rMDvO0ds79qlM1z8I/yERxwaLGgKwLbKJ4cHXf2
	7FQMgHtvgYF2QF5Jvujiz7h15BbUWUBwGNabFf5WpIad1/jZMTQpxWGsom2wv2K/
	mK61RdrDY6Qarn5GHFqZSdu6W7ZuLShxS4Xo+oJlVUf7SSLmzcR1gw7rWuPhDVPc
	Vdkg8SoV6cdZLgcKW4Nlxf2DrkKxMmDHL6LAL6r4pRzXoz7E9NT+mSXIrLHqnF60
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wryuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 14:19:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64KIJwO7052865
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 May 2026 14:19:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 20 May 2026 14:19:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 20 May 2026 14:19:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 20 May 2026 14:19:57 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64KIJiKo030378;
	Wed, 20 May 2026 14:19:46 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for ADT7604
Date: Wed, 20 May 2026 21:19:37 +0300
Message-ID: <20260520181940.548759-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518145802.49a3bc94@jic23-huawei>
References:
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -Q2oC0WsZjWx2SHQzAmmedjMvjdqL4nl
X-Proofpoint-ORIG-GUID: -Q2oC0WsZjWx2SHQzAmmedjMvjdqL4nl
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0dfb4f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=dzM6K9NnNKbWQKe0cTMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3OSBTYWx0ZWRfXyEyYp5ycarKZ
 5FP7bfOA/6zskAYuRfjB49UJ3ccryETPThYXDkz4gMWQ9o5CJmPVWx3hM5a71wMDRVnbMqZbeHr
 V+wwWvx7JRt8meSA7PLbijJAv4ZaMB9vntUJ3qMCG8ykJyfxBIVJRYk+4TMUBaifpcQ14H7+53I
 2495KtQkXipzBtZ7bpV5G954NyqPOCe8SkDKeYUh9tcw6OpM4zgFJyajsNdV07WhVuevIKintus
 Lb7h/BmwZ2Y+gmO5wPlnlUHwoyJghqaZBlnWSHUfuFVyadpDgqaXsCMQylOVd5e7MdWKrTPsVen
 ilJLMJJAkcrtiIZO6DxJfdvAei3vgWJiMopRXD0rLD1W8+9iWOKx3vLXGUziKc6oNtaQbnAV2OC
 TSq+tSq9CseS9CgWw52fNsU5U5iX+BgV01elkS7S0GR4fKKsI62nf5a0ff7rtHDlJjxQfT+UImv
 +I2biID1uT8XeCuQ0gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200179

On Mon, 18 May 2026 14:58:02 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
...
> > > > +		    !(st->info->supported_sensors & BIT_ULL(sensor.type)))
> > > > +			return dev_err_probe(dev, -EINVAL,
> > > > +					     "sensor type %d not supported on %s\n",
> > > > +					     sensor.type, st->info->name);
> > > > +
> > > > +		dev_dbg(dev, "Create new sensor, type %u, channel %u",
> > > >  			sensor.type, sensor.chan);
> > > >    
> > >   
> > > > @@ -1445,8 +1782,9 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
> > > >  
> > > >  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> > > >  {
> > > > -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
> > > >  	struct device *dev = &st->spi->dev;
> > > > +	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, iio_chan_c = 0;
> > > > +	u32 chan, iio_idx = 0, status;
> > > >  	int ret;
> > > >  
> > > >  	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> > > > @@ -1493,8 +1831,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> > > >  		    !assign_iio)
> > > >  			continue;
> > > >  
> > > > +		/*
> > > > +		 * Copper trace and leak detector sensors without a custom table
> > > > +		 * produce only a resistance result; the chip does not populate
> > > > +		 * the temperature result register. Emit only an IIO_RESISTANCE
> > > > +		 * channel in this case.  
> > > 
> > > Do we care?  That is are they useful without the table? We could just make it
> > > required in the binding.
> > >   
> > 
> > The datasheet specifies the table is optional. But more practically, in order to
> > be able to add accurate values to the custom table, the users first need to measure
> > the sensor's resistance at multiple known conditions, so I think the resistance-only
> > output is useful during that characterization phase, before the table exists. Making
> > it required would force users to provide placeholder values just to get the driver
> > to probe.
> Who cares of datasheet is crazy :)

Fair enough :)

> 
> The initial case could I think be handled by an 'identity' table. 
> If it's useful in more general cases maybe we should always put out the resistance
> channels? This would be a bit like we often do for ambient light sensors, where
> we have a computed illuminance channel (IIO_LIGHT) + the data it comes from
> (IIO_INTENSITY)

I checked internally and we could make the table required for leak detectors. For
copper traces, sub-ohms variants cannot have one, but we could make it required
for > 1ohm ones.

This means we could remove the LTC2983_SENSOR_LEAK_DETECTOR from the if condition,
and have something like this in ltc2983_setup:

if (st->sensors[chan]->type == LTC2983_SENSOR_COPPER_TRACE) {
    if (st->sensors[chan]->n_iio_chan == 1) {
        st->iio_chan[iio_idx++] =
            LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
        continue;
    }
}
+ the n_iio_chan == 2 check at the end

or drop the n_iio_chan == 2 check and do something like:

if (st->sensors[chan]->type == LTC2983_SENSOR_COPPER_TRACE) {
    if (st->sensors[chan]->n_iio_chan == 1) {
        st->iio_chan[iio_idx++] =
            LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
    } else {
        st->iio_chan[iio_idx++] =
            LTC2983_CHAN(IIO_TEMP, iio_chan_t++, chan);
        st->iio_chan[iio_idx++] =
            LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
    }
    continue;
}

if (st->sensors[chan]->type == LTC2983_SENSOR_LEAK_DETECTOR) {
    st->iio_chan[iio_idx++] =
        LTC2983_CHAN(IIO_COVERAGE_PERCENT, iio_chan_c++, chan);
    st->iio_chan[iio_idx++] =
        LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
    continue;
}

or use a switch case:

switch (st->sensors[chan]->type) {
case LTC2983_SENSOR_COPPER_TRACE:
    if (st->sensors[chan]->n_iio_chan == 1) {
        st->iio_chan[iio_idx++] =
            LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
    } else {
        st->iio_chan[iio_idx++] =
            LTC2983_CHAN(IIO_TEMP, iio_chan_t++, chan);
        st->iio_chan[iio_idx++] =
            LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
    }
    continue;
case LTC2983_SENSOR_LEAK_DETECTOR:
    st->iio_chan[iio_idx++] =
        LTC2983_CHAN(IIO_COVERAGE_PERCENT, iio_chan_c++, chan);
    st->iio_chan[iio_idx++] =
        LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
    continue;
case LTC2983_SENSOR_DIRECT_ADC:
    chan_type = IIO_VOLTAGE;
    iio_chan = &iio_chan_v;
    break;
default:
    chan_type = IIO_TEMP;
    iio_chan = &iio_chan_t;
    break;
}
st->iio_chan[iio_idx++] = LTC2983_CHAN(chan_type, (*iio_chan)++, chan);

What do you think?

Thanks,
Liviu
