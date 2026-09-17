Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9192C1788;
	Thu, 17 Sep 2026 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789614078; cv=none; b=HBljUhZXR8f4jU/TIwivW0hraNL6mA0ymefXx/KJjVpxoZwus4e0n3qqTrM8B9cY9MZG2jGR2LUiMQDELGtmiylXhiqCShtjUlV90mVSQnog24s0xxmSUmjdSNy4tTjCQXpLvBFwyaXb8QPI0zBn5U14AQTnhC3waQQDbOgNTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789614078; c=relaxed/simple;
	bh=QWJAJqvH1e/AGtyDInlJSpQJy2Zn0TUCa22Mxp86lic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDVm8uARxVNRQmIY/axiElxNyH1J6RLxxqFK4cXPtGMZVpMeScl4LxrGVm8eoR+hVXX9qq/x/4qIL5UnBoPNkeiabShh46ZtZ+ZW3PWxgWDMSQuGNr4MwpXqlTjz8nISnSEvneYyKWhQXnHADHYWXt806Dzyl2nUmZRqurR1zSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEaz2tU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEaz2tU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E1E1F000FF;
	Thu, 17 Sep 2026 03:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789614070;
	bh=YZ3EH78hvQbWNUoIiyebmp9fOz2qE1EZcl3jVsHy+wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nEaz2tU+DVWd6u3p15MU/SMK2qYh2FAQ+RBHctm1iQ/YBI6KvzERTvC8AeRb2R6dY
	 hbFBDASgAZgbS8hNf4dKuEkgo93YfdoVAVtAjhC+4kr5WoKa+Ph5P1tufb8TUNtcKP
	 QHilyA2isfSgrzYyfcSeNLEHgHSBLdcsMzfA+bl55aTGYBxNsRVP9BU9gJUjpAUx2B
	 f6ZVYGmEIdqDc88lQxAm+zJ/5+Q3DcHTsfUjJoBAKpEoVtUL7LBCkZ/ivioNeva3kI
	 rIaHqdBjCwl4GKaMmPA5ASJGvURzgCq86qgKidUwakCi7dYZGaPMutW3vgkjyYc69t
	 OPtyXLAVD16DA==
Date: Thu, 17 Sep 2026 04:01:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, "Jose A. Perez de
 Azpillaga" <azpijr@gmail.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <20260917040102.59be257c@jic23-hlaptop>
In-Reply-To: <aqiyQOMGGIzu-91z@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
	<20260912013912.51887-3-marcus.yu.56@gmail.com>
	<aqepkmQS_p6K1Bd6@ashevche-desk.local>
	<aqiyQOMGGIzu-91z@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:49:36 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> On Mon, Sep 14, 2026 at 11:00:18AM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 11, 2026 at 06:39:12PM -0700, Chang Yu wrote:
> > 
> > ...
> >   
> > > +static int as7343_setup_device(struct device *dev, struct as7343_data *data)
> > > +{
> > > +	struct regmap *map = data->regmap;
> > > +	unsigned int val;
> > > +	__le16 step;
> > > +	int ret;
> > > +
> > > +	/* Power on */
> > > +	ret = regmap_set_bits(map, AS7343_ENABLE, AS7343_ENABLE_PON);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Need to set REG_BANK to 1 before we can access ID */
> > > +	ret = regmap_set_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_read(map, AS7343_ID, &val);
> > > +	if (ret)
> > > +		return ret;  
> >   
> > > +	if (val != 0x81)
> > > +		dev_info(dev, "Unknown device ID: %x\n", val);  
> > 
> > Wouldn't be better to define 0x81 with meaningful name?
> >   
> 
> If I remeber correctly Jonathan prefers just putting 0x81 inline. I'm
> OK with either style so I'll defer to the judgement to Jonathan here.

I briefly wondered why I said that and went to look.
I've been reading too many multipart drivers that do

#define THING1_ID 42
#define THING2_ID 43

struct something_chip_info thing1_chip_info = {
	.id = THING1_ID,
};

struct something_chip_info thing2_chip_info = {
	.id = THING2_ID,
};

And in those cases it doesn't make any sense to have defines.
So I was thinking don't do it here either so we'd be in a nicer
position when another device (maybe) shows up.

Jonathan
