Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18036484237;
	Tue,  1 Sep 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281469; cv=none; b=AqdzDTRESZKRZpYOLcjM3/20dSONJRD9/jjSP0zjkDQrT1V3Q6NH7iOHuWTJLfjPMGieJtic08q3Q6cWOWolbpyp7WYpj8Wg4OLSol2cyI+33Ts1s6z5bW0H0WjlwQQLjwq21jUfWRPBdkwxDUKDoGt60mbmQopf+azVc1V4WY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281469; c=relaxed/simple;
	bh=ZYfD29Zk+rGU8BNK5ReLIGcFqaD6qE9+zuRBzYr1ChU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIX+8cZtgiDov5xzr9RO5a6paf0FradwJit3Xh6kOKFTeX+Y2p7qw67coysRv2wUIG+V1/yB7xM5wqandrDN9Dhr1b9cKqERiDeA3T2RbZ3NlIGOX0EqtnIOuEd+Rs3pyU7JxwSc6ae7GvCOcXzoqM9izIRGvfHnWsTLJoKu3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp0OkLeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp0OkLeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB91F00A3D;
	Tue,  1 Sep 2026 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281467;
	bh=uN08EoqRU5CJKsTaF+4v/3ejQA9w3ui5GBxyAFIzZSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tp0OkLeZwHdH+5jjudMS9vi4N8phTz7KVYHe/jOy5P1qHymzusKqcdilM9Flrl+7E
	 05huOLo9NdA3ocmZKC/Cr2VhO5tmlWhCMXdZ68585Ea16+R6xoklcxuq0UFwlB7f7V
	 kq4WYjW/vQjYzcA1yq0/9oFUH3dnyC+ztWVdmVum+f2Mn+JTIX7IOXn4Dzv60qFBrI
	 yxS6N+OFuOdwwyBKEwcdDM4JJhjZYrEBshCevqcYfyGm75+Bgfi2Z1kkO02I8IceTJ
	 +HSeacH9GH4RZ3tm2UHbK6q+Oiwma3G3/aCOefF7CpCTPVzZYAs0tINXS4hab4lu5/
	 eh2qmtl2rfQeQ==
Date: Tue, 1 Sep 2026 17:51:01 +0100
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
Message-ID: <20260901175101.1e059ac8@jic23-huawei>
In-Reply-To: <20260823233536.30b984ed@jic23-huawei>
References: <20260803094702.3852-1-david.laight.linux@gmail.com>
	<11o7545n-7569-3p9r-1q77-8nor8513r6n1@syhkavp.arg>
	<20260803163955.627bdd3f@pumpkin>
	<20260823233536.30b984ed@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 23:35:36 +0100
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Mon, 3 Aug 2026 16:39:55 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Mon, 3 Aug 2026 10:49:40 -0400 (EDT)
> > Nicolas Pitre <nico@fluxnic.net> wrote:
> >   
> > > On Mon, 3 Aug 2026, David Laight wrote:
> > >     
> > > > The x86 instruction set only supports 32bit signed immediate values
> > > > for add/sub.
> > > > Replace the "ir" constraint with "er" to avoid build errors.
> > > > 
> > > > Found by a patch that added used mul_u64_add_u64_div_u64() to
> > > > do a rounding divide by 2^32 (perhaps not the best way to do this).
> > > > 
> > > > A quick grep only found one other affected file.      
> > > 
> > > Would be a good idea adding those cases to the test module.    
> > 
> > They fail to compile so it isn't a big deal.
> >   
> David, thanks for sorting this (and all for reviewing)
> 
> Seems like everyone is happy.  What route is this taking upstream?
> 
> I held Rodrigo's driver to avoid the build breakage and would like to
> get it queued up early in next cycle.  So not that urgent but nice
> to be able to tick it off the list!
> 

Given I have a driver queued up behind this, shall I just take it through
the drivers/iio tree?

I can do an immutable branch just in case anyone else needs it this cycle.

Jonathan


> Thanks,
> 
> Jonathan
> 
> > 	David
> >   
> > > 
> > > 
> > > Nicolas    
> >   
> 

