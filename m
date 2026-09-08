Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268D4968E6;
	Tue,  8 Sep 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880931; cv=none; b=lYxbReI9mahcbg4cfgVY6WahfAoEst2mCIHFxcCyAnFETOU3Xid5hTdVfGy5c7WTir+O3YW5mDw5IXwIoIEKpfx/3zQcVH7YlZgJLfCZqv+wFahckT8cGKnIHVCmm19tJoQhEOi8lJUjc65rQoxARrpsA9TY+6kCYnhnzbcIzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880931; c=relaxed/simple;
	bh=Mjf10pcJ8KTIyobMzERpOQ3TGaDBOO08BFOmEL58Shk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6G5/RN5JOhMPPsGB+qYrTd8yI3OEcr32ZML3BltIESGFSp8H9FlA5geE85lfvv64VtbGa7ntxWB6unVwCWzscCZy4u5e3zyMlij060wg//n3S4ZWeFNPN/D9iHNQ4IrOegm3E63n/QG5DPd7cosCc+zitGJ61dhFdJidEENN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U1clidsB reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U1clidsB"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 38E9440E01E1;
	Tue,  8 Sep 2026 15:21:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2hptbq3PX80F; Tue,  8 Sep 2026 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788880905; bh=dcmXg07kRy0dDyWnssgE0vqKNs4qtDjD90LeFB/acsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1clidsBvKCmthHLRDCTlKv75xO216RGmv48PraBLA8jMOLfBHcTmMYZlkY99iQjM
	 VS3lC9to4kNHGwUo4d8vxm6X6xeBI+KwwQHfjtRf5rABi+12F88I8tPsqyiyQ6X0IR
	 hySrwl2YrJ6YYI8XxhRgG7aztqTtmDDQXFW3m+FMNyD9Zl9/8HqtB3fvicDAGICJD2
	 p1eYjcX5a+XqwL1gS+D7LXIR58l/pRBRxMx8lfgLMsa27KKrdOpEQE2wpTd5bvVyoN
	 NSAIihWCIN+qS3/IW7iy6ToMYX8hVRsCLG1V+NslqT0mKDBrtvE9UMxgqdt+9+0uXD
	 Q963urssYGOtrXfSvbaa4j8CVWK0un6qIfsjClSWsIbNg1bVTfZuZNYeICo6s/BDEA
	 tjJeFqrZoE30i0OJaeOJIg8+7UqkD8v7api0FIY9Rz/h1e9hRRO92xJAtZfeOmGMBE
	 zyVXz2eZuTLR4pGoMY7qNtyfweFBv2OQRxa8BVhczG7f+hYpoQhz3nhoTDtZqeKP3f
	 lyKRq3sHuZLLeUbGVQrAMhLLAOTI4beinbX9XyfPoT2r8uPzjbmXai52Hzpzgknk1n
	 YiSaH4O4ekWGD66X3pCEDmucHi/bgm28krQYGcPtLl7RsGN+Zn1EgKH0eRpv4a9jrT
	 M/XblJOUat/KHOMPmHtt9lfs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D75340E01DD;
	Tue,  8 Sep 2026 15:21:30 +0000 (UTC)
Date: Tue, 8 Sep 2026 08:21:27 -0700
From: Borislav Petkov <bp@alien8.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-iio@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>
References: <20260803094702.3852-1-david.laight.linux@gmail.com>
 <11o7545n-7569-3p9r-1q77-8nor8513r6n1@syhkavp.arg>
 <20260803163955.627bdd3f@pumpkin>
 <20260823233536.30b984ed@jic23-huawei>
 <20260901175101.1e059ac8@jic23-huawei>
 <20260907231444.7fa2d116@jic23-huawei>
 <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
 <ap_cLN807bC56OBU@monoceros>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ap_cLN807bC56OBU@monoceros>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 12:02:42PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> While x86 usually goes through tip and none of the x86 maintainers
> commented before Jonathan applied,

You mean it is easy to spot every question to x86 maintainers in the aval=
ance
of mails?

> it got positive feedback from hpa and peterz a month ago and iio depend=
s on
> it.

That's business as usual.
=20
> So I suggest to do the practical thing and pull Jonathan's branch into =
tip.
> Technically that doesn't make a difference (apart from maybe branch vs =
tag
> preferences).

It does make a difference when the merge window comes and we have to
synchronize when to send what. And we send tip stuff very early.

Considering how early it is in the game, I'd prefer if I queue those into=
 tip
now and give you an immutable branch or tag and not worry about adding mo=
re
stuff ontop later.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
