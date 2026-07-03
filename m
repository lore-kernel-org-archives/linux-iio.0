Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D12F1FEC;
	Fri,  3 Jul 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783121813; cv=none; b=i+mR/xTmTCcPih3YehbvgHnoG26gENCHnwaNcoR7RR7C95evr3uJUmlXsESr/IZudUfBuUX9Phq6rK4Xa99RmZgmHw/yE7p2UcEu6QU/cRrZ0oCCSRi/1IuT7QS3vgtD1Ouz3Ls7u3vMLT8+MvCchYrOor6SFqADXbP2cYydWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783121813; c=relaxed/simple;
	bh=wDAzIc9/yuz4mXdjoAzqXnid75rx6nEI4hFtYbbMjZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxi1T0P2iXHKrRe8HBy9A27ch5esNZjLKGF1E0v03GWjPn6jpsfDJpIZgnq7hs2Vd0CVA/yOE+OIPBpdKS5AFP/JnJNxscnEpgXijaXwEuLfAIOB0Vgos4amG6bgu2hdE57tEbcSMlY2fA1jvVX4L6ZCMq85ao5KnI0dw4jsJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFdewBlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFdewBlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D371F000E9;
	Fri,  3 Jul 2026 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783121811;
	bh=TT//f0vnPQWRYHGBNIgVljcibhzx6t3nbf8kb8FZOF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hFdewBlkYyZ3YDOT4g9yj60cnKUyFnk6tSo7AKbh+wUgwK3+GmBk7RVfSxeB5ySj7
	 JPC7y5Wchct1LFSLGNs5+k5fTThQBCn5o/jXOlj7DIJu+ombqPQQ6RlWIoxFqkgO2l
	 aig/+hiBovVwSukU8jIyp4nLXBpLQWAe/UeW32iTTDlBezsLJ7nI1FT9fQMo3NcVCW
	 O8oQugfB5YeGI1YdIm0/AUvMSHRwXhJmnEQCqDlwaN1BIW+FYpwlNbFH2i6cqULHPd
	 RmiBqp91fYD3ZNd0rMs/PUqldkjYNgSOcK+pViMioM6j5a2uHWMdDG6kot/cz7ZijX
	 5CMckNa7kFqHQ==
Date: Sat, 4 Jul 2026 00:36:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stefan Popa <stefan.popa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ciprian
 Hegbeli <ciprian.hegbeli@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260704003644.1e4d3320@jic23-huawei>
In-Reply-To: <akemSbFS7o-Y6qw6@ashevche-desk.local>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
	<20260703102941.1141341-3-stefan.popa@analog.com>
	<akemSbFS7o-Y6qw6@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +/*
> > + * The RANGE field (CFG bit 6) selects one of two current-sense full-scale
> > + * ranges (the MAX40080 supports exactly two: +/-50 mV and +/-10 mV). Ordered
> > + * so that the array index equals the RANGE field value: index 0 = 50 mV range
> > + * (gain 25 V/V), index 1 = 10 mV range (gain 125 V/V).
> > + */
> > +static const int max40080_csa_gain[] = {
> > +	MAX40080_CSA_50MV_GAIN, MAX40080_CSA_10MV_GAIN,
> > +};  
> 
> With a given comment and one time use of those definitions, do we need them
> at all?  I leave it to Jonathan, because my memory is weak on his preference
> in the cases like this.
> 

Defines for the indexes would be good so the ordering comment isn't needed.
The define as currently used don't benefit anyone.

static const int max400080_csa_gain[] = {
	[MAX400080_CFG_RANGE_50MV] = 25,
	[MAX400080_CFG_RANGE_10MV] = 125,
};

Related somewhat
> +#define MAX40080_REG_CFG		0x00
> +#define  MAX40080_MODE_MSK		GENMASK(2, 0)
> +#define  MAX40080_PEC_EN_MSK		BIT(5)
> +#define  MAX40080_RANGE_MSK		BIT(6)
> +#define  MAX40080_FILTER_MSK		GENMASK(14, 12)

The fields should be named so that it's is obvious which register they are in
then add field value defines where they are relevant - again naming them
to make register and field part of the name.

#define MAX400080_REG_CFG ...
#define   MAX40080_CFG_MODE_MSK ...
...
#define   MAX40080_CFG_RANGE_MSK
#define     MAX40080_CFG_RANGE_50MV	0
#define     MAX40080_CFG_RANGE_10MV     1

> ...
