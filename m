Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD572701C4;
	Fri, 22 May 2026 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451170; cv=none; b=QMzZ/xzAuuhGUol9upvTz9KAyPj5+7h/3VPVZPiGCIrcqr6ms+Lxy1NJA8sGrqP52utFD8hO0tFmg8et8xGQ6vOPJRkHMndRTRUr4M1XjqgHvumoZP4Wg3C3SMXi9Svyz/WinRz33JkpQEDWWPbSbbbr2cB+5s5mDk7AwRf2xls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451170; c=relaxed/simple;
	bh=aL2pS9GLvttib92W5qm/5QsnAP2sLgrRhXOhwnl9YXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4S20COmRQlmGWN+eOpqgBX/wt9UkvhcTWrLjUB7joTtk9VVeTn+on9f3Y76Aw9K5PSIkdBh+if4NKePQZfC1XSsexa5v9xJML3RH9nD7iUrx+TvYJnEz16uymxSZpMDwskHD7ntX9ku5/jzlV+qJ/azgjDWgETToWOo4x5l9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyyNTQsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyyNTQsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3591F000E9;
	Fri, 22 May 2026 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451169;
	bh=MzgE7B181m4tHUc2HwIvJrR+2HmRVQIF19+dOgeF/PE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JyyNTQsXfMQEMY0WKOCjmufUAvjl37T9QTqi7aa0FwUs6BARwNLnfVYzGo00spPq1
	 Ujfy1+wFeqnPQeqlhiAwAotTD9NMwdQUleoChhT9nEEfPAPIu7jviw/Ymab1RoP8ba
	 A0IiksOgNZ33eH/dgusb8hHUFRpLfRECNUsgCbhGZK9o3ISuBd1kCz4Ughxznh2t/B
	 Gl5qSMjVpEpAGy8sFFjTM/sgx6ODY8WPmUXrJafKft10Rwgzc0InRe52Raa6KYV7Kc
	 UFsyGfF1qH6CXlHqSdlK+GGyvPKxRfq1Sub6Pkeje69d+EJO0tZHuv5tZ1kQ9vP8Vk
	 bTyp0rI8g2cWA==
Date: Fri, 22 May 2026 12:59:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Ashwin Gundarapu <linuxuser509@zohomail.in>, linux-iio
 <linux-iio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()
Message-ID: <20260522125922.19e5c7cf@jic23-huawei>
In-Reply-To: <CALoEA-xYF-1Hf07JDVqbOGNXujLXWR9b7qW14RT9ZPwpmx9cjw@mail.gmail.com>
References: <19e4f066d51.4e6bc94b96251.5845269359367162045@zohomail.in>
	<CALoEA-xYF-1Hf07JDVqbOGNXujLXWR9b7qW14RT9ZPwpmx9cjw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 12:23:52 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 22 May 2026 at 11:44, Ashwin Gundarapu <linuxuser509@zohomail.in> wrote:
> >
> > From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> > Date: Fri, 22 May 2026 14:34:46 +0530
> > Subject: [PATCH] iio: trigger: fix memory leak in viio_trigger_alloc()
> >
> > Replace direct kfree() with put_device() in the error path after
> > device_initialize() has been called.
> >
> > The direct kfree() bypasses the reference counting mechanism,
> > causing memory leak and potential use-after-free.

That statement needs a specific path to be called out.  It's correct
but explaining why the reference count that is deleted is a problem
is needed as often that wouldn't matter.

Anyhow see below...


> >
> > Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> > ---
> >  drivers/iio/industrialio-trigger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index 17781c12bc85..9c72e7ae996c 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -598,7 +598,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
> >  free_descs:
> >         irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> >  free_trig:
> > -       kfree(trig);
> > +       put_device(&trig->dev);
> >         return NULL;  
> 
> IMO calling put_device() on an uninitialized struct device would cause a
> panic, as there are multiple goto statements that jump to this section
> before the struct is initialized. Additionally (as Sashiko points out), this
> patch introduces a double free issue - the IRQs are freed after jumping
> to the free_descs label, and then they would be freed again due to
> put_device() being called and a subsequently triggered cleanup.
> 
> https://sashiko.dev/#/patchset/19e4f066d51.4e6bc94b96251.5845269359367162045%40zohomail.in
> 

I'm also curious kernel tree the author is looking at to find this bug.

This was fixed (correctly I believe) in 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12b393486c70

Key is it resolved the issues Joshua / Sashiko pointed out by moving the device_initialize()
much later in the function.

J
