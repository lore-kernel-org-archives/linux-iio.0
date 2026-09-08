Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BD33D503;
	Tue,  8 Sep 2026 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838381; cv=none; b=ZcKmDDiIPqdMYGSDxbgcapIowTs1GPmJMKl+an7nYKEYfYGtjNTUfOmQUUUotkvuy6XC02FNlU9I/EYGggM+fgmFtvezbyjtCtCvTPoVbBRICZc0/7mUxprdJ5JdSgF+nbsLEf2jwoH80fRB3woJwGvnOCzQOBsp8az+TSNoF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838381; c=relaxed/simple;
	bh=tz6aBKJ3EeOYHZLF37tZIG2F6Q9S+RaJRrvQNXjjL14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7qU+6KcqNCkqsJKfR6/JwynV1Vb21Iu6/fDQTUmeWT9ksREOKEQexblh/lURPBsATL60iCKq8ZU2gRN6YCT+/XxqIaf6/faikPx9Z4xga1hybZ91jORA+9/tJbXGmPwh1Li9S/eNKQFabXr8aE4VdJRw0pYV8qyiKp2BFWkNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rn9g728A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rn9g728A"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78C4F40E016C;
	Tue,  8 Sep 2026 03:32:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z98zJYTWlIqk; Tue,  8 Sep 2026 03:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788838355; bh=/4nguhZJCkoXGgLEe9/E41pRIrfH1twM5GOij30kl3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rn9g728APQFXGVihqX/aORSO7cl2u6HXvTcOsIVgdTonjA7/5BAUBkzKGe7ZczpX2
	 Z8267O1PV0aDqJj6mqNyaJDFhLYrxKk2BsGL0uMnUh1uu8HBlswru0Vwa5PnKhzWlw
	 2zL/wNEwSvOaOoBLFILDruQsNiXiFZIbX9uxoIU/G+8D2tfv5WGyqRpenJbAAgk9Hx
	 d4O0NdOnhf4l00yJv+T570C0XgW2oh7iXTwZ0admw7hRw447ft8KYfAd/3YCbbMkBE
	 w1po5kON9YHG/ppIJB+3a9TEpDXgkuC7fLPmqrjetkcm/oWosNjCdDvZ3lfxc8vssY
	 +5TKOGWxg59ZcRxS6Bpvgcdo6yWk8Od+pyHf9wfbomCocI344XNe/mbHBkqx1ngx2g
	 xIWJMLzTBHq2hDauklzyR+p8IsHaD2ZyGcxaZeeB5j0xv4Pcf3cTpC1/spU6wmVnHm
	 WXMxAN1epIDPnUi3mC/umUERlmv9ApHAsaDFJ7hWoExM12u2bwEsaYN046yhpEIspa
	 VRLwe+5jG2A9Wl+KHNBnhnwSR2boRaN2BHVmNuMw4RNTOyNCDbPSG9K/E01OsFxRin
	 1t+zYUcGOa2lBQhwJMP3SJJsXD3xn9GeDi6bE7h+hjBFB6lfOjMM7nL3f9eoEQwmlm
	 CR5Dfch+lqt8azp4aueU4SO8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6642E40E01DD;
	Tue,  8 Sep 2026 03:32:20 +0000 (UTC)
Date: Mon, 7 Sep 2026 20:32:16 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, linux-iio@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
References: <20260803094702.3852-1-david.laight.linux@gmail.com>
 <11o7545n-7569-3p9r-1q77-8nor8513r6n1@syhkavp.arg>
 <20260803163955.627bdd3f@pumpkin>
 <20260823233536.30b984ed@jic23-huawei>
 <20260901175101.1e059ac8@jic23-huawei>
 <20260907231444.7fa2d116@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260907231444.7fa2d116@jic23-huawei>

On Mon, Sep 07, 2026 at 11:14:44PM +0100, Jonathan Cameron wrote:
> I went ahead and picked these up on
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git ib-iio-x86-asm-fix-7.3
> and merged that into the main IIO branch. I want to give plenty of time in next
> for the driver that was relying on them.
> 
> Currently this is all in my testing branch but I'll push that out as a non rebasing
> (ideally) branch a bit later in the week.

No, this is not how this works. x86 changes go through tip and if you need an
immutable branch, we can give you a tag.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
