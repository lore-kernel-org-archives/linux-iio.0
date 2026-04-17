Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5231B810
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455040; cv=none; b=m9q4Hmc41dclnI4sPRvqzbSwzM7u72KToBy+TjHqXXnP2l2uTtHEzpgsoVvC8+9R9zYc+K31Um8TdK2xM9mIvyWx10wBxJdBS0hTJ3ycCFzA7lA3dJpkdqu1rL/FCb6K8EuWD/bx80OhRtHE4YZ0uU0LvrSmWbD163ttRAWep4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455040; c=relaxed/simple;
	bh=KaFMDCFH9CdumsHQVkzpXcZ16qLlfuRi8NWo/FeNfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBKT1Sgsgak+oAvFvHqRD0MfBrNGGsI/dbIz0s3+ZVvMLFcDjsAtlHEGW7NrKVYcfmWpIHHulwnHMlrtKQL7KBzN5SH5EP0W57pUTNv6D2Oqp3blB41AlHa8jA8HDLVzuyHQWEpKT3IfkrPz1IauLCQ6xxxc4wrzcM9DjewQXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htHi75iS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htHi75iS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso6508835e9.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455037; x=1777059837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSJKJdhPF/oSEv0Q3RwysZnU9Ji4VqpvQLZ2wVMqphA=;
        b=htHi75iSbURVMZ6Xk9C/IrGjBnOFBWNfL2XmrCASRM+7fW23utl/LnXbfsSHB5bDuY
         p+JrBm3aDjplc/i+J+r+5z3cqZYRptIqbxLk4d2Fs+yDPu6pdSVhKrJvJ+PsyNXkDq8Y
         g1KMYTwZhGj3NXZxDotQEs15pNW1EocuyHt11lGYxOUqKuT1I0nP1Z3vqRpAp+1nxcdn
         u5qYKEtx9eWSjtv+po3EklPDjX5B4dyPS8B3N301kbz6KWAK7z2PDbb39K3lJoEnTUyX
         97wf6Z+bFsq0LOcC+MBtKcORuqrcPUAoc9J2Btom1LDSSbQv8je6lVjNxJkMmHQyu4UJ
         Av+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455037; x=1777059837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSJKJdhPF/oSEv0Q3RwysZnU9Ji4VqpvQLZ2wVMqphA=;
        b=hVBXpqGL5OelGbwHKWdGoI/q4nuJn23ht23YlLnchU06hn+fj7kB6NHaPQ33E1tOxD
         LArq/mvmSKlTJj8PA49ROKrIuf5yQSxqeaW6CBAnD/vflnfwqW1QJGFDXKkneJjuJVwC
         ihRUBnCZwt204CBcLYKlrdsn+/4y757qjqCeKjUGSLf9rVJvvP0N1fe968gQOwackzdE
         izDQcCK18jFiWiTLv2XQm+OxRud4f5pmU5NOlqY4d28F00R8ptlDti4xLLCUDAqaXXTx
         hQfM7fIErdyeip8QJmY4RbcCfEj/cjeUQpchItUKBYwJqwhIYkfLzvrHYppzN4uzCiYO
         8KqA==
X-Forwarded-Encrypted: i=1; AFNElJ/7V0z1EBAeOuiW+3yHtR3cYU8959OQ5SdSXfR6utk79lmJRn7hUNrrN9QVxJLFEcCOMduAQv0dCnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwypBppUnQinxsxPnGUrpW4KMEk7JV0KugRYpaVeBHA1jrs87CJ
	XtPKiGp2eIIwjFplGXQ4Wc31GW4Fk//aaC/7YUxvPXvD8Ma42RW9mGpi
X-Gm-Gg: AeBDietchabWAdd+ifLqJVQvStKMtN3Rn7l+mXuf8p6ql6HXRVrHdXq3ScklFB36Jbj
	1REqk+Ie4Zg5/eVjRhBGgZkX4iLdG1od7K6+VPLShR/e4Hb7R6C4lYPEqjuEHsI8xc/pED0t+vB
	YqQ2wYz8yd5T3o6mN+yrSnpFUBH4X971wxRukMsrap2Ia8/QpHBUhVATR+0GKtZ57BA91LlV0//
	rmTu+inRxmy94oqPcnGel8hNLTRx0Z36Gg/0PUA9e5Zuc67LBxJ6yLvf5aYm2CuzClqXDgzTjUp
	dNg6NOQBc+SZou93aX8am2PHG0MuDb6lhdX5JYtRMeigi3IGmQFcgncseX1O0sTcgSFQjS3EIDR
	HfARjj6dFjYyHSvG3ORnNDOgrB7jxussXH06Wfj61eyGDYw8IBlGri4I0Xuw8CkwoklWs3Xfs65
	DghRRRrFH7lKkdCiix5WPqAt1x3fE2wW4Z2hpNiu/I79uW814PdpezrneQfd3RS64rvvXGrMSJY
	XU=
X-Received: by 2002:a05:600c:1c11:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488fb782a93mr63697245e9.21.1776455037158;
        Fri, 17 Apr 2026 12:43:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc11ced7sm58174535e9.0.2026.04.17.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:43:56 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:43:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede
 <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@Stromeko.DE>, Ben Collins <bcollins@watter.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260417204355.37fd960d@pumpkin>
In-Reply-To: <20260417173621.368914-2-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 13:36:12 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> The bitfields are designed in assumption that fields contain unsigned
> integer values, thus extracting the values from the field implies
> zero-extending.
> 
> Some drivers need to sign-extend their fields, and currently do it like:
> 
> 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> 
> It's error-prone because it relies on user to provide the correct
> index of the most significant bit and proper 32 vs 64 function flavor.
> 
> Thus, introduce a FIELD_GET_SIGNED() macro, which is the more
> convenient and compiles (on x86_64) to just a couple instructions:
> shl and sar.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/bitfield.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 54aeeef1f0ec..35ef63972810 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -178,6 +178,22 @@
>  		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
>  	})
>  
> +/**
> + * FIELD_GET_SIGNED() - extract a signed bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @reg:  value of entire bitfield
> + *
> + * Returns the sign-extended field specified by @_mask from the
> + * bitfield passed in as @_reg by masking and shifting it down.
> + */
> +#define FIELD_GET_SIGNED(mask, reg)					\
> +	({								\
> +		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET_SIGNED: ");	\
> +		 ((__signed_scalar_typeof(mask))((long long)(reg) <<	\
> +		 __builtin_clzll(mask) >> (__builtin_clzll(mask) +	\
> +						__builtin_ctzll(mask))));\

Have you looked at what that generates on a typical 32bit architecture?

It really a bad idea to use __signed_scalar_typeof() on anything that isn't
a simple variable.
The bloat from all this when 'mask' is an expansion of GENMASK() is horrid.
Indeed both signed_scalar_typeof() and unsigned_scalar_typeof() should
really not be used - there are generally much better ways.

In this case you can just write:
	({
		auto _mask = mask;
		unsigned int __sl = __builtin_clzll(_mask);
		unsigned int __sr = __sl + __builtin_ctzll(_mask);
		__builtin_chose_expr(sizeof(_mask) <= 4,
			(int)(reg) << __sl - 32 >> __sr - 32,
			((long long)(reg) << __sl >> __sr)
	})
and let the compiler do any more integer promotions (etc).

I'm also not convinced that the checks __BF_FIELD_CHECK() does
on 'reg' are in any sense worth the effort.

I have tried some simpler alternatives, eg:
	!__builtin_constant_p(reg) && statically_true((reg & mask) == 0)
however that throws up some false positives due to some of weird ways
people have used FIELD_GET() where it is nothing like the simplest
(or most obvious) way to do things.
That might have been the code that split a 32bit value into bytes
in a printf with:
	FIELD_GET(GENMASK(7, 0), val), FIELD_GET(GENMASK(15, 8), val),
	FIELD_GET(GENMASK(23, 16), val), FIELD_GET(GENMASK(31, 24), val),

	David

> +	})
> +
>  /**
>   * FIELD_MODIFY() - modify a bitfield element
>   * @_mask: shifted mask defining the field's length and position

