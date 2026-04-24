Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D33BF66C
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031119; cv=none; b=DXGRBM5FKboQx+eQOpQTXpQ5aJCkS7hNdCQO7/wkEY/JlQ8JFeZjLhlKRvc59WY0wcZNcb8PQ0zYrotYUlTbil3zuyChMzVhw++U22KFRtgrSu0Nl4INwJkBitH78l5J/AtfVVsuFN58wkGrqfVkr14CEEyyB3kHKOvLhSMaKfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031119; c=relaxed/simple;
	bh=tTHaPHWqgVisxc2523ejIl2WZCl5K1U/EZsNjq0tOjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsAWtQMG+b/QHexngLxSgtCtLLBpgDPYg2vVFITmoaUhdpNq7cVc+dEayCq+JleTrmtaY+KnVbcCshQ5yT0tQHfPimxB6dcEqmpubpGYGUFdNoFxAdXWqrBF0SyzZbV+AqBQou1grRjcHaCEQzdjxsor2nYX2KYpna9I6lEnDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/LFEQy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/LFEQy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3348FC19425;
	Fri, 24 Apr 2026 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777031118;
	bh=tTHaPHWqgVisxc2523ejIl2WZCl5K1U/EZsNjq0tOjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/LFEQy8LB2rU7IRzZ1enzp5PDBB5UXrgWJioo8AdFoFQ7xmt27Xw+yCf0CsuBG8W
	 u1HyZNsRg5Sf4UBQJdw92WYcKFtqjnUM4EWHITLAdsc5Ld9cKOTet3N82Yc6Qn8Ayj
	 YRa55L44lgzDOUTXecMAjZsGoKVJQzuU1R/X/R2RHPRtCa1tpEgVDLRrIk6c+HJo9L
	 C0qyfq5ywwd+W0z/cQsB0T+cnnnbTGG+RbrEa/Epu4ag4v16hxZM83QxF4DPksUeqt
	 a2XVBwSKs6LTzG74JIhuz2PWD8NkdUxnsYpZOLh31bxq/H6uLhWwPAYgntRvKJSc1S
	 ku/mzdLYAq5XQ==
Date: Fri, 24 Apr 2026 12:45:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, Eduardo Augusto
 <eduardoaugustoabc@ime.usp.br>, Christian Barry
 <christian.barry@ime.usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: mcp320x: refactor driver to use
 bitfield API
Message-ID: <20260424124510.5e4f3cee@jic23-huawei>
In-Reply-To: <aeskXSpBCIvWghPu@ashevche-desk.local>
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
	<20260422222553.67660-3-gustavo.pagnotta@ime.usp.br>
	<aeskXSpBCIvWghPu@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 11:05:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 22, 2026 at 07:14:13PM -0300, Gustavo Pagnotta Faria wrote:
> > Update the mcp320x driver to use the standard Linux
> > bitfield API (<linux/bitfield.h>) instead of manual
> > bitwise shifts and masks.  
> 
> > This replaces the hardcoded shift operations in the TX
> > data preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
> > and replaces the manual masking in the RX data extraction
> > (mcp320x_adc_conversion) with FIELD_GET(). Explicit masks using
> > GENMASK() and BIT() were also introduced for both transmit
> > configurations and receive extractions.  
> 
> I believe somebody told to you (or to the similar patch *) that this paragraph
> is an unneeded detail.
> 
> *) I'm already too much lost in the flood of the patches to IIO this spring...
> I dunno what's going on, but from last few days when seeing something that does
> ring a bell, I suggest contributors to start actually reviewing others' patches
> in the mailing list for this (IIO) subsystem and read other reviews to learn
> from them. It will save a lot of time for everybody.

Lol. I just replied to patch 1 with the same message. I should have read on.

> 
> ...
> 
> > +	case mcp3301: {
> > +		u16 rx_val = get_unaligned_be16(adc->rx_buf);  
> 
> This is used in all cases (or almost all), can you make this assignment and
> conversion be done outside switch-case?

I asked for it to be moved in as it is invalid in a couple of cases and
I don't like having variables taking nonsensical values even if they
are then not used.

> 
> > +		u16 raw = FIELD_GET(MCP3301_DATA_MASK, rx_val);
> > +
> > +		*val = sign_extend32(raw, 12);

Can make it less painful though by doing the FIELD_GET inline or maybe
even using the proposed FIELD_GET_SIGNED().

https://lore.kernel.org/all/20260417173621.368914-1-ynorov@nvidia.com/

I guess we can't assume that will land that soon (though please keep
an eye out for it doing so) hence in meantime.

		*val = sign_extend32(FIELD_GET(MCGP3301_DATA_MASK, rx_val), 12);

Thanks,

Jonathan


		
> >  		return 0;
> > +		}  
> 

