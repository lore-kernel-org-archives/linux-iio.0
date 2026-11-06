Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979917;
	b=x5TulZq/4tMU9/jbULPCAeYmpWnziBXoO+vrbOkcY4d0zgdZ3nT30oU60YlTYCmjKnaB
	 8Hzh8L+pAnNdeTjQiuDpDc+KkYVnzGKjEogVns5i8G/Aj5uIPyA99xrs8RqZrKW7a8tcg
	 H/VIk2bZEYapRUuoTyIXfwqPu91Xlx9E5TIX5ajPYvNTQXWpL/5B81yWyxn/riRshaGOW
	 X26FL9wxORnj/OXVpzMpJTQAygHCL23ePq7GP6Mhm287gezFv2c+Z0BITPfUde7selhjJ
	 HKPS8oeE5SWhFHp8p5ZHnwMEW+4L55dB8s5BPClornLqkGzvjd9zlimdGbiTHrZUJmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
	b=ug9BWb5WRAULHWRNOZT/B4p9/aZ1qgw9VNHxNS+ZLY9Ygsdh+2ykGK+yicSC1N+gBKvS
	 2ufWY8g9AX346t+hFuIhPbk54CAOgrDuvPTz88JUIknLEbhfbrRBb2NykvK86PLnFoPO+
	 JKYCotzPmuxfYExrLaYZ5wf6L54oGLTkBU5cKrtZszthBfFgq0gDOto5nBzeKESMf+9NV
	 KkphR4VK32tZO+bCy7P/FyypsdzRZ+Db3K4RLxpJYKDgKFSFS5fQcqMtTUYSER+4HZxHW
	 3JLM6JHhp734frjbM1dxoOBZX2zVj1fPAT+HgrXzu5LwBUZI/UmVU+WIKLhsMDJhnMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVCIfsqA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09564606D80E
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 15:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09564606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVCIfsqA
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ace304021eso5451091fa.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 07:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793979915; cv=none;
        d=google.com; s=arc-20260327;
        b=shAOTcBoFT3ojZ5y29jqXpX8/w8u5pMYDmjm4ARdsH1PCZNLchHz9lFzH7Mk212Uim
         9JLvS9YpvQQ/9131hPUfzsb2ids/8YNWMaqnzXRxcxm2dRoUrA2dRoSdv5w7nLqSDZH7
         TrWqE8ptF0eQb6VKBXm2Uz9eNW72dvnXdo5/Cw+SVceHNcYzMbPpoAZSsZ3ecWU0cZx8
         yP/0WPmLIQMaU5Y1PeUNa8jDe1+Pbvlj++eYggbeTnauGlYb4w3O2t3shXIPQ3KTF6TO
         Hl0aZPuftl1Ax/osk5E/qlNPYyEV1YYYMFrfi3Lv4mB+81NcPKfskp930FbCKjR4/ZNY
         wuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
        fh=/hf/ipXFGffJmJ5LN60p0acBmzh+GIA7e6dfvEO2zKA=;
        b=pYS24KQhnYaZodi843Pm7Qh8h5/48Wz3qa+jSg+YdW0JBz/QqaZd+M3+jMItt33hmS
         YIzArYPZKUZBa55i3nx93x0bnjY4W6bjETfIp3eia6B3yqEz7lKK+CkDnWiYV+XAq27S
         C11G7nS+6ccSx5dSNJSo8UMElwCcuo/00htiWwgAUlB0QEuWAugRRYiNHD01icQpQ9Pa
         9Z9vYIgy5ntp/5CwZll1mWuB1jenYxEqBhjvncS2XOcvsisXZwuGeXn0bc4/lzoT4ihu
         NjY8jKB5vyqFcII39MUVk5ze0y3sY6L/zSSe+QjKCahIcQKoP9y6Bw8CmkLlL1GH2/d9
         FUxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793979915; x=1794584715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
        b=PVCIfsqAf5aued+4UX32Kej7j7opbHVpjVXl5FZhp8j7wmRx+DasE0lzqCRuCo3clz
         qpbZownOonc5iRdpEU++sYYh99mbKPzkdcUIBKSCWol08MUuBedGLqibNKlos7VlUh8r
         7A8x1Glzqk56FB6vNv9Ay8IAYUnQcclrwpbPUNZyW2agundbnQWocEB+qhdWhxiy0Ggk
         OlnGvRba4fyzYD+DqcHCtBwKjxZ+t+hgEhg38kUVvHd2alHoa4rKFCAGAJ6as4EvXDZb
         MrDVN32K6YE4CsqwBhQfmd3ez5azKL4hFjGjVZyDnPpHWxOysMEkGFCjyPG47s4ObB3R
         evmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793979915; x=1794584715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
        b=sT+8De7CpruHwpz+ljaQp0Sl2CJnC/3h7f+8mqd3BqJgIR83UAr0W9RhoGZll+Dnho
         iPync+DNzqvkZoPU3SylHyhoIu2qh7SmQktQMxVj6swUGIbLaL3tKLnVlEB+nylECMk2
         i2FE0PtKgNdNIRQLC0hYwDUwJ152OcFY2xhoZTc354/zq8FhE3MCbDhE/bfUcvV+1mc4
         b/DUb7oOx+fK8sOiYv6WXprynvb3FflbqRjnSZ8VF0ojYHKcimz8oZIa3LlujPTDKjzd
         02JbPYWD4UKXmJpTwZjoX7amtVWG3CNrPyh1mbcxZopY99r4a163cUInD/qRLxYwEg1O
         0LoA==
X-Forwarded-Encrypted: i=1; AKwUvBywMOKci5Cde4ow89wDuSMt1WEBvKTxP17NdilLWpmAlC2Pba5wNziTaVJ22tgGhHRslfqYsq8zz9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ykXrtngCy9BfijS7CA/A+S1tFWc45kWIoRt63cQXRY6lH07J2
	WHIS3gdExYsk85WBKgZ1CGj+yfLXVIb+xCq2JuxWqXFmHbmdhuhEgIbuK9rvk49rWJNHVlmtelV
	SAGfoq8tZbrtfl4pM/tSLRb3v91oUImI=
X-Gm-Gg: AYBFou27T77/Qlt75PJmHKIgRdSpH7GNBYzVJaFxpcDq0wnRZtk7w7P6jonNM8gfn70
	4dmxfnrVREnVv4qfonol2nSDAjtK6rNGEgE1yJu54trcqd3njmiOASavT4VOZmxpeEfRjt8LxN7
	FLd8mJ4DVRksOk/xGYiulAaLeazDZXp465SA40pC3rnRwCuZKIot2GKZwFBawBIEU0g1QN+rQ4m
	QyQBJZaDB9P3U+bpSyV5CZWzJQCjCG9Ef7NDlCqpNIB0t3gnycGJXJNLg5Wlzv55Gva2GYGxk9m
	xc499qOlcAXQFaIRbbxZ7beShfnuwhAeke7Mdzt7oLAbcFcXuwtwbOU/dJHFtwD2IhLmRBP2Yq6
	J4YZACxkkdd0J0tkAzx06Le6gdFVzxGS1q2HAe7A=
X-Received: by 2002:a05:651c:1612:b0:3ab:2a19:8624 with SMTP id
 38308e7fff4ca-3acf3a11804mr5879131fa.5.1793979914945; Fri, 06 Nov 2026
 07:45:14 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com> <tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com>
In-Reply-To: <tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 6 Nov 2026 22:45:02 +0700
X-Gm-Features: AclHuK-XTflrXNbXUwnG9Gy_4IC-jvOmhlr3UlYx53CWnDfOKCsQP4T4U6VaP7U
Message-ID: <CAO26r3TMHb=YxzwS7DYDUTS9U454zrq05yC-b8ojva-pAdCsRg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
To: Shuai Liu <847807867@qq.com>
Cc: Igor Korotin <igor.korotin@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Brandon StJohn <branstj@gmail.com>, 
	linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 16:53, Shuai Liu <847807867@qq.com> wrote:

> 1. clippy warnings
>
> `make LLVM=1 CLIPPY=1` reports four warnings on this series, which the
> Rust CI gates on. Three are `clippy::ptr_as_ptr` in the IIO abstraction
> and one is `clippy::useless_conversion` in the driver:
>
>     --- a/rust/kernel/iio.rs
>     +++ b/rust/kernel/iio.rs
>     @@ -202,1 +202,1 @@
>     -    let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
>     +    let priv_ptr = unsafe { (*indio_dev).priv_.cast::<T>() };
>
>     (the same pattern at lines 334 and 397; line 334 is already inside
>     an unsafe block and just needs `.cast::<T>()`)
>
>     --- a/drivers/iio/position/as5600.rs
>     +++ b/drivers/iio/position/as5600.rs
>     @@ -133,1 +133,1 @@
>     -                Ok(IioVal::Int(angle as i32))
>     +                Ok(IioVal::Int(i32::from(angle)))

Hi Shuai

Thanks for catching the Clippy warnings. I reproduced and fixed them,
and the Clippy build now completes without warnings. I also replaced
the ignored, AS5600-specific example with a generic `no_run` example,
which is now compile-checked without being run.

> 2. ignored doctest in the SMBus word helper
>
> The example on `smbus_read_word_swapped()` (rust/kernel/i2c.rs:841) is
> marked "ignore" and references driver-specific facts (the AS5600).
> Ignored examples are not compiled or run by rusttest, so the helper
> currently ships with no tested usage. A generic, compilable example
> works here:
>
>     --- a/rust/kernel/i2c.rs
>     +++ b/rust/kernel/i2c.rs
>     @@ -841,8 +841,15 @@
>      /// ```
>     -/// // AS5600 stores the 12-bit raw angle at command byte 0x0C with its
>     -/// // high byte first, so the SMBus (low byte first) word result must
>     -/// // be swapped.
>     -/// let raw = client.smbus_read_word_swapped(0x0C)?;
>     -/// # Ok::<(), Error>(())
>     +/// use kernel::{i2c::I2cClient, prelude::*};
>     +///
>     +/// fn read_hi_first_register(client: &I2cClient<kernel::device::Bound>) -> Result<u16> {
>     +///     // A device whose 16-bit register selected by command byte 0x0C
>     +///     // transmits the high byte first needs the SMBus (low byte first)
>     +///     // word swapped.
>     +///     client.smbus_read_word_swapped(0x0C)
>     +/// }
>      /// ```
>
> 3. repeated unsafe blocks in the SMBus access helpers
>
> Patch 2 implements the `FallibleIoCapable` impls for `u8`/`u16` with
> five near-identical unsafe blocks wrapping `bindings::i2c_smbus_*`
> calls plus error conversion. Extracting four small safe helpers would
> put the safety argument in one place and turn each call site into a
> one-liner:
>
>     fn smbus_read_byte(client: &I2cClient<device::Bound>, reg: u8)
>         -> Result<u8>;
>     fn smbus_write_byte(client: &I2cClient<device::Bound>, reg: u8, value: u8)
>         -> Result;
>     fn smbus_read_word_data(client: &I2cClient<device::Bound>, reg: u8)
>         -> Result<u16>;
>     fn smbus_write_word_data(client: &I2cClient<device::Bound>, reg: u8, value: u16)
>         -> Result;
>
> For example, `io_try_write` for `u8` then reduces to
> `smbus_write_byte(client, reg, value)`. Happy to send the full diff if
> that is useful as a starting point.
>
> With 1 and 2 applied (and 3 sketched on top), `make LLVM=1 CLIPPY=1
> drivers/iio/position/as5600.o` builds with no warnings and the rusttest
> doctests pass.

I also followed your I2C refactoring suggestion and added the four safe
helpers as methods on `I2cClient<device::Bound>`.

Thanks for taking the time to review this. I'll Cc you when I send v7.

Thanks,
Coirul

> Thanks,
> Shuai Liu
>
