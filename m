Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49F2512C8;
	Mon,  7 Sep 2026 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819288; cv=none; b=da2whEqzEu59gzjo2qVhbcsc2LOacZqoGODMJ19HULATX0RUnPvIJ0bzs76v4gEvzvy/3x7K+Ff0oGwQ2z8LohSHQd6TxBSS0DVj1rjJrFHygSc//ynidCzcmlHeR/mtQHi1lZcFq3aC4ILufH51OolHKKQ5PF5WAdy1T2EAxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819288; c=relaxed/simple;
	bh=tHA8DvT+ZGAoZ+88//8DktoapK98E0GNZ/0yTO5Hbtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAIqTCnpA3aHtOGWmD5C25rE5qzfOkMouVAUDU/H5rI752aalaFyf87YPAgtc/S3z7jFNuFXNm8lKG8CCVlRrWe+a6/ccpPkp0SN3R4oh5lR6g9xBCL4YWyJKQNjTG4vJUd0/55D01Lz/mQmdkW69Zmn68yzWa218blQJPvYxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBGMCLZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBGMCLZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D9D1F00A3A;
	Mon,  7 Sep 2026 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788819287;
	bh=lWgXCcsB9CqG+/eI2m8zz0LJWHEJ6/DG+py2Q4e8IE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nBGMCLZMn3JaCVqXK4ZBLAPY24CcGO6T1Vq7Ey8t24Cyec3ru3VSaVd8eIXC7iFhG
	 2+RBB61bKEj/UNSkEoHDSbMQWvni3En8lsn84w3dshY4vuERLGG3M/qnSvILz7wq2d
	 oEqXDblMLqvi/LAuqZglrwKJo5Qas8HFRvOqRyJiFzqZlW673kKaQpWVEdI9+9Y8vD
	 kHX4V9Ij3CMAjg80lX7Z+LBONDjN80jw2sjZmoWFbFCi1f8v1+R/nFqr2yWoGectAK
	 Pk8PrhVkVOnCGd9k1TVzk4ui475gdjaih+r7DvBOay2BN15EuSDCQ1ZeCgyKX18Vtx
	 i2LgNdmFess5w==
Date: Mon, 7 Sep 2026 23:14:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Laight <david.laight.linux@gmail.com>, linux-iio@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>, Borislav Betkov <bp@alien8.de>, Ingo
 Molnar <mingo@redhat.com>, Thomas Gleinxer <tglx@linutronix.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260907231444.7fa2d116@jic23-huawei>
In-Reply-To: <20260901175101.1e059ac8@jic23-huawei>
References: <20260803094702.3852-1-david.laight.linux@gmail.com>
	<11o7545n-7569-3p9r-1q77-8nor8513r6n1@syhkavp.arg>
	<20260803163955.627bdd3f@pumpkin>
	<20260823233536.30b984ed@jic23-huawei>
	<20260901175101.1e059ac8@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 17:51:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 23 Aug 2026 23:35:36 +0100
> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
> 
> > On Mon, 3 Aug 2026 16:39:55 +0100
> > David Laight <david.laight.linux@gmail.com> wrote:
> >   
> > > On Mon, 3 Aug 2026 10:49:40 -0400 (EDT)
> > > Nicolas Pitre <nico@fluxnic.net> wrote:
> > >     
> > > > On Mon, 3 Aug 2026, David Laight wrote:
> > > >       
> > > > > The x86 instruction set only supports 32bit signed immediate values
> > > > > for add/sub.
> > > > > Replace the "ir" constraint with "er" to avoid build errors.
> > > > > 
> > > > > Found by a patch that added used mul_u64_add_u64_div_u64() to
> > > > > do a rounding divide by 2^32 (perhaps not the best way to do this).
> > > > > 
> > > > > A quick grep only found one other affected file.        
> > > > 
> > > > Would be a good idea adding those cases to the test module.      
> > > 
> > > They fail to compile so it isn't a big deal.
> > >     
> > David, thanks for sorting this (and all for reviewing)
> > 
> > Seems like everyone is happy.  What route is this taking upstream?
> > 
> > I held Rodrigo's driver to avoid the build breakage and would like to
> > get it queued up early in next cycle.  So not that urgent but nice
> > to be able to tick it off the list!
> >   
> 
> Given I have a driver queued up behind this, shall I just take it through
> the drivers/iio tree?
> 
> I can do an immutable branch just in case anyone else needs it this cycle.
> 

I went ahead and picked these up on
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git ib-iio-x86-asm-fix-7.3
and merged that into the main IIO branch. I want to give plenty of time in next
for the driver that was relying on them.

Currently this is all in my testing branch but I'll push that out as a non rebasing
(ideally) branch a bit later in the week.

Thanks

Jonathan

> Jonathan
> 
> 
> > Thanks,
> > 
> > Jonathan
> >   
> > > 	David
> > >     
> > > > 
> > > > 
> > > > Nicolas      
> > >     
> >   
> 
> 

