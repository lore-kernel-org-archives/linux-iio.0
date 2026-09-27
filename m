Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861232749DA;
	Sun, 27 Sep 2026 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542486; cv=none; b=Jhm39VQ/fvZr0WvRAeFeqmZEPzo3SGKCEJ4vUuahwcMrL6qzE2Ko0dkF7O1A7fRe5VMeImuR2kw7o6/1+kvbz6GG4Sr2At65ywvVodi02IKr6hu+/WOUgnifqzNY04EAUOsqNrgO7QHYSWWU0aNN8pG9sC0FODZIohgsZxzsGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542486; c=relaxed/simple;
	bh=eDhAy9YHmIef5PpfyCD64Nr4jmVPtByYuE1CUwsNxJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev8WDiqcDnB2PcOklOjMMp64Xj87XwMQoF6PO7n9jEB0P/zQTH1unDK8NwGUm6qR86I8fwYBg6aHE8V8xXzZJm1c/eZnEhlpv1mbsrOlaRjS4SU4jxcFLLX9rKCKD9/xlgsRhfKq3VMA2+T34W0Iw4/HT+Mf5zfzfcrWf4RTdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii3EmcsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii3EmcsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D9D1F000FF;
	Sun, 27 Sep 2026 20:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542485;
	bh=dZlVlrWmYn5obEhkkIyxRmaEYWIhRBRACfJcNiKJbyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ii3EmcsYyfc9E3R/vAOTSTwh+qRmcHYJhBnziMmGGhyomrnZYcVx2m33wpEk22lJb
	 jzImmP7ciQXmt42JX2YnxLYJQVxcq3YDXuikOyeGInNQfQCEksiH2qkA12EVS3z5NB
	 oWbtYyLbjR+HjNZdpxEtEqQAHmJUGfZOlDJfY0L7LpfDqFW9sLz6qyhnhgydYCAyrk
	 ROF/eJFGB+7Gl1MV+66VXod5SJGgMSSxT9mW6APn7dtFPPdUWAgtkKeXxjGqkvinNq
	 inaBk02TrgSPKtd1DdFHMab/qo8bRQHRMeNfCbU+Uva6BIcXHr3np8bDcZk2hAZ96J
	 1bRf2jKy4BVHw==
Date: Sun, 27 Sep 2026 21:54:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ivan A. Melnikov" <iv@altlinux.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Francesco Lavra <flavra@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tools: Use proper macro to detect _Float16 support
Message-ID: <20260927215438.115ca189@jic23-hlaptop>
In-Reply-To: <arEDbA8fIxR6mrZq@iv-work>
References: <20260918161305.1161852-1-iv@altlinux.org>
	<20260919113945.2bee973b@systembl0wer>
	<arEDbA8fIxR6mrZq@iv-work>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 15:33:55 +0400
"Ivan A. Melnikov" <iv@altlinux.org> wrote:

> On Sat, Sep 19, 2026 at 11:39:45AM +0200, Joshua Crofts wrote:
> > On Fri, 18 Sep 2026 20:13:02 +0400
> > "Ivan A. Melnikov" <iv@altlinux.org> wrote:
> >   
> > > __FLT16_MAX__ is an internal compiler macro. GCC defines it if
> > > _Float16 is supported by the target in general, but the support
> > > may depend on the exact target options. For example, on i586
> > > without -msse2 I get the following error from GCC15:
> > > 
> > >   iio_generic_buffer.c: In function 'print2byte':
> > >   iio_generic_buffer.c:141:17: error: invalid conversion from type '_Float16' without option '-msse2'
> > >     141 |                 printf("%05f ", ((float)converter.f + info->offset) * info->scale);
> > >         |                 ^~~~~~
> > > 
> > > To fix that, use the public macro without double underscores.
> > > 
> > > Fixes: cdd445d4b2a9 ("iio: tools: Add support for floating-point types in buffer scan elements")
> > > Signed-off-by: Ivan A. Melnikov <iv@altlinux.org>
> > > ---
> > >  tools/iio/iio_generic_buffer.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> > > index 000193612aad..9ea93984e0e9 100644
> > > --- a/tools/iio/iio_generic_buffer.c
> > > +++ b/tools/iio/iio_generic_buffer.c
> > > @@ -131,7 +131,7 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
> > >  		printf("%05f ", ((float)input + info->offset) * info->scale);
> > >  		break;
> > >  	case 'f': {
> > > -#if defined(__FLT16_MAX__)
> > > +#if defined(FLT16_MAX)
> > >  		union {
> > >  			uint16_t u;
> > >  			_Float16 f;  
> > 
> > One Sashiko issue:
> > 
> > Does this unintentionally disable _Float16 support for all architectures?  
> 
> Indeed, it does. Sorry, my patch is incorrect. I must have completely
> messed up all my checks on Friday.
> 
> > Since the tools build environment uses gnu11 compilation flags without
> > explicitly defining __STDC_WANT_IEC_60559_TYPES_EXT__, FLT16_MAX is
> > undefined across all architectures. This causes the preprocessor to skip
> > this block entirely, causing the tool to always print 
> > <unsupported 2-byte float> for 16-bit float data, even on platforms where 
> > native support previously worked.
> > 
> > If FLT16_MAX were actually defined, the compiler would still parse the
> > _Float16 block and throw the same missing -msse2 compilation error mentioned
> > in the commit message. Is there an alternative way to check for hardware
> > support without completely disabling the feature?  
> 
> Apparently, the only correct way to detect _Float16 is to try compiling
> some code that uses it. For that, a feature can be added to tools/build.
> 
> On other hand, x86 without SSE2 is the only platform I could find where
> __FLT16_MAX__ is defined, but _Float16 does not work, so a simple
> platform-specific workaround would also work and would be much less
> elaborate.
> 
> WDYT?
I would do it properly.  Avoids problems with what is defined for architectures
changing in the future.

Thanks,

Jonathan

> 

