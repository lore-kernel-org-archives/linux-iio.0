Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C03603D8;
	Fri, 22 May 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462328; cv=none; b=Ygya+ksaQPRGdRa8lu1yT75YS/cDcBl1cnLj+Lcf6zJ1fGfDc6MAakCfaiilUDKokLEHWwcZYufmn3qCgSpSBwbDvysxxXmBowQgsmFs370Mk24KevEdVZkCUjcODXIH1SK5bU32b/ne2FgiwuOB9/scaQ2Gy3bTFPlT6YdJ+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462328; c=relaxed/simple;
	bh=Ybz0geEtcPpUdrhYwHGCiqOijU+0CfH318psp3FIeaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+GMI/NJfVsqswo8RA/jGJueLyZYSeI75+Gus9YG0umRya/1sjH1hYTNdOw4ZUpipvMZsY0D6nOJCaSQbfVDkct/xEP/BaFEtB2rG9i0QbOsvAYLqKOtrtKYOWviZWFldy2cC8IZ0ICQvuL003O7PJvOd8T/BmUntabzdKe0mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNLVjrSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNLVjrSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8511F000E9;
	Fri, 22 May 2026 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462326;
	bh=lH7d0WILS/uMZVZCW7jnVb9ulWfo73WxoGRa8wTNFtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oNLVjrSPo+cvk9uDe2UPWymoR8jhQFisnEgItuGFaJFhnXn2WVytdRL7FpUm26F8x
	 EsLicAGkobS1VJfU0AWwyuGQ8LjCG1hzdXY+HM7Jok3QSyftK0PVbIyGIxBmORqycz
	 8Zm7mOXPzsRUytCceDIxxKMl0CHq/cehRlS9418o+eHIJQvmxqejlVng5y0bmXDRun
	 dMMvW373h0Fz6bUumWi0thnsXhQtMw95B84CZSfymwFxawC5s9W+GlULeOM44ppw7Y
	 6I6E0aJJEGGKP4JbjJfB29TFVfS/LndZei7Th3zbtONz3HKyqCbPJ5y3+Kphi8AxYQ
	 AnAdgGPHNVciQ==
Date: Fri, 22 May 2026 16:05:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Mircea Caprioru
 <mircea.caprioru@analog.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5686: update of_match_table
Message-ID: <20260522160517.766c42f0@jic23-huawei>
In-Reply-To: <ba4tnwmwcqkovyq67ootyqxyqhzk4xd3crohdpv6so7nidjdgb@kgv5zi6aw2nw>
References: <20260520175748.537850-1-grandmaster@al2klimov.de>
	<ba4tnwmwcqkovyq67ootyqxyqhzk4xd3crohdpv6so7nidjdgb@kgv5zi6aw2nw>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 09:18:24 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/20 07:57PM, Alexander A. Klimov wrote:
> > When AD5673R/AD5677R support was added, of_match_table wasn't updated,
> > so these two devices couldn't be probed based on device tree contents
> > until now. I fixed this.
> > 
> > Fixes: 477bd010c20e ("iio: dac: ad5686: Add support for AD5673R/AD5677R")
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > ---
> >  drivers/iio/dac/ad5696-i2c.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> > index d3327bca0e07..fb118a02f76e 100644
> > --- a/drivers/iio/dac/ad5696-i2c.c
> > +++ b/drivers/iio/dac/ad5696-i2c.c
> > @@ -91,7 +91,9 @@ static const struct of_device_id ad5686_of_match[] = {
> >  	{ .compatible = "adi,ad5337r" },
> >  	{ .compatible = "adi,ad5338r" },
> >  	{ .compatible = "adi,ad5671r" },
> > +	{ .compatible = "adi,ad5673r" },
> >  	{ .compatible = "adi,ad5675r" },
> > +	{ .compatible = "adi,ad5677r" },
> >  	{ .compatible = "adi,ad5691r" },
> >  	{ .compatible = "adi,ad5692r" },
> >  	{ .compatible = "adi,ad5693" },
> > -- 
> > 2.54.0
> >   
> 
> I am aware of this, but it is going to conflict with:
> https://lore.kernel.org/linux-iio/20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com/
> 
> This is also to be handled by follow up work:
> https://lore.kernel.org/all/20260422-ad5313r-iio-support-v1-1-ed7dca001d1b@analog.com/
> https://lore.kernel.org/all/20260422-ad5313r-iio-support-v1-9-ed7dca001d1b@analog.com/
> 
> checkpatch would complain about this, once the dt-binding needs to come first.
> 

I'll assume for now the fix will show up as part of Rodrigo's work.

Thanks

Jonathan

