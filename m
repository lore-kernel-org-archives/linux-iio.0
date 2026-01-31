Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EB368262
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886751; cv=pass; b=EZhbl+DD1XjZF9+om4+wx5HdHydxDWC+i4k0OG0scn1INtgJCm/oBP3Oj2VQaNZhHuyIApQvjnqcAVJfsRYNo8raNZnVSobjtKXYTIkdA+2gD3oWHd2hLKBuZoENl+9ZveP7tRi8UpjTjDRLNtELSKPGYaxxKKe3W0wRzIcTxO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886751; c=relaxed/simple;
	bh=erofji1e1CWtzqljw0JcvduMKVWY7GT4RFfbJKogxSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGQ2lvAr6d5eJXGVEZHW/LNcFplcuwmgbWLaOdYs94gbkUpXjkILufYEODI1Xz/ObTvp/xioUwAfcQr5lfHeMA5RbMudRiCUmlPJG73Uek5p3xy6SxbTjnpxA6Aix04HV+GE8C0U0iA/vAa/O/1h/5V1rK5h4P0G2kYpPJu29Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCIIJU2I; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCIIJU2I"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8863db032dso523665866b.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 11:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769886748; cv=none;
        d=google.com; s=arc-20240605;
        b=MVMCVoUfhwNZjS5eW3lqHeE+7Q+jzQ7iITpqgLxDkJQxF5IW71pBThM3wTLYg5pQaf
         H9oRSUNQQSGweVEIHUFYuL1RCI41NRwAzM+ajHuSV0sSpM44Knr1jzUHfV1/pI5G9L9S
         LO977xqhxCmPUlgMJAPFZ0ym/YTD9rURQatsPFs87xmQxjP7s8I2s+gvwSdon0AAO5wh
         52ORyQYl+q3CqbuHgXIONzgpx0daY5GGoPGwqnngfwubYn0xyENbkETRTXdCmrhjrw1b
         dpVjtaxLdx5HY/8oKK53Zi4ctGDzl3PU7YTmK3/jvaqj8kgKUBISp641CD7I5+ej/UTB
         K9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ryjSph2VWAx8aP6E2wZb6hfrlVeYYMRCjjAip5DiYB0=;
        fh=bon0jU1FAXmA192ZGFvna/fQEGhKz6UbpebPFqDdMYo=;
        b=Kgq84pFqLegIyEqSxwuzgrF5z+UVdnmWQgHOyW0rcL7/niX8UojjtQdUvxyxHoVpZt
         bBQdHjHW9PzUJCXWcBue+C65ZSUdfEqDLakPC16AUvNFFHhnTm6cZYU71RziZcAb9k3u
         +tKtJbh89RWUDztfP1xr1iGNGCPvWir1xzSFOi4Xmdw7O7KxvHor9DIIHTazgstXXaYJ
         ys8f8HL14oE405KETlWbpfEAJiMYQtzIHynUZCTqXWlldJl1lyQf7GNy6VuDgTeimI7U
         Y/UTT/86jmgv27hQr0N6nnLu3CRn8MiP3J1X5b00DxwF+LikV4HpJp7R3PQncBfDilTG
         XoSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886748; x=1770491548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryjSph2VWAx8aP6E2wZb6hfrlVeYYMRCjjAip5DiYB0=;
        b=BCIIJU2Iufd6+7siksXMDXAjBz03Gsn55hcBIief8L8dvXE9l9jxlhpAoTLMHJsT7y
         6Rf8INmQDb3mpfyAPwJP0065DEyNgI/lX7SeMoh9AOYVR8JGlOY3LcmIp0IhJEukCvw1
         jffb1t04NvhbwWN3qpz6IoMgXu4ypnflWSvX5wlupz55gq2K4uamxyqKj/POxPyrsYOu
         OM1LglJZ8xZbSaZE3FAQql+1ObvHOIdTIxziZZD2fsC5OkkmMSNFVBxu/Khdbyyc8msK
         y5Ykhs3FlbCwhq5MwQSVdi+8bfssqEM/9F3kZ0KUFwljamzFOwwT2wPY4IkwWpGkQVp+
         GZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886748; x=1770491548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ryjSph2VWAx8aP6E2wZb6hfrlVeYYMRCjjAip5DiYB0=;
        b=M2ifvRmuekvzf4y1ttPAWf1oC0W9qvJP/a8+DwMJvZ5jd5hZBcj1VcY+SkAI0wmcQs
         Kk4YIBsTrsWvgjweTd5+IWvynlmtgKVBGK4AeuCsQ5gAIrsVl8CguCSaJpM0VGxb7sA4
         lFPcpqFAl1mRuDxBVxzAKbO5yU9TqnsiwfvsKr/ZDLcU6lUzIViODqhhNw8iRypAdWzW
         8ExiFdZlRiJCvwkrrIf0yGhw1VRs52FUlXkdX1TYb3DuH+b/e2YvoaUWUWZj57vGPN2O
         IP89it65JYrioR7PQ5CFha0Tmr3y7Cuw7SHMuJRnbX4tdkvwMJ8RZa5gqORUAEFJF9eQ
         Efvg==
X-Forwarded-Encrypted: i=1; AJvYcCW8F3wlsuhrNFfBn3o4wt4KMfv3sADb8xiVwBwhT5V9QLDsYoLEdhmNhIAyafJrDvKOen7YXJK18hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEGmneJG5tJxCDqOOv14FJqjporpmVor06LRuDDaXl3dIY8c4E
	HYOCyQV/Bta4DDmEmyJ4b1QNVECBHWPAPX0Ag2sXiJww8tq1nn48rqROJHT+afsbPLFEpHUdtOJ
	ZULJKVEyr82rtwwANvZ9w/HqWpAzgHqw=
X-Gm-Gg: AZuq6aIthx9uTG4VWECe4bsq76x/gGLEMXcuhW59bmGJy+zrEFdNvZo+Gt7V9E0zyeJ
	vrz8aDa8EGEZcJjhC/i5koWNTodOtsVNUQWQ24IylWzZOC5VkP1LpjzHzIoGAH0cj51WWpPvYaF
	hjylImTh+wArwOfFtNSgPHFeMZiEAYvnC+LxqVikFU4IUj0EG/2BtbrahhmWB9qDX7bc8WEHSmU
	6IHNXH7keEGUBKbflwa2/Hf15/oJ95Py7XRILd74+ltFlsKhyaL2YXraEOJviBfzkqVYtsC
X-Received: by 2002:a17:907:608d:b0:b87:1ed9:f58b with SMTP id
 a640c23a62f3a-b8dff7bf37bmr448894766b.51.1769886748241; Sat, 31 Jan 2026
 11:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
 <20260130-adt7316-correct-macros-v1-1-8a71df1e42f1@gmail.com> <20260131155413.28fcc701@jic23-huawei>
In-Reply-To: <20260131155413.28fcc701@jic23-huawei>
From: Michael Harris <michaelharriscode@gmail.com>
Date: Sat, 31 Jan 2026 11:12:16 -0800
X-Gm-Features: AZwV_QjkmTAfviYlLDkr5vmmzNMLS23n1WBgBDovdtM5ZBamSNIsME9WJwag-TI
Message-ID: <CAHXWO3R4_18dxw8s5S5-7nbT8xjX6hZ5jrTmG+5csePOvdmfjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio: adt7316: remove unused macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resent to include the mailing list, apologies for the duplicate)

On 1/31/26 7:54 AM, Jonathan Cameron wrote:
>> Delete macros that aren't in use
> Why?
>
> I'm not against driver authors only introducing register defines they
> are using, but I'm also not against them deciding on comprehensive define=
s
> or at least making sure they cover all the fields in a given register.
>
> Having only parts of a register defined sometimes makes people miss
> that they can't just write the whole thing because there may be other
> bits they do not indent to change. As such it can be useful to have them =
there.

Hi Jonathan,

I was under the impression that it was good practice to remove unused
code (including macros) for the purpose of reducing clutter. Hearing
your thoughts, I see why it would be better to leave them, despite
being unused.

Please disregard this patch.

Thanks for your feedback,
Michael

On Sat, Jan 31, 2026 at 7:54=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 30 Jan 2026 23:38:27 -0800
> Michael Harris <michaelharriscode@gmail.com> wrote:
>
> > Delete macros that aren't in use
> Hi Michael,
>
> Why?
>
> I'm not against driver authors only introducing register defines they
> are using, but I'm also not against them deciding on comprehensive define=
s
> or at least making sure they cover all the fields in a given register.
>
> Having only parts of a register defined sometimes makes people miss
> that they can't just write the whole thing because there may be other
> bits they do not indent to change. As such it can be useful to have them =
there.
>
> Thanks,
>
> Jonathan
>
>
> >
> > Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
> > ---
> >  drivers/staging/iio/addac/adt7316.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/=
addac/adt7316.c
> > index 8a9a8262c2bec34f3c3e79d8174f492b9a23fb70..4173c8822fff495e8c69d9c=
f6c11be9e9227a8c1 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -111,7 +111,6 @@
> >  #define ADT7316_AD_SINGLE_CH_MODE    0x10
> >  #define ADT7316_DISABLE_AVERAGING    0x20
> >  #define ADT7316_EN_SMBUS_TIMEOUT     0x40
> > -#define ADT7316_RESET                        0x80
> >
> >  /*
> >   * ADT7316 config3
> > @@ -154,7 +153,6 @@
> >  /*
> >   * ADT7316 value masks
> >   */
> > -#define ADT7316_VALUE_MASK           0xfff
> >  #define ADT7316_T_VALUE_SIGN         0x400
> >  #define ADT7316_T_VALUE_FLOAT_OFFSET 2
> >  #define ADT7316_T_VALUE_FLOAT_MASK   0x2
> > @@ -194,15 +192,6 @@ struct adt7316_chip_info {
> >   * Logic interrupt mask for user application to enable
> >   * interrupts.
> >   */
> > -#define ADT7316_IN_TEMP_HIGH_INT_MASK        0x1
> > -#define ADT7316_IN_TEMP_LOW_INT_MASK 0x2
> > -#define ADT7316_EX_TEMP_HIGH_INT_MASK        0x4
> > -#define ADT7316_EX_TEMP_LOW_INT_MASK 0x8
> > -#define ADT7316_EX_TEMP_FAULT_INT_MASK       0x10
> > -#define ADT7516_AIN1_INT_MASK                0x4
> > -#define ADT7516_AIN2_INT_MASK                0x20
> > -#define ADT7516_AIN3_INT_MASK                0x40
> > -#define ADT7516_AIN4_INT_MASK                0x80
> >  #define ADT7316_VDD_INT_MASK         0x100
> >  #define ADT7316_TEMP_INT_MASK                0x1F
> >  #define ADT7516_AIN_INT_MASK         0xE0
> >
>
