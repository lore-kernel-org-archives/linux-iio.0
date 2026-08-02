Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61A313540;
	Sun,  2 Aug 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695158; cv=none; b=iJtOZogVun36oeg+En8HT5gDwe5MWLRV+yUqQTJUhSJloAVHF7bbbnGaNSErv90f8PRVbuSPdzbytpLuJdVTpUxFfLwJAXvsyrjMrhnm8JiBQ7rZL5phmcZ3+a4DqSZIBB0NEPlEXtXASzQbLtEPNLNnT1XSQVMbavXN36PLsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695158; c=relaxed/simple;
	bh=nI6hYgiZL53MWkJ6lVpWk5WJHEi/CCIiDxFGtTQ/jPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YX/N1Yio2W4PxQvIpXyeXsMZfaD4rQvnkStCzBxgci5gPq7kzFYR3CgZnDBUOiMhKmzpBRzhK65AbOanduYVoCEHNTiwsd1cKht+ce2vfaAa2zpZUwNL8PsvmVGWiHkytP999U70PuzdSjF6cRSfshZ84cuT+wa11LPcgIX3gVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odnu2zPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odnu2zPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A4E1F000E9;
	Sun,  2 Aug 2026 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785695157;
	bh=FvAvKNtFxAQpyl2sYFkjf13f9im8eEYRafZC6/one0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=odnu2zPapITvyfVNiRpW09j/ahlNM6xu+xIk7YcNoEAIqM4au2ycBoccuv4KZ7AIy
	 XNunVn+RVeKeYXrvQxt0pTNPlIXmhvmv00D8Lrt1Do5dwgfEbb1LO2FTMvIiQho8VD
	 Y7bJFhwWRbKlGY5Tdu6YQeqfkTQrFedNBtV0OJG9MdPvcIUgwK/IVRdq2eSXqyVg9o
	 rdoevWxpZjwVpSaCG3oToc8hzgso8vhp+cWuJkG8AZEN4ozqREsEOa9JWe/j6rvupc
	 zzi7W857uCTOeX6Ufh7wZc/dfK2L8Z05JbTxwbVqm7gFPrydtwIL25jFYNyzZbTPOU
	 4R9Q1ZX+y65IQ==
Date: Sun, 2 Aug 2026 19:25:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Cong Nguyen <congnt264@gmail.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ariana Lazar <ariana.lazar@microchip.com>
Subject: Re: [PATCH] iio: adc: pac1921: fix wrong channel used in trigger
 handler read
Message-ID: <20260802192551.76ab4a2b@jic23-huawei>
In-Reply-To: <06f059d0-ac5f-408e-81ed-220f4cb1daf5@baylibre.com>
References: <20260802071246.62046-1-congnt264@gmail.com>
	<06f059d0-ac5f-408e-81ed-220f4cb1daf5@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 10:48:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/2/26 2:12 AM, Cong Nguyen wrote:
> > pac1921_trigger_handler() walks the enabled channels with
> > iio_for_each_active_channel(), which yields the scan index (bit) of each
> > active channel, while ch is a separate counter used to pack the samples
> > contiguously into the scan buffer.
> > 
> > The register to read was looked up with the packing counter instead of
> > the scan index:
> > 
> > 	ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> > 
> > pac1921_channels[] is ordered by scan index, so channels[bit] is the
> > channel that is actually enabled, whereas channels[ch] is merely the
> > ch-th array entry. These coincide only when the enabled channels form a
> > contiguous prefix (e.g. all channels enabled). With a sparse scan mask -
> > for example when only the power channel (scan index 3) is enabled - the
> > handler reads the wrong register (VBUS instead of VPOWER) and pushes it
> > to userspace as the enabled channel's data.
> > 
> > Index the channel array by the scan index (bit) to read the correct
> > register, keeping ch only for contiguous packing into the scan buffer.
> > 
> > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4
> > Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> > ---
> >  drivers/iio/adc/pac1921.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > index bce7185953ec..0037509503ed 100644
> > --- a/drivers/iio/adc/pac1921.c
> > +++ b/drivers/iio/adc/pac1921.c
> > @@ -1037,7 +1037,7 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
> >  	iio_for_each_active_channel(idev, bit) {
> >  		u16 val;
> >  
> > -		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> > +		ret = pac1921_read_res(priv, idev->channels[bit].address, &val);
> >  		if (ret)
> >  			goto done;
> >    
> 
> Looks correct.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

+CC Ariana who is dealing with similar parts and might be able to sanity
check this.

FWIW looks correct to me too.

Jonathan

> 

