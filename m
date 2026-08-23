Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163293624AE;
	Sun, 23 Aug 2026 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511947; cv=none; b=hwP9/spEnS8eRUoJxztjGi8GdeIqgb0s+rUd/zbKIJKBkC64A7qlcAWTwud19Evi6X1+TYc+yHtjQ/Adf3OK+aOFcKkeZIpvgaKTyWld5A/A3zYtdFioE9bM6auDibtBDWQLHGa/tMvVS3Dkl34mzt6NgoIpnKAoYgcMvH8oVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511947; c=relaxed/simple;
	bh=iHHwv69lyPrcgtUcTe530jbJPZ0ho7MtCggSv4jUivk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRjDISJE6VmSeg3ynFBT5PaptEK+o7IagM0E39rdBOHg4z+QsI4bNUAUx0BV4U5NtQt8NHFflsOCufBrMlDw65qxTKJkLDVvcavnOZlpV/iqX5v4QhCl475222S2v+yE5vcwiptB0OstJdCbrAqGn/moyfxzEYWHmYf9IIAlKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azpediNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azpediNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649151F000E9;
	Sun, 23 Aug 2026 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787511945;
	bh=dTWUPEStHlwKSNO9esWHZyJTWuImLOlcQ8fAb6DmF3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=azpediNyQV9frml3oa+atjqjn/ClnbF0V1WiGtruXYbdihTqnOFJ0wyDsgTW6q64D
	 J8QGuKPFq64cMxL/fUyzSlNR0vpsDmZr0I13J8ZQW0dHVk7i6krZVB9WweF+L0BSUI
	 sc3qsR5VOciFPfMtwCp2v0sB0Y4W39/GQfOuZFs5Q1v7J1Q4FriiBMXckXO3fu75hC
	 dWGabC4kDcp02rexPZ49K94e+96PtwW38yWX84x2bLkoJZKbSbH2J5VCLFtrYdO+Zj
	 wWH74S4RqAZPznhfDzXV+PKUTJRi4qbWWrzJy6Ibrz0knHirfVKtsdS2rFKo5mrMV9
	 HIeADzTSDebNQ==
Date: Sun, 23 Aug 2026 20:05:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 01/14] iio: adc: adi-axi-adc: Initialize state mutex
Message-ID: <20260823200542.446c2dba@jic23-huawei>
In-Reply-To: <20260823195215.5c73a417@jic23-huawei>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
	<20260821-ad7768-driver-v4-1-bb8fbd06d4eb@analog.com>
	<20260823195215.5c73a417@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 19:52:15 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Aug 2026 16:06:54 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
> 
> > The AXI ADC register access paths serialize transactions with st->lock,
> > but probe does not initialize it. Initialize the mutex before registering
> > the backend.
> > 
> > Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > ---  
> Where a patch has already been queued, please add a note here to say so.
> 
> Until the bots get a little more clever about dependencies than I think
> they are today, it makes sense to keep the patches in the series but I
> don't want anyone to waste their time checking again stuff we already have
> headed for upstream!

Sashiko is repeatedly failing to apply this one and given how well it is now
doing at finding bugs that makes me nervous about considering picking this up
without that extra layer of checking.

See if you can work out why it isn't applying. Maybe there is another dependency
it isn't seeing?

Jonathan

> 
> Jonathan
> 
> >  drivers/iio/adc/adi-axi-adc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> > index 26b9c75bd4d8..b5e59b1871b6 100644
> > --- a/drivers/iio/adc/adi-axi-adc.c
> > +++ b/drivers/iio/adc/adi-axi-adc.c
> > @@ -684,6 +684,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
> >  	if (!st)
> >  		return -ENOMEM;
> >  
> > +	ret = devm_mutex_init(dev, &st->lock);
> > +	if (ret)
> > +		return ret;
> > +
> >  	base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(base))
> >  		return PTR_ERR(base);
> >   
> 
> 

