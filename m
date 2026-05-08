Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C579374187
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231906; cv=none; b=cJEkufP2w6UadrU0w3q49kNjs6eyDZ8ggCoDAD7CdZ/CqFTCXi/iO2EnvEPIqFw+Y57ThC90GrVCQvmQKCvjeLCbbw4kJpQfZ6kmp3XcETGYyuiYVHOZaGRlCkNaKpWw2xN10EooQogZ07puFdqfl1pW3+uf1+ruxJpJTjl3xxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231906; c=relaxed/simple;
	bh=x87VvY9k09CMD6ZDoAc6MgD8HfCyyOZtXGs0mQHknbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrKXnFY5LhiCet3CFDLTX6DfFshGP6RrnAeXZTvxZRkew1wbWNpEe31EE5VHwvLDwta9FN0/oxRZgN0w8F7AU6YQc6x5TL0Q/F7zPyk3qNV6atW1ohMQOc3kVjaodCOgUgoS5dBJCY+WEQMp3TVUQ101j7x9LnAXyRepfj+GxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeYIyQgW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeYIyQgW"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso1450220f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778231902; x=1778836702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ku/ICma2gxDE2kcR48qisRKKRusKewtK808/1tsRoR8=;
        b=OeYIyQgWI020jpfSKEuD1phpdmINy0V8DiSQUJzfZtNjOFFq7/ZyTZ/17Mg1NwnLFt
         deId3MoO2FPEzJLEgLYziJX2rhNP/8iH4PoOfXvDv9jo7FzRFrrDHV1HbkkKaHLTnQ25
         HkeMsQEqrtw7ZgUyOEiVdFoDGKKp/jHWN2dov3vIStagvvCMrtJV3z9cl64wO2R3xbwU
         Y0cKuC9CQPrnUtBZEuryKcukh/8NLRQkTRv66msUJa3VWkbBBUZRd8oKgR1m1pSJsu9p
         FDO2u42MhLZi62jh557xAgJv1SqobCbbj/0OJoAzm95+0plG8BZWFrHzcLZAxvrlSOOj
         TE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231902; x=1778836702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ku/ICma2gxDE2kcR48qisRKKRusKewtK808/1tsRoR8=;
        b=RgXV2+8ewkwTmjXH39m7XOSB1pQSvbIFrLif8u92y5s1tXCtTVVyR/nW7Jiym5KrSa
         oXt9k8cp4nSBC8voV2I/mU/JmohulS5mXu0WvS0ewnJ9GIHPP5snLp030gpj9oevWjYj
         qrb1FAYkwm8HKnR3e/SB1/VFgWPsV82EjyfGGn9D4wwUlWiNeSioIoeOB52EEWQUgWIj
         cqT+h0p9pH02wYY5En6UYystp/SxaD6/zbIv3+v0ZQGGi/m9i3iNi9OM0sUrQLzQ/dFx
         m9eBDnL/fO4G28Z+/e13d07/TfSULuH2ju/AMac/a0Mmnm4JWAHaDjjOQIN1snZY7wm/
         FTgw==
X-Forwarded-Encrypted: i=1; AFNElJ8KZ0Nh3IS1Ff4R35raewvEkER97I8R1PaUET7dDLkY/7f5m8Wvn+K5vNPrNn9KSt5a4bX+UNas3j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgovAAPiozwsUbVgpukETCNx0TNfVUABLCw3EGhHbRwJNLufQG
	F2BpBsEE6vL3X2VTt6Vh3gaBzfXmtpWiTz4nSSP51FaaiJ70zu8FGaYs
X-Gm-Gg: Acq92OEkikwVeqPwtGle/tEhJZUDjf3vyqxG0pHOTDJpxDBttxNHc7lpOFIx869w/+J
	9BIwWPHlzhsShdADNJnlOPH45K9vEhMY53ZRwatXDwhK4zCmgUkaADG8w/dTSc4qBn0cOUDGNFT
	FWs9wcWTJ7/Y68HcxIX54lpFIExMojP0JhnjRWK2LJJGFlVSIHfYxeI4D3KUJLHm7upqetAsG+a
	VrW5uEmtzUNq9O2Sd43mYO7ya2SdapClcyg/W+YJXBsU5VOLh7hnaMYiyJUS0M22+3F7ZLAU+PS
	ev1vCT9XP0HoFTEdgccCdR/FEkAy07Q3NFxogMdvxgzwjuk+4Y43ROuzEBgnzO5El8bL9atT312
	Rd9WNJEJyAQDVWbLjRONrxAzAIURQ+DxyFz3J7t+rkJe6A5tJIh1db1gjJYMB8SGURwo0uC/z+a
	zdBnJqS+bSI4IWCm4=
X-Received: by 2002:a05:6000:4210:b0:43b:9a9f:8956 with SMTP id ffacd0b85a97d-4515ce1c80fmr18257155f8f.22.1778231902269;
        Fri, 08 May 2026 02:18:22 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bbebdsm3214464f8f.5.2026.05.08.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:18:21 -0700 (PDT)
Date: Fri, 8 May 2026 10:19:15 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <af2no3bJA9MSjXvV@nsa>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
 <afCVtXBHIIoLlsRo@nsa>
 <SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>

On Thu, May 07, 2026 at 05:25:58PM +0000, Stan, Liviu wrote:
> Thank you for the comments, and I apologize for the late reply.
> 
> On Mon, Apr 28, 2026,  Nuno Sá wrote:
> ...
> > > Both sensor types expose an IIO_RESISTANCE channel reading from
> > > the resistance result register bank (0x060-0x00AF), added to
> > > the regmap readable ranges. Scales are 1/1,024,000 for copper
> > > trace (result in mOhm) and 1/1024 for leak detector (result
> > > in Ohm).
> > 
> > But for userspace we report both in Ohm? That's the ABI AFAICT. In DT,
> > you also mention IIO_TEMP is used:
> > "IIO_TEMP reports coverage percentage"
> > 
> > Can you expand more on what the above means? Are we reporting milli
> > degrees celcius to userspace?
> 
> Yes, both IIO_RESISTANCE channels report in Ω. The commit message was 
> misleading, it described the register's native units (mΩ for copper trace,
> Ω for leak detector), not the userspace output. The scales are chosen to 
> cancel those units and give Ω in both cases.
> 

ack

> As for the IIO_TEMP question, the chip's custom sensor table stores 
> temperature in Kelvin (same as the LTC2984 custom RTD table). For the 
> leak detector, coverage data is encoded as (P + 273.15) K, so when the 
> chip converts Kelvin to Celsius on output, after the driver applies the 
> 1000/1024 scale, the IIO output is P * 1000 millidegrees C - 0% reads
> as ~0 millidegrees, 100% reads as ~100000 millidegrees. But yes, the 
> actual useable quantity is coverage percentage, not temperature. Is there
> a more suitable existing IIO channel type for coverage percentage?
> 

Will defer this to Jonathan but if we can have a real of the coverage
given the temperature, I guess this is ok. Given that I think we don't have
a better channel (unless we add one?) for this. Or just extended_info...


> > I could not find the datasheet so I guess it's not yet public?
> 
> Correct, it is not public yet. Will upload the URL once it is.
> 
> ...
> 
> > >  struct ltc2983_data {
> > > @@ -272,6 +275,7 @@ struct ltc2983_rtd {
> > >  	u32 r_sense_chan;
> > >  	u32 excitation_current;
> > >  	u32 rtd_curve;
> > > +	bool sub_ohm;
> > >  };
> > >
> > >  struct ltc2983_thermistor {
> > > @@ -575,6 +579,10 @@ static int ltc2983_rtd_assign_chan(struct
> > ltc2983_data *st,
> > >  		if (ret)
> > >  			return ret;
> > >  	}
> > > +
> > > +	if (rtd->sub_ohm)
> > > +		chan_val &= ~GENMASK(17, 0);
> > > +
> > >  	return __ltc2983_chan_assign_common(st, sensor, chan_val);
> > >  }
> > 
> > I'm not sure if we shouldn't just treat the new types as new sensors
> > instead of trying to push them in the existing one. I agree with Andy,
> > the patch does not look great with respect to if() else() and going to
> > deep in indentation.
> > 
> > >
> > > @@ -758,83 +766,113 @@ ltc2983_rtd_new(const struct fwnode_handle
> > *child, struct ltc2983_data *st,
> > >  		return dev_err_ptr_probe(dev, ret,
> > >  					 "Property reg must be given\n");
> > >
> > > -	ret = fwnode_property_read_u32(child, "adi,number-of-wires",
> > &n_wires);
> > > -	if (!ret) {
> > > -		switch (n_wires) {
> > > -		case 2:
> > > -			rtd->sensor_config = LTC2983_RTD_N_WIRES(0);
> > > -			break;
> > > -		case 3:
> > > -			rtd->sensor_config = LTC2983_RTD_N_WIRES(1);
> > > -			break;
> > > -		case 4:
> > > -			rtd->sensor_config = LTC2983_RTD_N_WIRES(2);
> > > -			break;
> > > -		case 5:
> > > -			/* 4 wires, Kelvin Rsense */
> > > -			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
> > > -			break;
> > > -		default:
> > > +	/* ADT7604 requires hardcoding sensor configuration bits to 0b1001
> > */
> > > +	if (st->info->has_copper_trace &&
> > > +	    sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
> > > +		rtd->sensor_config = 0x9;
> > > +		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
> > 
> > Like the above, we have the following kind of condition all over the
> > place. In DT we can just have a different type for these and map it to
> > real value when creating the sensor.
> 
> I understand, I will introduce new adi,sensor-type enum values for 
> copper trace and leak detector. The driver will map these to the 
> hardware register values (18 and 27) and handle them in dedicated 
> switch cases with dedicated functions (ltc2983_copper_trace_new() 
> and ltc2983_leak_detector_new()), removing the has_copper_trace guards
> from ltc2983_rtd_new() and ltc2983_thermistor_new() entirely. One 
> tradeoff is that the adi,sensor-type values for the new sensors will 
> now not coincide with the hardware register values in the ADT7604 
> datasheet.

Yes, I was aware of that but I think (I could be wrong) that the
simplifications it will bring will justify for the small "fixup" we'll
need to do on the driver.

- Nuno Sá
> 
> ...
> 
> I will address the rest of the comments in v2 as part of the restructuring.
> Thank you very much.
> 
> Liviu
