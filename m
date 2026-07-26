Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040522D4C3;
	Sun, 26 Jul 2026 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092869; cv=none; b=NvaZyy4bNw8Di8HpOkg9BdkzqJcEUhpTiZpqV7acUN6+877In+nUEd9wH1SbZu3ZhBfiBHV1Wfzcq/NEgOcMqEwflAXgRYT0LYty76uNSpX/XsIbeqTG1qNjy0/gKv5iy3j3Dw9Ph4r068JBv3lnnjfb95IcfkD+y870cIgqu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092869; c=relaxed/simple;
	bh=oON23xFbkNyAMPDbMMaRT7hyMrRP2v+DFa+P6gGpUkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je5Kgq8kfhHfIw1gZFaxI4RsFeXS2gzAc8XQ01Jk4s0aACjg1IvQmHNLf4s5IGObwjz7grDUUE4WtWCcdzEZTOK3j4zha1P5SKPa+5h0SsaLNhaXnZNHAEK0REAeT6Y13JzTct8jCYLMPJkWW0D9kdbPPhJVdssvc7aisr9XwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCCQ1e9w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCCQ1e9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79E81F000E9;
	Sun, 26 Jul 2026 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092867;
	bh=z/3gNw8jDqRmIukYRJCsBdb/MizwSld3mpvYQm6OfpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PCCQ1e9ww71wisnb5pRqpeqPQofLn8NUTdg63z2aHPnytvpb1Q6RHAJi1ArY+cNBv
	 q/wMvLzgUA3OyHhscYLiWw1OrYAOsKeazhzYWBo8y0calsujmb7V6r8KhqI8WvJwCL
	 fSVSFPpGVO6gKlW/cPXmOQbofEej6gU2zrltMdtr1qmu9G6W/ge+j3x2XWBBLYIwR5
	 oxHadGswkMPaLXNPEnrUNihU/fna/XqR9dKrsvz8lD4f4vWXIffph5JhH/OGVeaiNv
	 zc+pI4y5CkhyZe6BJ36AKl+CuegIiLgp5fCv50/ZkAM2u/lPioMDZP0kdNip8x+8ym
	 c/7uBUkfNDExw==
Date: Sun, 26 Jul 2026 20:07:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/5] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260726200738.0410749e@jic23-huawei>
In-Reply-To: <amN5Sw-EsciZCF1V@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1784835663.git.marcelo.schmitt@analog.com>
	<1c12e37f273d4f99916768e1a9b44dbae30f9d0c.1784835663.git.marcelo.schmitt@analog.com>
	<20260723200452.082871F00A3D@smtp.kernel.org>
	<amN5Sw-EsciZCF1V@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 11:40:11 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 07/23, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The IIO scale factor exported for the LTC2338-18 is incorrect due to an unaccounted internal resistor divider (missing 2.5x multiplier).
> > --
> > 
> > --- Patch [2]: [PATCH v8 2/5] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs ---
> > commit 79bd7cc98e49057401d7fb8d26685b9092c4787e
> > Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > 
> > iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
> > 
> > Support for LTC2378-20 and similar analog-to-digital converters.
> >   
> > > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > > new file mode 100644
> > > index 0000000000000..107388f870626
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ltc2378.c  
> > [ ... ]  
> > > +static const struct ltc2378_chip_info ltc2338_18_chip_info = {
> > > +	.name = "ltc2338-18",
> > > +	.internal_ref_uV = 2048000,
> > > +	.chan = LTC2378_DIFF_CHANNEL(18),
> > > +};  
> > 
> > [Severity: Medium]
> > Does this chip info need a field to indicate the scale multiplier?
> > 
> > The LTC2338-18 has an internal resistor divider which acts as a 2.5x multiplier,
> > but this struct doesn't currently contain a way to specify it.  
> 
> I guess it makes sense. Might split support for this specific part into a
> separate patch to avoid it holding on the rest of the series in v9.

Works for me. 

J
> 

