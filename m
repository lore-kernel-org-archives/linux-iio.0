Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340C346E7D;
	Mon, 27 Jul 2026 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118726; cv=none; b=F6v7zif6mKvWN6bHnSFnyatbNTjgJtMANTxibTh7GzzwgOBx+h47D8uLiXhtH1vmc3cI/V0KMXAAqutR2JDee0FFWIUFALXHE7hGnMTWTszVZePT9Oky5NJ/8lP3jbm/iLRkMLly9xkVxQNCmQO7lmBU3o+3V57LBfHOlyGjN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118726; c=relaxed/simple;
	bh=HWBsGfzqCx/iPrhlOvwCgi88ssWC5dl12uyPbMpNfF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvkiLTixSYd4Ww6xGmUs1q7e3xrEvUQzhwcIzye8giSy9QU8i+EMVWpSedFioXrG4MTPywJKMOY7OtQ0SyNyeXWrCBX8n93oXGTLZ7Lgm9wqYoA+/ek8S6zo+8hfutO9Rn5Z9eO8LXWymxzgOHoRXD87yMbEcKnXuJ3ml2/gPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UClm3Hap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UClm3Hap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237A11F000E9;
	Mon, 27 Jul 2026 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785118725;
	bh=j+SDgml2liz3wAz3hskno6rqwwr955T1RRgDiSpOF4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UClm3HapUy96B50HrhcCOR81UmtyEOe6bJGYJ2+dofM/R6fP/SdZyPRcGDdfbZMsD
	 PSRX6r7GTA37kboJBWr/Y/pIB+cSoptxDNob8/CFOqkulRUNkpddTU1JYlyJ9A3SQz
	 yIY9TCMmEZwqxhBsUYRp1S/kIEPXtgd+HZEoBp5+LB4Cx0TLxEm+98M+rMhblR7iFw
	 2igMAj9nskw980e5+9TZOc8iGnYGSZV5fvx5MwrlxPHjSJbgJ2RXOsel2zr5WPrI1z
	 GOmIEs1tBe8QJvRmGeAjqxhW+wKTObxxYdoEyHstyzqM3U9Nz3JutAmoLeYDd8D5wx
	 yfvvPsPdV/IBQ==
Date: Mon, 27 Jul 2026 03:18:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Babanpreet Singh <bbnpreetsingh@gmail.com>, Petre Rodan
 <petre.rodan@subdimension.ro>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: abp2030pa: Remove unreachable return in
 abp2_read_raw()
Message-ID: <20260727031832.484af15f@jic23-huawei>
In-Reply-To: <d11e5b35268c4ec044c24c22cbfd816a9072edda.camel@linux.dev>
References: <20260726072234.7-1-bbnpreetsingh@gmail.com>
	<d11e5b35268c4ec044c24c22cbfd816a9072edda.camel@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 15:42:55 +0600
Siratul Islam <siratul.islam@linux.dev> wrote:

> On Sun, 2026-07-26 at 07:22 +0000, Babanpreet Singh wrote:
> > In the IIO_CHAN_INFO_RAW case every arm of the inner switch on
> > channel->type returns - IIO_PRESSURE and IIO_TEMP return IIO_VAL_INT and
> > default returns -EINVAL - so the "return IIO_VAL_INT;" following that
> > switch cannot be reached. The sibling IIO_CHAN_INFO_SCALE and
> > IIO_CHAN_INFO_OFFSET cases have the same shape and no trailing return,
> > so drop it here as well.

A bit too much detail.  Just saying they all already returned is fine;
we don't need to know what was returned.


> > 
> > Found by smatch:
> > drivers/iio/pressure/abp2030pa.c:382 abp2_read_raw() warn: ignoring unreachable code.
> > 
> > No functional change: the compiler already discarded the statement, and
> > the generated object code is identical before and after.
Sensible check to perform but no need to state it in the patch description.

I tweaked the description whilst applying.

Applied to the testing branch of iio.git on git.kernel.org

Thanks

Jonathan

> > 
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> > ---
> >   
> LGTM.
> 
> Reviewed-by: Siratul Islam <siratul.islam@linux.dev>
> 
> --
> Best regards,
> Sirat

