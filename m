Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863D3AE18D
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785981291; cv=pass; b=CMDy9OdgiAVzIowA/PbNmlHsiALCjmtNyrMzUr6IG3qD3voCAuMuBuOV/gtfuUeEqViClk69YK4GAk7BWCINvfYU905UTRnufM/0TS8qWEOe4X1keMKvkqLtNqYE34aJeJjOLpy19q2RaacUTVz/IuvIPmEMOdrpeyCP/Upt2Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785981291; c=relaxed/simple;
	bh=AczqHU5YXkv/sGRytG5ILNrvmcbBaCPxNcePJM/KY2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g26fKxJjfdtgd1lVsa1r+EkziSpREFY1oLg2YolQiZMDgUOWDDZwnrvJtWqvHgcb6RDXYd153ROqM7RI7bRP/cmjy3dmfYtBe6eyN/YAFzr3o/ifhX4aaMGBKNBOvTTsUJthwMNenVbMwx6VjwP9tggz8w8XOGE2jdYV58Q0wg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARRbLNkm; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARRbLNkm"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso8965371fa.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 18:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785981287; cv=none;
        d=google.com; s=arc-20260327;
        b=ONGTfJAu8p6KSYPALVU43ZogACeCQ5Wiwu0v3WbRgYSsfAhJ/pLlcFr6goW2lI/82r
         rb2UvQ267/rtsTxqu07x92FbQiwO356MnS8oLDRPXj6hpbX7KmeEWajF3aRDt6PsaZsN
         XHHekUHf6APwpzWPp+cJgC0UXmBBWdVWc9OER8kQhrAfwy1vMZ7VDikXwsj5IX/W/edK
         TvSC7iRZpNjQ3MZobMPAsBklL1ZMlEQWj406lQkGiWfHz/t/iBixMR7KhvcOv3X9oaeE
         fcWaofBoSIBujyNKr1i/66CzTs5Gs5gTWnGQxlpsPsALRGEZzyH2zpZl9wZm/Wv9rpLy
         Zxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y0v+95FJN2xAeGezXtBHmiTa1Xgl32MRgRsBCWW8cqA=;
        fh=2PWiul75xYYLxXZO9QFVN63ZsWoFA48n5qoSQRolt70=;
        b=iZTboEhtUu9ZeNsCJpRT0UXfSB2Lb+JiEygalRiOqGP1yOSIfd/gP7d0Wqx0xNO0/p
         0FXUOKyNk/v6dl+A1yO62xEzHHNJ+9u9LRcXaxvppksyxNBq3PdeiIvZd1BVlP7ED/nN
         FsnUhTsr2cnxMCIvE8fO7MvGFathJebkDAU+GeOTUQO6kt91VVJhOMI1ca0UPbh/mJJU
         8I4A9nRtBoqsP4Zn2eQbjTowPwn0JhccpF6gIO3CXl8QsPsDfL5meRqmapWds2WINAPi
         kGHGAzcW8mWlEEQnPP7AkQ5iRszmwtl0LziM77cPvtRdU/IYIRPbZXR7kzIKOiHSPbZW
         mnaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785981287; x=1786586087; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0v+95FJN2xAeGezXtBHmiTa1Xgl32MRgRsBCWW8cqA=;
        b=ARRbLNkmhRQIYmTjCNnFVSCjhNvCHVq6agB6tyAWBA5c5P/MtstZLiVGD6gBE2nLGt
         ok/8crs2TTWqbYTqmToA85qJ24bwlYkWyazes+ZBawLvqTm0rfs32JiOlfSOBiZb2RQq
         uRiocUiDNst4ft99f8ZeGKu3IFWj2W+2xxG709G05ONEY38HXfxEw10hppjWDIo2eLkc
         igehXGIayAfTx3uTu34HpLyTPZB0LL9P8z9wbkAZj8O7VnoPJ++S6XrFOvioeHT75YH+
         ISGxynCPuWu4sLr8aN6amv6ik4Ax1/qSr+NpiS5klyUtuglaXr8DN7GcNVGYf/xC9b6q
         2mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785981287; x=1786586087;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y0v+95FJN2xAeGezXtBHmiTa1Xgl32MRgRsBCWW8cqA=;
        b=l7tgGXfpMqO4wmkd6rpbG06y6F9axGZqBvV8vVFDNJpkIFs1WQIAThgN0T8OXE1UrB
         Ut+sxVg/8D58U86szr3x8YvT0H7N2GJtOs3WeeKVTMp43DxtscbmqVDL6kGdsHlQbE4f
         X6elZbx9FtQQQQgQBSH6KhFYiFiWyaR59UDPncBCfAbhV7VcGDGh5KC9MGs239ficgOc
         1GN3Ij0EkcayopFy8bHifMTjyxd+Q5buMEbx/lRcofNlBDYlMC7Y7pTRDYOuq6mNqqEq
         0crmo6s90cL8KoMt9BvfOePn0EzRR2UItx8XZLriM+P8HV5uLWNN5heBd5RnV5qGXmdF
         h3HQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmRuZ8rQ7mzNj5DXGZVyQJ3vxtk9fRXKcLmPt/jYs3/sT/PSH706/KlPgo+KT9X5jbHFR3JkY+Ndc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5isMeA4M1NbRH99qwMB+bCqeKTmA67zHUxplTstWb3iKisOAx
	Y+7aNA2Teav2GQj9a/W/RwmtlevghAvIKZpLI+7a04C7zooMw2XwRGXz+Yvej9MazIogEyjW4jg
	eSFMi/4UVfvcKboKMdFCDcAWjskX3Q9dnYlt5
X-Gm-Gg: AR+sD10UTfvhx7+ldFRwvfqF/efKmvg/PMXHLwez3vN3pelpcfyUXS4MrDl2vc18Rv9
	GAB58wIfshmLnrHP7x2xRqGCrZez89QLRvqyx0uze7j/8hgfjnydEUQgpwt/E2OpEoyBRolbjDU
	UZJa/C6HNrf5qB6rgLEKamDlasLtNUCEAwvBkTFeO/WN4Tfj0YUwkf7Gtj9FkRBMLd8NlgYHLsz
	MX++h2W/uc6ZNjP0kePMlvuN7mJV3ShqZJRnaiYZvB07i8maFtEbNbIml9H7MDzhdOlEOt1n03C
	/LWiTdP8puWsu/K6iXelKTreKlCd6cmp0dSNRncwOqcdqMs=
X-Received: by 2002:a05:651c:43ce:10b0:39c:6e2c:23c3 with SMTP id
 38308e7fff4ca-39fbb1a77b9mr10575071fa.5.1785981287009; Wed, 05 Aug 2026
 18:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-4-muchamadcoirulanwar@gmail.com> <20260803021304.60316f02@jic23-huawei>
In-Reply-To: <20260803021304.60316f02@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Thu, 6 Aug 2026 08:54:35 +0700
X-Gm-Features: AUfX_mzWK4XXhsRESZ_Kmb2gu7WrUK0XlrPMF2qslyhsMb3pa9c6pviVSb90BcA
Message-ID: <CAO26r3R4TzKmemR4r060Bz8xGaAPZ72j8MCEzOHB29+xtBEsrg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams AS5600
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 08:13, Jonathan Cameron <jic23@kernel.org> wrote:

> Sadly my rust remains very limited :(  So you both end up at the back
> of my review queue and I can't provide much useful review!

Thanks for the review, Jonathan. Every review teaches me something regardless.

> > +config AS5600
> > +     tristate "ams AS5600 magnetic rotary position sensor"
> > +     depends on I2C && IIO && RUST
>
> The IIO dependence should be implicit given it is buried
> deep in a menu gated on that.
>
> > +     help
> > +       Say Y here to build support for the ams AS5600 12-bit
>
> This Say Y language is odd as it sort of disagrees with the M
> section below.  Start off with what it is then finish up with
> any suggestions on Y vs M.
>
> > +       magnetic rotary position sensor with IIO channel support
> > +       (in_angl_raw and in_angl_scale).
> > +
> > +       This is a Rust driver that exposes the 12-bit raw angle
>
> I think the aim is that no one configuring the kernel should even
> know what the language used.
>
> > +       and radian scale via the IIO subsystem.
>
> I'd skip the IIO reference here given to get to this help typically
> someone already navigated down into the IIO menus.


I'll drop "&& IIO" from the depends line and rewrite the help text.
Device description first, Y/M hint at the end, and no mention of the
implementation language.


> > +
> > +static AS5600_CHANNELS: As5600Channels = As5600Channels({
> > +    // SAFETY: `iio_chan_spec` is a repr(C) struct where all-zeroes is valid
> > +    // (integers default to 0, pointers to NULL).
> > +    let mut chan: iio_chan_spec = unsafe { core::mem::zeroed() };
> > +    chan.type_ = iio_chan_type_IIO_ANGL;
> > +    // TODO: Use kernel::bits equivalent once bit_usize exists
> > +    chan.info_mask_separate = (1usize << iio_chan_info_enum_IIO_CHAN_INFO_RAW)
> > +        | (1usize << iio_chan_info_enum_IIO_CHAN_INFO_SCALE);
>
> No nice BIT() equivalent?   Those names end up rather repetitive with
> most of it coming twice.
>
> I don't suppose there is any way to avoid that?


There's no bit_usize in kernel::bits yet. I'm considering adding it
for v5 since the change is small.



> > +impl IioDriver for As5600Priv {
> > +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
> > +        const INFO_RAW: isize = iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize;
> > +        const INFO_SCALE: isize = iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isize;
> > +        match mask {
> > +            // IIO_CHAN_INFO_RAW: read the 12-bit raw angle value.
> > +            INFO_RAW => {
> > +                let hw = self.io_lock.lock();
> > +
> > +                // Read status register to verify magnet presence before
> > +                // reading the angle.
> > +                let status = hw.client.try_read8(AS5600_REG_STATUS as usize)?;
> > +
> > +                // Check magnet presence (MD bit). Without a magnet the angle
> > +                // register contains stale/invalid data.
> > +                if (status & AS5600_STATUS_MD) == 0 {
> > +                    return Err(ENODATA);
> > +                }
> > +
> > +                // Word read at register 0x0C: SMBus read_word_data returns LE,
>
> That seems wrong.  It assumes LE data on the wire, but should return in
> the CPU endianness.  Hence it's a swap in all cases, rather than an be16_to_cpu()
> which would get it backwards on a big endian platform.

You're right that the comment was misleading. That was my mistake. The
swap is unconditional and has nothing to do with CPU endianness. I'll
rewrite the comment to reflect that.

Coirul

>
> > +                // AS5600 stores angle big-endian, so swap_bytes() is needed.
> > +                // Mutex ensures status + angle read is atomic.
> > +                // NOTE: Equivalent to C's i2c_smbus_read_word_swapped().
> > +                // Long-term, regmap-rs with val_format_endian=Big handles
> > +                // this transparently at configuration level.
> > +                let raw = hw.client.try_read16(AS5600_REG_RAW_ANGLE_H as usize)?;
> > +                let angle = raw.swap_bytes() & AS5600_RAW_ANGLE_MASK;
> > +                Ok(IioVal::Int(angle as i32))
> > +            }
> > +            // IIO_CHAN_INFO_SCALE: radians per LSB, 2*pi / 4096 = 0.001533981.
> > +            INFO_SCALE => {
> > +                Ok(IioVal::IntPlusNano(0, 1533981))
> > +            }
> > +            _ => Err(EINVAL),
> > +        }
> > +    }
> > +
> > +    fn channels(&self) -> &[iio_chan_spec] {
> > +        &AS5600_CHANNELS.0
> > +    }
> > +}
>
