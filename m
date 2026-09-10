Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D644BAA11;
	Thu, 10 Sep 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056562; cv=none; b=gRu2qX0BUicJAB53SNVomsSSSk2kSqDVossXTfw1s0oVKU3eDASGrNXnp+h0CW90uMCnAGR5zeh5cbo7OWF6+O0gLGgPIXFG5dXlMW6S7hjHNGr/IBlQEaME0U7WmbXCQXE44sIaw70USVrRhFCYekuNEKxrBTP4T2OvV1Gg/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056562; c=relaxed/simple;
	bh=2U+ltwTMYXVi268fLCTmLLyzR8pRlBbwry1hESU4vmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsTSQqNvrpH8KWRMx7CXA/dlhuj6/KXZ/ILroh2lgP5RgBFPURmOjZrvcAh2GCf89TjuRR6qp5Y7k7rSchmq8Dv+yaBhsp/15l0BJzeq13v+17sNrh6RrIY2r6T2CGz3lAr7UnbqpNri4yfjWqxWQBAWCdmARwaPs+GbFgKFd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjy0BHbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjy0BHbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBC81F000FF;
	Thu, 10 Sep 2026 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789056560;
	bh=whGOP8ry5KPgaWQs8fLSDE+EARpX6C5SukzqMWGdOzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gjy0BHbIvE9M4P14oFmxBamBCvnsFWxZoEcpHVoE4CtL8F9RC3OCsF64+AezugUfz
	 D3Z3Cx/+Fs6zl8BpxFGxWJUuN56FTKSYkh01tbhhtPcp9fqTHohEhOtbzXF7WYQuvy
	 FBajWDxYwAAp0WA5oI6S6Wm8PNkIAyZIJHUhpYkpk2/TB9YZ7GclIKxfnR3Il0A2Qj
	 hF56nYWC2fLMMQdOYxb1R+0TENpbDumQjS7pVAc0QXPSNZc0uQrUcFK4SfjaOtaxWt
	 0hRgp9H3UK583qCTQMD1NA6TgcozPmPh4O8wosRNL1p+9GzK6f6oYv420bJ0fCP7UE
	 +fnong2p8AB+g==
Date: Thu, 10 Sep 2026 17:09:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 David Laight <david.laight.linux@gmail.com>, linux-iio@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleinxer <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260910170913.1a3ab4b2@jic23-hlaptop>
In-Reply-To: <20260910034527.GBaqIn13O6zSuD4vak@fat_crate.local>
References: <20260803163955.627bdd3f@pumpkin>
	<20260823233536.30b984ed@jic23-huawei>
	<20260901175101.1e059ac8@jic23-huawei>
	<20260907231444.7fa2d116@jic23-huawei>
	<20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
	<ap_cLN807bC56OBU@monoceros>
	<20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>
	<aqAtRgouK7DyDlpJ@monoceros>
	<20260908165501.GDaqA95YQKx_IL416d@fat_crate.local>
	<20260910042029.7c78f6dd@jic23-hlaptop>
	<20260910034527.GBaqIn13O6zSuD4vak@fat_crate.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 20:45:27 -0700
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Sep 10, 2026 at 04:20:29AM +0100, Jonathan Cameron wrote:
> > I've dropped the branch from IIO. That's fine because it was still being
> > tested and hasn't gone out as non-rebasing yet.  
> 
> Ack, will do first thing tomorrow.
> 
> > Next time I'll maybe find an IRC gateway and ping you on that.  I can't
> > find any reference to that being your preference in the kernel docs.
> > Given you have a helpful page on tip, might be worth adding a note.
> > I might of course be missing it.  
> 
> I'll send you a private note after this.
> 
> > If it goes into a reasonably early rc, I'll just merge the relevant rc
> > rather than needing an immutable. If next cycle, immutable please.  
> 
> First one can go to Linus now, second one would go next cycle. Do you want to
> base ontop of both?

Only need the first patch, so I'll just pick it up by merging
an RC once it this is upstream.

Thanks,

Jonathan

> 
> > I started out a bit grumpy that I had to hold a non trivial series for
> > a cycle because of an x86 bug (having been very happy when David
> > fixed it incredibly quickly!), that got reviewed then disappeared
> > down a hole and didn't look like it would ever be seen again.
> > Meh, got me on a belligerent day.  
> 
> No worries, happens to all of us.
> 
> Thanks!
> 

