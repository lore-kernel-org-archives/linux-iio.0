Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA62AEE1;
	Sat,  5 Sep 2026 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567052; cv=none; b=dStDosTzjTFK2xMt63TCzsYma55o8MuUMqnZPKz2KdtilFmerW6djFVgJF4yyWXaOkYsn/EoYnq/41hHzizrDwzx1iQPJ/tNTs1q/jQx2qg+Tpw03Bhv6QODgVofnplI2hy08nGcKUMxyia6DDA5h8+YVWZ7obS1zGeNodx325M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567052; c=relaxed/simple;
	bh=nO38fvsU4trfKIU9eJEtU6RjAcMhulR9NDTR7TMCQ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gsbqmse5Oa7ifQQiocVkZjNf7OH4ckTtsEGB/ciyXhe55VcQ3NzajzFQ3TClIwXDeKe6aU5qCfjHRClPWNDWp44fp1dmWOsfLGhoMKlXVLQgyuTlUOGOqKS5K3tfJt+05bdNvZnuQoxnT4aNPZ0aMh6Ks9hr+c/1os4FoNV7TQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcGEIiOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcGEIiOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE651F00A3D;
	Sat,  5 Sep 2026 00:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567051;
	bh=1zc4/dh3iIANSt2hvHxTwW4sXcw+Nh+xC5GGazmy4Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mcGEIiOEAH3IcnEocVy7m23N6TRcjjAvO5LAPilbQfOE+GBqwE0PAL+bhGcfJbuQu
	 +/680egDsxuG96htNViJpYq3sg4uyoeKiz5qMY4BSENqsGxMpoAb4V2/ZFiC5kBXAx
	 DI3NJDj12BHHqwbpxrQ2SShGGfcpBQw+gDYzKki2XvUDMS5BmOzAwDUCXQgPu0LvKJ
	 snagDOFBUphJfFB+LQxkLNsJb+j9G9zzlRHraNUYTgqDvGH7QIWnKWDWD5heK+XrRh
	 YQYZ7RKRUl6hO7Lu6YhxYkiJcS+tQGfC8HlRc3NKLjCgXvwcKewlPLBbJZ36sGiI8G
	 DZJai4WvHRCCw==
Date: Sat, 5 Sep 2026 01:10:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Crt Mori
 <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] iio: temperature: make headers conform to IWYU
Message-ID: <20260905011044.0f37018d@jic23-huawei>
In-Reply-To: <CALoEA-yK8kP6DbPuzh_BnNUnxOU_meAcWWFURMvO6svGBZo2-g@mail.gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
	<CALoEA-wDkFkKVLCkQOvntnw-cD76Gz=MVW6qNJL21Obn+s-wEQ@mail.gmail.com>
	<CALoEA-yK8kP6DbPuzh_BnNUnxOU_meAcWWFURMvO6svGBZo2-g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 09:55:09 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 1 Sept 2026 at 07:09, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > > Changes in v2:
> > > - Add missing headers pointed out by Sashiko.
> > > - Swap <asm/div64.h> for <linux/math64.h> (Jonathan, Andy).
> > > - Squash small reordering patches with iwyu changes.
> > > - Link to v1: https://lore.kernel.org/r/20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com
> > >
> > > ---
> > > Joshua Crofts (11):
> > >       iio: temperature: iqs620at-temp: make headers conform to IWYU
> > >       iio: temperature: ltc2983: reorder headers
> > >       iio: temperature: ltc2983: make headers conform to IWYU
> > >       iio: temperature: mlx90632: make headers conform to IWYU
> > >       iio: temperature: mlx90635: make headers conform to IWYU
> > >       iio: temperature: tmp117: sort headers alphabetically
> > >       iio: temperature: tmp117: make headers conform to IWYU
> > >       iio: temperature: tsys01: reorder headers
> > >       iio: temperature: tsys01: make headers conform to IWYU
> > >       iio: temperature: tsys02d: reorder headers
> > >       iio: temperature: tsys02d: make headers conform to IWYU
> > >
> > >  drivers/iio/temperature/iqs620at-temp.c |  9 +++++++--
> > >  drivers/iio/temperature/ltc2983.c       | 19 +++++++++++++++----
> > >  drivers/iio/temperature/mlx90632.c      | 10 +++++++---
> > >  drivers/iio/temperature/mlx90635.c      | 11 +++++++----
> > >  drivers/iio/temperature/tmp117.c        |  9 +++++----
> > >  drivers/iio/temperature/tsys01.c        | 17 +++++++++++------
> > >  drivers/iio/temperature/tsys02d.c       | 12 +++++++++---
> > >  7 files changed, 61 insertions(+), 26 deletions(-)
> > > ---  
> >
> > I seem to be having b4 issues as this sent v2 again with the same
> > mistakes?  
> 
> Okay, never mind. b4 did send the right series but forgot to bump the version
> number up.
> 
> Anyway, some Sashiko remarks - just commit message issues (forgot to update
> some headers under the ---) + one remark about me including slab.h for
> GFP_KERNEL, but I suppose I could change this to gfp_types.h instead.
> 
Lets not go around the houses for ever.  Close enough to perfect for me.

Applied, thanks!

Jonathan


