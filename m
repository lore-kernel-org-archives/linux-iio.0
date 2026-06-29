Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF692DB788
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755118; cv=none; b=QqMSMSH6++tAa9mC1WMNzNtKJB8wYEYd2ae9ImsF85WfRk+0xKcs0cnMxJdnxGnPkVhLzb/w8IGT05EiH+k77NkfI7jXpSHDDTFwlJVxXgqBxyq8S10OEX2i2d5w++1Vxe0C+Ub9XjUcoVqoIQjU9AGgEJzS5p/rPWf4VsEuXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755118; c=relaxed/simple;
	bh=BiJEny0LSD1212/l0Ybzk08mrhYUdni/um4kOzIeC5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS58pyK/QEuV/zcT6rSofrj/eKX93Qv0/NfF1vWqzlS79FHmqXzYBIRB5J10WZiZ1zwuyUChvrPSBw1Ur7jlGaeip3MSNKWrUP8v4F79g0cqMQp81GtEG4kJEDSDsxuirFMkF6gb5H6Wa4Bwy6LGW1emqDoXzUZJKWEqeri8mG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuobyOBI; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuobyOBI"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59ebb89109aso3169188e0c.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782755116; x=1783359916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Twvn/bIc7PA5IV9RrXY1WwG29WqyLHjssToGt3hx7lY=;
        b=JuobyOBIeAWPoeKZ19PcubUIHkofhtCkxbfTH9yUKd3CE0lRr5MiHpD3qysDZnro3C
         hXfpfMSdlLFmGZuWaRoN8I/A5gXAXi0ghMX8eM2wf8EfX+LMO3fI3GwM2m1aTosFS0z3
         F6dhFfb4dz/KTVr+ux3xB2G/UYhpODnsgxDMxG/Sp/mYQ9sLLQFc+LqanKU0g4jQGNL2
         LkSXOG7+eIu4X0wTf9vPEV+bVFhikiqjq4N8UryTflq8KtfP/4fvjMkNUlJaCzVrT2qa
         kkKKtnvjt4mTSS8OYEql/MVq2QO8qwUd22J80viFncOaDMC5f7zJEsdJjDw3Sq5VMC2S
         +IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782755116; x=1783359916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Twvn/bIc7PA5IV9RrXY1WwG29WqyLHjssToGt3hx7lY=;
        b=OWxjUz3JvXzr/Ak+JH1RSKBPWT3B/Y/1EKsjfsHMYE84iQKVCid4v70Luh2VZ55YKa
         dgEHMS8yHjhFR9vT/U5tAV6X2oAvPEuv68bdCETdHFbR4jFroF+vhnHCvW+4VCSIimwv
         1jt4Un2EFuRNHG2Ik3xGfjJ3miXFxUYRH71n/8JiN3QZ5u7kJ+2VbRBLry04LUAky/kg
         f9w7UI0AGWX6/AJU57g2fWtKmttvoso+Q3dWfRWtf9X7q+0huNz25E+LGT774mIA6KBX
         O23dVz4V70iFw0r6/Px1FFWYebMI3qKlkNib5zS5vVd86YR3BaTZB5o2oSPLqMw20N5A
         IMOA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2YUE5x5FtMDoG1njnfvPhUXGlTvUDDvFU6mHQW90C+burypQFAlJByBj2oCSLvUteOPqKxp5dWKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/R7M3CacfrtF25J7JBzMjubNlr0oeQOe5O+RHDubQYOuE59X
	UkIZaYd/MbNSH/C0qPnj7HN4EMa9YyHVLYBrZ0Y+niSt7Y23C+WhbtM7
X-Gm-Gg: AfdE7cmSv5L1P6RQluZADhD/qdUeciFGOqX9Owq/wdiYGGkf5Sze8OIaiZQOZM+uAwk
	mYwZEQ93//8urf8hfsO5weaII7hvl5WfPkv78Qqc01naiHA3Wzdg7Vvse/TYQqk7EL2o//t7k9q
	eMnASUpAyIf5OLbkL8lEqoPRd7k0ZhXLl04UVjolJ6muJ2YzvARosku2HRSU/boiPvKTF7RZnvj
	zjjm6s/KzhE7zIXE/sSoiDvjhy/XxIL0vYBV6hTpddV87+JD3SAAjY9urFKOsggEq4ZuVoc7RDT
	xRBso+TwvFyFS3ao/COZupc+q/PeaY8aV6/ty5+s1mZsCJzDMKs6IagwbfouytDTUj6/uRUXMNg
	OFcb2JwyH+Cz3wVBf3P8LXW267zqWXaw7ihIho0njTlCHZDR9/iMfraFXybbJI3uaMCz62RgVe8
	B8ZOpzf3U7sfhtCkdzFFF1og==
X-Received: by 2002:a05:6122:17a2:b0:5a5:3eea:4513 with SMTP id 71dfb90a1353d-5bdbedec567mr459042e0c.12.1782755115782;
        Mon, 29 Jun 2026 10:45:15 -0700 (PDT)
Received: from localhost ([2804:30c:1618:8400:e838:86ad:21d4:de00])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd78e4bf00sm5740525e0c.2.2026.06.29.10.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:45:14 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:46:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v4 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
Message-ID: <akKvWOIy44jZMY_h@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
 <0abf862eeb277ae82262d09b11b1446f04c47be7.1782397418.git.marcelo.schmitt@analog.com>
 <9c6e0a74-c9c5-43ee-8eca-ae1667c51c32@baylibre.com>
 <akKHv7j22P6KczXb@debian-BULLSEYE-live-builder-AMD64>
 <3a96a20c-f435-4b98-9e95-26a28bd06e7b@baylibre.com>
 <akKZOq6DV5x1FvAc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKZOq6DV5x1FvAc@ashevche-desk.local>

> > >>> +static int ltc2378_regulator_setup(struct device *dev, struct ltc2378_state *st)
> > >>> +{
> > >>> +	int ret;
> > >>> +
> > >>> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> > >>> +	if (ret < 0 && ret != -ENODEV) {
> > >>> +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> > >>> +	} else if (ret > 0) {
> > >>
> > >> Else is not needed here.
> > > Why not?
> > 
> > The if returns unconditionally, so else is not needed. This is just a general
> > principal.
> 
> Unfortunately in this case ENODEV will go further, I don't see full context,
> but it may lead to something unexpected.
> 
> Personally I prefer the ladder of
> 
> 	if (ret == -ENODEV)
> 		...
> 	else if (ret < 0)
> 		...
> 	else
> 		...
> 
After splitting regulator availability check on a chip specific basis it will
probably simplify to something like

static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
{
	int ret;

	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
	if (ret == -ENODEV) /* refin is optional */
		st->ref_uV = st->info->internal_ref_uv * 2; /* ref buf amplifies REFIN by a factor of 2 */
	else if (ret < 0)
		return dev_err_probe(...);
	else
		st->ref_uV = ret * 2; /* ref buf amplifies REFIN by a factor of 2 */
	
	return 0;
}

For 'ref' only parts it will probably look like previous versions

static int ltc2378_ref_setup(struct device *dev, struct ltc2378_state *st)
{
	ret = devm_regulator_get_enable_read_voltage(dev, "ref"); /* ref is required */
	if (ret < 0)
		return dev_err_probe(dev, ret, "failed to read ref regulator\n");
	
	st->ref_uV = ret;

	return 0;
}

Calling the appropriate ref setup function for each part shall then (hopefully) 
error out incorrect device trees.
