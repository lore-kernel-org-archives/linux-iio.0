Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6E431E53;
	Thu,  2 Jul 2026 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952331; cv=none; b=si0f9i2YsL1i9V76nzg9qBTwMip75JwRT8B9i6+1SlGnhDFpw79CnHNnPArW1e6lHvQrDPIuymNo5YcS4arQNsShMHJ8lFXmuWt0EXQVrPlvJwiTXKnG7DLBQAVDMw6UpC7VUlXJiKE3ZSMwBwTlZKkWSRuSn8FuQVmn+oP0Ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952331; c=relaxed/simple;
	bh=/NLffSrRaCTFhNhXhiOhKLtYBkouRMipNtuNOs5dlgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfXKTwk2N78VwjZECW8Lu7FRKMbmxa05HJCyUwXHUA7qezla14zDXsuR5bOsRHd0csbghnLSzRzXgNJbSUdnjMhFatoI5j1BdP0YKhHn2zJ6xSWyaXCj2kL01BLc6dm0j2NjM2pKDvbLM+YrgMH5NX+UD13+DuFds9Ec8hPU4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpmEXLlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpmEXLlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A201F000E9;
	Thu,  2 Jul 2026 00:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952330;
	bh=iw+z57/78cbfnAiBvQk7R5b0U9mPbeM4OlgkLTJ1GsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cpmEXLlSdvOw4lpM5IJ5sB8nNFYnvnX+D9JK4lJy1xffVduT7Z6oXDszC5NRzpG6S
	 k4Ar+s0Yj1IvvpZCfFROl+Gnz88amFP0dVnBksyBDYWvd/Q2nlS19KjPB4BDVO+Eti
	 p3MtbNbN5cAjLxEA7AbpXW6bknyYNkpTTnCeUYv85Cm0vpaXTzUfe3vAKCwKtfIh6L
	 vYT0lf8hOMcwyQtvCvQbuw/yK/sUmi4jZWHLRO4zi1/YdY97lF7NSXYipW/QBDjOoy
	 kFTHLmCu6hN4roRGkxTXT9eGhSdhWbpPYw4vj+QyMMK7kqIGG52P7cusye8yShh2gI
	 0ygqTQEPzdtFw==
Date: Thu, 2 Jul 2026 01:32:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukas <lukas.metz@gmx.net>, Siratul Islam <siratul.islam@linux.dev>,
 andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <20260702013203.46778542@jic23-huawei>
In-Reply-To: <c64ed5e8-90b2-4898-b218-b1e41382765d@baylibre.com>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
	<20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
	<36ffe80feb5a521c28b1a6d10bf1338dc39ddef1.camel@linux.dev>
	<ajuVjk-lw-DqUVnl@berta-MS-7693>
	<c64ed5e8-90b2-4898-b218-b1e41382765d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 09:18:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/24/26 3:30 AM, Lukas wrote:
> > Thanks for the review. As i said this is my first time submitting a
> > patch. I have looked at already existing spi dac drivers for reference
> > but i seemed to have missed quite a lot. But the comments are greatly
> > appreciated.
> > 
> > On Wed, Jun 24, 2026 at 12:56:15AM +0600, Siratul Islam wrote:  
> >> A link to the datasheet here would be nice.  
> > 
> > I will try to add all the small suggestions i dont mention explicitly,
> > like style issues or using guard instead of manual lock/unlock to v2.
> >   
> >>> +
> >>> +	if (st->internal_ref) {
> >>> +		st->vref_uv = 2500000; /* 2.5V internal reference */  
> >> A note on where this value came from or why this was chosen, or a reference to datasheet would be better.  
> > 
> > I think i would add the suggestion from David Lechner to remove the
> > internal_ref property completly and add "the way of doing optional
> > voltage references". This includes using the macro
> > DAC8163_INTERNAL_REF_mV. Would this be acceptable?
> >   
> >> You have a CMD_SOFT_RST defined but not used. Should this be used to reset before doing any configuration?  
> > 
> > Yes this is a command which isnt used at this point. But maybe it makes
> > sense to reset the DAC first when probing.  
> 
> In general we tend to reset IIO devices during probe. DACs can be an exception
> though since they are output devices and resetting it could change the output.
> This device is quite simple anyway, so reset probably isn't needed.

If this one is write only (based on another comment - I haven't read the code
yet), then I think we might need to reset anyway so that we can bring state
in sync and allow readback of the current channel values.

> 
> > 
> > Best regards
> > Lukas  
> 

