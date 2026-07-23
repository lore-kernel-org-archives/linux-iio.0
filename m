Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8D39CD08;
	Thu, 23 Jul 2026 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782526; cv=none; b=JDW5RSZtYoYKCgdLO5b3co6n+p7yT0Ug4S9w/wvjneY3/A8z1ax0B+u7Jlziv7ATVrPc42PGd0ENXLfW96xZVDEUyqM+gvZcvx/NSZI7XxrJQhS/GgrmYaWiJVGFWH983gakAf9zG9Vry8Te7uxRo/3aIulIObjkv2zM3QrLJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782526; c=relaxed/simple;
	bh=DqdcGNgGa2c1Rwi0YCb47sezO7/2DOY7BAfHABxWCfY=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=I1/haVIBrfhvZjA32aq4M8EMup3/vuGOvRU0/vvppDtnne+njsJrgjXdsCROFGQl5AN5+lA2HnvAtT5T37nw+1b2ol14K+TVnb5VbzFQe32VZza2psFENlUDLZCRgTP0enDjACdcTHDSVlZla6aT6yZLX0H5E9cZ2ih19/3n6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wnp3toMs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wnp3toMs"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0ZsEv348168;
	Thu, 23 Jul 2026 00:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7AIxg
	xPi6hfkED/0aK3ERMsFmCiQaPYZp4Vkf4y1OWg=; b=wnp3toMsJS5+AAkp8S6NQ
	ZbhkWhnI/OzNFyUlnTCfxW0iJIEBSVfV8ShnHKpdBkBOZfr1uayo0yU8ylAudQMF
	7OjNezhiWSf/umeGEuVSYGRA9FQGtyvXt/HdBO86HETks6uXH6Bsppt+F3qADzvE
	lTEbGWUej7OTUy6mr0kSDr2LINblYsg2JOnyyVRtuVBPUoGeKStFU17LNiP9qOsw
	G+X57sT6M5u+Rz6v77IyekjchX6iu9mBaxmXsc+i8ESLB/JDD4AF8Ep4Eb2o7vfb
	CgqP0EOAifuW1RFYM9/uQC3R7vHtaAzc4V8WY2Cz8RdYpU4iZHZ3yIleoct/lW47
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fj6vr189p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 00:54:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66N4snnK027444
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 00:54:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 00:54:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 00:54:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Jul 2026 00:54:49 -0400
Received: from localhost ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66N4sTkg025398;
	Thu, 23 Jul 2026 00:54:32 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Jul 2026 12:54:23 +0800
Message-ID: <DK5OKWNA10W8.10TCZD1XTZQBQ@analog>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: add support for
 AD5710R/AD5711R
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.8.2
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
 <20260721-iio-ad5710r-upstream-v2-4-324949dc72da@analog.com>
 <al9MPk9HfI0rTDHY@ashevche-desk.local>
In-Reply-To: <al9MPk9HfI0rTDHY@ashevche-desk.local>
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: nP8IqFsj4tKebq06AjOU2ZEer7Q5KwYc
X-Proofpoint-ORIG-GUID: nP8IqFsj4tKebq06AjOU2ZEer7Q5KwYc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA0NiBTYWx0ZWRfX6SqIQVsnySyx
 h8vZXhxkpidNzzlqcU1ajkcseB1GMEVVknRksSeSyfOjB+awzAhl+UK6W6vj4A9vGWZKxc03xRj
 bLwj0j9mxE4iOQWyXScjH0VJqhvORd5xqgbRgklL7APIW8w9GH7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA0NiBTYWx0ZWRfX5MzTgB5DRfYr
 oW7BXh4M6VLpKxbU0K96NW/0uVfUuVTCnTpepbQGY/3mJ5SeTuaL2KM8jh1BYg7g+6ghAr2ILAy
 JGDim5Fm6xfx2ufhWuIfW5Nqh5IF5Uewc+OTEYD1K73DH4lXVLi0b2cTtpHkrD1paWCh6TfGahB
 59qUlKHHn1hOszUsgJZCh4VLAlyOIALneJPl2XY5vES38e8IIm/is4nPJT/8WrQSqhYiw3N2bsW
 enyMEyJxlQaKPJgyE4kImaQMsSDyGZiXyuxu8wTlnIDBP18FQcRqZfK/qCuwoSHA6L9JR93Pqt0
 X8M5FkLOfNzTYTUd5MIHR4O1sBlFHu9vZ33CbU7Vj6CTZn4UjBTqp+aPJkvZ/+HgY9FZhCwB5De
 iFtS45e2oXZql1qygX7V0Ozl9CgqhO2iCmtd+cB2+c9fCaOxranbLnY0aetV/BaMVHAWLnab1v2
 qCBPNXyCaqvvuOggVQQ==
X-Authority-Analysis: v=2.4 cv=WIpPmHsR c=1 sm=1 tr=0 ts=6a619e9a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=VeLFCf2KXPs7WgRmu0EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230046

On Tue Jul 21, 2026 at 6:38 PM PST, Andy Shevchenko wrote:
> On Tue, Jul 21, 2026 at 04:47:13PM +0800, Kim Seer Paller wrote:
> > Add support for the AD5710R/AD5711R, 8-channel 16-/12-bit configurable
> > IDAC/VDAC parts. They share the AD3530R register map and access model,
> > so fold them into this driver.
> >=20
> > Each channel is configured as voltage or current output from its DT
> > channel@N node via adi,ch-func, building the iio_chan_spec dynamically.
> > Voltage channels enable VMODE_EN and report the reference-derived scale=
,
> > current channels report the 50 mA internal Iref scale. The powerdown
> > mode is read-only and derived from the channel's configured type.
>
> ...
>
> >   * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
> >   * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
> >   * AD3532R/AD3532 16-channel, 16-bit Voltage Output DAC Driver
> > + * AD5710R/AD5711R 8-channel, 16-/12-bit Configurable IDAC/VDAC Driver
>
> In the above only a single data width is mentioned, maybe split this one?

I agree, will split this into 2 lines.

>
> ...
>
> >  #define AD3531R_MAX_CHANNELS			4
> >  #define AD3532R_MAX_CHANNELS			16
> > +#define AD5710R_NUM_CHANNELS			8
>
> Why NUM and not MAX?

I think this can be drop since it was only used once in ad3530r_parse_chann=
el_cfg()
and that check can used chip_info->num_channels instead.

>
> ...
>
> > +static int ad5710r_get_powerdown_mode(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan)
> > +{
> > +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(st->regmap, AD5710R_CHN_VMODE_EN, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return !(val & AD5710R_CHN_VMODE_EN_BIT(chan->channel));
>
> regmap_test_bits()
>
> > +}
>
> ...
>
> > +static ssize_t ad5710r_get_dac_powerdown(struct iio_dev *indio_dev,
> > +					 uintptr_t private,
> > +					 const struct iio_chan_spec *chan,
> > +					 char *buf)
> > +{
> > +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> > +	unsigned int reg_offset, ch_in_reg, reg, mode, mask;
> > +	int ret;
> > +
> > +	reg_offset =3D chan->channel / AD3530R_CH_PER_REG;
> > +	ch_in_reg =3D chan->channel % AD3530R_CH_PER_REG;
> > +	reg =3D AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> > +	mask =3D AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> > +
> > +	ret =3D regmap_read(st->regmap, reg, &mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sysfs_emit(buf, "%d\n", !!(mode & mask));
>
> Ditto.
>
> > +}
>
> ...
>
> > +static const struct regmap_config ad5710r_regmap_config =3D {
> > +	.reg_bits =3D 16,
> > +	.val_bits =3D 8,
> > +	.max_register =3D AD5710R_CHN_VMODE_EN,
> > +};
>
> No cache?

The existing ad3530r/ad3532r regmap configs don't use a cache either,
so kept this one consistent. Can add it as a separate cleanup across
all 3 configs if preferred.

>
> ...
>
> > +static int ad3530r_parse_channel_cfg(struct ad3530r_state *st)
> > +{
> > +	struct device *dev =3D regmap_get_device(st->regmap);
> > +	struct iio_chan_spec *channels;
> > +	int ret, num_chan;
>
> Why is 'num_chan' signed?
>
>
> > +	int i =3D 0;
>
> Signed? Also, split assignment and move it closer to its first user.
>
> > +	u32 reg;
> > +
> > +	num_chan =3D device_get_child_node_count(dev);
> > +	if (!num_chan)
> > +		return dev_err_probe(dev, -ENODEV, "No channels configured\n");
> > +
> > +	channels =3D devm_kcalloc(dev, num_chan, sizeof(*channels), GFP_KERNE=
L);
> > +	if (!channels)
> > +		return -ENOMEM;
>
>
> 	i =3D 0;
>
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		unsigned int reg_offset, ch_in_reg, mode_reg, mode_mask, ch_func;
> > +		enum iio_chan_type chan_type;
> > +
> > +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to read reg property of %pfwP\n",
> > +					     child);
> > +
> > +		if (reg >=3D AD5710R_NUM_CHANNELS)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "reg out of range in %pfwP\n",
> > +					     child);
> > +
> > +		ret =3D fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Missing adi,ch-func property for %pfwP\n",
> > +					     child);
> > +
> > +		switch (ch_func) {
> > +		case CH_FUNC_VOLTAGE_OUTPUT:
> > +			ret =3D regmap_set_bits(st->regmap, AD5710R_CHN_VMODE_EN,
> > +					      AD5710R_CHN_VMODE_EN_BIT(reg));
> > +			if (ret)
> > +				return dev_err_probe(dev, ret,
> > +						     "Failed to set voltage output for %pfwP\n",
> > +						     child);
> > +
> > +			chan_type =3D IIO_VOLTAGE;
> > +			break;
> > +		case CH_FUNC_CURRENT_OUTPUT:
> > +			chan_type =3D IIO_CURRENT;
> > +			break;
> > +		default:
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "Invalid adi,ch-func %u for %pfwP\n",
> > +					     ch_func, child);
> > +		}
> > +
> > +		channels[i] =3D ad5710r_channels[reg];
> > +		channels[i].type =3D chan_type;
> > +		i++;
> > +
> > +		reg_offset =3D reg / AD3530R_CH_PER_REG;
> > +		ch_in_reg =3D reg % AD3530R_CH_PER_REG;
> > +		mode_reg =3D AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> > +		mode_mask =3D AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> > +
> > +		/* Enable the channel in normal operation mode */
> > +		ret =3D regmap_update_bits(st->regmap, mode_reg, mode_mask,
> > +					 field_prep(mode_mask, AD3530R_NORMAL_OP));
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to set normal operating mode for %pfwP\n",
> > +					     child);
> > +	}
> > +
> > +	st->channels =3D channels;
> > +	st->num_channels =3D num_chan;
> > +
> > +	return 0;
> > +}
>
> --=20
> With Best Regards,
> Andy Shevchenko

