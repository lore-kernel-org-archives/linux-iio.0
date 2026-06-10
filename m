Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDC3ED5AE
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107313; cv=none; b=LB5itgoEWE3z180KJF4zNgdGvrPBNDGOZ+fSARYOPXqAgoHfkioxm5Nyz0b95Xykd7+ZCTU7gI0ZvWzwPQGLzOjhgni0wk9/rSPom/JTbllnFJtrimlPhu0FXmsninyU770rI8IcrKlNn9MYgwrqKcjc6pCGPr3M2PxXM1xLMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107313; c=relaxed/simple;
	bh=1Z5kDwNHcziKqIU1aQUCsFkC//eQuaWU4EQc4ydfLwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVZGSDsnKi1d+dGFqKaG2Ho/8pi+9sHAN0Ks1cengsfR0/E+dVXPClnt02xuDkoNhLwpyeGeyQTtjhic4g0xSeNjZv+QXYamur9Xc0DTI+5OScSFXEnHV8Z8gR8io7TbJ/DxPBtx/Ui+eRAlP3OIMpy8x7kFjkrIhXq91lrZK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0vD+bQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0vD+bQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9351F00893;
	Wed, 10 Jun 2026 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781107311;
	bh=69CsVnLiXz5iUsPJ3uYUz3fob8d7dYw8wV9Se+f4Bsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b0vD+bQIWI3S1PI44mMSGUZTPdbZ/+5oFkqB0iG2UksmrYu0L0o/DMHE5eR+7iSnf
	 ZAYvaziZ83cknJGb+9tpoRKOMx5ILL5lV9WvFf/Lczr0JZFE2Lzjqs7EMM+7iJ3sYR
	 PxLHWb5IULulBotFeVhlGYAypHritZDW97nJ49xehzNgxzi8hkjyC8K0NYii6fynuQ
	 v9OOb55Bsw1yYLugm23mmsoY0flP0uxaDNyrRhpXKJZlrIaYFQ/sRWdLBz+/+t3Llf
	 8YpqEj22FDPrtSm18nAesQ1Bt7aFC2YubOlS9fLNYaQehzHIwGOrz6nt02S1tYQJmL
	 nHxI7VLnQ3kBA==
Date: Wed, 10 Jun 2026 17:01:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: core-trigger: correct CONFIG_IIO_TRIGGER macro
 name in #endif comment
Message-ID: <20260610170143.1814175d@jic23-huawei>
In-Reply-To: <20260610155921.0000655c@gmail.com>
References: <20260610040501.204967-1-enelsonmoore@gmail.com>
	<ailpoosKZwGskxUo@ashevche-desk.local>
	<20260610155921.0000655c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 15:59:21 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 10 Jun 2026 16:41:54 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Jun 09, 2026 at 09:05:01PM -0700, Ethan Nelson-Moore wrote:  
> > > A comment in drivers/iio/iio_core_trigger.h incorrectly refers to
> > > CONFIG_TRIGGER_CONSUMER instead of CONFIG_IIO_TRIGGER. Correct it.
> > > 
> > > Discovered while searching for CONFIG_* symbols referenced in code
> > > but not defined in any Kconfig file.    
> > 
> > (Btw, did you do that manually or using some scripts?)
> > 
> > Wow! This line is from 2009  
>  
> Perhaps there should be an award for finding issues this old :)

Plenty of those out there I suspect :(
Younger me didn't write particularly good code!

Applied.

Thanks,

Jonathan

