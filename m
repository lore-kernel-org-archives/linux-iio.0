Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859A26ED3F;
	Sat, 28 Feb 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296702; cv=none; b=nlY0TIwlFo0vj684eHQtaLsYJMtikM3nEHhYXo9R570bS5FVCjldBJ9C0BS58Q+u7kjbYLX3fdI5mn8YynUC4EtHinUKtk+Yqx1hYLjOuRHys62iHUI/rvgADd6qO3QNRymd+dfvWGPVPC/XH4EWIatWgEbukB2t4is4evOFgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296702; c=relaxed/simple;
	bh=NlLCyfiydTFgH1zaFeYjyuQC5Rn6klYr48HxNOVtw0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abSpn7Jvr5ZJ1JYd4TLmVjnxZoHlALzz70R7ZIYorv6TwGT3gEaHuAoBJjx6ObXvMDM1CXZbHEqp4U8eimZhzLRwb6HdaQALpdarxeG5nI+HS9iY0Xw4iTBlqlDHdHie0503KvYuDWsoqKQjofmqKQGf+lz9nA8CSUMEvo6NI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+f2xPxz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+f2xPxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6950DC116D0;
	Sat, 28 Feb 2026 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296702;
	bh=NlLCyfiydTFgH1zaFeYjyuQC5Rn6klYr48HxNOVtw0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+f2xPxzOn3BAKLv3q6P2n9ZpwwocZryhrnYmFgJdVTk85F+9I3Nfik1FQ+mkjW1F
	 B/LaX0GM3qt4cOJ2MSjj7MIdqi+dvDh1yJYq7TCWVDxmIh2Jld95xvtXWEDJ4vhk7T
	 KOvSdAcNgdgSLFL1i5qLQb03TAaNOqqPSqP50cXzpR0EYwKI2QPbtAZjgXRUdsdpj8
	 8GIdyNWpfv9Ey8l/LJKv0GKbcu2VDI5tT+98+cV3oDl2jtZLmacCoqopxEkkm6x6dB
	 qdOBDwpFhPUb4y3z3PHwkPVVcXFLLq52+YNctDEagayNY07TuC4hBujaRiBa1t+Hbg
	 CJsjbCEgwB55Q==
Date: Sat, 28 Feb 2026 16:38:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Francesco Lavra
 <flavra@baylibre.com>, Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <20260228163813.1b693ee1@jic23-huawei>
In-Reply-To: <aaAYsblcnf4SEe_X@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
	<20260225101711.2368206-1-flavra@baylibre.com>
	<aZ7fbdpWRFsvpGWf@smile.fi.intel.com>
	<CAMuHMdXMOvWQ1T8CMDvR5XFBxO8m1ai8m982R8Nyf9LXiE7K5Q@mail.gmail.com>
	<aaAYsblcnf4SEe_X@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 11:56:01 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Feb 26, 2026 at 10:43:34AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 25 Feb 2026 at 12:42, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:  
> > > On Wed, Feb 25, 2026 at 11:17:11AM +0100, Francesco Lavra wrote:  
> 
> ...
> 
> > > > -     u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> > > > +     struct {
> > > > +             union {
> > > > +                     __le16 data[3];
> > > > +                     __le32 fifo_ts;
> > > > +             };
> > > > +             aligned_s64 timestamp;
> > > > +     } iio_buff = { };  
> > >
> > > Hmm... Have you considered m68k case? IIRC there the alignment is 2 (even for
> > > 64-bit members), so theoretically the beginning of the structure can be aligned
> > > to address 2. and hence the __le16 data[3] will have no gap to the following
> > > timestamp. In current code it's 64-bit and not 48-bit item.  
> > 
> > Fortunately, the layout of a structure does not change because the
> > first member could be stored at a less-aligned address, as that would
> > make it incompatible with a different instance that is stored at a
> > differently-aligned address ;-)
> > 
> > The alignment of a structure is the maximum of the alignments of its
> > members.  So that will be 8 bytes, as the aligned_s64 definition has
> > an internal "__attribute__((aligned(8)))".  
> 
> Thanks for the elaboration on this case, my knowledge about m68k is too shallow!
> 
> > It would be wise to add explicit padding ("u16 pad") just before
> > timestamp though, for documentation purpose.  
> 
> __le16 :-) Something like this:
> 
>      struct {
>              union {
> 	             __le16 data[3];
>                      __le32 fifo_ts;
>              };
> 	     __le16 reserved; // ...compatibility with the previous impl...

We typically haven't done this.  I'm not sure why this driver justifies it
as IIO timestamp placement always relies on the set of rules Geert has
laid out.

Also if we did do it, applying an endianness to reserve data is a an odd 
thing to do.

So as far a I'm concerned the approach in this patch seems fine.

Thanks,

Jonathan

>              aligned_s64 timestamp;
>      } iio_buff = { };
> 
> ?
> 

