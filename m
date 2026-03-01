Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139752D7812;
	Sun,  1 Mar 2026 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772366566; cv=none; b=vC9e0dla2n6dDiVt4nUnH7n9nToCJZ4Jw4edXXJYyPss3vTYNOLk1xBziFnv2kDs+UAUEoZR0NmW6QkHu4PBj4ZZaWyIxT3bkRoGUW2MT8/vvJATtJNxIdyoOfCyT06S86lBEGRNYC+44ZukuhbPfr8HuSzGKRFzVGLqHT9yoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772366566; c=relaxed/simple;
	bh=l8JZQLGPRkr0PNpeaYN8DoU3j9cTIpjRqRUM915yyJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X95zpZ+x8OOMcxPMveJPFa/Mt6kFfStzICqKgQ5lyst6hTtSpRFzAOvhiCb7amPo+g9Kn09xkzfbibg4yeA4dy1LHyBuq9KLw7PyzULKZnjppkeg69/RdnClrElQ+ni6wDJ74T+Sw/Dh9kcUC0DbmfsoWaVOuWfsRRCIV5ymWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWyFQjhx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWyFQjhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C37BC116C6;
	Sun,  1 Mar 2026 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772366565;
	bh=l8JZQLGPRkr0PNpeaYN8DoU3j9cTIpjRqRUM915yyJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWyFQjhxA2llfkxYldApt3N9fDmjLLqM/iJPB4SKSYLKFNjjnbfsk/f1+1lqZ1fIN
	 xskIYSEZGFgSl1ZacFTPtUFfVDEa/rcosjxid9ozBlBIvLYHljti/LUH9EdSt64oF+
	 6Nc6sKfuZafTEaLuQEJFMTw6ZuIpjZ9MIoFzZHVJU00d+w+Y/9reWlEygshOGZQUCX
	 elH/20+R0NJnWqCP7XkZ1AoUF3xUJEIYYYUK3iCM3ZN4K3ND67cdDTH9w5pj7wy0Pl
	 Xg5RXzRNlsaL4vSz/XmSJciTBQWAb20S9bLA/GsJhhmH3eh0q7PfJuIrm1FGwt1tU6
	 rJYZipP7PLuiQ==
Date: Sun, 1 Mar 2026 12:02:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Ramona
 Gradinariu <ramona.gradinariu@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl380: fix FIFO watermark bit 8 always
 written as 0
Message-ID: <20260301120236.385519a2@jic23-huawei>
In-Reply-To: <84fae6b8-d188-4e5c-af06-b342f3d27514@baylibre.com>
References: <20260227124305.55271-1-antoniu.miclaus@analog.com>
	<84fae6b8-d188-4e5c-af06-b342f3d27514@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 10:50:00 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/27/26 6:43 AM, Antoniu Miclaus wrote:
> > FIELD_PREP(BIT(0), fifo_samples & BIT(8)) produces either 0 or 256,
> > and since FIELD_PREP masks to bit 0, 256 & 1 evaluates to 0. Use !!
> > to convert the result to a proper 0-or-1 value.
> > 
> > Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  drivers/iio/accel/adxl380.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> > index 8fab2fdbe147..a51d1d61c412 100644
> > --- a/drivers/iio/accel/adxl380.c
> > +++ b/drivers/iio/accel/adxl380.c
> > @@ -877,7 +877,7 @@ static int adxl380_set_fifo_samples(struct adxl380_state *st)  
> 
> Some relevant context...
> 
> 	u16 fifo_samples = st->watermark * st->fifo_set_size;
> 
> >  	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0_REG,
> >  				 ADXL380_FIFO_SAMPLES_8_MSK,
> >  				 FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK,
> > -					    (fifo_samples & BIT(8))));
> > +					    !!(fifo_samples & BIT(8))));  
> 
> Technically, this works, but in terms of understanding the code I think
> fifo_samples >= BIT(8) would make more sense.
> 
> fifo_samples is a count, not bit flags.
It's an odd bit of code, but then it's unusual hardware too.
To me it is about bit 8 not the value being big enough to have a bit 8 because
if there were yet another register that was for BIT(9) then
 >= BIT(8) would give the wrong value if BIT(9) was set and BIT(8) was not.

We could express this what is going on in a bit more explicit detail maybe?

	FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK,
		   FIELD_GET(BIT(8), fifo_samples));

So there we are extracting the 8th bit and writing to the location for the 8th
bit.
> 
> 
> >  	if (ret)
> >  		return ret;
> >    
> 

