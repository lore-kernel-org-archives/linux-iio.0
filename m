Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7148875D
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395284; cv=pass; b=VpCzOuDQsByCX2Qn8pF2mjj7lhCZ2/hpALAcNUnoUrtZi7kHzPCgSe/pk+imAHe7IqmHm7puGt72sQwsQ2tEFDpjcIrc29ZXveehRK72Ym5bY/h3sBjPVyu6E2+svgAcqb0MBzvThW/7fbI2rxuv2G1hTOPTkamgNk/I2wUftEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395284; c=relaxed/simple;
	bh=zzSBJEbQ3D9kyu8uohCICPb5V7tAUfamh/FCwHx6Zig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B11xiTP0uG6HRvfxJLv+RYgXKIUg5iw7JAVq8k16njo8g9FcnWJryLuV8lV/PP7foMgwgDDn/ctMNUpMeERn6zMvmFcmPyQs64K+5yvhuoZRZHesHkquMLer34ZgziHK0ugBQDN2NlNEDPavTHJSfGBAJiYTtKI/mGWMkBBDX3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=XwUSu697; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="XwUSu697"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c43373ae89aso122438966b.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 00:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792395280; cv=none;
        d=google.com; s=arc-20260327;
        b=koZmL4CnoJnGzDyoELUTF6X0F9rDMxqd9TR/4X19fz/BBrWSa4LtqgykbZfpqGw8gx
         ScRZcTf55pqsP+V6KOhvI8LgCx2yRTpvwF/SB/Kb/qzxcj3oO3P3dxg4UHDdWjcZX62+
         wEkyUASC5/L9UW3XXXs0bWRYJqLeopxl0ty2lPJhjuEiGTZmXZk0jhibgU/Fyy+Nn0Vf
         EKa1qrPQFXEjlNTY7jSwOIwkcA060hrsOE6ew5iVe7NT4yleJ/eMpLPHjCoh4fdeaQUr
         WZqaxdTrP33jrYiaBVEWe3Bgou5aRR/Sh3h4BbxzkUAusyTBWmVWxR3JES4gfyCV4jN/
         hi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QuLQGTBq/GHWEdWfb6Pl6kV6ni5j9Kr3GuQHGNwnH7k=;
        fh=kFi4j1Rm4nC67s31YIW1bbcNn7rcd0RrAZyyKxfzGM8=;
        b=NPnF6DjRinDpdJ1kiT0FOlWlbvr/Uy5l4uMclC+CBCpZLoJ8NClir27whEpHJEDCnl
         0zjOIQtVoR2RRoNc5uzbDVa0g4LkRO+If06cRYpwkksE9DcwHYg6nCKYq+zgXU2VV7K0
         9oxfRSrgmg2UKpG/wwyBRskd14U3xHiAMPXpD0F+O0D4EdVDK2BblY/YXN8xPhKSqwNE
         FVP39jgIXDTw92lC8AmVwtAHOuxLJ1J+uPXpBfBLSodcpbdF2Kxh+2Ug+a92sILX2/yu
         ySgub7S28tYg6QCSkT9Mr17ToYX9GnV4rZ0fIkVCOFb8TBh0l2Wr1ArQzSjWGCsDxelY
         r9FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1792395280; x=1793000080; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuLQGTBq/GHWEdWfb6Pl6kV6ni5j9Kr3GuQHGNwnH7k=;
        b=XwUSu697Lv9ee6OEmMvJgkz2ewk8k1NOLtAhirHxyYwO8wHogzkd7KkKXDGq2f0XxA
         xNTbesQmT5UCzFFtErfsO6q+XU/ZJO/QztLo45yuVEkcV7SjS0eff1YFa4B4QRNJSPl8
         Ky1UM6QccI2zF+OXG6k+cDRHxhmzrc6QzjXX6dly5DEor2hLLQsLoYAHBc4s3sSpC33F
         dxO/hqNSLhci7kD42ZLQuZc114RnVSHm2A2pUDJrvOWsGSdKY2zwe+OyP0gNJKR0sDbw
         hvc7lNeflrzCEvDQMyrFkiDvvir9TcpNJ3r6PY2B2+3x1FNQbQgjTmNYq/e83a0g3P0l
         9vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395280; x=1793000080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QuLQGTBq/GHWEdWfb6Pl6kV6ni5j9Kr3GuQHGNwnH7k=;
        b=ldU+k6oWYrAz2x565JNe9+HdLd3+VrPZCFWlfUIQNLU5Aex6eGtHzQYbKLJU4P6dnq
         v+oVWkDsRxsPK+4ZdVoNb0mf2uA+ZSsj8A19B9guqkFEsFOlT6nL5Vhrvi8eaE0TqTnp
         NzWDcZHgbwqTNyTiD/eAHszaCxd9KIOouxmSR8Nvdfj+BEme0+1a5qa+G7KH9drq0s3p
         iA5T77u+jlmt80rTWz9uZkzFrlTkMyKzqE1ZM7xYGW0jp8dS0QxrXrqQqdz8zlcX32pR
         tFCrgCBEPzb+DigYkwJWYmPQw7ppX3nW+B1rG9nfNEpM86UAjqdnYbNq3EDuBn2DEn6t
         GV1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwx7wixjL/MrtinOTUfPPUu9Hj036f6+LIbvR7jVNrOdIjecHKElq70oJPjhWe9dylbzBqHrIFEkug=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIXk6xVS+aNHSagQV8IfjbwI7OxL+52OfgTc5BYKKetf18Ji8e
	vGOp/JVZp3Ua/L5WUXvnonn90DhCaguTM2aHuDihnVEW75+nCsjJhr/L2VAYhmjcEuWWly06xwF
	g2b8AA0I/B/GB7hgmASrPRokEDzZEkjSHqLT+UH0M
X-Gm-Gg: AYBFou0EPMLET2IdXVKeQe8AyEkVOGYTHQwV59B1mRv8JDecGFB+Ba74Fgo4XMkl5M4
	17OclVqKBRBMPLS1j80jToeRKzLQgOh4Ux0CRZciidRbXWZ3Y8ZRpEcoaQrLc8Yg8Tv9za8WFeM
	4UATnfKnxXh3opl34XTqQ5l7e1WFpTKQY2ChO5JZiIukd/ikipAK9wEDT5wkfOGUS9mPCABOHiK
	RnDc10up0FYbyVj7M6xHpldHu0jVMA4cIc9AZkC5Uzxy4cwZBx7I71/NZhmxrKsRuzP599Lqte8
	MxMg3VxWu8Idty/JrQd/0wy2sm18GpB0YP3DkLBzL1ddFzSulESd
X-Received: by 2002:a17:907:96ab:b0:c40:38b5:d784 with SMTP id
 a640c23a62f3a-c419e23dccdmr466129766b.22.1792395280534; Mon, 19 Oct 2026
 00:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917110121.631587-1-salah.triki@gmail.com>
 <CAKv63utdoBrCFiw8vkGsMhY9PrWX0DWdxqP5szvTGpdmfSQh5A@mail.gmail.com>
 <aqvoH9ohxkJ6iPei@pc> <20261019040135.1da889ec@jic23-hlaptop>
In-Reply-To: <20261019040135.1da889ec@jic23-hlaptop>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 19 Oct 2026 09:34:04 +0200
X-Gm-Features: AclHuK8Qhha2TFYgLBfys_ZMbGLsTyM3cX7mEN5gt3EskW5QE0v2YufftZFcLiY
Message-ID: <CAKv63usdo_QdcRyFrUvym_=_203CXLK55irpiPyVeipRNw1nEg@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90614: Fix dual channel probe
 condition check
To: Jonathan Cameron <jic23@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
No objections, but I wanted to test it and can't find the time for
this sorry. I don't think I have seen a single channel MLX90614 when I
wrote a driver, so maybe that is something that came with 90615
patches or later.

Best regards,
Crt

On Mon, 19 Oct 2026 at 05:01, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 17 Sep 2026 14:16:15 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
>
> > Hi Crt,
> >
> > Thanks for your feedback.
> >
> > Actually, the patch primarily fixes the behavior for the MLX90614.
> >
> > In the current codebase, MLX90614 has `chip_info->dual_channel = true`.
> > Because `mlx90614_probe_num_ir_sensors()` checks
> > `if (chip_info->dual_channel)`, it returns 0 immediately for MLX90614
> > without reading the EEPROM CONFIG1 register. As a result, dual-channel
> > MLX90614 sensors are incorrectly registered as single-channel devices.
> >
> > For MLX90615 (`dual_channel = false`), the condition was bypassed, causing
> > an unnecessary SMBus read to EEPROM CONFIG1, even though MLX90615 only
> > supports a single object channel.
> >
> > By changing the check to `if (!chip_info->dual_channel)`, we fix both
> > issues:
> > 1. MLX90614 correctly reads EEPROM CONFIG1 to detect whether it operates
> > in single or dual channel mode.
> > 2. MLX90615 skips the EEPROM read entirely.
> >
> > I don't have physical hardware to test this on; this bug was spotted via
> > code inspection.
>
> Explanation makes sense to me and as Crt hasn't come back with
> a reply, I'll assuming Crt has no objections (shout if not!)
>
> Applied and marked stable
>
> Thanks,
>
> Jonathan
>
> >
> > Best regards,
> > Salah
> >
> > On Thu, Sep 17, 2026 at 01:27:48PM +0200, Crt Mori wrote:
> > > So this fix is for the MLX90615, which is registered as single channel
> > > operation? Did you test on 90614 as well?
> > >
> > > Best regards,
> > > Crt
> > >
> > > Crt Mori
> > >
> > > Melexis Technologies NV
> > > Transportstraat 1
> > > 3980 Tessenderlo
> > >
> > > Mobile: +32 492 46 22 15
> > > E-mail: cmo@melexis.com
> > > Website: www.melexis.com
> > >
> > > ----------------------------------------------------------
> > > The contents of this e-mail are CONFIDENTIAL AND PROPRIETARY. Please
> > > read our disclaimer at http://www.melexis.com/mailpolicy
> > >
> > >
> > > On Thu, 17 Sept 2026 at 13:01, Salah Triki <salah.triki@gmail.com> wrote:
> > > >
> > > > In mlx90614_probe_num_ir_sensors(), the check on chip_info->dual_channel
> > > > is inverted.
> > > >
> > > > Currently, if dual_channel is true (MLX90614), the function returns 0
> > > > immediately without checking op_eeprom_config1. This forces all MLX90614
> > > > devices to be registered as single sensor (num_channels = 2), making the
> > > > second object temperature channel inaccessible.
> > > >
> > > > Conversely, if dual_channel is false (MLX90615), the function skips the
> > > > early return and performs an unnecessary SMBus read on EEPROM CONFIG1 even
> > > > though MLX90615 does not support dual channel operation.
> > > >
> > > > Fix this by negating the condition so that single-channel chips return
> > > > early with 0, while dual-channel capable chips (MLX90614) proceed to read
> > > > the EEPROM configuration register to detect whether 1 or 2 object channels
> > > > are present.
> > > >
> > > > Fixes: 3d5ead238bc8 ("iio: mlx90614: Factor our register IO and constants into model specific descriptor")
> > > > Assisted-by: LLM
> > > > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > > > ---
> > > >  drivers/iio/temperature/mlx90614.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> > > > index 27d6ab5f5d7a..4f79da1f905e 100644
> > > > --- a/drivers/iio/temperature/mlx90614.c
> > > > +++ b/drivers/iio/temperature/mlx90614.c
> > > > @@ -565,7 +565,7 @@ static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
> > > >         const struct mlx_chip_info *chip_info = data->chip_info;
> > > >         s32 ret;
> > > >
> > > > -       if (chip_info->dual_channel)
> > > > +       if (!chip_info->dual_channel)
> > > >                 return 0;
> > > >
> > > >         ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
> > > > --
> > > > 2.43.0
> > > >
>
