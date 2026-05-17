Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333ED3B9D8C;
	Sun, 17 May 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027931; cv=none; b=DBzA6lVwSW13y0It8Wa+CNPoteHnL4iBuOXH2Get8fgoG0p1UbWEDlm+190QE2nCMHkA+bH1MxbyEcPWBbJlyLHKy9jKMj3lazOxiuU1RfMnz0DQ8lJG6RZvZUMO1sPvRN6DWSkkIQJUGzorPZt30+3Bz8Ww2V5B+t4lk1TmaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027931; c=relaxed/simple;
	bh=zVxoCnkErkQ941CW0Syt2kXqWyhnkFFiBKBaKZS06M4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWjwru4bDG239cWIZx/hZkedGSUJU7dKmI3ODr0Vyeqz6TWV7SQBZfELznSRxrJMp1L6mL0JInfqQJf+7USAvu9wb1n5KOpto2d48ImRiSTLkfDbvwoY4R+0oG2jHST6VsQ4wxpNCNog062Y8BoBw/JxGSxqBciY0AlsgadujlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjJz7UA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjJz7UA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F945C2BCB0;
	Sun, 17 May 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779027929;
	bh=zVxoCnkErkQ941CW0Syt2kXqWyhnkFFiBKBaKZS06M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjJz7UA7qnUpgKw7XmqtPlUL4HjOoNy/rTca13Xck71Jt/tLHTEhhV+RXQFOsv/f2
	 Vbe2ATGkuJeberRHmM92kTdXMwH46gI01Ee6ek/XD0lrMGl134Qc9pdyvEpVg+tvxh
	 I6XPZ5ALGpAu1RHepGQr2HxvCnZFpEtTwDNjT7rZWFm/n6StSKZSuZPruHo8kPRYMj
	 FZmeSVExzkHlXjzjp9Hi79C1Hce3kcdQvQztPnrQrJ3MmSuciMLTtxz3hbJeZPY67N
	 UZZlSPZv5u30PA4OH8QRB0HOdIBKpur6jb/pWii3/j7pwzK1C8cxvlhWaLx0U15UxI
	 BE1WeWxfPhUwA==
Date: Sun, 17 May 2026 15:25:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <20260517152518.2520de8d@jic23-huawei>
In-Reply-To: <twmplpld42lfibgcp722wgiovpe6cb4ojjadcbqtmytil5au3j@fiapntlpaboy>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
	<20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
	<afnt7awu2vRI8JTh@ashevche-desk.local>
	<lnoaqgoxwvnskoklp2ucjivgkbbxezm2gps62553kouhmmgkji@dozbs2qlcckn>
	<afoMb7IJdUrifv-Q@ashevche-desk.local>
	<laxss5h3n7w6ocub46l5ju3lzbqk3dskmthrg52a73yhlgjiyp@2npdo4gce46w>
	<twmplpld42lfibgcp722wgiovpe6cb4ojjadcbqtmytil5au3j@fiapntlpaboy>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 17:31:48 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/05 04:50PM, Rodrigo Alencar wrote:
> > On 26/05/05 06:27PM, Andy Shevchenko wrote:  
> > > On Tue, May 05, 2026 at 03:13:43PM +0100, Rodrigo Alencar wrote:  
> > > > On 26/05/05 04:17PM, Andy Shevchenko wrote:  
> > > > > On Tue, May 05, 2026 at 01:35:10PM +0100, Rodrigo Alencar via B4 Relay wrote:  
> > > 
> > > ...
> > >   
> > > > > > +static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
> > > > > > +				       unsigned int *pd, unsigned int val)
> > > > > > +{
> > > > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > > > +
> > > > > > +	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);  
> > > > > 
> > > > > Just noticed that semantically this is more like _field_modify().
> > > > > Besides that I would consider adding a shifted mask variable or definition
> > > > > 
> > > > > 
> > > > > 	*pd = (*pd & ~AD5686_PD_MSK) | ((val << shift) & AD5686_PD_MSK);  
> > > > 
> > > > We cannot do this as the mask would depend on the shift too. AD5686_PD_MSK is
> > > > being defined with no shift, so that any shift needs to be applied at runtime.  
> > > 
> > > In my proposal I thought of
> > > 
> > > #define AD5686_PD_MSK(shift)	(GENMASK(...) << (shift))
> > >   
> > > > > > +}
> > > > > > +
> > > > > > +static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
> > > > > > +					       unsigned int pd)
> > > > > > +{
> > > > > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > > > > +
> > > > > > +	return (pd >> shift) & AD5686_PD_MSK;  
> > > > > 
> > > > > 	return (pd & AD5686_PD_MSK) >> shift;
> > > > > 
> > > > > accordingly.  
> > > > 
> > > > Same here...  
> > > 
> > > But maybe it's over engineered, and your version is okay... Maybe we can even
> > > switch to
> > > field_get()/field_prep()/u32_replace_bits()/u32_encode_bits()/u32_get_bits()
> > > from bitfield.h.  
> > 
> > That is indeed better, thanks! will adjust...   
> 
> Now I see that the "over engineering" is that field_get()/field_prep() recomputes
> the shift based on the provided mask, which was manually shifted. The u32_*_bits()
> variants seem to rely on constant masks, as I get compile-time errors.

I still have these stalled on the fixes making it up stream (and into an rc)
but in meantime can you confirm that I read this right and plan is leave this
patch as it stands?

Thanks,

Jonathan

>   

