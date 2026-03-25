Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DF2EBB86
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421474; cv=none; b=XVaLfJ+Xd3owXPRGIky8HSQkaCr/XKt5WYYBc6MEd076gIxIr/jv/kOjATwjMfesSbtzNnOk+1cjQaxszlhC2YVe8GYiJvBOsHBy4dFG90ls92M56Ynxhr37/tECkUMEvErGyAQxRYBSNVu9e4mRae3Ad/fU3ajRglppPcpDv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421474; c=relaxed/simple;
	bh=a9L+x+A71AqHzDfc96UA3vrt2kBTKbIuPN7tQU0/uv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emO+Z4zGry+r3kE4hVCTQcjGDLqtJH+fM9p73PDSwhdLnTnjhS3EW6qVZHJXvSy/floTp1DIPA3iw2Laqt5+UHKkeU3Asa8ofrPIGPoCOPY818u1zRhXymkQcBE+UtfRy0W7YZVM1baSF2xk3vWbWC1LJwMPoRI5fEy0g14IIOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4DRveGR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4DRveGR"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a893d289bso2353735b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774421472; x=1775026272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LJV4sPnSyU9J1R56dTKZzRwNtdmeA7clljGd62UrdE=;
        b=n4DRveGRnris+dMf5AqmVBuv0UBOlJAdxm6CCju6la7VriFieZ8UrWCLQf9Yor6HsI
         1AFWIKnRkkpDX7SwLTo4zVVDcvYXlcOaE6dqj7XwoqihoPE70HsUmDlvvuOjFCi9z4QW
         2LsB9Mp8PpkzHdQZhrrWQzveT01SHSvFp/ZYG4o5SMMQ3rXYV5mXnjDP5bYcrDbI4cy7
         uWeBHkoeaAkQa9dnTKEXpkdCzNaXD/lpDuPK1TrB2dQwJxiFzJz5a/wfNNtDh2QOSSB1
         8aZTp+NFRBhgqUXVoB3OnaYBMUupzr+LA1lCeXUsAlEgS5e+nNijnI0YTJMPtM333Tr3
         SGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774421472; x=1775026272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LJV4sPnSyU9J1R56dTKZzRwNtdmeA7clljGd62UrdE=;
        b=M+2BgbQ1x7WqIzNTJubGXON4qkoIMqYQ76hlGr+7v0ux28XrcGSyHxCigj1BzHQrEJ
         C2ZF0+TlSWsz120Fkwz6eL6KKA6Htq1hMTNhNxQQ4KY8DZsJfpILbXXsRZDGHetPYJkX
         uGiU2mUjRxgWaEExUsbzXfLtrxCvqNoNZytaTrhTwy1Ii078RXIAZcqwpSnys0KbkBC3
         5detzHkFA45tqfYigFtef3OXJVWXJoFy1hPW6b0hhOyGJkSA/mfSnugpsBL29dWZmPGZ
         ONGTImil3BwQsCOwpIC1kM0z3tHqkkrcc6zpIpzf7NhqSMUBHqrnik5mi93rA4MkcQ1u
         kQ3A==
X-Gm-Message-State: AOJu0YwhXeJ3M8iUPanCYfd9CHPNDjfUIo+MjmeUVLgLUPlaDEjj0ekg
	aqof2KPbVV69P5kA9u6/+AAM86RXbGGsouMOXgM/vMnJCq9+6ZP3zlk=
X-Gm-Gg: ATEYQzz1KPjsjLORzJ4QvugoWK4biRqJxr9YMwgEDY4Hgdm24Zw1uCTwV5B0UzwszNR
	bRroQ8Hzk93ujAyL0KxA2EmWX5IkK2O7ykuc4Gnnj8S08piMJOcoorThrmWqNpaf8Ny+Fsj9nA6
	w841MR8hYmEtYnGnEZDe/D/jJQh6JjA7BQucAGk2ZJmVlHD1b3pnqaAhGT81raZpPqGc1sd6gvu
	8yCHU7axSnQ9zml3yROVGcInPnHARgBQRJEO39ig0q+sMBpY5sbYRkj1/dehtEzxW0kAaQrKq8E
	q7p0IPWt50t7vERk/KNh19ENxXc95IeSzRWT02Xg4YADNegN1RY7ouaueqrjODHPOfd5RNCuuCy
	feAmwLHXgOuZX4YJSvcvC8S3M5vjNLrE5x7Uinw3ezUeTIdMZpmKJFrxVWYvtStKEydKI6Pm+ul
	XnfVSmzQiDupxcQXYONSSTck8TwIL0W210HDKtGtlqnETsT0URMDJhEfa1I1TY6nUapD+JcL2/Q
	1sRQf1es2SEXdtdTE8Rl/5qlvifyleh9Pg3lj6Z6xrCh6k1OKxawWOCOc2eHgGt
X-Received: by 2002:a05:6a00:3e0e:b0:829:9130:e689 with SMTP id d2e1a72fcca58-82c6dea6a4bmr2282908b3a.15.1774421472260;
        Tue, 24 Mar 2026 23:51:12 -0700 (PDT)
Received: from localhost (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da9c3sm14336233b3a.44.2026.03.24.23.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:51:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:21:39 +0530
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, anshulusr@gmail.com
Subject: Re: [PATCH] iio: dac: mcp4821: add configurable gain support
Message-ID: <acOF-wN2Diwm_W2E@nik>
References: <20260319165216.351668-1-nikhilgtr@gmail.com>
 <20260321180707.73a7ad60@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260321180707.73a7ad60@jic23-huawei>

On Sat, Mar 21, 2026 at 06:07:07PM +0000, Jonathan Cameron wrote:
> On Thu, 19 Mar 2026 22:22:16 +0530
> Nikhil Gautam <nikhilgtr@gmail.com> wrote:
> 

Hi Jonathan,

Thank you for the detailed review, that’s very helpful.

> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/types.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/spi/spi.h>
> > -
> > -#include <linux/iio/iio.h>
> > -#include <linux/iio/types.h>
> > -
> Hi Nikhil,
> 
> Don't do code recorganization in a patch doing anything else.
> Also, it's fairly common convention to have subsystem specific headers
> in a block at the end for a driver in that subsystem.
> >  #include <linux/unaligned.h>
> This is the oddity.  Was a result of a mass change from
> asm/unaligned.h to this that didn't include reordering headers.
> 
> Given you are touching the driver anyway, it's fine to move that up to
> under spi.h, but should still be a seperate patch.
> 
Understood. I agree this wasn’t appropriate to mix with functional changes.
I’ll drop the header reordering from this patch, and if needed,
will send a separate cleanup patch that moves linux/unaligned.h to a more sensible location.

> 
> >  
> >  #define MCP4821_ACTIVE_MODE BIT(12)
> >  #define MCP4802_SECOND_CHAN BIT(15)
> > +#define MCP4821_GAIN_ENABLE BIT(13)
> 
> Put this in order. So above MCP4802_SECOND_CHAN
> >  
Agreed. I’ll reorder the defines so the gain bit is placed logically alongside the other command bits,
before MCP4802_SECOND_CHAN. 

> > -#define MCP4821_CHAN(channel_id, resolution)                          \
> > -	{                                                             \
> > -		.type = IIO_VOLTAGE, .output = 1, .indexed = 1,       \
> > -		.channel = (channel_id),                              \
> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
> > -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> > -		.scan_type = {                                        \
> > -			.realbits = (resolution),                     \
> > -			.shift = 12 - (resolution),                   \
> > -		},                                                    \
> > +#define MCP4821_CHAN(channel_id, resolution)					\
> > +	{															\
> > +		.type = IIO_VOLTAGE, .output = 1, .indexed = 1,			\
> > +		.channel = (channel_id),								\
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> > +			BIT(IIO_CHAN_INFO_CALIBSCALE),						\
> > +	    .info_mask_shared_by_type_available =					\
> > +			BIT(IIO_CHAN_INFO_CALIBSCALE),						\
> > +		.scan_type = {											\
> > +			.realbits = (resolution),							\
> > +			.shift = 12 - (resolution),							\
> > +		},														\
> >  	}
> No idea what went wrong formatting wise here, but that needs to go back to normal!
>
Yes, that was accidental and slipped through during editing. I’ll restore the original formatting style

> Why is it calibscale as opposed to scale?  A x2 multiplier presumably affects the
> scale userspace should apply? calibbscale is for adjusting due to minor device differences
> not this sort of major range adjustment.
>
Thanks for the clarification. You’re right exposing the gain selection via calibscale was incorrect.
The GA bit changes the voltage‑per‑LSB and therefore the scale userspace should apply.
I will switch this to use selectable IIO_CHAN_INFO_SCALE values with scale_available, and remove all use of calibscale.

> > +
> >  	default:
> > -		return -EINVAL;
> > +		break;
> >  	}
> > +	return -EINVAL;
> 
> Why?  Original code was at least as good if not better.
>
Agreed. The original structure was clearer.
I’ll move the EINVAL returns back into the default case and avoid the extra break.

> >  }
> >  
> > +	default:
> > +		break;
> >  	}
> > +	return -EINVAL;
> Move that up into the default. 
> 
Sure, will move that up.

I’ll post a revised version addressing all of the above.

Thanks again for the review.

Best regards,
Nikhil
