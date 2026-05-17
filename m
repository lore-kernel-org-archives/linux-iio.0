Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC987337B97;
	Sun, 17 May 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017904; cv=none; b=qxqCHt+E4o9IFt51a5ql5m+4DpSFrn3NkDQaeynIXsWcrb2HO9/IeKluGRHGoIdD0LAptMDHqEYotSLt1+sOe3bkHdSZw4+B2FzQWAsQzQdd39S57pbNiUF7M7mcAolPyl0Ba28Gi1MRyN/t4KeB6jwztEUJktqv3yabxjLieIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017904; c=relaxed/simple;
	bh=CerfeuMIUR9xYcuan6KE0C341OJm+R/ddiU0xIMv+AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW6rcYLGOfUBqbk7oG1YZhhQMBi6oaiQbjTzofEvWq6OQHJDj0voqzrrBDiH8zvwpZr4ArP4YRfV45AFLr6IUyxIy9ZSkddI47vNlQzQBlRvzVjPMCjfrbBj3PxogHjpThzoKjQEWcd3Jn7QiqPlQ9QhldcpwSIfBXLK9FScMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx2GFtt2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx2GFtt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC242C2BCB0;
	Sun, 17 May 2026 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779017903;
	bh=CerfeuMIUR9xYcuan6KE0C341OJm+R/ddiU0xIMv+AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fx2GFtt2qIPBadi/8KTXqvfc+QgLOu2m6VPWO5yEH+c/dnQZDV4p3FjxXQKvKIOA6
	 GsSAEJEh1lkZArefVAU8TnW1gvF2qW5H+uxIxyALC+KU5rNUc0KR63D4yS/Aa6A3tF
	 6E4HIvWt+CYMgjfmU+TeQEaHZ/Cfn0BcgEyZ5FERPM6941CejhGJ1AtMR1Bys5q2Lj
	 LbL3eAOdKm/eKjXlR9t+37QDpIs9BIjYubLSxjnTjx2sobJwIFEcGkEVeL2OvKxB5v
	 bClBZCLTCdFzsLV6qJlCvwU+xWaUlVZ1ryhp5EoOTm1LnwV8oSGzXn2fQmI760zo7J
	 uy8iMaXappNbw==
Date: Sun, 17 May 2026 12:38:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Joshua Crofts via B4 Relay
 <devnull+joshua.crofts1.gmail.com@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>,
 Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iio: light: opt3001: switch driver to managed
 resources
Message-ID: <20260517123818.76cc4668@jic23-huawei>
In-Reply-To: <CALoEA-y+1zgrjA_KiTRJRiJepHGb3a2_kHfdJPa0VTPdopqtCg@mail.gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-9-8018cf3a8a0a@gmail.com>
	<20260512152600.764ff7c7@jic23-huawei>
	<20260516131017.3de30733@jic23-huawei>
	<CALoEA-y+1zgrjA_KiTRJRiJepHGb3a2_kHfdJPa0VTPdopqtCg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 19:04:56 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sat, 16 May 2026 at 14:10, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 12 May 2026 15:26:00 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > On Tue, 12 May 2026 12:57:29 +0200
> > > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
> > >  
> > > > From: Joshua Crofts <joshua.crofts1@gmail.com>
> > > >
> > > > Move the driver to use devm_* functions to automate resource
> > > > management and simplify error handling. This also allows removal
> > > > of the opt3001_remove() function.
> > > >
> > > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> > > Some trivial stuff inline.  I'll probably wait for sashiko to catch up with
> > > it's backlog and get to this one.  If nothing comes up there or in other reviews
> > > I'm fine tweaking the stuff below whilst applying the series.
> > >  
> > Sashiko did come back with a lifetime issue.
> >
> > I think it's a false positive as there aren't any workqueues or similar
> > that might still be active. IRQs will long have been cleaned up before
> > the mutex_destroy() occurs.  
> 
> I would agree this is a false positive since the request_threaded_irq was
> moved to use the devm_ counterpart in this patch.
> 
> On an unrelated note, I also have a first version of a new driver I'm working
> on, is it okay to send or is the workload too big?
> 
Fine to send new drivers. Just try to ensure you don't have too many patches
under review at one time.  Keeps things fair with so many contributors.

Exactly how many is too many is a bit subjective and depends on the complexity
/ type of patch but never more than 20 unless there is a mass refactor in
there (1 line patch stuff).

Jonathan


