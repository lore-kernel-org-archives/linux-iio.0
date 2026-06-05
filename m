Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104A35E1C0;
	Fri,  5 Jun 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668809; cv=none; b=gZpky9pTaYpeakQyKMfvVyYjy7oJ7qwChtGbKQfAsGu6WGh9t8+W/tPeYFtTf+3f5rfUAil0Y4rNqFnooLlb4iZv1UYmHVlq1uurXCFZpwidO5Ae62SlccE1A1LQLC7WAg76A44iizQIOV77381gL71rcSF3uYr3C4HdFn4sids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668809; c=relaxed/simple;
	bh=7wFJ5IkD/rqkXIejOdToxbX4+xkIOaxJhkDI3k9F2TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6TEkSYA9usTPZMei+eOIZ1pPaB23TdcoBDgInbnJmkhWdP6kz7tt4rpHaKVtHqOsk8vRXkeDgH4LOwBMIDTRvC/0Rn7gTxBFxys44ENORUg2rnZ5rGfN3SR518SqijZ3XbXOExuCaJd+6yRDf+RwAeSQ5kgbodfXZvkxxX03hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciRrWfTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciRrWfTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75751F00893;
	Fri,  5 Jun 2026 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780668807;
	bh=YnLjWnBU/ykYm2jI7JAvvpklnyKWG746Upvh99vHdRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ciRrWfTUkxhZgAi8tWkGmWDkp8MlNp8/n8I8m+dJIzG74sUOBYNrw/Ct0UNkBEHQ+
	 BUZAnf7QKSPCNcCWh55deerxD7dshaU1E/apg222VAE4zoCdN8Ovhq3IfZq2S1xHEr
	 gEJu6hwrSgqMR3Z3MKukLzqQWlenpi82KoflijVuLW3WZgDqYe7a7wLsppz2GjEGwE
	 XukiCVQgwiofb4OEA/D0sCW4flnqL24lDA+3w3vSmAPE6m4TuDoWNjV1TL3DBbZ3RO
	 +Bx2QP9/UU6yNyA8BSXdcaTU/CBVprCICxktGx0J5CHMCNPsMaXI2M6bImnKXM4RbX
	 ALVaH/8OZ3/iA==
Date: Fri, 5 Jun 2026 15:13:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Kempe <andreas.kempe@actia.se>
Cc: David Lechner <dlechner@baylibre.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Message-ID: <20260605151320.415cc432@jic23-huawei>
In-Reply-To: <aiLS232YzmDvXhsN@w570anl.actianordic.se>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
	<aiGH7x531jwzOVxF@lore-desk>
	<aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
	<aiGNeKTzOR30w-Qf@lore-desk>
	<aiGZxzz8DF-E-tux@w570anl.actianordic.se>
	<CAMknhBG+u__qiLv0aRLYnUW3iYXkYDLHveQ-bs2gGZfBAD6Viw@mail.gmail.com>
	<aiGmfzaSj3bNyXkM@w570anl.actianordic.se>
	<20260605131518.072dad20@jic23-huawei>
	<aiLS232YzmDvXhsN@w570anl.actianordic.se>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 13:44:59 +0000
Andreas Kempe <andreas.kempe@actia.se> wrote:

> On Fri, Jun 05, 2026 at 01:15:18PM +0100, Jonathan Cameron wrote:
> > On Thu, 4 Jun 2026 16:23:27 +0000
> > Andreas Kempe <andreas.kempe@actia.se> wrote:  
> > > On Thu, Jun 04, 2026 at 06:14:11PM +0200, David Lechner wrote:  
> > > >
> > > > How about setting the SW_RESET bit in the CTRL3_C register during
> > > > probe too to ensure the rest of the registers are in a known state?
> > > >  
> > >
> > > While the shub register file is selected, the reset register is
> > > shadowed so it can't be written without first selecting the normal
> > > register file. A reset is already called from probe in
> > > st_lsm6dsx_init_device() after the whoami check has passed.  
> > 
> > The fix is fine, but I think it shouldn't be buried in the whoami
> > check as it's a bit of a weird side effect.  I'd like a top level
> > function that we can see in probe(). That can do the read + write
> > if necessary sequence you have in this patch.
> > 
> > This driver currently hard rejects unknown wai values (which it probably
> > should not given fallback compatibles should work). Lets assume that will
> > get resolved at somepoint and so the wai gate is advisory only. That
> > means that the dance to avoid writing to a device that doesn't match will
> > no be useful anyway.
> > 
> > As such, I'd prefer this 'reset of the register file mux selector' was
> > part of the reset function and that was simply called before checking
> > WAI.  It fits more logically there than in the whoami check function
> > which is just the first place the unexpected setting causes problems.
> > That is put it in st_lsm6dsx_reset_device() and call that before
> > st_lsm6dsx_check_whoami().  Maybe with a comment to justify that.
> >   
> 
> I agree fully that its current placement in st_lsm6dsx_check_whoami()
> is not optimal.
> 
> The reason I put the fix where it is, is because 
> st_lsm6dsx_check_whoami() is what assigns hw->settings needed for
> st_lsm6dsx_set_page() to work. I moved that assignment to before the
> whoami check for that very reason.
> 
> As I see it, moving my fix to a more reasonable place would mean a
> larger restructuring of the driver or making the whoami check advisory
> per your suggestion.

That feels unwise (even though it would work) as a fix for this issue.
People would get very confused at the informational print.

Ok. I guess maybe this is the best we can do.

Lets see if Lorenzo is happy with earlier part of this thread

Jonathan


> 
> Best regards,
> Andreas Kempe
