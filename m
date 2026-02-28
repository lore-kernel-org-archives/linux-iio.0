Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D555246783;
	Sat, 28 Feb 2026 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772284948; cv=none; b=Jk25K2fk6LSyjlo8fBarI+eVhWWC44FgDb+maKVhc1wjp+TAs/Q6haqimnH6NKQ6DaAfIV7lcXiRE+2OEyYppVnTf68LwxFaON9dfSby/pcHo7rS1QnEfoubdxkpIQYGFWhVtPkYlXgPWA9C1UuQ0jov/7S9gQpf4Q6YzSjNG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772284948; c=relaxed/simple;
	bh=YKpixnDDab2E7ZmdPdTMzn2mGQ/IvrkXrx+1KTwplio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9ag6zcAAvXEh4fzujS/GDapNjcC7EQOCBgCSXmL0hQoELcS2JMxgUjnPT6h3dIZcA+7ZE9IQ7PEyccChe3z+BjJ3IyXhGVJrB2EvaIiU9FUnFAmFeGuk//WqUYbNS4zocVV0BqMTzRPo43u70Pgamba/GEASMAKSlO68i3ZQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5HwzcSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5HwzcSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99971C116D0;
	Sat, 28 Feb 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772284948;
	bh=YKpixnDDab2E7ZmdPdTMzn2mGQ/IvrkXrx+1KTwplio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g5HwzcSRWZAAmCtYqVVnpVWs1Fg53pjuwqzokOl+dxnY6Ho37u4olrkCcxPvFMGDg
	 pjLImyG9L0E2p1HMR7Rs+oMetQLuYBAKyK5uSxXqNRW9mRcoMbuFH7Thk0JYX0wruN
	 KZW0r5uZb+kPM6hRGcgE7NWVL4by0WuNY9ZhHr5hCZKkWimbG4tYgBS12ysBSv70WF
	 qq+IogZFU7adPDdrGYgRTcoBS8zQmOtDDTRDw/nh5A5C2BQGVgR8vBC0ZlKaOy6As5
	 rJGzEihjG6rm3sgZq+ubjHN/GGWMFjILp8eyIAvxwrVJlkofIZoQ+GhnyRlREAY9n+
	 mxn39WiHr7nfg==
Date: Sat, 28 Feb 2026 13:22:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: abp2030pa: Remove IRQF_ONESHOT from
 devm_request_irq()
Message-ID: <20260228132219.41f637ce@jic23-huawei>
In-Reply-To: <aaLqsGEwNTlRmNJ4@sunspire.home.arpa>
References: <20260227-abp-v2-1-a482c02a5876@gmail.com>
	<20260228114823.1411901d@jic23-huawei>
	<aaLqsGEwNTlRmNJ4@sunspire.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 15:16:32 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> hello!
> 
> On Sat, Feb 28, 2026 at 11:48:23AM +0000, Jonathan Cameron wrote:
> > On Fri, 27 Feb 2026 21:54:29 +0800
> > Felix Gu <ustc.gu@gmail.com> wrote:
> >   
> > > Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> > > without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> > > in IRQ request and gives a warning if there is no threaded handler.
> > > 
> > > Remove IRQF_ONESHOT from devm_request_irq().
> > > 
> > > Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
> > > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Signed-off-by: Felix Gu <ustc.gu@gmail.com>  
> > 
> > Applied to the fixes-togreg branch of iio.git.  If Petre wants to take
> > another look and perhaps give a tag that would still be welcom.  
> 
> thank you for the patch, Felix.
> took me a hot minute to upgrade everything to 7.0.0, you were both too fast :)
> 
> Tested-by: Petre Rodan <petre.rodan@subdimension.ro>
Thanks Petre!

Added the tag.

Jonathan

> 
> best regards,
> peter
> 
> > 
> > Thanks!
> > 
> > Jonathan
> >   
> > > ---
> > > Changes in v2:
> > > - Fixes Petre's comment.
> > > - Link to v1: https://lore.kernel.org/r/20260227-abp-v1-1-b6fed0545852@gmail.com
> > > ---
> > >  drivers/iio/pressure/abp2030pa.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
> > > index 4ca056a73cef..b44f1bf4c633 100644
> > > --- a/drivers/iio/pressure/abp2030pa.c
> > > +++ b/drivers/iio/pressure/abp2030pa.c
> > > @@ -520,7 +520,7 @@ int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
> > >  	data->p_offset = div_s64(odelta * data->pmin, pdelta) - data->outmin;
> > >  
> > >  	if (data->irq > 0) {
> > > -		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
> > > +		ret = devm_request_irq(dev, irq, abp2_eoc_handler, 0,
> > >  				       dev_name(dev), data);
> > >  		if (ret)
> > >  			return ret;
> > > 
> > > ---
> > > base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
> > > change-id: 20260227-abp-016a007ab817
> > > 
> > > Best regards,  
> >   
> 

