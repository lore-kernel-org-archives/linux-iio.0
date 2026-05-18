Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCE3E00BF;
	Mon, 18 May 2026 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091685; cv=none; b=Qm0cGg+fTJVOMkzKBt4F71l5AypQscPSxYYRAY7eSsp5Ic2D1yeptUqeNrct8mEM0AWNARXzqMAPSR1gG8pdKSaQjNyBJBRqKEN71hn3+xxcswG8CSWNYQfaKZl9wq97u4v98DVoU87h92YXTKzagxoVsk4RrlaSMrYoUAfYNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091685; c=relaxed/simple;
	bh=kkVu6KbuspfNySAVsvW3FsvEqu9yql8ziQaMin2nxBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDUqS4iJdtfjQi8W8v4qAnOyVz9EsU/pZQcrDXkG/Ms6Ldlue5OswOA3GeyG0VM0rh502vKQ67rpU4mlFPyflQztkcIU5IUDYcSoeHlj5njo+Ou4D/dicOJAPEqEM+HZnMmiFvjLatmnHYRLmX+fZdbTdYjZ86H1o4H32Du4IPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bswwgy79; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bswwgy79"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I3M7UT174954;
	Mon, 18 May 2026 04:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oEWE7
	EY0P5l/hBScGfHoHisI61A1Pvwve2WFQHzEEBM=; b=bswwgy79BDTk05FdBBc/w
	g9E1+DSnC+wP9QxSa5C1DuA0Ornr3J0xIeNXgVGGA9oq1fpUbXMdkeXqpYI450YZ
	rHtgInO9j85hQX15sdowxMq2WsJn/H8vNrQPKmPMGWziTv4gY434Tqgbppwv13hx
	RESI/0bGMFvfCGV6rFx0KizIALYR4QSqeP4sxc5gIdMBk7MBnmpfCKQlDCD7TWZn
	KiW03MHenZ0qEXYCDwE+Wnp9Va+NnLMHL1x4TlNyEY8VY1zc22A53B8kXq/4swUG
	WESaR8SKov1yEZdI2nGct+60RSlvCiuwZFnIJ5ORYsc2APAIDxqIsqjR6TkEwd0e
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e76wd33px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:07:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64I87qht015323
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 04:07:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 18 May
 2026 04:07:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 18 May 2026 04:07:52 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64I87fQa018119;
	Mon, 18 May 2026 04:07:43 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for ADT7604
Date: Mon, 18 May 2026 11:07:17 +0300
Message-ID: <20260518080731.83585-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516181250.039e154a@jic23-huawei>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3NyBTYWx0ZWRfX4qUwewI7BlQH
 CcgM2TP1rHxSVHhZcuWZu6oWjmQqFkaRUf7U7oWeRuHxtoTgA9cAljTfL7ibdS2Ph0hS4m0sgO1
 DqoDtcR6obFaTRaVQ+W2IKYz5hlfRhXOv98mJORgpK8pf/G1hu1DMzJaS0qri8ESn13RU7Cwqv8
 llVgBMxXLqn9nCF24Ijl6St/FqZJd3aa7fbJshB0RfYNj6IQt9NUggfs5KI5rdRWmJFA8SKAjdf
 Fhg1ctMbNXnh6HeUd+TPXjsuJBlTrm9OmH/bXBviuIvMvtBm/EUQ4/BKR5cgrseNY4JCVrFliAc
 +2c13A0opZZoXjhnhe3sQWuYWKcPGK3Pt9HUbCDcodaDZ1Ft4LKa5uvWSaS2p55fSI8wwpNQ3Lg
 cAH+aA0/FafBD3ETE5JtmX/QB7vo1J0xinRgdClzzb9SggrwYFo38pNHWCRNvR/7qhoduRzzMPq
 0JmNnjXBzO51c2A05AQ==
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a0ac8d9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=g_30PTRQj-5-3ZeuMogA:9
X-Proofpoint-ORIG-GUID: EtTz80t85O_IzfgMC75o2-mPmwSXi2zF
X-Proofpoint-GUID: EtTz80t85O_IzfgMC75o2-mPmwSXi2zF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180077

On Sat, 16 May 2026 18:12:50 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> >  drivers/iio/temperature/ltc2983.c | 401 ++++++++++++++++++++++++++++--
> >  1 file changed, 386 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > index bf435e965c6d..acd043ed62f5 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -28,6 +28,8 @@
> >  #define LTC2983_STATUS_REG			0x0000
> >  #define LTC2983_TEMP_RES_START_REG		0x0010
> >  #define LTC2983_TEMP_RES_END_REG		0x005F
> > +#define ADT7604_RES_RES_START_REG		0x0060
> > +#define ADT7604_RES_RES_END_REG			0x00AF
> >  #define LTC2983_EEPROM_KEY_REG			0x00B0
> >  #define LTC2983_EEPROM_READ_STATUS_REG		0x00D0
> >  #define LTC2983_GLOBAL_CONFIG_REG		0x00F0
> > @@ -186,17 +188,43 @@ enum {
> >  	LTC2983_SENSOR_SENSE_RESISTOR = 29,
> >  	LTC2983_SENSOR_DIRECT_ADC = 30,
> >  	LTC2983_SENSOR_ACTIVE_TEMP = 31,
> > +	/* Sensor types for some parts only; map to RTD_CUSTOM/THERMISTOR_CUSTOM in HW */
> > +	LTC2983_SENSOR_COPPER_TRACE = 32,
> > +	LTC2983_SENSOR_LEAK_DETECTOR = 33,
> Given you care about being in range of this I'd add
> 	LTC2983_SENSOR_NUM
> >  };
> 
> > @@ -1329,7 +1649,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
> >  	if (!st->sensors)
> >  		return -ENOMEM;
> >  
> > -	st->iio_channels = st->num_channels;
> > +	st->iio_channels = 0;
> >  	device_for_each_child_node_scoped(dev, child) {
> >  		struct ltc2983_sensor sensor;
> >  
> > @@ -1357,7 +1677,13 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
> >  			return dev_err_probe(dev, ret,
> >  				"adi,sensor-type property must given for child nodes\n");
> >  
> > -		dev_dbg(dev, "Create new sensor, type %u, chann %u",
> > +		if (sensor.type > LTC2983_SENSOR_LEAK_DETECTOR ||
> 
> To make it easier to extend in future, perhaps add the NUM entry I mention
> above then >= to it here.
> 

This makes sense. I will change in v3. Thanks!

> > +		    !(st->info->supported_sensors & BIT_ULL(sensor.type)))
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "sensor type %d not supported on %s\n",
> > +					     sensor.type, st->info->name);
> > +
> > +		dev_dbg(dev, "Create new sensor, type %u, channel %u",
> >  			sensor.type, sensor.chan);
> >  
> 
> > @@ -1445,8 +1782,9 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
> >  
> >  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> >  {
> > -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
> >  	struct device *dev = &st->spi->dev;
> > +	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, iio_chan_c = 0;
> > +	u32 chan, iio_idx = 0, status;
> >  	int ret;
> >  
> >  	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> > @@ -1493,8 +1831,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> >  		    !assign_iio)
> >  			continue;
> >  
> > +		/*
> > +		 * Copper trace and leak detector sensors without a custom table
> > +		 * produce only a resistance result; the chip does not populate
> > +		 * the temperature result register. Emit only an IIO_RESISTANCE
> > +		 * channel in this case.
> 
> Do we care?  That is are they useful without the table? We could just make it
> required in the binding.
> 

The datasheet specifies the table is optional. But more practically, in order to
be able to add accurate values to the custom table, the users first need to measure
the sensor's resistance at multiple known conditions, so I think the resistance-only
output is useful during that characterization phase, before the table exists. Making
it required would force users to provide placeholder values just to get the driver
to probe.

Thanks,
Liviu
