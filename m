Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24F3D902D;
	Sun, 26 Jul 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090163; cv=none; b=lE3WhHqoEuEsnONKlceO0z/YIO8iUrHAjCIzLjg32fENpJ39tFoRvXOi3FYUtawUiHpbw4+y2HwL8uUPFhJ7plYZxgoyLp67RLvq/YyF2v/m5eDBoypLiHa/qjQHxVNBkT8pGS/xvsZdIKPtXJljH5+w5zHvhkjS8tFuOdE2/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090163; c=relaxed/simple;
	bh=sycNYN/Zpx3AngXNEUMy/Pghd9PMrHie6smcGtpwpRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5der4xwwcyQCzme7PPIDOC3EbpEs7Fch6qXB71NGi9TaarQ2xvRxUaxhvaaREp41mIO58BS6wrCyWczdgASIhZUidIIW81q19Zthx6Uf01FR7cbW341+PRZV6hdT7YnQcLgjoACQF5CTCxUUfcC8jq+ARmK0kjH4GaowCffHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMtOOsuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMtOOsuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D021F000E9;
	Sun, 26 Jul 2026 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785090162;
	bh=Xhf/Ffzu3Uysc2lY5M8EO00iavAGYcNy+7Efwn32KzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TMtOOsuvCOamrpusRFkIWQEaQKP1uIKV94tXtoM33mwtFwZkgPtGK88fMM10qnTMY
	 1gwjVB0ArwthsmFB8GH8z58yZ90tltSTNEamZUM2e4CWRCs6hB4AjHEstcm4t0HfJr
	 MujAr+8mtaW4a/vJn7VVbFUYH0MgTseozLvv4wxirCJvdTX1eYSmcnqwsLEvoHAzoY
	 LQEr/SXkmzqxom2lF18d0Px8OzRn4AOw5aMVa9EUN1fKbH2VLPBw16svlLLldCo93f
	 93MerShIAgr+bJI1rZNjEG2Xd3sp4yxhAB3xHmWX5iPGevKJOBb7/BAKF550GQM8O2
	 QfGRc5Djii6jw==
Date: Sun, 26 Jul 2026 19:22:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mailing list to veml3328 entry
Message-ID: <20260726192237.17cd42ef@jic23-huawei>
In-Reply-To: <2d168bc5-1410-4771-923d-229041913c88@kernel.org>
References: <20260721-veml3328-maitainers-v1-1-8166db77c79c@gmail.com>
	<20260724234301.64660df6@jic23-huawei>
	<2d168bc5-1410-4771-923d-229041913c88@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 13:31:16 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 25/07/2026 00:43, Jonathan Cameron wrote:
> > On Tue, 21 Jul 2026 16:28:19 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >   
> >> Add the IIO mailing list to VEML3328 entry in MAINTAINERS, as it is
> >> standard to do so.
> >>
> >> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> > Hmm. ok I guess, but I can't say I'm enthusiastic about this sort of
> > entry by entry update.
> >   
> 
> No, this is just wrong, please don't do this. The subsystem defines the
> list and tree. Individual drivers should not duplicate the information.
> 
> This is just not only pointless churn but ACTUAL information
> duplication, which is never a positive thing.
> 
I'll drop this, though I think there are arguments both ways on simplicity
vs duplication of info.  Anyhow, I also don't want to see mass patches
removing these lists from subsystem entries without a clear consensus on that
being worth the churn.

> Best regards,
> Krzysztof

