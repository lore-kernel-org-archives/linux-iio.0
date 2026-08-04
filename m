Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBE390986;
	Tue,  4 Aug 2026 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884874; cv=none; b=pv2xg09wvpH03m77R6aP9Zf2yjyoAnR0ONydBnQsg64TKXXIjELjrbLGyq6Uy0xlDg6SrJPL1Wyj/rwW5mzOHJ31iBWvPDDGUT6+ZiT+IzwEYO3SGYdBpHcEKCXWA5nlg1NgUoFdPNO/hk8FGuAahK0y9SjW8G+/8RDbTIg6bog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884874; c=relaxed/simple;
	bh=YhgZa/oAAy26IM7PABlGMIcsdUn9LeJ+ZmQ1pnYRnYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDoutcsUSf+FK9JoMvm/8gESeo+Yk/cM+aLNH8fAW1cZ1Hdyhs0MSx20UMvsXMZa5vck5hnp0TQM++lrPpBnsI1KrBr5DdWW+s8bUYXhr/jgPxVZ/qbKmhHaYz3DwBnQxU3vfZ7QTTOZv/ZW1WUYkpVXCMl7PDhqcW5W/xXNLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncLGWdiu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncLGWdiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1ED1F000E9;
	Tue,  4 Aug 2026 23:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785884873;
	bh=YGTMQ7Qj1wgDJyw8TgWUfQsJCzsvTo9xgTmzxYCryq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ncLGWdiueZzhIhq/4dBpjJrD/8FfEk6FTAgVBXaUAvfLdidwxKM4YAJ9uq7e3QXAu
	 3pr6naMEZXe0FDQLvRTDflXc7I4OVZN/GvnEsJvqEjTkdSe/SSNlM8+xlMYylrlUMp
	 GIcXsvja+HBi5Tsq/Z6S4i4Tl2/9P/3W/qlGfzA7o0W5+i8ESlMR0LjX55cvNqxjxm
	 xWQ07Y+ddMjmDZQqLQJh94tNHr2JLizdEtvNd3xsKeZtmCXoTrhSFwrmK+wotdrPvp
	 O1KXOdlOJE4moK3vUJTAtYaJountLb1TbmNUXenXOl1uWRRRHwkPsVZsqR8RLWpyis
	 +geFCpKcQ9Tag==
Date: Wed, 5 Aug 2026 00:07:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 11/17] iio: frequency: ad9910: add basic parallel
 port support
Message-ID: <20260805000746.4a799d04@jic23-huawei>
In-Reply-To: <20260802100400.588fa107@pumpkin>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260729-ad9910-iio-driver-v10-11-aa1f6167729e@analog.com>
	<20260802015607.7d7d4dd8@jic23-huawei>
	<20260802100400.588fa107@pumpkin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 10:04:00 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Sun, 2 Aug 2026 01:56:07 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 29 Jul 2026 09:25:38 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add parallel port support with amplitude, phase and frequency channels.
> > > Those will be buffered capable channels, but only basic control of offset
> > > and scale are implemented at this point. There are separate amplitude
> > > and phase control for polar destination, which will provide different scan
> > > types. Enabling and disabling of parallel mode will be implemented with
> > > buffer setup ops or with update_scan_mode() once IIO backend integration
> > > is in place.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>    
> > Hmm. Curious... clang --version gives 22.1.8 on x86_64.
> > 
> > make LLVM=1 LOCALVERSION= -j12 W=1 C=1
> >   DESCEND objtool
> > Documentation/.renames.txt: warning: ignored by one of the .gitignore files
> >   CC [M]  drivers/iio/frequency/ad9910.o
> > In file included from drivers/iio/frequency/ad9910.c:10:
> > In file included from ./include/linux/clk.h:13:
> > In file included from ./include/linux/kernel.h:26:
> > In file included from ./include/linux/math.h:6:
> > ./arch/x86/include/asm/div64.h:113:8: error: invalid operand for instruction
> >   113 |                 asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
> >       |                      ^
> > <inline asm>:1:7: note: instantiated into assembly here
> >     1 |         addq $2147483648, %rax; adcq $0, %rdx
> >       |              ^~~~~~~~~~~~
> > 1 error generated.
> > make[5]: *** [scripts/Makefile.build:289: drivers/iio/frequency/ad9910.o] Error 1
> > make[4]: *** [scripts/Makefile.build:549: drivers/iio/frequency] Error 2
> > make[3]: *** [scripts/Makefile.build:549: drivers/iio] Error 2
> > make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> > make[1]: *** [/home/jic23/src/kernel/iio/Makefile:2184: .] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> > 
> >   
> > > ---
> > >  drivers/iio/frequency/ad9910.c | 154 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 154 insertions(+)
> > > 
> > > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > > index b41b011af281..aaeff2e7640e 100644
> > > --- a/drivers/iio/frequency/ad9910.c
> > > +++ b/drivers/iio/frequency/ad9910.c    
> > 
> >   
> > >  static int ad9910_read_raw(struct iio_dev *indio_dev,
> > > @@ -691,6 +753,48 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
> > >  			*val = 0;
> > >  			*val2 = tmp64 >> 14;
> > >  			return IIO_VAL_INT_PLUS_NANO;
> > > +		case AD9910_CHAN_IDX_PARALLEL_PHASE:
> > > +			*val = 0;
> > > +			*val2 = AD9910_PI_NANORAD >> 15;
> > > +			return IIO_VAL_INT_PLUS_NANO;
> > > +		case AD9910_CHAN_IDX_PARALLEL_FREQ:
> > > +			tmp32 = FIELD_GET(AD9910_CFR2_FM_GAIN_MSK,
> > > +					  st->reg[AD9910_REG_CFR2].val32);
> > > +			tmp64 = (u64)st->data.sysclk_freq_hz << tmp32;
> > > +			tmp64 = ad9910_rational_scale(tmp64, NANO, BIT_ULL(32));    
> > 
> > Process of elimination points me to this line which is a slim wrapper.
> > 
> > static inline u64 ad9910_rational_scale(u64 input, u64 scale, u64 reference)
> > {
> > 	return mul_u64_add_u64_div_u64(input, scale, reference >> 1, reference);
> > }
> > 
> > David, any thoughts?  
> 
> Lots of instructions only support sign extending 32bit immediates.
> The asm constraint for the ADCQ needs to be "erm" not "irm".
> I bet that is true elsewhere as well.
> 
> See source/arch/x86/include/asm/div64.h line 114
> 
> I'm actually surprised you see it with clang - it usually prefers the "m"
> constraint.
> 
> I'll try to find a source tree that is clean enough to generate a patch.
> 
Thanks!  For anyone following along:

https://lore.kernel.org/all/20260803094702.3852-1-david.laight.linux@gmail.com/

Until David's fix is in a tree I'll hold off on merging this series.

Given timing, that may unfortunately delay it a cycle,

Jonathan

> 	David
> 
> 
> > 
> > For now I'm backing out the series.
> >   
> > > +			*val = div_s64_rem(tmp64, NANO, val2);
> > > +			return IIO_VAL_INT_PLUS_NANO;
> > > +		case AD9910_CHAN_IDX_PARALLEL_POLAR_AMP:
> > > +			tmp64 = (u64)st->data.output_current_uA *
> > > +				AD9910_NANO_MILLIAMP_PER_MICROAMP;
> > > +			*val = 0;
> > > +			*val2 = tmp64 >> 8;
> > > +			return IIO_VAL_INT_PLUS_NANO;
> > > +		case AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE:
> > > +			*val = 0;
> > > +			*val2 = AD9910_PI_NANORAD >> 7;
> > > +			return IIO_VAL_INT_PLUS_NANO;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}    
> 

