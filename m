Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D7361951;
	Tue,  8 Sep 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886534; cv=none; b=QMJGc8Q2iK5iBObb2Zq8CsyhplamjqxIG95Iq0qSswpsTlwaguf4WDV8QWU/CYuSVvncIiLuxTfD+ubCT5k8VknkHym2/6arrIodVccVdzg5kd+ZLW781bnJu9bLnq9pHCSR/UNqWC2WP0Y2ennvLiVoGwpjRhgGfLC0n65eg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886534; c=relaxed/simple;
	bh=vU6Lg8mVgH2kLihnlQaJOsrnqcEQ35BkClCyDzQd3Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp9cyvOCB82NAhLn2OBUqqy8dTryStyoQqlHSZ/zjlTa17OlJpxAOTT++cfx1cN7FSM5bn/t2JRcIOwH10bSycDJ1zefmx1FQ8TAv0wpy9CE+Lorq3YRnkiyo8ugkZ5ZZuKUpWWozEhjPWLP+LbK1c9mzDHTlmPdObVPkjJvn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ye4uMFIv reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ye4uMFIv"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2AE2240E016C;
	Tue,  8 Sep 2026 16:55:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YxAPGzGJBGqz; Tue,  8 Sep 2026 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788886519; bh=6eozimjrpivccbyvOVlUavXK7iRmTgvftqA3yiD2zCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ye4uMFIvMeIfQkSEXtF5yP2syWq7hXfFJRMeGyGkVJZ0E/NUIC0u6zesLA8iAmyyl
	 FxAblM2wUHR6wVmcqSECunUZJvfhx7Ex5HHcFgBXsHC6QUwM7rZJgxPVHh8B9U+GW2
	 sBkAt6k/hsdJYx/wM2RJ/N4roCGUmHpBJV7yogLLkq8hiFAjDiPZ8wSXABT4xBL/zR
	 J6HGhSCCvOBa5Nkm66qLcb3Xr95XjRyF/kUXTLKk+4YsIKvUpYT12+WkG75XYt7Dbh
	 5LwJ7/vBO7IoptldpHYW1WPMnUNwUmwduhHsm0sZ36eN/rNuH2DuiKmAG55+YY9J0M
	 7KzrazJneLCltJWQWKLAsTFGyZ+vf5wF5woLANfyNcW1j7eN0r4d0yyg/INTlqmcjx
	 mZVJ6Y9Jn4R9yugA+JcNhglVYgqiIlqQ5qIX607fzVM/uXzaAL4iIzFgjuP5LOpqrK
	 viasYT8ezNoqAVFI7bgnOEuMGPYNfB1fG6y4YuXSIYo/xH+zn3U/qN5YIeZNCd/p3w
	 CChJtsnJJtdzoQGfBt9d7cZhmGUQDVJ92nTWFxU5LmviKRIwNZ8X3BJ8yLgfRVW6IY
	 2JQO5NETS3uoqRj3oneBDTe7AdvTJj7gjlQ+rLoqBG+FfoqFA6oL0odWY3oKmcz9no
	 m6qbFGemS3HYJAkmYznzXMoE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BA6340E01E1;
	Tue,  8 Sep 2026 16:55:04 +0000 (UTC)
Date: Tue, 8 Sep 2026 09:55:01 -0700
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
Message-ID: <20260908165501.GDaqA95YQKx_IL416d@fat_crate.local>
References: <20260803094702.3852-1-david.laight.linux@gmail.com>
 <11o7545n-7569-3p9r-1q77-8nor8513r6n1@syhkavp.arg>
 <20260803163955.627bdd3f@pumpkin>
 <20260823233536.30b984ed@jic23-huawei>
 <20260901175101.1e059ac8@jic23-huawei>
 <20260907231444.7fa2d116@jic23-huawei>
 <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
 <ap_cLN807bC56OBU@monoceros>
 <20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>
 <aqAtRgouK7DyDlpJ@monoceros>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqAtRgouK7DyDlpJ@monoceros>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 05:49:17PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> I don't see what you mean. If both the tip tree and the iio tree
> contain the same commit (with or without a tag on it), it doesn't matte=
r
> who created that and when and in which repo it appeared first. The firs=
t
> to send it to Linus makes it new for him and all later PRs using it onl=
y
> introduce the follow-up commits. So if you pull Jonathan's branch you
> still can send the branch/tag that contains it whenever you like
> independant of when Jonathan sends out his PR.

Yes, I'm going to have to merge that branch into tip now so I'd need the
assurance from Jonathan that this branch is not going to change.

Also, those patches are not tip-conform, but whatever, not that important=
 for
a one-time thing.

What I really don't understand is, why this rush needs to happen now so t=
hat
we completely do a one-off on the agreed upon process and we have to do a=
ll
this unnecessary gymnastics?

We have plenty of time.

So why do we even have to debate this instead of you folks dropping this =
and
we merge it through tip and then everything's going the usual way?

When people start merging x86 patches in their trees, when do you think t=
he
process will break down and we'll have to redo branches and go into a cra=
zy
dependency madness?

We're not merging other stuff through tip without an Ack - why can't you
adhere to the process we've all agreed upon?

Yes, this can work now. Is it necessary? Absolutely not because it is
a one-off and will get everyone involved, confused.

So please do not do this in the future. If we don't react to the mail, yo=
u can
always ping us on IRC like other folks do.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
