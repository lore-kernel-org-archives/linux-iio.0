Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E636A344;
	Sun, 26 Jul 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785075080; cv=none; b=k757epdTN6ukmyNqDrLYbjIijd27OPdYx8SVurnC3brWFhSTfDxccCJODPIHnToiuAlMxoFu1Ge6TUBsFRE34WDlynu3KXvvOMKakE0hwNUQUdRpAHahhh7babSz/5n9spyuY8hqXVCsHKtmaChWzpBqrDq6S25Dk8oEHSsuvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785075080; c=relaxed/simple;
	bh=BKTLHX37zLdvtJliPMiILp1Be+MnybF13jhw9Z3xkxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6ZNMpaRG7AccdbOQLK59A+rUCkeUSn0AJ2lX6IUzhyALaCbblrwqs0RJNLaJ+DpATwyGKKktKd7mS45RGlNkO8QLC8rcP3o7+6sIC7CJkGudrX3o8HMurytlADUyE/hxe9SsfPudR8N2XQ1FE4YqORNkNJQU9wkaBFQUwT3Ec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=QS5sk1WS; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="QS5sk1WS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1785075076; x=1785679876; i=lukas.metz@gmx.net;
	bh=d9HlqCg+zTckbEPVYjRxtGc2s5560W2rhShMyc5k/ZI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QS5sk1WSQy8v9YP0Dct7+PQhAj3PxYVVlCk51Q3uN0PJ/J7bYLkaIsItjt+aEMTD
	 znWD+A1tkXIlyXySw3EoLcpRLnyS205uOC1Bp8X9pjwQewZV0F0UO1o+am7chiljt
	 WzgCmAxOEtky289Zxk/TxVgCHRI4O5C0hrmqX4RSmt1T01fJOIVCXAucM3v5zNSOk
	 KHz7tBzZtFqXDrStoZ+L3IAvoj0jvapiO7D5pin6W3QVG5VYD6yNsi1S/l9nQHF/M
	 G8ACCZjocqtdIgZrvidRDQFjfq0MAWnjml4ldscwUJO1FIU6xdM5ARcUGzF14a0tI
	 +QqyrNbYRgNMbxIDew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1xDjPt2bLB-00dmLn; Sun, 26
 Jul 2026 16:11:16 +0200
Date: Sun, 26 Jul 2026 16:10:46 +0200
From: Lukas <lukas.metz@gmx.net>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <amYVZtbxu4fjhBkx@berta-MS-7693>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
 <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
X-Provags-ID: V03:K1:cTsiLtd62MqHUogcRSqBWprkwiOxKjlmQvFhVqhGGkYZrAFLjh4
 A86zRzVDuO7zPVR58ig8o2c3eql8tbRACf9gZiA41CNH8ltDQ2uEM4sBT5VutzwnhlbvS8z
 kNe18CN6t8UgHOEsDYqNZbJMphZgz6jsHbE5q9dgMY6usCR6k+4R6GFTOpxgIiowc9L+vPB
 +SW9n6BHZKncB/KrwmkZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CCCPyHTkZjQ=;JYP3tcFIEdkS7hJ37DfZc1rD0rh
 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

On Wed, Jul 08, 2026 at 09:58:13PM +0600, Siratul Islam wrote:
> > +
> > +	const struct reg_default reg_defaults[] = {
> > +		{
> > +			.reg = CMD_SET(CMD_WRITE_UPDATE, 0),
> > +			.def = info->default_output_reg,
> > +		},
> > +		{
> > +			.reg = CMD_SET(CMD_WRITE_UPDATE, 1),
> > +			.def = info->default_output_reg,
> > +		},
> > +	};
> > +
> > +	const struct regmap_config regmap_config = {
> > +		.reg_bits = 8,
> > +		.val_bits = 16,
> > +
> > +		.max_register = CMD_REF << 3,
> > +		.cache_type = REGCACHE_MAPLE,
> > +
> > +		.volatile_reg = dac8163_reg_false,
> > +
> > +		.reg_defaults = reg_defaults,
> > +		.num_reg_defaults = ARRAY_SIZE(reg_defaults),
> > +	};
> Why are these defined inside probe? Should be defined outside the function.

The default values after reset are different for the compatible devices
(0 for the dacxxx2 devices and mid-scale for the dacxxx3 devices).
So these are runtime dependent. The alternative would be to have two
regmap_configs for the two device types and add these to the chip_info.
Or do you have another suggestion?

Best regards

Lukas
