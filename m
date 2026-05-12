Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058B385D9D;
	Tue, 12 May 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605686; cv=none; b=nmMqNgII4D+WBO1FFISd+3IdXpRxEjbzGG5xBbSdfMZSeQw7OJu8HR627DP04/8fcapVavXKI/N6l1VK2D8+lbku0jXYILFWo7M9niUGRgJNldzdcz7OhA0kAbbOSZaCLyqs2i3p8RHCPnQQZH9PKMPYQ8Ip7mkDiAH/WRVrPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605686; c=relaxed/simple;
	bh=TzeUqxMc2X+9kTMHzfG5+93t5/KCclwmX+quLLIIrWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqHYqiCvx2ehimUwFNa5jnAqwBgWqh+JVuVaK4IXC/dIlO8eWa2rFDE0/9QEKMZBCekUjZm3LZFuZnV/Q1hLhj6uNHP44/4n2CCW0uoFcLrANnSUhzLyARsHIGvyLLJSEA+Wiv2uND7Fe/I25Z9V/F2CJDx/1VoJZYVdmX89Fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVECPylz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVECPylz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C126AC2BCB0;
	Tue, 12 May 2026 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605686;
	bh=TzeUqxMc2X+9kTMHzfG5+93t5/KCclwmX+quLLIIrWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mVECPylzSM8yhk5xQ5i6BiXWbBBfpmeMyximdOI8xcyWHxXN2xwd2BrP/kMaYQU2v
	 f+eMF/CEMMy6WV1ijvMYKBVlbsHWG3AbLbcpFaUIFfPGSi1hSiZNcRkkAsc2grtvNK
	 tfmDO7UCB04JlTP7P6LuuDaWc2pcpWH04RMRO9F7nJvy0SpaUBiaDy6K/Kw5BO8DS3
	 HR0uv6bUOLFW37GtkL1DjhxexP12pFlBnCNuzKFTGIKk5+LGpyngpPMKzFGekyJCXB
	 u4ZxKI78NDAxcKm6zxXttKv3FUr+Hfh/fNCXY+cwQIkAzoX2V1JGITrOe+uFgpOQ9u
	 UD9d97WJCZarg==
Date: Tue, 12 May 2026 18:07:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mapping file for include-what-you-use tool
Message-ID: <20260512180759.61918948@jic23-huawei>
In-Reply-To: <4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylibre.com>
References: <20260512073505.1310-1-joshua.crofts1@gmail.com>
	<4742ea18-f3df-46dd-aad4-18d1e5f03f7f@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 10:36:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/12/26 2:35 AM, Joshua Crofts wrote:
> > As promised, I'm sending my IWYU mapping file, based on Jonathan's
> > version with a few additional tweaks by me.
> > 
> > Other than adding support for more assembly file business, I've also
> > experimented with individual symbol definition (see BIT() and GENMASK()
> > in the following file) - this is to prevent issues such as the tool
> > wanting you to include <linux/bits.h> when you already have
> > <linux/bitops.h> in the source file (I agree, doing this symbol by
> > symbol is tedious, but BIT() and GENMASK() are symbols that especially
> > do this, and they're included in most, if not all drivers).  
> 
> TBH, I would favor rules that are easy for machines over rules that
> follow existing human conventions. Is there really anything terribly
> wrong with including both bits.h and bitops.h other than "convention"?

If we do want to obey these conventions maybe a wrapper script rather
than making IWYU do all the work?

> 
> > 
> > Feel free to improve this file and pass it on. I wouldn't really fully
> > rely on IWYU as even with the mapping file the results can be weird,
> > but it definitely serves as a good starting point when doing driver
> > cleanup.
> > 
> > I'm making this patch an RFC - this is not intended for merging.
> >   
> Sharing it is nice. Automating it would be amazing.
> 
> Not sure what the best way to do this would be though. I've considered
> the idea of having an IIO linting service that could run iwyu and some
> other checkers that catch common issues, like spaces in { }, where and
> where not to use trailing commas, etc.
> 
> At first, it could just post the results on a public page (like sashisko).
> And if it ends up working well, it could eventually automatically reply
> to patch emails.
> 
> The hardest part would be finding someone willing to host and maintain it.

Absolutely :(  
> 

