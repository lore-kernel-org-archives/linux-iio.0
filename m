Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE83331EB9;
	Thu,  2 Jul 2026 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011710; cv=none; b=Vgi70pX8udrZn4xMk+bfVOBQpS8RpNHGAaPLhaMpsyucdqpppVnCPtIcwrQdqQv4dhXw4kxpgn+IbS0zbK9/vtDfjyfGnzsQ6rYMV0H+xPyVg1gbw3Dlda/LS9cPfDGGRjIdNKEPb1PdpR+ZLNGkoWld1BFob43AJelVuoTrTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011710; c=relaxed/simple;
	bh=hNEaxQM0qBKGCOXBqKFkjNU7fmzvZ26mqbFlgFmhlos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDE8pujAofrcgJ1eJepd5Enq1Uc0ty7GXonhxUN6kpGlr2kDmXgo/8jCSgQ0FabqykN6VjY4i9hyBLqlZ4OmN8Z0XaABUfySTeF5Vc5ESRYfaGugSq8I2REvZuWnNYRkFq5PAeAncKiN6rcnYyK6mnaie362R8xZjnXxI2lcCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7Qd/qNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7Qd/qNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263E61F000E9;
	Thu,  2 Jul 2026 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011709;
	bh=mE4XublvrmrIB5dB0Z00fIDiH2TH/g5SvFOg45UUWQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j7Qd/qNu2SDZ2W/52PKXt2h7uRkJZSVTjklJY+xq7vsbKfPC2X0580JqYjYsUq/Rw
	 eaRvKzd/RcZjyIAGAvyYx+Hd5lxFWbL9qRHrqf0f7T1Dq6HlXoZZh1McWgSfB8DtUM
	 h0+KetmGkbiTrI3xWUJigf+vuGlCWW6upYT3QSyeyRQCyl8eTL6q39ZvDtBrOtc4aj
	 hb9LrWLMfFY93a75HXVlouEwWh9+3tdo4oVXG9NJJCyhge+MAx2AJj1NcQQ+V8xnm7
	 vMWa0dZCCf76JRNZ/Z6c/7LeTE08YcTFakViu+SvGKcWMYVcO2jdJjojLsJUxffcmr
	 IF7KZRvSViyPQ==
Date: Thu, 2 Jul 2026 18:01:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH v3 2/2] iio: adc: ad7779: Remove redundant
 dev_err_probe() after devm_request_irq()
Message-ID: <20260702180145.2929a03d@jic23-huawei>
In-Reply-To: <20260702135454.0000064b@gmail.com>
References: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
	<20260702114649.9758-3-mokshpanicker.7@gmail.com>
	<20260702135454.0000064b@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 13:54:54 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu,  2 Jul 2026 11:46:49 +0000
> Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> 
> > devm_request_irq() already prints an error message on failure via the
> > IRQ core, so wrapping its return value in dev_err_probe() results in a
> > duplicate error message. Return the error directly instead.
> > 
> > Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> > ---
> >  drivers/iio/adc/ad7779.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> > index c1a99b4c1256..a5b8bfa99a74 100644
> > --- a/drivers/iio/adc/ad7779.c
> > +++ b/drivers/iio/adc/ad7779.c
> > @@ -842,8 +842,7 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
> >  			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
> >  			       st->trig);
> >  	if (ret)
> > -		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> > -				     st->spi->irq);
> > +		return ret;
> >  
> >  	ret = devm_iio_trigger_register(dev, st->trig);
> >  	if (ret)  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Applied.

