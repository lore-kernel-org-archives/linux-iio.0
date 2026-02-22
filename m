Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBC3570DF;
	Sun, 22 Feb 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771779542; cv=none; b=nDa5gRO50+A0KarCYcpCM/Uxsz6AE2QD18RXU06OWCyJTrGJulpo1BlRNSUNKdBAICVWYJxVCgd4ovczrlgjC80bT8QH87cudZ7KmzN+FC3EhFsM+tnQditlra5c63DrMWb7R1gsViYU9WSuowU2So0JlG4Izoid6WUdF8jb1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771779542; c=relaxed/simple;
	bh=jO9gMaExfKnPbkIm00Luu0xtdN4Lyyx4xGjd6UuaKjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEo8+UEZKAe7kfUAZ61hmEiu/dN85fTg5DcPxZLApByxkHX+fd8nK1iocvIgMKR7Owu+ihpYx2IBodHrPDQbYoK3Aze/ip3aR+5argqdW/vDbNXbjtsnu2mvrZIy+Ftg7wHBqdR0KEzIrfbc6akrYmBJm/mGWgXDNzyLc3gzEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWWFIvOk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWWFIvOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E2EC116D0;
	Sun, 22 Feb 2026 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771779541;
	bh=jO9gMaExfKnPbkIm00Luu0xtdN4Lyyx4xGjd6UuaKjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWWFIvOkJfX02PpZKahoTdewjto8Uy56mRSOx5zGoCqi/hq/q9lt4v594gMUzN/S/
	 8fWS5DlZXOAiq0iqKSMeIKpMJMFZgcUfNr9YU1kS1fqBitrSgC82JtzT+JB4ea3NCY
	 Jan8H9hjeT1VlY4yoQ8T3sfNIMHN83N1tkXslpQ1ac7XfMTqFnwa2SFa/o5M7vTYva
	 RwfHNGTj5sntyFHDt9BEJWpzZaOIaQgSwt+FExXM430TC7Vl012qzcVHSn8fnT2B/F
	 vXuoGyGq7o9TQAfQsjiRszDsoK+crUmntHiiGOSV1zJABjK514XK8/3/CDdhdrL/x6
	 UzkvxrCpiUzoA==
Date: Sun, 22 Feb 2026 16:58:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in
 probe path
Message-ID: <20260222165854.63ab359f@jic23-huawei>
In-Reply-To: <aZhoJlYUzuHXSGXL@smile.fi.intel.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
	<20260220131151.74329-2-antoniu.miclaus@analog.com>
	<aZhoJlYUzuHXSGXL@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 15:56:54 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 20, 2026 at 03:11:39PM +0200, Antoniu Miclaus wrote:
> > Replace dev_err() + return with dev_err_probe() in adrf6780_reset()
> > and adrf6780_init(), which are called during probe. This simplifies
> > error handling.  
> 
> ...
> 
> >  	ret = __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
> >  					 ADRF6780_SOFT_RESET_MSK,
> >  					 FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
> > -	if (ret) {
> > -		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(&spi->dev, ret,
> > +				     "ADRF6780 SPI software reset failed.\n");  
> 
> Consider adding
> 
> 	struct device *dev = &spi->dev;

spi itself isn't used so
	struct device *dev = &st->spi->dev;

probably make sense here

Might be worth similar changes for probe() etc where there is a lot of &spi->dev
in use. At that point it would probably need to be a separate precursor patch to this one.

Thanks,

Jonathan


> 
> at the top, so this line becomes
> 
> 		return dev_err_probe(dev, ret, "ADRF6780 SPI software reset failed.\n");
> 
> (while at it, I would dare to drop 'SPI' from the message as is easy to derive that
>  the device in question is connected to SPI bus.)
> 
> 		return dev_err_probe(dev, ret, "ADRF6780 software reset failed.\n");
> 
> ...
> 
> Ditto for the rest.
> 

