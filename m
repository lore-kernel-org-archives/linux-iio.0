Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CE2D77F5;
	Sun, 12 Apr 2026 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019764; cv=none; b=gJCS7N3jj1J3LdGFDignCn9kXxK+vZZsJFuwK/qtqUAN1ZSkgJF4xmqzv6kimcG1ySGiLmCePAk5DBOnJ2nS31BM38bDNNVoN4bI2KR5s8tdZsIpRLE58nXd0jGUrLtnSF1cmkaWAGKJmLMzAF8Ol+cY5gKoe41Y6XJ5YFXuKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019764; c=relaxed/simple;
	bh=9pt6C1bRI4GN67l5DpzLKauMuL1CGynAlXNdPrtp72M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gm2kJJOiN97ZeUaglRnE1GB0lbPU9YyBqcWyF102RVzA55vJhCK+0g8cIm0gq4bWiUy3aQzn1AZVuSrht5MeuTFUJ9Wz1HBv6YyQ2VHUGt3sxix//L4/xD9AMQyuDPAuJt6juaL80jpkCjhz/vVxFlQhDDhQsUJa90ZpwAIMO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrcpFIsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrcpFIsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE28C19424;
	Sun, 12 Apr 2026 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019764;
	bh=9pt6C1bRI4GN67l5DpzLKauMuL1CGynAlXNdPrtp72M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BrcpFIsVt9EqiEMUhNniaiA69acdLkAtSBzAnxuNvhV/KChqfbkdzM1qjo/QRRO3D
	 0spXAuOO9Wlv3Nota5IQ85TH7FBia8QrW6KIPzZSwWWm29LSnKdj0N3yzXEDkVVbK8
	 l3nwYZFVIq/8MxcJP1kxwhOhVK2G3FnuknwX0fP3aOZq3tcmLt6LZyyOY+ETeRtjtK
	 1IojWfBkzrKRWsX9P4gM6Xgm7AjmCRKAfFSfQ4zdhIptMk3MH3ij855vKRekj2dqCX
	 JDNKfOJUiZwkiQNSCcPS7eKVcM6iiZunvoki6/Xx02jVk9m/NFVRtxWo6qHMlEI0j1
	 h+tVysImuDLoA==
Date: Sun, 12 Apr 2026 19:49:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <error27@gmail.com>, "Md. Mahmudul Hasan Mabud"
 <mdmahmudulhasan1511@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: iio: adc: ad7816: redefine mode
 constants to start from 0
Message-ID: <20260412194913.1ca4eb43@jic23-huawei>
In-Reply-To: <acuqnOdv-ym628fC@ashevche-desk.local>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
	<20260330181710.23258-2-mdmahmudulhasan1511@gmail.com>
	<acunqXdKj7im8tH7@stanley.mountain>
	<acuqnOdv-ym628fC@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 14:06:04 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 31, 2026 at 01:53:29PM +0300, Dan Carpenter wrote:
> > On Tue, Mar 31, 2026 at 12:17:07AM +0600, Md. Mahmudul Hasan Mabud wrote:  
> 
> ...
> 
> > >  /*
> > >   * AD7816 config masks
> > >   */
> > > -#define AD7816_FULL			0x1
> > > -#define AD7816_PD			0x2
> > > +#define AD7816_FULL			0
> > > +#define AD7816_PD			1  
> > 
> > I don't love this.  AD7816_PD used to be related to the spec but now
> > it's just a random number which tricks you into thinking it has
> > meaning but it doesn't.
> > 
> > if (chip->mode == AD7816_PD) { /* operating mode 2 */  
> 
> We can leave that and add a new member to the string array
> 
> 	[_DEFAULT] = "default";
> 
> and associate it with the default choice which seems to be _FULL as per
> kzalloc() in the IIO core.

Hmm. This ABI is pretty bad anyway, good not to introduce more values that
don't actually occur.  Like pretty much all IIO drivers, I'd suggest
this shouldn't ultimately be exposed to userspace at all. This is
what we have runtime PM for which removes the need for userspace to
do anything specific to bring the device out of power down mode.

The only place we allow these is when it's an output channel an
powering down is entering a specific state (typically a pull high
or something like that).

Jonathan

> 
> 

