Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028563;
	b=LvVdEapGZawbkDagZuiYqh2ofzf6dz3gEn353imDXByMFe98QKhWLWLLg+QyRbKRjS3f
	 6s5xNU8NcpNXA7C+kdZTyZaB4fYgWQzaL/YcTXKtwIFrj09CZZOk51behQGpkURiPK7r2
	 eaHQHISRj8h1ljaAJ4yLyfJZOH94QjpT6CQ+ZZU69MiAT2S0XxXwU0In8qW5Dmksf+UJm
	 UgAZIOpMXxLT6i6BvLhI1RGW2QAtdjPjLhtVhRHB56OBI5d8V3lbGN1uTtLDJxeWb7WsU
	 5yShuUddKzOV0yIqvGkM4c6u3q1ml1XKJLnCH9FL3lbe4okvflykwf4UIs2F2s/oTNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8iZubcz038EY8c4oZtKV+g//UmaZbw0VPeAJAfl9gbs=;
	b=lzqj0/WUFZzudMaRxfNzrae9+jy4/B+MtfccIlcwkTiJ+3TZBkdzidNb7NvV03Xl07A/
	 kefzDLG0g8DlbwmuqiBLYdLviUmNcrYpUP/3slL9Hfe7f7yMUPrX3vlKsR1yJGAfvr1xE
	 NpmjGlEli7u2kW4VHbYSmwkNDVgLxh4Q3fsF7qCNKTL0spBpvfWWpugvE+REU9n6XLxw7
	 kHexV9o6hO5a6AIOOcnD4ABcHvujjnDI9wJkv14ClvGaTFUjK2cwcD08JymfC6KsDdHDm
	 S1KxWiam/zynl4YIXfabX2tMUKaqGNPynxKtVwts46wERpe8yqQ1zHNOib8lfbL5FNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="n/3EmII+";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27673606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 15:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27673606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n/3EmII+
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1752341a91.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793028562; x=1793633362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8iZubcz038EY8c4oZtKV+g//UmaZbw0VPeAJAfl9gbs=;
        b=n/3EmII+fJ3KhXyCQp9OEAWpnHIEVyvrQJ1AzXdeKd0KhvvrNiJNZtCH4Gj55qCChy
         q2DyGFrBEWIZ8NO+qHPrl/AFajFpUQIRdQnIMx9BBZV7oJWloxHlED+nsYrFCkmqqoIf
         PFX5J+e0NMDoVfhMUi/4b+hA3ss5n3qwKz3J/1JfpswNsbxfbBKmfYEzSa+4e5AZbgWL
         xtpMqxmQMC0Gh0ZTd7nLGGX0NzBGE+Mmur1OF2t9GnRaxPk0xPdAghfCfB31U9g54r4k
         9/pN4Da0ifQQvbcjqz2k9bcsAwyNxSh3X2GopNHSIrWhmnfcZ0KTW84YAe/ea33TbZiW
         3mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793028562; x=1793633362;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8iZubcz038EY8c4oZtKV+g//UmaZbw0VPeAJAfl9gbs=;
        b=libbfAmW6IX9dh8kGIA7VCeD1P8V5hb3tAL0nlZvn4q0IRb+UJ89saW5ZgnRDUJSlj
         +OnWdkj26D1FTwUQDdwmjjHOwt1D/jLcRarHYqKwyeprtzdtqj2jrIiFz0mDhy1BmdCS
         8+v+TljCAFXILKogPJKl6g7/e0tGx/KZqKKz5yl7xQslNUyKvExXcQ3b/sYqB2Shvny7
         9VbzVuiZETpNFnJnT2CUpRRSbprslMSxWzsdVW4rR/sVfcpmaOhr1l06QCoCSPaaN4pq
         ark4aDHVsPiHIgS3zkwHASHT1Qq+m51XQesQIBFR9ekznHQWI6/lLzNDYx60JygTR7aL
         2vNg==
X-Forwarded-Encrypted: i=1; AKwUvBySexmJEgYJ8pOAZfDiRgWmgmwXyf7CD+WWWly6AZ5+FOmgDUfGW6OvZ4SCN3QY0i4X9aqjXDlvVcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf1x67VMnDGrYs4zsIH0EEqjhHP2kr9ULrQDl/9px5uz9vuwuo
	nYUpk8pv+eQM8TAtNhR6DgcuVQNTQdfo4HaeF1RQrJg94X9vOVKnQNoz
X-Gm-Gg: AYBFou3iheE8X9jQ1BXSM8MSrDZcQxXtP1SF+6uEFq40rmDku5FH33fOlySoJokxnhQ
	+OZQDfVkKzbnSkvitQteXQUe18KJOmEQRmshrTAZbtHTx6oOVFrn9lrya9xFR7MlmV6gC4IcAVq
	KL18b1eY9/5L2p/fWiTJop23z59oKsO802GRBV+JlKv29oCxvX4YSjIFCjRQEq45sR5ekqMIFpa
	PvbN1xs4SV5uovByIksynGWVGtVv4a26i7sRDj6gG5Vmp9AVfl+/9NYjLfZJZyxPvRK52fNfUV7
	6bTzfHozzPf1u5kopNgux5J9/Ue1w9d1EDJnxT5kf5U5LPgMCFN7tfp4YjQU/N1hmBjfXP+t+ZQ
	JQt2F5rhm1osKT4UqULMzb+b80HDUxg0X8zwoX52QQpXQtpVBWpAe76DW0s9zz5SgTgWIkU8YPM
	fJnTo6J+V82bEg2kU2bCJ/X9rtgN71T1nWqLAxQ+rJbQeZl64WN3GatZ7qLNv7Bju4bJl7YI6pj
	TLM+jOFc4rHW+74Rfzy1peGZg77yIC1s0K0bGZ/DvV/PqiQz7OihrTQAxDnPTOtcWQpavM+FV8Z
	82jFh/WL+d5+dWOlQrQZUm7V8dy3RBdgcQfqWDznE+LRU/HrDxk=
X-Received: by 2002:a17:90b:1c8b:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3adea8966a7mr5554619a91.18.1793028562351;
        Mon, 26 Oct 2026 08:29:22 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae403d0d9dsm3332a91.15.2026.10.26.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:29:21 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 26 Oct 2026 12:29:16 -0300
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 4/6] iio: test: rescale: compare scales against the
 precision of the output
Message-ID: <r3mtebdkezwd4sfpnqp2e3mo3bjqzzgdyyfcw3h5x6mqp5cskz@4d72r3r2wpkm>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
 <20261026-e-notation-v4-4-a366a6d14d57@analog.com>
 <at9mXdRhiM-9TVyg@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at9mXdRhiM-9TVyg@ashevche-desk.local>

On 26/10/26 16:40, Andy Shevchenko wrote:
> On Mon, Oct 26, 2026 at 08:54:08AM -0300, Rodrigo Alencar via B4 Relay wrote:
> > 
> > The scale tests format the rescaled value with iio_format_value(), which
> > prints at most nano precision, and require the relative error to the
> > expected value to be below 1 ppm. Both strings are parsed back with
> > iio_str_to_fixpoint() at nano precision, so for the small scale cases the
> > check only passes because the expected value, like the formatted one, is
> > truncated to nano. For example, "0.000000033594" is parsed as 33 nano,
> > equal to the formatted "0.000000033", although the actual error is about
> > 1.8%. If the expected value were rounded instead, it would be parsed as
> > 34 nano and the test would fail even though the output is as accurate as
> > the format allows.
> > 
> > Parse both values with kstrtodec64() at a scale of 10, one digit more
> > than the output precision, so the expected value keeps the digits lost
> > when formatting. Scale 10 is the largest that still fits the overflow
> > cases (about 2.1e8) in an s64. Compute the relative error with
> > mul_u64_u64_div_u64(), as the product with 10^6 no longer fits in 64 bits
> > for those cases.
> > 
> > Then allow a relative error up to the relative size of one nano of the
> > expected value, the precision of the formatted output. This is 0 ppm for
> > values of 0.01 and above, so those cases are checked as before, and it
> > accepts the formatting error for the small scale cases.
> 
> ...
> 
> > +/*
> > + * iio_format_value() prints scales with up to nano precision. Parse values
> > + * with one more digit, so the expected values keep the precision lost there.
> > + * Scale 10 is the largest that fits the overflow test cases in an s64.
> >   */
> > +#define IIO_TEST_DEC_SCALE	10
> > +#define IIO_TEST_NANO		10	/* one nano at IIO_TEST_DEC_SCALE */
> 
> I would put them as (9 + 1) to show that actually show that "with one more digit".
> I also don't follow the comment near to the last definition. What does it mean?

With decimal scale of 10, a unit is 10^-10, 10 units is 10^-9 = NANO, which is
the scale used in iio_format_value().

-- 
Kind regards,

Rodrigo Alencar
