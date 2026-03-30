Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE8386561
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858183; cv=none; b=pz3QvNiPlNRIUkD4KuuNeohOTMz75/SGFm2XcrJVTV78ZzI2OqKQ09XR9msL5ajShyabnnMxIlJaLQsuTvkYEVaHr4EaYafghKLSAk04kLUlfXhnGFypsiSy6+4irSOS1dj7LLeiRwp0OQmyTSq7ke//ixct/A5ZyjXnURYxJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858183; c=relaxed/simple;
	bh=tW/INbpmXJVg5bz2Qnv9IGM49uAG3MWpQtvcviWEy7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huyIM6H9RR/iDUJ4L1/u2yu63uwrtVG/XowE46Jl4RvJvUY9aqcYdt7WAYw/CvFBwqNMAIPIccP2bUii92p/dnM1TEmwPfEICMI7pWEdMAS8T+7rJo78oWS4/Mb15ahhu393jhOOfJqtMlKUts24MxLX84QfYOrKTUmM735iSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94dd01deb53so999768241.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 01:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858181; x=1775462981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIsXweoHuxY7XSIOhAMab+JXNuNNW1YEPO1/VtWzLsQ=;
        b=HFKMF+icspM8w3YxxI5e5zztjVQNmKVTg+lbiyHVVSivZM3zKBlPtajBVHyJvr4fIw
         wKhsgfR0Ymm7Kp4HWng9wazZIDrWpVym3pFNhlF7Igy7gz7tVUzK9I+Y3hU/JflwvLVs
         m/zQEd4cAoiL//yMSqJyUm/buWwk6P7PcaXdloOJJIgLdeWRzx8ZWZzbKhLnLIR1wpDX
         7ieO1xUspmfBjzS5/sUXyMDBFR3aVQoicI5NfQ2VU56x+d9baf51ipI0Z+HwCTowwR4C
         Ds9QBv0OxpSg1vW0yw/bjUuqPTMm6OwB3LHJEeK3Ia7PLy7ff7KWus4M2jXAREsxKeB8
         TIZw==
X-Forwarded-Encrypted: i=1; AJvYcCVY1DL8EdW2TwLqPvQ/NSoKy8sGo3dd9Dq0CsSg4eku5Mhna5RsYd1aHpsgRrFs40r20HlH1rjlKEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ecnamRkFoFvOa+Gg3ZX7LVgmrqTPp5Ld+fZiJI3B0fymJqh6
	px8tUWbkcf6XZA5dezcoYXtdWXRaeYjKAkighGuVAgjp6/8XJ66fFWdZ+5VFaFl+
X-Gm-Gg: ATEYQzzrgS4V9cp6m/1f1ZvwyCHiwu5gKz4p5O0bsf+HkGGU3vGb/hdO7gMOwfmlwQG
	ewOuKpwUwhq/9oVQvR8IYSx511kJHrKAlq/S680jmKi4x+doa/YNtvAo8IuRR7jZZc1mg2s6Lke
	g2aihvdgpOP0bOnJig4oU+lji2wOPnqBf8mAFv1wOfvnA84WSdHrSvW4WniR8O5cGZXeOo+Xrhn
	JVCd3COdVRUy4zpq6GeFu9fxHUOxvIgXncEJZ6quWrZPfwX0vOkRYI7JZ0uJVIYkYy0OrWDYepE
	JDPzyrDKdfuX1o9Fnt1ebifkW+MkgMqqH+le/+lwNeSuxu5Ja9WO+QvPSY0X1/N6Q7AnWx1vxUD
	T2lxU0y1uIlgN5LBAoMrCzK9IkXpQyLPgvD6Uo4Uq/Upr7cuuCKyKJAxIhu1y5kvRNaqrKAUkrm
	xljvhZ6f7C960lhxi7ZT0yiqz3I4oCusdnUrYHAhZcZI7Sp5bN05gmPTe4UOM2
X-Received: by 2002:a05:6102:5e8d:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-604f92e7165mr4050717137.25.1774858180933;
        Mon, 30 Mar 2026 01:09:40 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9539e258601sm6289889241.3.2026.03.30.01.09.40
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 01:09:40 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so992879241.3
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 01:09:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCry6EOgesLjZLBPM9fa4MjSK7zovffGEVewk3Wg4clcdEiTjUf5M6xKa3YIO5V1fBuw40AV+Wpp0=@vger.kernel.org
X-Received: by 2002:a05:6102:8028:b0:604:f29d:84b1 with SMTP id
 ada2fe7eead31-604f92960b5mr3654837137.20.1774858180376; Mon, 30 Mar 2026
 01:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaHrsTS9iG-PEfue@ammar-VM2> <aaLIhgJjrNlp3oTy@ashevche-desk.local>
In-Reply-To: <aaLIhgJjrNlp3oTy@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2026 10:09:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUcDrDR-1f5eXjdyDR3-HcTFFeGsmYU2whV=fQhzsCNtg@mail.gmail.com>
X-Gm-Features: AQROBzCLuIVPTTxt7k5F4tDK5RHqMB9Fn11dB6AR3oeM1joJzuqZmax22uYJ_WA
Message-ID: <CAMuHMdUcDrDR-1f5eXjdyDR3-HcTFFeGsmYU2whV=fQhzsCNtg@mail.gmail.com>
Subject: Re: [PATCH v2] Docs: iio: ad7191 Correct clock configuration
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ammar Mustafa <ammarmustafa34@gmail.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Feb 2026 at 11:51, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Fri, Feb 27, 2026 at 02:08:33PM -0500, Ammar Mustafa wrote:
> > Correct the ad7191 documentation to match the datasheet:
> > - Fix inverted CLKSEL pin logic: device uses external clock when pin is
> >   inactive, and internal CMOS/crystal when high.
>
> high --> active

Thanks for your patch, which is now commit d2a4ec19d2a2e54c ("Docs:
iio: ad7191 Correct clock configuration") in char-misc-next and
iio/togreg.

That commit message still says "inactive" and "high", thus adding to
the confustion.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
