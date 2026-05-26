Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE603DA7EE;
	Tue, 26 May 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806327; cv=none; b=Zi9TVkD9Kg5OcU/k8aXsmVy+ayrXrIREDnf7+vChXp8CSME+tz97iNprbn/L2sQgogaJ/QtMRLv3/PwwObqp77/cHTbs/4tpvq0F+5wn53uJmdk6x6oiSgW7bOP7ukDnBtQ2Fg41+YymlazHxGDkLkxKb8PpCy9mXKWbyBiHHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806327; c=relaxed/simple;
	bh=UYbONTEV9vs56g1ZFb99CD30fUyhw15rIEZKPtDTO3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZKadmZQhhSwXYHJF9keWVRdbmm0WKFXP2ECXVng3RK7nlbsTRoLrXxMYw/DYIbr4nXGuiu9v/FmVHrSdbmwyUJfbmrGAOyhYqU+E/+W6yOA6IcjMJZz+g5MedhjJO7mQR9j2rA6U3Jjdumhy282XGdkyNBmVynMR7f4LN803IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8o4D83Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8o4D83Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80221F000E9;
	Tue, 26 May 2026 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806326;
	bh=wUGADhbyRd5N14xtmuSy5+IF0x8GoLkwNB8mWquFArw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m8o4D83Z5X9M3k009BixUr3jp44M60B22XKkb3N/5j36MDQn/fMagnEn4PgKwCuTu
	 2Dxg/KSvtniRehqyIbmeQgBLn59GUZi1jB0b0X6PXFVwtTAmHgGoj/ecadKlUMlke4
	 2q0czIM3kho2bPdlTF/2DIHqJzlT42+hHFm6IrG1v13a6qNKSc7VVDEV7SymNt4oPn
	 DfBrRSkw6q/4LByIVATIoSYdHn2MYHAEv1FOGij7hZEwTwgdJvvj9aw4mg5G0d/6DU
	 E6F8aflk0/H0Cin9Y0vcHuSkDvZTIiYTD4N292LcyXyNMsO5mPFWiwAIzdXouSF8SW
	 UnTxPcsejXl/A==
Date: Tue, 26 May 2026 15:38:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: chemical: scd30: Cleanup initializations in
 scd30_float_to_fp()
Message-ID: <20260526153842.61e15dfd@jic23-huawei>
In-Reply-To: <CALoEA-w7i4wQR_k9Eb6KPQLiLk6ZVrFmFoY9wHaO+7=ng=H-tg@mail.gmail.com>
References: <20260524020309.18618-1-m32285159@gmail.com>
	<CALoEA-w7i4wQR_k9Eb6KPQLiLk6ZVrFmFoY9wHaO+7=ng=H-tg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 08:49:17 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 24 May 2026 at 04:04, Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > Include linux/bitfield.h for FIELD_GET().
> >
> > Create new macros for bit manipulation in combination with manual bit
> > manipulation being replaced with FIELD_GET().
> >
> > The current variable declaration and initializations are barely readable
> > and use comma separations across multiple lines. Refactor the
> > initializations so that mantissa and exp have separate declarations and
> > sign gets initialized later.  
> 
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>  

Sashiko review of this one is really interesting.  If you fancy doing a bit
of digging it would be good to verify that it is correct on the original
code giving a very wrong answer on 64 bit platforms.

I poked the compiler explorer (https://godbolt.org/) with and without -m32
passed to 64bit gcc. Looks like sashiko is right to me.  However given the way
it is used I think we are in undefined behaviour territory so it might
'work' unless the compiler is feel malicious.

Upshot, verify it for your own understanding and then add a fixes tag
for wherever that issue came from.

https://sashiko.dev/#/patchset/20260524020309.18618-1-m32285159%40gmail.com
> 
> Not really sure, but the title of the commit could be better? Perhaps something
> along the lines of "simplify floating point bit arithmetic". Usually you don't
> need to mention the function name in the title since it can be found
> in the diff.
> 
> > @@ -89,10 +96,15 @@ static int scd30_reset(struct scd30_state *state)
> >  /* simplified float to fixed point conversion with a scaling factor of 0.01 */
> >  static int scd30_float_to_fp(int float32)
> >  {
> > -       int fraction, shift,
> > -           mantissa = float32 & GENMASK(22, 0),
> > -           sign = (float32 & BIT(31)) ? -1 : 1,
> > -           exp = (float32 & ~BIT(31)) >> 23;
> > +       int fraction, shift, sign;
> > +       int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
> > +       int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
> > +
> > +       /* Determine sign of received float based on IEEE 754 standard */  
> 
> IMO this is an unnecessary comment.
> 
> Codewise OK.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

