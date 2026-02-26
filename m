Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BA38E13F
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099028; cv=none; b=rZV2MvqSx2dCqtiXO6f8Ffb6OPqUHLlkw4tEzsRkJckjoLzQj3+fmQmondppkPZ2eAhdGHMGGAOqIyNay8Mz0fKkjgrOXAgfInN7M3VlIzw4umXGQRvX6VcYkJL+rJpkFAIiO/AwVeOnH21+qiKaDSHZUwXeWh4zvvWs6FB0LtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099028; c=relaxed/simple;
	bh=/S2PYGkHe8ntuxqNNWLfs1n9FTai+JUq4ZlR6Edpltk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn+dyFmhevNM1Z7H4wlWk/Gn61iqA2vgDZ7UHD4jdAeJa44rv7s0DYZSCMWGbFmQQbpW3auoXGfxuyV7JNPFodVO7X83lpJksk3oE8ADJ38HkwVs4qFcuuWdqiQPxS/9LtMcq+4GfjE85pt/WjNk5vOE2+CcSIBMnyBCqwcFeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso378381241.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 01:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099026; x=1772703826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp+WuKYQrvIK39HhrEYM8s23RNSBPp6K0LAJt9BbK+I=;
        b=nXvJtjjma+C1WIVEevt5zQbZvmiZGrpBX2xjVsSIRMA7Vlrx3WB0cZJZmHVySS0bkE
         jlGZg8ITZluY21FK/zmWYP589gVFUAeCWBuUoaVPJ4XMaQorU7/Tt8u3e1epG6i6fSjG
         hlUrwC/7J1q/ouy8s7FYdgSIoGNVk5Bg3NbZUSHqV2n2LrzFwoieNJ6dWQKTZKgr3O4I
         hbaFHPetA+ARNzOxXLjTK8Cp4BcK/8HL5m+0P08iP+Kjlu7sMWvyMHYJlMtSmYICQFMq
         DjQInEcIhvWTV5YxlM/u6VE2mA7kHmRvghCJWoOlsOoM+bk8YK5uENV00hYN/Hk5pFn+
         5NyA==
X-Forwarded-Encrypted: i=1; AJvYcCWO/N0eQNVqW2nVEC29COgs0ZDjNl/cA9iivrfV+Ke4nNw7hR9uHjLsHOLelZPj449350hjKT6mAAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5I+k3wS3/dMUSEaECneReWjCsKSDkhKtcCUl9Kjj/l232UYuz
	7qWyC3toqZEg1hHCahrlvLRAgq6pHekGqWQmc3FmozJVChJMfAIBB0of0TbziNpZ
X-Gm-Gg: ATEYQzxJYDGOoNtnuHmFtTB0lfffyRAc0v8z7GKOXxD6gWJqwgtVvIT9ATEVAW3i5r8
	gVD6PTjHaKcmp388lUWczNfBT51CCOgHCFUpbSRZtF6Zyb8j85mPhqk7xdEFn5XuNxU/Kq962Ue
	WfFEUb5kkm/VWu9ly2hooJxTYlkyyCqomWOCQEu6bFP6B69/jUWTTH8gifdIWMrC3D3F2ImEOrd
	eB9F30q5Obq6fCKMIudu2TmgDRXglLw48Rp6ltGSbVltk9eUMa7YSUnmoEOA7Ca2kF3V/yqHwYm
	DWg7XKAqdVsXyUtFnN+GyC13kwcrkDZ03NShJFPmiqvubL30uqhhbG49wbs38oqNyy22Kg51b/n
	Qst/6f8gTh3jsEc6Jjx3RC4Uf2ds07PxtRMDIvw/g0M12liZbc5mfDLan17JBOIswMy09BFKX2B
	Uz1evLEGiJYNedSI9f1g+P02VLjQdtt/wiqCsoXFDywWB+urDr3idWXEeeEdBm
X-Received: by 2002:a05:6102:1626:b0:5f5:3619:8bd1 with SMTP id ada2fe7eead31-5ff14087fa6mr1749138137.25.1772099025874;
        Thu, 26 Feb 2026 01:43:45 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65b281asm1108530241.13.2026.02.26.01.43.45
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:43:45 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5fdef6330bfso382600137.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 01:43:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNxsSUn7uIDoud/t91rKxwEv3qSZ30k9HC650R+GWGPr4H4u751ziNO+dFKna83jyL0Nz/PE+iZ1o=@vger.kernel.org
X-Received: by 2002:a05:6102:32ca:b0:5ff:a1e:ee66 with SMTP id
 ada2fe7eead31-5ff13e21dfamr1933555137.2.1772099025362; Thu, 26 Feb 2026
 01:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225100421.2366864-1-flavra@baylibre.com> <20260225101711.2368206-1-flavra@baylibre.com>
 <aZ7fbdpWRFsvpGWf@smile.fi.intel.com>
In-Reply-To: <aZ7fbdpWRFsvpGWf@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2026 10:43:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMOvWQ1T8CMDvR5XFBxO8m1ai8m982R8Nyf9LXiE7K5Q@mail.gmail.com>
X-Gm-Features: AaiRm52C-kex9GHahxu_nWJO5ymejtUWryYRBuGFsNzefYJtjE1hyPfJHG0l3NA
Message-ID: <CAMuHMdXMOvWQ1T8CMDvR5XFBxO8m1ai8m982R8Nyf9LXiE7K5Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Wed, 25 Feb 2026 at 12:42, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Wed, Feb 25, 2026 at 11:17:11AM +0100, Francesco Lavra wrote:
> > The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> > accelerometer invalid samples (i.e. samples that have been acquired during
> > the settling time of sensor filters) with the special values 0x7FFFh,
> > 0x7FFE, and 0x7FFD.
> > The driver checks FIFO samples against these special values in order to
> > discard invalid samples; however, it does the check regardless of the type
> > of samples being processed, whereas this feature is specific to gyroscope
> > and accelerometer data. This could cause valid samples to be discarded.
> >
> > Fix the above check so that it takes into account the type of samples being
> > processed. To avoid casting to __le16 * when checking sample values, clean
> > up the type representation for data read from the FIFO.
>
> ...
>
> > -     u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> > +     struct {
> > +             union {
> > +                     __le16 data[3];
> > +                     __le32 fifo_ts;
> > +             };
> > +             aligned_s64 timestamp;
> > +     } iio_buff = { };
>
> Hmm... Have you considered m68k case? IIRC there the alignment is 2 (even for
> 64-bit members), so theoretically the beginning of the structure can be aligned
> to address 2. and hence the __le16 data[3] will have no gap to the following
> timestamp. In current code it's 64-bit and not 48-bit item.

Fortunately, the layout of a structure does not change because the
first member could be stored at a less-aligned address, as that would
make it incompatible with a different instance that is stored at a
differently-aligned address ;-)

The alignment of a structure is the maximum of the alignments of its
members.  So that will be 8 bytes, as the aligned_s64 definition has
an internal "__attribute__((aligned(8)))".

It would be wise to add explicit padding ("u16 pad") just before
timestamp though, for documentation purpose.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
