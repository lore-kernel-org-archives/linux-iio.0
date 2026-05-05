Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89240627C;
	Tue,  5 May 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978564; cv=none; b=O6K3uWHCYl9Efx5WbK+JM5iK5Fvz4loh9YOzEk666DR5qj/7xFRW3F825iuVT6wb4P9/A8zMlKcD/UYXu2g4TiAuHl3Zf781ElMazWYdMof3J23klysmRA3YiFTYIBB1EgTw6gcEzBp6tq5jFL9GwUCdGiSRvGDcsF7g3PtWiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978564; c=relaxed/simple;
	bh=jX85wrfikksOZA8rJzFXX8nHvGArvgQLpXde99CbP9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqLEX3QhbwsxM497VEXzlen3nCDDtHyz+BeqKE6g5u7PLJIsJEY8byWIwGW7H3bOUQptHC74s6TJpFAI2+E/jbGgjKmLSo4AHA75mgy+djl2Oj/NZni1KJUb/BnKN7+bvQTb+T4fzsB58XXJ/W4XWDoUsKwZQTh6M/0ZgFcH0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOpSyKKY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOpSyKKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1E1C2BCC7;
	Tue,  5 May 2026 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777978563;
	bh=jX85wrfikksOZA8rJzFXX8nHvGArvgQLpXde99CbP9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bOpSyKKYGOPSrbG58cgdtpXS9y6HobOPPKPZzgdbRmW0hEhUQ6qVfJU5xkj4lHSru
	 0HAfqF5RI+6Hj92C0GCvFi75u6fsyMh/uhI89o180qO6FrnoeutgSiwg7KidZX8yGU
	 HJ2Dnb7EO2DKXvem5K2CE1fp34GQ5XXcXXMJSdzv0fvTn+qvEr1gGE+a0nWS323S+F
	 YVUrHbMf58WPugwYAbU7hXgeldjEmgv5u/6mbICYIAdd4/5XBoThKndWNs/O66qEoD
	 oMAbl6okwwW/T7QtsfiMfUOAO3faj9/SkpKg4rb/TgBGT6cDeFole/gtE0qBTlYb/r
	 135Y4mZK7CjTQ==
Date: Tue, 5 May 2026 11:55:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, rodrigo.alencar@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Popa
 <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, Greg
 Kroah-Hartman <gregkh@suse.de>, Michael Auchter <michael.auchter@ni.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
Message-ID: <20260505115553.2ac39ec0@jic23-huawei>
In-Reply-To: <afNBY6dQ5Nw-EZcH@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
	<20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
	<afIRG2S94JEn3Oqd@ashevche-desk.local>
	<CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
	<afJLlpsU17Pmp0uH@ashevche-desk.local>
	<CALoEA-wvYvZr7ixC4UOh98mZAas1vbOe5CXT89DOy3e7xTmJ_g@mail.gmail.com>
	<afNBY6dQ5Nw-EZcH@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 14:47:47 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Apr 30, 2026 at 11:18:42AM +0200, Joshua Crofts wrote:
> > On Wed, 29 Apr 2026 at 20:19, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:  
> > > On Wed, Apr 29, 2026 at 04:38:02PM +0200, Joshua Crofts wrote:  
> > > > On Wed, 29 Apr 2026 at 16:14, Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:  
> > > > > I haven't checked this deeply, but I hope at some point we will have
> > > > > more or less usable state of `iwyu` tool that may do this automatically.
> > > > > At least current result looks better than the original.
> > > > >
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> > > >
> > > > I did find a "filter" file of sorts for IWYU that Jonathan had on the
> > > > mailing list.
> > > > It does a good job of omitting reports of very low level headers but at the
> > > > same time IWYU still tells you to include things like <linux/stddef.h> and
> > > > remove anything <asm/*>  from your includes. Perhaps it needs more
> > > > tweaking?  
> > >
> > > You need to check that manually and then decide if we need more amendments
> > > either in the patch or in the `iwyu` "filter" file or in both. In case of
> > > filter file changes, please share them to Jonathan and mailing list, so other
> > > people can adjust their work in case they use the tool.  
> > 
> > I have made some changes, so I'll send an update where people can get the file.
> > Also I've noticed that there is a /tools/iio/ directory in the repo,
> > perhaps we could
> > add it there so people don't have to search lore?  
> 
> Perhaps, but it should be approved by Jonathan. Sounds good to me,
> nevertheless.
> 
It's not really a tool so the overall tools maintainers may not want it there.
Is there any precedence for similar config files?

Jonathan


