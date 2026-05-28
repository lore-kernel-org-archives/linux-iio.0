Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A43ED3AA;
	Thu, 28 May 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973674; cv=none; b=KyPAVoOdGKdM7uC0Q7WAK0014xsL3jbieQ1mBMRU0PNDdmYoS8l4atmEVykMvhRI91yWnDAQglxedDaAJ2aKc1f2dzQS/GLZm0Sd2Vj3SkpVjFVOZjRXWbc9gtBr8GbqVb63AERtzziuUEE9QdIHa0c6lRFYI1qNMbbB2ypkRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973674; c=relaxed/simple;
	bh=4NW6EeLPQQiKxH/OtaLC8IgPFihjblg4f0K875fF3Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfEz1RlOtPWW9OowIn0KtY+VBIHTaY7fn8xMvuBFqrujUR8/AsxGNOwwzmKmk/sbXljssGuQDmRJ599bpGJLkcdYB/mwDb99TbrdS30QpbVVZYJbaC9J6u9FS6gXOcTP54mju8bCQBCSJ3Otk90oF6J0acdjnkWrfdDpL5/3b+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLuJk024; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLuJk024"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE621F000E9;
	Thu, 28 May 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779973673;
	bh=7meS7bMfb/UJfaljo5jCJwLUbLNtF6EQGZ7+lFu/Zys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FLuJk024Fw8xNvCgOEvs7QonBTS3smCQ+PqDwO3VfXs1I7dP6plO8YfdO4w9NMYkb
	 xamc62eqzqlO3DbO4f8Zd8/ZzUAcHvHHONCTcmHfeQsJdYVgoLAcJR30Us/VIFv8h7
	 2cf5He1s4W5sbMRKONnEH068qfPLvhjz4LdbxO4r7pEOFde23NgMNl5OuDsiFUfmyZ
	 JwtNRskZD6k7uYspfxGjYRnMgexurCFnos3t57cDKoJWQRk0IppvTVtEoQttc2h3nm
	 m7bbHVICWjjJ6hQv7maL72Z8zAstTTc2Anr0IgQ7T8gQvaSIJV4xmPcfEDQiY3Ch1S
	 eRaZm9t6eN2iw==
Date: Thu, 28 May 2026 14:07:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Stepan Ionichev
 <sozdayvek@gmail.com>, patrick.havelange@essensium.com, peng.fan@nxp.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH v2] counter: ftm-quaddec: use devm_mutex_init()
Message-ID: <20260528140745.033560d6@jic23-huawei>
In-Reply-To: <20260527215219.508476-1-wbg@kernel.org>
References: <20260527175758.7d65e9fe@jic23-huawei>
	<20260527215219.508476-1-wbg@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 06:52:18 +0900
William Breathitt Gray <wbg@kernel.org> wrote:

> On Wed, May 27, 2026 at 05:57:58PM +0100, Jonathan Cameron wrote:
> > On Tue, 26 May 2026 12:24:25 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >   
> > > On Mon, 25 May 2026 at 17:14, Stepan Ionichev <sozdayvek@gmail.com> wrote:  
> > > >
> > > > ftm_quaddec_probe() calls mutex_init() but neither the cleanup
> > > > action nor a remove callback issues a matching mutex_destroy(),
> > > > which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> > > > enabled.
> > > >
> > > > Switch to devm_mutex_init() so the mutex is torn down in the same
> > > > devm scope it was set up in.
> > > >
> > > > Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> > > > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> > > > ---
> > > > v2:
> > > > - Add Fixes tag and note that the leak only shows up under  
> > 
> > It's not a leak as such. All that happens is the 'magic' pointer embedded
> > in the lock is not set NULL. No memory or counters or anything like that leaked
> > in current mainline where the implementation with CONFIG_DEBUG_MUTEXES is
> > 
> > void mutex_destroy(struct mutex *lock)
> > {
> > 	DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock));
> > 	lock->magic = NULL;
> > }  
> 
> What is the purpose of the magic pointer? Is it just informational, to
> catch instances where any attempt to use the mutex occurs after the
> device memory is freed for example?
More or less. In some cases the mutex life can be less than the structure
containing it.

> 
> William Breathitt Gray

