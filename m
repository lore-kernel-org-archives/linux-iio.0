Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7E3438BE
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661449; cv=none; b=mFtouWLZp5l9OPVTi1Oj5n6cr7V1oW2MSsKfS8v1Y+pvlY3+6ym/t6FjbFoj9G1lMS+F09Byap5iHDiVOAd/lQTkF6QjGXsfFuCpSugiFa9iBIe3iVofl18rvZtZR9ZG14sDf6/9r4l4pv3p5I/81xU7QUHIXIy8884xYMwIGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661449; c=relaxed/simple;
	bh=XoqwTzBTDw0ldPHh8ANmlH4Zu4YUOeLFd2ixic5ddNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvsk/FScLh2we8TdSnfXfJezmopIOrvdCU2EKbsExuRZxVvko3r0XgBD8qWaqkHMwAIci5H9agUOtkKTkgufWec/RryUeN5J6ch10vC1vN0Z0Q3JFYifwjcUMU23w5teAUtMycVP19LmmREB0QO9tgKZBVJYzY8d5X8DbnPjhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lStp2W/D; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lStp2W/D"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-476a130c138so2717561f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785661445; x=1786266245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KLNngFHUaW4FMnMMnOZ4ee/Vyns/yW+WufUQsHnkGgI=;
        b=lStp2W/DxU44DcfIaqwGkszwmLSUYfjd6d1nZmvUTu9qDyc5YrR55OQM/qelXZAiym
         snP1KDyR3CBcf24WNAKvGZU1+MjMF3uBoB2FVnEvyUkqPHEjWJbAAIeID/xVf7aGK8wS
         wBdaquxyj7LsasO2ziK0lxo/ovcnWfdfMHIu6/EOO8nSIOsrnKssImg03jLud3y4Jiw/
         bBoJKnnLCjFv+L0Suv+JTAYZL+ZHgK9T68mJwoDM0nGH+tNou6recLCy3sSEx1+h48OF
         JGhaTu2cM2w21wvhrAkoZc4/YW4x/zzn3zSG68evkH9DkYmOoJ8ZDZZwHwBtZnJQP6gU
         XEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785661445; x=1786266245;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLNngFHUaW4FMnMMnOZ4ee/Vyns/yW+WufUQsHnkGgI=;
        b=sN2f+EOF/QlPqV5pfvHYZXykRuVfqAnv/H4+6+e2TDXxKtpQ1QqPipuDs5XWT296b2
         wfcvTQz3lvZBXaZd3tyrVv4eS/uU/bPfhXhaVNos9NmffRu6ptcwcIGBC74c8qquh0Lb
         4hb/TDgCS1xSY7JFezoLQVcSlXwaCDXjasmKExmTrAE++EGqGHFvvcS8zwAhRKCsjuFg
         v0dpGty4Ah8RTz6QKsRlxAAH8vnWbD1ZvgbALOyPQ/oHr2RdS8t3GNh7qF/rYukKHj91
         r7Ntq1d0ubJfT2ZKSYA+0//NiHdortkA5tYp22aYWOXeqXuMHgA8At/O6cZGPUf7Rx8F
         SAUA==
X-Forwarded-Encrypted: i=1; AHgh+RpPr3/+FfsVSCbLNOu8nq8xIkPHK15K7W29/lDlkCj0ZTJE/nNdUgEq7OIMbciTksVVC+M7aKomy88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFj6LKgTJKbwEa4W/qpCs9ooZRA2hjVZ+dkdZ0pZupT8dH0M5
	IKJBmyXjGt2nAxse9mrOPm3o326m2lp350TRNNbE220w5VZxgN1ynPuA
X-Gm-Gg: AR+sD106ZMsmb+K/JepqfMrqfGEwo6zM2U+Kt78Bj4gXBWL1sYwehdAP1gTov3xwBTz
	yzkZSl1tdXTjS9VPQQhMPKy+ag51FFvC2Hf0iufowqGObFd3zbqgDt1G74hIBN8vRlk5bhfelhj
	aATA8vl5FnQenTraQdxCV6rZHZvkk6wtECmhgTDEgHKDa/LzV2qx6fpLWEPKG2ZcfEN5q7afX76
	U4+Ip/0IxaHAb7Y14Z9Gj3xMkVSJDk+FyYoPELqZ73WLVmy8Lsi56Y2+2NusG0dVRR1/Nx5Inyy
	Kl+w/BcPADULzt3E2CemrodFnPI9SOtaf289LSRae1omaQHwpGScJtod5p/yCbMY+sdWdZY8lPu
	Jx6/Pv5PEozQwIXUE3BVyhspJ6F1zS2pZlunS7awPUKqpb8DdxbVVWAY/dMRYMXUEAQnb25UsCT
	3hsQMY2WDwFUK2ETe1ZH9YUsqYIxngElQeXLrzEUsjxpAIB1jYkc9JdKgNAqep01S9ZFpbLD/+y
	HzLIHlqU15DopRGkAjFwp6iCw==
X-Received: by 2002:a05:6000:2dc5:b0:47f:34ba:2d0d with SMTP id ffacd0b85a97d-47fd72a9061mr14609516f8f.8.1785661445068;
        Sun, 02 Aug 2026 02:04:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562a38sm22160461f8f.21.2026.08.02.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:04:04 -0700 (PDT)
Date: Sun, 2 Aug 2026 10:04:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20260802100400.588fa107@pumpkin>
In-Reply-To: <20260802015607.7d7d4dd8@jic23-huawei>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260729-ad9910-iio-driver-v10-11-aa1f6167729e@analog.com>
	<20260802015607.7d7d4dd8@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 01:56:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 29 Jul 2026 09:25:38 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add parallel port support with amplitude, phase and frequency channels.
> > Those will be buffered capable channels, but only basic control of offset
> > and scale are implemented at this point. There are separate amplitude
> > and phase control for polar destination, which will provide different scan
> > types. Enabling and disabling of parallel mode will be implemented with
> > buffer setup ops or with update_scan_mode() once IIO backend integration
> > is in place.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> Hmm. Curious... clang --version gives 22.1.8 on x86_64.
> 
> make LLVM=1 LOCALVERSION= -j12 W=1 C=1
>   DESCEND objtool
> Documentation/.renames.txt: warning: ignored by one of the .gitignore files
>   CC [M]  drivers/iio/frequency/ad9910.o
> In file included from drivers/iio/frequency/ad9910.c:10:
> In file included from ./include/linux/clk.h:13:
> In file included from ./include/linux/kernel.h:26:
> In file included from ./include/linux/math.h:6:
> ./arch/x86/include/asm/div64.h:113:8: error: invalid operand for instruction
>   113 |                 asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
>       |                      ^
> <inline asm>:1:7: note: instantiated into assembly here
>     1 |         addq $2147483648, %rax; adcq $0, %rdx
>       |              ^~~~~~~~~~~~
> 1 error generated.
> make[5]: *** [scripts/Makefile.build:289: drivers/iio/frequency/ad9910.o] Error 1
> make[4]: *** [scripts/Makefile.build:549: drivers/iio/frequency] Error 2
> make[3]: *** [scripts/Makefile.build:549: drivers/iio] Error 2
> make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> make[1]: *** [/home/jic23/src/kernel/iio/Makefile:2184: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> 
> > ---
> >  drivers/iio/frequency/ad9910.c | 154 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> > 
> > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > index b41b011af281..aaeff2e7640e 100644
> > --- a/drivers/iio/frequency/ad9910.c
> > +++ b/drivers/iio/frequency/ad9910.c  
> 
> 
> >  static int ad9910_read_raw(struct iio_dev *indio_dev,
> > @@ -691,6 +753,48 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
> >  			*val = 0;
> >  			*val2 = tmp64 >> 14;
> >  			return IIO_VAL_INT_PLUS_NANO;
> > +		case AD9910_CHAN_IDX_PARALLEL_PHASE:
> > +			*val = 0;
> > +			*val2 = AD9910_PI_NANORAD >> 15;
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		case AD9910_CHAN_IDX_PARALLEL_FREQ:
> > +			tmp32 = FIELD_GET(AD9910_CFR2_FM_GAIN_MSK,
> > +					  st->reg[AD9910_REG_CFR2].val32);
> > +			tmp64 = (u64)st->data.sysclk_freq_hz << tmp32;
> > +			tmp64 = ad9910_rational_scale(tmp64, NANO, BIT_ULL(32));  
> 
> Process of elimination points me to this line which is a slim wrapper.
> 
> static inline u64 ad9910_rational_scale(u64 input, u64 scale, u64 reference)
> {
> 	return mul_u64_add_u64_div_u64(input, scale, reference >> 1, reference);
> }
> 
> David, any thoughts?

Lots of instructions only support sign extending 32bit immediates.
The asm constraint for the ADCQ needs to be "erm" not "irm".
I bet that is true elsewhere as well.

See source/arch/x86/include/asm/div64.h line 114

I'm actually surprised you see it with clang - it usually prefers the "m"
constraint.

I'll try to find a source tree that is clean enough to generate a patch.

	David


> 
> For now I'm backing out the series.
> 
> > +			*val = div_s64_rem(tmp64, NANO, val2);
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		case AD9910_CHAN_IDX_PARALLEL_POLAR_AMP:
> > +			tmp64 = (u64)st->data.output_current_uA *
> > +				AD9910_NANO_MILLIAMP_PER_MICROAMP;
> > +			*val = 0;
> > +			*val2 = tmp64 >> 8;
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		case AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE:
> > +			*val = 0;
> > +			*val2 = AD9910_PI_NANORAD >> 7;
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		default:
> > +			return -EINVAL;
> > +		}  

