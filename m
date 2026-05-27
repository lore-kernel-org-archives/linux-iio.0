Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2453D3D0E;
	Wed, 27 May 2026 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900923; cv=none; b=P821jOkEaqUgdXm1IWkkEgv8kl3adF5dbpqNri1qhWPF5PdlRDgZOUCUabu62Oo8lR0Qu1nXRNrT9mvexog/i2f1YcM8StmgDqwzj1rruGStFifUybg+jF4CQlqsXtafWsjf2UILQ79QgtiiRsyXSKqbohzqBEXAfBcdUlER6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900923; c=relaxed/simple;
	bh=xYBxmPwzYljmqGLt5t3ujnRD17U4hmMla9th4va+G4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pp0uXFjiQMF/alnenPp8U9B+d+rdu53IdEHBjZi/mfNO5TR0rDVS64+vkJ2eEdMEs25hEcVdkrCttkYEy38hLseR5cNP2iVb0ifTaolBdADcEVnvC8OoMevYS7v7eFX2tgTwrCfG6pVf+8wQLvMbD4FHqzQdHW9oBzy1vO6+T+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP+mTxMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP+mTxMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406C21F000E9;
	Wed, 27 May 2026 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779900921;
	bh=PzUMxx6PLxv7d5oqq1yhC4GQkgXxltVbOFMLvWw3Jns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IP+mTxMXdQ5M8z4GpEsh68xyG0AE3fCWoDv9fCgKXzwuOKhHAWyEw7VoX9wTITi+1
	 Dx3FPqWsQVx0C5dzUdJ4sOIhUFu8F5OKiMRhuV0Ax6JNrgF4SNhqlHGtfWYFfDOlJx
	 N2zbjE8wBNiKMiMU6sBogUJPY+Qy4L0OKkE8rihcp1EidvyNxs+Ob7h7JzDCQNxVUq
	 FVkcTX7FepUs6zj9ME3KM0ORsICV76wgCsDl8+aydnREct6WH7jtl+/MBxJdsYWiCV
	 oTL4GZELIPbx/MStQtmOBcNlUn/UhuV8Hk0v3tY+qMsu7A/EoKC/H62sSQjCpWx5sH
	 5odr1scRwzCuQ==
Date: Wed, 27 May 2026 17:55:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, o.rempel@pengutronix.de,
 kernel@pengutronix.de, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org
Subject: Re: [PATCH v2] counter: interrupt-cnt: use devm_mutex_init()
Message-ID: <20260527175513.0df47897@jic23-huawei>
In-Reply-To: <20260527065632.502242-1-wbg@kernel.org>
References: <20260525151152.7238-1-sozdayvek@gmail.com>
	<20260527065632.502242-1-wbg@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 15:56:31 +0900
William Breathitt Gray <wbg@kernel.org> wrote:

> On Mon, May 25, 2026 at 08:11:52PM +0500, Stepan Ionichev wrote:
> > interrupt_cnt_probe() calls mutex_init() but neither this driver
> > nor the counter core issues a matching mutex_destroy() on unbind,
> > which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> > enabled.
> > 
> > Switch to devm_mutex_init() so the mutex is torn down in the same
> > devm scope it was set up in.
> > 
> > Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")  
> 
> The mutex_init() code was added in 7351312632e8 ("counter:
> interrupt-cnt: Protect enable/disable OPs with mutex"), so the Fixes tag
> should refer to that commit.
> 

Not a fix.   For a long time it was common to take the view that
mutex_destroy() was only useful if you had marginally complex lifetime
handling in a driver and it might help detect bugs.

Now devm_mutex_init() makes it easier to do, the barrier to deciding
to have that protection is reduced, so we apply it to more drivers
(for IIO I now ask for this always).  That doesn't make it a fix as such,
more of an update to modern approaches and definitely not suitable for
the backports that will likely cause.  So I'd drop the fixes tag.

Jonathan

> William Breathitt Gray
> 

