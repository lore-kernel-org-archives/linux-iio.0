Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94734CFDE;
	Thu, 20 Aug 2026 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192126; cv=none; b=iD8hlvLQCHXGbW70tF9tCOQx4EtmYGR8aKnOy1l09dr0dju1Ks9zCQXm5fMs74HhhqrnnRgEO7APe+dGIW2OieTxaNrk9bhqSAD2xjpnQeq6U3BN0+GVskkyqsFcegjZL9Z+bTPXzlLynFInxF13HkqG9jUY7BPkESZBa2LxmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192126; c=relaxed/simple;
	bh=P1xR/muZAxRaFXLU7srT2I5kqMpTG2w+UtUe67zkTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UujCa3XAbdipbTEm14mFphkugFmPEpODxIHdxA0yzUCkQgHvAYa3oPOCJj0zt+NdPkI3Zbsn4KnN5O/8l+d2XmPAH9XrYg1pHw240oWaZD0BqLidY5rbHFaTNZkYh4baDARrV0QtRJNaMVQIiwR43P6alwF4Q2E+25mjnEzGzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN88mdBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN88mdBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1016F1F000E9;
	Thu, 20 Aug 2026 02:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787192124;
	bh=0O/c3Fg5txuzPlqv7C06Oc4LP6ynYWkny3HaNdKiXXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LN88mdBpxOG4VnkwYnTdzMZeLGUMredYgOwftB5dCv98HLsFfGE+10GpJBY5ghJfv
	 Ezg9GlHisPUo7C0p6CGKxqbWIgllDPfR3i+P3Nqi/wczKyv70+n2GS/2oMts2IaKhS
	 SiRqII1Ns/rrSnO+hWcVm5iLMsuog+L81PgGFhTyZR6j2zr8vaB6UIOmrJLufzjrGc
	 IWR8fyDClKQgZqoDWXyX/H+FrH6GhXcEaSj/GaILy8S/X9inMxSmCFkqufXbpPkau6
	 4ncbcw769+xfxPFVmF2LlYRPgKyV9D0Sv2eDtuPRoLlEFP7uDvjuzWlBXgc0C+YQb3
	 bKjGaf6w0l35Q==
Date: Thu, 20 Aug 2026 03:15:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Gabriel Rondon
 <grondon@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: accel: kionix-kx022a: unify staging buffer
 and convert to iio_push_to_buffers_with_ts()
Message-ID: <20260820031519.56bc8d09@jic23-huawei>
In-Reply-To: <aoVY1NpKxKskuUC1@ashevche-desk.local>
References: <20260818215122.52715-1-grondon@gmail.com>
	<20260819010900.7728cff8@jic23-huawei>
	<a23c2959-5c05-4018-9ac8-7c87e563d1c8@gmail.com>
	<aoVY1NpKxKskuUC1@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 10:18:44 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 19, 2026 at 08:15:40AM +0300, Matti Vaittinen wrote:
> > On 19/08/2026 03:09, Jonathan Cameron wrote:  
> > > On Tue, 18 Aug 2026 22:51:20 +0100
> > > Gabriel Rondon <grondon@gmail.com> wrote:
> > >   
> > > > v1 was a single patch converting the two push sites to
> > > > iio_push_to_buffers_with_ts(). Reviewing it, Jonathan pointed out that
> > > > the driver carries two separate staging areas holding the same thing
> > > > (buffer[8] and the scan struct), and asked to fold the cleanup into this
> > > > set.
> > > > 
> > > > So v2 is a two-patch series: patch 1 drops the redundant buffer and
> > > > routes the one-shot read and the triggered handler through scan, and
> > > > patch 2 does the deprecated-API conversion, now with a single buffer to
> > > > push at both sites.
> > > > 
> > > > Changes in v2:
> > > > - New patch 1: drop buffer[8], use scan for the one-shot read and the
> > > >    triggered handler, move IIO_DMA_MINALIGN onto scan (Jonathan)
> > > > - Patch 2 now pushes data->scan at both sites instead of data->buffer
> > > >   
> > > Nice.  All looks good to me, so I'll queue it up.
> > > 
> > > Applied to the testing branch of iio.git which will be rebased on rc1 once
> > > available.
> > > 
> > > Note that there is plenty of time for additional feedback, tags or indeed
> > > me to drop it again if someone spots something I missed.  
> > 
> > Ah, Jonathan was quick and efficient :)

Hmm. Worried about too many thing floating around is more accurate.

> > I'll drop my comments to 'nits' in order to not generate more work for  
> 
> And I, in the opposite, insist on mine against patch 1 as I consider that that
> makes code easier to read and follow.
True enough - so tweaked

Jonathan

> 
> > Jonathan. Hence, acting on my comments is not required.  
> 

