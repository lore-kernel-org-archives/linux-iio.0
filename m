Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418237DEB6;
	Thu, 10 Sep 2026 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010437; cv=none; b=qH7kPm1fcNqeFaCVBEM4fq/a0VoXxa+cpNKOiJceBaQpeErZWKB7F5Lz7WrLH+8sJGP2aAzx+jE0brrdM2ak/nMifT6d2tkFR1I8Palb9wC8vi9O2APZ/cEASXGBh9G/sJuTr9GUc2fi6GwOr86xQZUudoW++khmgDBQAplAE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010437; c=relaxed/simple;
	bh=wLK4mIxthB3BZvo7ECLXPgPSLtaD20pir6OdlRw0VyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6VtGd/bd9EXvrQvfr3n4112mBRUGDRlI5rxarvy3O0A31IHOxDU1rfjdRTpXUt43BpJFw+1vV1/TTwg3LwFzPeV44XzcsvSGU8eyGMBr0YSrQ0i0tYAVUjscGf7Op2vhyHB/WAdurapVfbih3Z1W3e5OoCt0MDv1SfTPd/nt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA2rDpoR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA2rDpoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D389C1F000FF;
	Thu, 10 Sep 2026 03:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789010436;
	bh=2EB70JFDpzLI0s6pkD0sPoT0z4Ey0yYYBi6G0LOrZC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AA2rDpoRtm+3ufmdFn844tzBcFS6/ZdCe0Bdckhfc0pea/DdDAcB+DKL80DZmG3aw
	 0utk5kDv+DtgXxkjQM8dzy3RfXV76m8+/ZPBNCCf09NhINacKEcKSFrPCtCF/ZbZ8T
	 pL3+dfKGjY5RZXMMLrlXWmCShxknmDbWP59QbNVanCejj7PUsYVNedqCq9fmTm5xUH
	 ImLGpsgOsMfb3rs4L5L44EtV99Y/IC3ShLnYsXiEi0u2L72LnOmC9TYoQ2TI30JEYN
	 AjGJqBXRNIWkUOVxMQ0L9MQdhJzzgSgUsTKgOGzV8ei9EljbhKfC/a8B58hAzzn3Sr
	 IIqjsllRjPE7A==
Date: Thu, 10 Sep 2026 04:20:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 David Laight <david.laight.linux@gmail.com>, linux-iio@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleinxer <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260910042029.7c78f6dd@jic23-hlaptop>
In-Reply-To: <20260908165501.GDaqA95YQKx_IL416d@fat_crate.local>
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
	<20260908165501.GDaqA95YQKx_IL416d@fat_crate.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sep 2026 09:55:01 -0700
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Sep 08, 2026 at 05:49:17PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > I don't see what you mean. If both the tip tree and the iio tree
> > contain the same commit (with or without a tag on it), it doesn't matter
> > who created that and when and in which repo it appeared first. The first
> > to send it to Linus makes it new for him and all later PRs using it only
> > introduce the follow-up commits. So if you pull Jonathan's branch you
> > still can send the branch/tag that contains it whenever you like
> > independant of when Jonathan sends out his PR. =20
>=20
> Yes, I'm going to have to merge that branch into tip now so I'd need the
> assurance from Jonathan that this branch is not going to change.

That's what an immutable branch means to everyone I've ever shared them
with in the past, but sure - it wouldn't change.  Anyhow, easier solution
below.

>=20
> Also, those patches are not tip-conform, but whatever, not that important=
 for
> a one-time thing.
>=20
> What I really don't understand is, why this rush needs to happen now so t=
hat
> we completely do a one-off on the agreed upon process and we have to do a=
ll
> this unnecessary gymnastics?
>=20
> We have plenty of time.
>=20
> So why do we even have to debate this instead of you folks dropping this =
and
> we merge it through tip and then everything's going the usual way?
>=20
> When people start merging x86 patches in their trees, when do you think t=
he
> process will break down and we'll have to redo branches and go into a cra=
zy
> dependency madness?
>=20
> We're not merging other stuff through tip without an Ack - why can't you
> adhere to the process we've all agreed upon?
>=20
> Yes, this can work now. Is it necessary? Absolutely not because it is
> a one-off and will get everyone involved, confused.
>=20
> So please do not do this in the future. If we don't react to the mail, yo=
u can
> always ping us on IRC like other folks do.
>=20
> Thx.

I've dropped the branch from IIO. That's fine because it was still being
tested and hasn't gone out as non-rebasing yet.

Next time I'll maybe find an IRC gateway and ping you on that.  I can't
find any reference to that being your preference in the kernel docs.
Given you have a helpful page on tip, might be worth adding a note.
I might of course be missing it.

If it goes into a reasonably early rc, I'll just merge the relevant rc
rather than needing an immutable. If next cycle, immutable please.

I started out a bit grumpy that I had to hold a non trivial series for
a cycle because of an x86 bug (having been very happy when David
fixed it incredibly quickly!), that got reviewed then disappeared
down a hole and didn't look like it would ever be seen again.
Meh, got me on a belligerent day.

Jonathan

