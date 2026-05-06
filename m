Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2749550E;
	Wed,  6 May 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086273; cv=none; b=aIXSl9bWVNO4CgZgZn2F5lO4kWU3784P4vYjaE2ii6eJx7niLmC1oJfb/IiWkg85IGThELtNHUYODWWNoW36KanCwVMHKekZkkZFDIBKXQrY/694s34BswyOXWAUfbuo0zM7IZoCsqGm7kAKrNqoG8SaV6UgriuGd6V1YTcIj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086273; c=relaxed/simple;
	bh=+kFP0pu/j1nFYGDiqFO/RAAxZAlTARxWr509Oo98FY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UR5PKLg38qBZySN0n7fZfYxe3hXCoIrg+eIOpLyghtjuJGZD9Va7DDROsI+/HpWIbU75TpYRgTWUdOinCtliD8OPYoLcrSB3+pZTO2I20462f42me2NpMe21JOPKABfyk6bD+ZF7xfg2SslRRK/LSfk1Yc0XpOZPsrCmKdS8JmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A85fowRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A85fowRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8452C2BCB0;
	Wed,  6 May 2026 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086273;
	bh=+kFP0pu/j1nFYGDiqFO/RAAxZAlTARxWr509Oo98FY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A85fowRyq1Wh/tPYOz/myGV9oFM9l+0vmU4y4Vu3h3ZnxdpNVzhD+rfjmvVemwEU7
	 y4tRPvE37rnifXdsD8Nb12fnSt7zp/eBVh2L0njJJWB29Q7elxA2kk8iYINLNTcCzi
	 B+N3NtgIrFnqplqtKyYmHGaZh2JxtA+4s5DG7Ry/OMwrknU5hCIHPVNpp2yVHa+3VJ
	 NT/jjBX11Fwo6DrBWjGwGKvZUHGYirhgPinK/MCLMzbQPidkess63So37G+qEv1zqK
	 g5O/pNHK0v3CaaRQMmzmcjfAH1yOT9Y33nqEPgTVWv63x4ea+fvdAqIL1qJZ+5tY7P
	 r4hREjmot5IsQ==
Date: Wed, 6 May 2026 17:51:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/18] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <20260506175105.3ca3209c@jic23-huawei>
In-Reply-To: <afruoZ4Oq0Sz7QEA@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-6-831b9b5550fc@gmail.com>
	<afrg7uXqyKs9il1Z@ashevche-desk.local>
	<CALoEA-z+K8FzgwbYfi_aJ3oL6qi2TyXFDYKpmn1Mmjw8XApvNA@mail.gmail.com>
	<afrrzM67n7NQWdE3@ashevche-desk.local>
	<CALoEA-w88c3565-U49ic+FDG1mfpohWzMjZmTus+Nj037W0Sow@mail.gmail.com>
	<afruoZ4Oq0Sz7QEA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 10:32:49 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, May 06, 2026 at 09:28:06AM +0200, Joshua Crofts wrote:
> > On Wed, 6 May 2026 at 09:20, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Wed, May 06, 2026 at 09:02:15AM +0200, Joshua Crofts wrote:  
> > > > On Wed, 6 May 2026 at 08:34, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:  
> > > > > On Tue, May 05, 2026 at 01:46:02PM +0200, Joshua Crofts via B4 Relay wrote:  
> 
> ...
> 
> > > > Fair, probably a badly resolved merge conflict.  
> > >
> > > Hmm... Usually what we use is interactive rebase. Very powerful tool!
> > >
> > >         `git rebase --rebase-merges --interactive $SHA`  
> > 
> > I see, well I use `git rebase -i HEAD~no_of_commits_in_series`  
> 
> Good that you are already onboard!
> 
> > and sometimes I move a different thing by accident.  
> 
> Yeah, this is usually unrelated to the tools, human factor, you know :-)
> 
> > It does get a bit
> > crowded with 18 patches (yours were fine but I also had to do some
> > resolution after moving the order)
> >   
> > > where $SHA is the same one that you used as --base for the series.
> > >
> > > In conjunction with
> > >
> > >         `git reset HEAD~1; git commit -s --interactive -c ORIG_HEAD`
> > >
> > > technique, you can easily move parts between patches.
> > >
> > > (There are even more advanced techniques, but I'm an old-school guy.)  
> > 
> > Good to know, thanks!  
> 
> You're welcome!
> 

Given the issue was minor I applied and dropped that change that should
have been elsewhere. 

Thanks,

Jonathan
