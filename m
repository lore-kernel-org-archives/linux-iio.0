Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92D363C53;
	Wed, 23 Sep 2026 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128533; cv=none; b=HwZrarpjtPF3yQbtAP+0pls8TcwXjooQZmMZZuQHGcfF97B3h4WUNAodsgWyuY6xWtsi6RKtGBqq7PvWPpIa1mpY5QFD0uze2viPSkYT51ttBn1E0ieXuF945xAORZCKZHus1NPNcoLbD0XiXKlDQBAfhvxoC4uRQf/KkElz9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128533; c=relaxed/simple;
	bh=0iCFEQlm1p8Fr5jcnQVVzaPOt23XyT2joxzszaHHzOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrBYWDA1kAQeD54OfQO0Yfw2UPo66Lw3Y65xnYiyMeq919l65bHYUSG9yTCYryIJJHJotJ68X2M/LKa+ETF4MVF9fKbAvmy3fnU25qS6JKuQkJUnBHOwZLRJXd8lz7+MI4NGU++J9dU8TK8e7Z5/jfdX+nlJLKxkLUfsuG+Nlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d10FBC8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d10FBC8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07411F000FF;
	Wed, 23 Sep 2026 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128532;
	bh=X+dyIOnJDxtCFBSI269Uh2sL2tF0Fhcw4ura3+Ar5q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d10FBC8JthFkSm3LXDMRoCpjw96umUoAMYYErFFBLSJL7E3jKlvFC0h6b5GJNMF4O
	 NJx3ExCevp48xoOTACLsO+Zyk+xoPbY7b040RB3Sv4dgKeJcJNvj8+hNqyPkSjvD2Z
	 ar7Wc8rIHt0YpXGhmHK5YMQX0dqPFqMXOAz5xolcnkzCsoVC8JsIVMZcN5ZdswDiTE
	 Q1sSKKyHepASa7KV9NreTCyDv17S6jFSeTCDdm1z9BIBV15t4enQyVsI7IraO+FfTh
	 jtd6FAP1xtmEHYVe+hZ4wTR8SzUNr2prLZhQF4PpH8hY6BKL9zURfCrUFeiixz9046
	 BCO283Zfna5oQ==
Date: Wed, 23 Sep 2026 02:55:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 04/17] iio: add IIO_FREQUENCY channel type
Message-ID: <20260923025522.49b10c08@jic23-hlaptop>
In-Reply-To: <bukynp5qvtqf5jgqnxzxesvt5vimm3i3lvqrwmffc7fecjnabx@rqyeho7v5cnn>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260729-ad9910-iio-driver-v10-4-aa1f6167729e@analog.com>
	<xevuqaudwm4hpnhbful263yx6r45liuch6yc7xjk2i7wly3oxo@xe2htu27rkl7>
	<bukynp5qvtqf5jgqnxzxesvt5vimm3i3lvqrwmffc7fecjnabx@rqyeho7v5cnn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:07:45 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 22/09/26 16:56, Rodrigo Alencar wrote:
> > esOn 29/07/26 09:25, Rodrigo Alencar via B4 Relay wrote:  
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add IIO_FREQUENCY channel type to support Direct Digital Synthesizer (DDS)
> > > devices that handles frequency values written directly to its buffered
> > > interface.  
> > 
> > ...
> >   
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  drivers/iio/industrialio-core.c | 1 +
> > >  include/uapi/linux/iio/types.h  | 1 +
> > >  tools/iio/iio_event_monitor.c   | 2 ++
> > >  3 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index bdf3d4c06331..a45277bc5d99 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -99,6 +99,7 @@ static const char * const iio_chan_type_name_spec[] = {
> > >  	[IIO_ATTENTION] = "attention",
> > >  	[IIO_ALTCURRENT] = "altcurrent",
> > >  	[IIO_COVERAGE] = "coverage",
> > > +	[IIO_FREQUENCY] = "frequency",  
> > 
> > Hi Jonathan,
> > 
> > Thanks for not giving up on this one! Taking a look at the testing branch,
> > I think this line was dropped during the rebase (addressing a conflict)  
Fixed up. Build test just running. Thanks!
> 
> btw, now that we are at this again, it crossed my mind...
> Is it fine to have a channel named the same way an attribute may be named?
> wonder if userspace tools could get confused.
I don't think so as they should be dealing with the ordering of different things
and we will always have a channel type before a modifier.

Jonathan

>  

