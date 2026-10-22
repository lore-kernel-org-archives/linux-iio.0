Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792685133;
	b=G8gjly1hgMAHjtVzXU8LQMeUvZQfAahLTSp1btN7olTXnrpJ/GU3nAVZk1zUXYQ4Jwd2
	 liOTX1Du4fMBcgFap32K6kXYXlO0K6xIlngWLJFxmuBnKvufIYm+8UCAZyHHJp6t9Chuu
	 gwg929cPplNwwlkxsAimoUhPYkjoTtFnH57qb9WJFnd2J65g8PIGSyMz32OqlfAfN2OtD
	 LQFiV69H5g66UL3ReJtRRt6jiS47k7Ob5OhrzCNhuzTd8B+vM3qtEBVKeTjRYkLosuBJc
	 1uYGq9f9/I/Er2MS4Re+qF8iSPx+kObb33yRd6W7/Uum0kEZlJWF2gvpE9RYOuaWMmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
	b=D9DACUPCc4m8dXbsxuNrCJgVMSF2qAnsdRROyi7PlkdumCkvFjrbt1d89aUmJNeS7amp
	 HDIKqUiSKDj/xlzTpTHd1DXmjI0ozLhUqZpz2k18NfMk6HFWEY2qGGilUkSagnmgntto6
	 tgPIV1wb2nn/TBH6p4jvE/dsVOFBgdQ+36GGt/DjgP9+faf6URXExUr0Nx4f5lIfaK+t7
	 MKbkhVsgNp2SrQkszqwclcIQ+oReVTM4AOcChcjvzC5wSIbaGdrpyCto/h4eonqTE5zVZ
	 MhtHXd/5RXK31F1vn5FR+sj0OSWqQcxAATRgIMrbDaOVtsdBdAJGHRqhADZ5oFb1G/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=po2Ejtmm;
	arc=fail smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0F606A31D
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 16:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D0F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=po2Ejtmm
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ab4354db11so15087251fa.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 09:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685131; cv=none;
        d=google.com; s=arc-20260327;
        b=UOS9UqG9jrwrUem/TZNeWAE5rmq0TMG4nguRp8o+QgTFERGT0sM48Ox3mUvM57Aim7
         vyEbCfirQKprC4Z74wKKm+61OFt6GfDrVAW1vnBVmngw3+4aa3Y6cRtCyBocgd/i+Lwe
         lUV+6+v36XoponUdxEZ2HyrHPBMcryfD0P4btsRaaErnCxlMvgO6l4WHKePWyxcdTiO6
         LSTMAnsDlgsZgMxTYvLQZw6gv+KVq8507c8A3V4rKunQs6RLo557hfaEHpDxURZpHUMZ
         /Ki5uefclQZOAPBsM115qboFmuYemp+IL0vDyj4WunETOr7jKAL+pcIbDSR4jP9rl4FY
         esng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
        fh=ejmfmuOxXxeDY7ikyfrikM1XzzpABIirLNeJ6kfEgXY=;
        b=qjmZ8OYu7ny28Eb9i8HKXr6hoOr4bAqe0Sd4eJlGLgLDr6hUz6eGJZ9rl76AjwOOKH
         N5j9BOqWxlNZOsC1vbyeP1lANNNeI/YDP5oLEvdIi5eweuz924o9iuRRiHmZqSAHbge0
         wneJ2j9UtO0Lr+nqgAxzCyjTuQcQfSs8PcCwQrM/Cthhcc8VAPhVjxHG1uj3/kwM3Cv6
         oT6E2SntW2Lem5h5z+jVUvYMoCupakoxc6AilsaTi7/IzyY6i2myf48sw/gHg3cYVJT1
         J9mj9/pao2pHzYW5bUZkoqRQMYuHHPAtLNivf2cX/EZIC25crrTSY1hu1YonwrMbkAmy
         lmRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685131; x=1793289931; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
        b=po2EjtmmhjEnBHkbQa505xq9tldXRzLLiYUKajpmJEW6SybEo90CZ0lqMjVa63jsZc
         hBqO+hVyyfp3yMA3aOmJ/rYRiZTHJeyhNRuTBX5d7el4UNaAUSpUj0iajRk30E1ugAdr
         2G4T5gLJtkMgJThjAbkjcfdONnuZbru9nEP8pIO/2nmPriJoUBZnQekt5x2y3lec11md
         bQ7OfvBEGTrDvpc0tQtmEBfFcnEXfoKGYpnbVi8qY5k+7PRNl6d/wifiA0bHvzixl07I
         pvFROBWdh0rZOyDKhlPSor8xwgaeSIbOVGatbpAHmH/8+VTlGB27UgUCaThtBfsY4u0z
         WE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685131; x=1793289931;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
        b=ftiVK+PwXeVcgkHVGg0Jbqh6l/L7he85O/7TClqI/hph6aAXpK9ackBI9GWci8xg0O
         oaU7C2JLza/tCeIOxX2Cj3YNuogos1mjBNxi06Au/lUB4qarfehm2HZ074R7ORcNs8wt
         ZOfXMlmJy/bQai6y46ntWrI7ldQcNhgs8MMGsAsXxvT2/DzTMxCWruv7m3kdu1LyYxIf
         mcQMXh+NWwTr/XmpT1i5eoBKCHAhz9uVIZ+4P059DrpRX5Bw8DwzPMGIpl2EP/9v1e1M
         /rtp2M79Rsrl7+FEKTztifimfumVV9WdfZWGCkK42Pm6X3SLtfJUnVWinQs/bO6eLeNv
         jI9g==
X-Forwarded-Encrypted: i=1; AKwUvBzFChXYBLZpHpe1jU3zfq1XpDz60knhSsGhKtUG5SqysZ2DC4phLUKdiXqx6qjh+Vpp5+mJAGj1zRA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTml39pW+qQk0VZn0UWk+ZxafxrsQF8vO2mvnw8PD6JTQ32aU1
	dMnRvq3cVmhEy1eL8MrT4STUQ7ujkQijC++vaKhCV+izQnk15g4sbVTtAEpKOiRe+YQLtMxp9Yu
	DGIll4TJtYfKhqtywQz5HFP4SoVfm7lE=
X-Gm-Gg: AYBFou1ZP5NujEDcm1eOaR5ev+6qH+ds9TPjTg1azFdbR84CUt5lKArH7eAmhEWOIPx
	ygkl/O96Sk2mx7DJxMWDjFdFY0i/wFFsI0Nixy89BtmzY3M7UqzT1r8KwszOUkQcI7X1SyWpG0M
	K1VAd0Oi3N2EwsYFShV2W9Ya3JEPxEBJEQuejnPnKVJY09fFhB+5IvVCk9lpIhS5nFw91Wl//ou
	uS/Hr0NXkX+rX+E+gdFUaLsHdUAtJ6LIXxJoQ605UI+neiWS0MQ/vDE9vps5hnudoQUKOvCITOA
	hOXEbOiG/qWTMndglJmh5dhvV6U6UdSobxzmC8wytAXEkG78siCVPZGCVHu4KB631Tp9e5gyTDh
	VU+W99zAvas0tB6qCoCKsHkvTENUoleuh2L4P9w==
X-Received: by 2002:a05:651c:c01b:20b0:3ab:3f1c:c2c0 with SMTP id
 38308e7fff4ca-3ac441adcf0mr12071131fa.22.1792685130710; Thu, 22 Oct 2026
 09:05:30 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com> <179260197668.3127.18219777718091081046@linux.dev>
In-Reply-To: <179260197668.3127.18219777718091081046@linux.dev>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Thu, 22 Oct 2026 23:05:18 +0700
X-Gm-Features: AclHuK-_6y3CZAcHO0wx7PGRH7qXj55F0nJkQUzx_zuArGiTC_UADw4Zf8xvi5o
Message-ID: <CAO26r3QK+Q5=JR5TeMzEX-WiLpgYWd8Zn0O1qx11LxTgN96BPg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
To: Igor Korotin <igor.korotin@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Mark Brown <broonie@kernel.org>, Brandon StJohn <branstj@gmail.com>, linux-iio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 23:59, Igor Korotin <igor.korotin@linux.dev> wrote:
>
> Hi Muchamad,
>
> Reviewed the lifetime/teardown contracts you asked about. read_raw() has
> a problem: it takes parent: &Device<Bound> and recovers &I2cClient<Bound>
> via TryFrom. That conversion just got removed upstream ("rust: i2c:
> remove TryFrom<&Device> implementation for &I2cClient", use-after-free,
> unrelated thread), so this won't compile anymore. More importantly, Gary
> Guo made the point that needing the conversion at all is the actual
> design issue: a class device shouldn't reach back into a generic parent
> reference during a callback -- whatever bus-specific resource it needs
> should be captured once, at registration time, and handed back via its
> own private data.
>
> Concretely, this means dropping devres and letting Data<'bound> carry a
> borrowed reference directly, which it's designed for
> (Driver::Data<'bound>: Send + 'bound):
>
>   pub struct As5600Priv<'a> {
>       client: &'a I2cClient<Bound>,
>       #[pin]
>       io_lock: Mutex<()>,
>   }
>
>   unsafe impl Send for As5600Priv<'_> {}
>   unsafe impl Sync for As5600Priv<'_> {}
>
>   unsafe impl IioDriver for As5600Priv<'_> {
>       fn read_raw(&self, _chan: *const iio_chan_spec, info: IioChanInfo)
>           -> Result<IioVal> {
>           let client = self.client;
>           ...
>       }
>   }
>
> In probe(), capture the client once via deref coercion (Core -> Bound)
> and split the driver struct so the registered IIO device carries the
> same 'bound lifetime:
>
>   struct As5600;
>
>   struct As5600Data<'bound> {
>       _iio_dev: Device<As5600Priv<'bound>, Registered>,
>   }
>
>   impl Driver for As5600 {
>       type Data<'bound> = As5600Data<'bound>;
>       fn probe<'bound>(dev: &'bound I2cClient<Core<'_>>, ...) -> ... {
>           let client: &'bound I2cClient<Bound> = dev;
>           ...
>       }
>   }
>
> register() then just returns Device<T, Registered> directly instead of
> transferring it to parent devres -- that transfer is what forced T:
> 'static in the first place, which is what made storing the borrowed
> client impossible and pushed you toward TryFrom.
>
> I built this end to end against current rust-next: compiles clean, zero
> warnings, and zero changes to rust/kernel/i2c.rs. Happy to send the full
> diff if it's useful as a starting point for v7.

Hi Igor,

Thanks for working through this and building the changes. I'd be glad
to use your approach for v7, and I'd appreciate seeing the full diff you
offered.

I got the lifetime model wrong in v5 by storing an
`ARef<I2cClient<Bound>>`. I only realized that while fixing the
documentation for v6. In v6 I stopped storing that `ARef`, but ended up
relying on `TryFrom` in `read_raw()` instead.

Storing the client reference in the IIO private data rather than converting
the parent back in `read_raw()` makes sense. I'll check the lifetime and
teardown details as I prepare v7, and I'll acknowledge your contribution.

Thanks again,
Coirul


> Cheers
> Igor
