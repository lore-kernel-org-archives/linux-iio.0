Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3C3431E6;
	Sun, 13 Sep 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341251; cv=none; b=omQ7Bmi63KoW1pno9NmER+Y1/QTEyxA90sgnECknexBsbv8ElBFWuraXzGWcQhEvybcLdCvqhcdyrFwy0RWp9VpDKSn8wRoyjzFVhX2LBj9z2gSOBnMvQ5M6K1Oa4vU3kmAxii4q9KgxbvgoZK2PD4xaxPMYoo25TSQBnnzFJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341251; c=relaxed/simple;
	bh=3FBobjjDPtwUwax3Sny6vGgQI1b7u3f11oqPPeyxfBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbGI2nXRzByDnkznQAnQIqnkXX4S5eVAWDPrBl1K/9UGUXnSRmjqWkGIhgKvIhTDKrDRi1qdvG9ANiWnoxyAAQU6XcptiJTqrSzSKWzxW2X4sIh8HDLNjEjr/QKV9jOaWkkLS8kQASb/8q9s0JjRHYqr4Sn345XifTDPBe9SBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kl+XGujV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kl+XGujV"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9BBC340E00B8;
	Sun, 13 Sep 2026 23:14:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id P9ZSm16585ma; Sun, 13 Sep 2026 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789341235; bh=e62KowmjjdQv5qI4jQteduKm/oNHV49I+nup2iHWgLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kl+XGujV9Qv3Rfh56/USijqLHshkvpRNRHmlY3CXHRd/A0PGz982qHjNzTrf7JHZS
	 r2I4rLBh73ryDNjezHh1jQpeli5ReC8twWdGkxFf0rh/DeVqiHz3jfN8/r80+uKoUa
	 LzfMn4xFSRunMCO01jiDfn6rRGRhKPRxwYmZ7Vdss38WXz86wiGHkx5rhfT4f6ZBYK
	 x/lr9x21SF6DtadTmvlwToj1tiePcZQ8EejP8m95k9Oq+ldJuitAKaS7CRoH2W6rQi
	 0DhlF8DHJJXucBOC5fU/fOKAbetGI/OirGxToWDmfBZaRzDKbJLSjDPdEGJ3NI0/1N
	 5EE7dbmbnu/Q/IicqHxz3PAfr2K+mU0xSFJkRmIHxsr7x0ZojnTPrMmlL3/HSrluN6
	 YmS3kX3o0xh07ME9+0hkORFgyO3WHsIaXPZ8XnAhmhGqulS7khOoMPPWj2Llw3hCOc
	 1vaXfO0WgLVrZOPzUnT2VDiuo+4deHI1rYPHJfGten9/lgirzTt30LnzHbrD1RpVbx
	 LCm2eXFMrk6TfXfpFeLos0gRtsdrOqLekyNcMtVxI0VrpJIZzXICDRgyLCpIZwvXcF
	 3ACU8w2p8ce3U0F0h3MlIO5XpX3HkWTYdBwjKmrUkieY+VaPP/+skgOVrkKTyPP0tL
	 JNmuMAbI4OzUY3/A6TpIUX40=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BE5340E01ED;
	Sun, 13 Sep 2026 23:13:41 +0000 (UTC)
Date: Sun, 13 Sep 2026 16:13:37 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-iio@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260913231337.GBaqcuIfvFRlIeQITe@fat_crate.local>
References: <20260907231444.7fa2d116@jic23-huawei>
 <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
 <ap_cLN807bC56OBU@monoceros>
 <20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>
 <aqAtRgouK7DyDlpJ@monoceros>
 <20260908165501.GDaqA95YQKx_IL416d@fat_crate.local>
 <20260910042029.7c78f6dd@jic23-hlaptop>
 <20260910034527.GBaqIn13O6zSuD4vak@fat_crate.local>
 <20260910170913.1a3ab4b2@jic23-hlaptop>
 <20260910180002.GAaqLwImwJj66E8w3L@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910180002.GAaqLwImwJj66E8w3L@fat_crate.local>

On Thu, Sep 10, 2026 at 11:00:02AM -0700, Borislav Petkov wrote:
> Pushed out into tip:x86/urgent. That branch should be mainline with -rc3.
> 
> If something last-minute changes, lemme know and I'll do an immutable
> branch.

It changed - -rc3 released and we didn't send the pull in time:

https://lore.kernel.org/r/20260913225356.1033865-1-dave.hansen@linux.intel.com

I can let you know when Linus merges it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
