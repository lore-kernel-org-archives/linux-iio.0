Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFC383C9D
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778358365; cv=pass; b=ocUaFPGKHSG2t6E0oknC+rfSBpDSPK19z8hKSMsn4UYm5OGmYCTfTl+tLVZWmLQCCgx4fLXsvQxLwjQNVopKQxFZpQ7GSt+B6557xoDPvX63oWoT7eCj+kt6Qp2XJzeEKbYOZpa5etOiayJFN+MfRS2XhS67KRRYdNMNyLbieaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778358365; c=relaxed/simple;
	bh=su+isiQqtQCsNpLq6V2xgnU6bpChhZzlORZaROftQN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqhJYBFjQRXmbjZ8OxYv3CWOXI2Vkg5D4BuHjW4b21t7IxEr1lvPUgaGZfq/zcYyRrhrXNQ/KB5gdRP9yvfFaig4BfTJHxgvIuws6fO55MM4YJcLrecH+gtiH9m2cw2tu6vH5OUWFusL63juU118rWfpFJM/Dp32KaF3ickkVVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FriHj4fo; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FriHj4fo"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so31360827b3.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 13:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778358363; cv=none;
        d=google.com; s=arc-20240605;
        b=VKfPS9gLAtcDP604BI6tjam4Vbvvgv4Bjvvp100DCl20RsCqcVc6r20adfDEcmunu9
         uEao6Ku/ROoMF1nmnzkS9FwVjpIgrJnISMSE0VUTEfWZOEt9M49Wykr7mgio7cQjTj5A
         OaBaE0/mpT+hvcBh7OzMEyHtk+7ObDuPI95EIZnKy0Emf8GQaRDte5A1+Y94/C3Niz2K
         FKHSard3EBIJE8wiPlp/i9NcMuKEdI4W4pGsioZpW433zkZF8XzK4I+LbOquJO51FId4
         E8HGUPWpI5+NtOZ4v8tQT1Le03UlWP6NOPW6BUt9p+lzw0VzwGDjh8yFlqFOm5ml8KbH
         rn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8YQsGP8uw0vp9urmqjIKxpnukHxbZTJqWmAo3vcZPw=;
        fh=dSamLi+tpVxjJn0W3wBFtJV8ayA543PsMJvrCgnNSLw=;
        b=lJVk4PZ81jM1B/tJ7bCZxuQudqLiWWLj3/8iKtWpnOaTAbWkeBrdDQFT7BRmts41ix
         sX2P+HQfItEO3tLMeI5PD7cfJlKz4O3bJVlE7zsMoe6bTHTLPDb7z/mvKKoWGO9iqJgE
         kuEraZQR9PRCKkBpErDtVCoHKhYemN7J3fwSef7Reg59bFAFP2nSzoO+zI6Z790PhFsC
         NAfOVoEli9kore5Crm+QWYVxG1xlEFjZVRp6unw3wtHSOPH5YxuSXvxc/YLttgXgWCw+
         lfWVh3z9jZ71HrdLKsytGDu/ZSOSBKA/8qvIbVk5/ko8ZyCw95FzPE58tbdrM9/JEaNw
         j0Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778358363; x=1778963163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8YQsGP8uw0vp9urmqjIKxpnukHxbZTJqWmAo3vcZPw=;
        b=FriHj4foKAEpjNLezBXFoV+6d+rL77w0fJIs7EVlgKvhwEJZJy5jPFmJN8KFsVNiky
         RKHHjxV62pm2DlofNieFXpPlaFVZML1GvezayHD234aytVj2miYzo7rJA0cNuxaElBqf
         18+VnDBPtRmrjeLdih2331UroCOS/i7jaiktEnX4Uxo3k5Ms7UMVdaBekKlJ19+1JycA
         dQuNBQYA2r/ByePORibOb+ko5GbeQX9azLzz9tp29OhQ/BAsbX9WJrdvdRtmpiYrehWC
         Zdxis/HDd+EyGrFbLof7icjsK11XrQ9bR7HlZSWs4RwnjSM0BaROf2imru10TKy46/dc
         ki4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778358363; x=1778963163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8YQsGP8uw0vp9urmqjIKxpnukHxbZTJqWmAo3vcZPw=;
        b=YYkWRBmmuJpOi/Z7gRmzNLd5D58YalBz9iUVhQceCt/cgH7T9M9l8t7q/q4RnswedZ
         oSioM7I5QW3ID6lS5rHqc0TU3h+7Yfe5O+AF1i/4jGam2MgBCFrUvuU+QKf9oc5RNeH7
         MHA8JswClUmKjzzSmvvnrOjWhGf3dLs7wN/FkAnoev8p8NvDLSHneV1m0hwoURd5/bir
         pFpt2y2/FahVOqQU8juD8Cj4Vs1ps8Y9RGwi1uymmBADhYhc+Q3reQUxxf62VDs/vA01
         ADIOJKREsrG2bvI5ObzTF9tb8rryiLnEAlctOTDrHWpIB9WAj3QIzlWgfQhtdlZ31Wh9
         K3Xg==
X-Gm-Message-State: AOJu0YzlSI9USJe9Q/4Aby5yw7M7xkPR/O0ufUv41PpbnfH+zm/jZ4n4
	o/QBiPhwXN/1sVqQFfVx3ri+hQJl8pegA0kG7B4LR7zszAjnnTvvDyjzvbwCFGuicpMYfvLOyAM
	WoQE7+EDTsfSThb4XIHDKleDNaKqbK34=
X-Gm-Gg: Acq92OGJStdE/LOR3MM4wHwXg25Ee2RwpzrfCBUsIUn9VhdVdtugD4u0In5VudbEf6b
	urCffbzgYSLyg0mPwBcnB5kyt3VQMdLJNA9EfCrXZUpNQoI4GLEUgu3S5HI5IB6NpIKSBW2JAvG
	EId5fAhbf+3Ei1Drj3mcr9in+PfoPxoqycejRj9VU7tLaM5ESPSOa4EtUur96FJpJfJ5nGjrM4u
	OsB8mRm03e7RoWeCKPjXc05EZtnr3bXubve7/eBv+vb0pXskGa8SYSZQmvSNOy30yVXSMmyKTgD
	dBbT
X-Received: by 2002:a05:690c:c6c3:b0:7b3:f33:35e5 with SMTP id
 00721157ae682-7bdf5e07727mr152824747b3.16.1778358362999; Sat, 09 May 2026
 13:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509090320.85481-1-dennylin0707@gmail.com>
In-Reply-To: <20260509090320.85481-1-dennylin0707@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 15:25:52 -0500
X-Gm-Features: AVHnY4Lsr7DnfygKRm3d_eW32fDtFl_-Ze2-Xadd1Z7KS_jr9JbRFTdGKxviX9g
Message-ID: <CAKqfh0F+rAqAwdu=BtagPa2D-F-TANm8Tx3RCOoLyZXkYAn2pg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: addac: adt7316: check SPI write errors
 in probe
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 4:03=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com> =
wrote:
>
> The probe function issues three SPI writes to switch the device
> from the default I2C protocol to SPI protocol, but ignores their
> return values.
>
> Switch the repeated SPI writes to a loop and return an error
> if any of them fail, as failing to switch the protocol should
> abort the probe.
>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
> Changes in v2:
> - Return error instead of just warning
> - Clarify that repeated SPI writes are converted to a loop
> ---
>  drivers/staging/iio/addac/adt7316-spi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
[snip]

Hmmm...has this been tested? Normally patches like these don't get
merged unless tested since we need to know how the hardware would
respond when we hit an error case and quit sending data, and also some
of the timing changes introduced by writing, checking if its an error,
then jumping back. I've personally tried this patch before and it got
rejected so I'll link it below since the questions that you might get
asked will likely be similar.

Link: https://lore.kernel.org/linux-iio/20260426205039.125818-1-m32285159@g=
mail.com/

best regards,
max
