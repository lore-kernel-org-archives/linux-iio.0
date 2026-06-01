Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C6395D9F
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312322; cv=pass; b=SbzLBrDAy5Np7ZN6azd4lFOxn93QsazNqaANgbX6VL3Nfnvr7ODsKLzNkY1HWUrtBaHSchyrr869W0UjIcCBUOFJIlbIUE6lQnjxZ43KsctDhZU1GhZE01qQqI/VyGzqKyNpPVKuXhZwqy3QP1CA1+XNfzfbs4j6jGgUC75cIBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312322; c=relaxed/simple;
	bh=CTuqB8f8CHnjUFXfepKG78RIBK3dVznwIcbKmaKwToc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOvSkImSmlCq+PkTjd8OkbVG0J3D5ui/11u+nBc0lR80ljCfjIgyJglVcq28nWzbxMk7Tv5Vfkc/Tilx//wlzumebmedT8zrn2MHhWv2rSuEeAbUensYbUesY1BzIOGXpw5g6u5BPBrRZ1fDhFT3Cb16X9saMBWIQykwjJktWGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBt1I18N; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBt1I18N"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39664fe2dd8so15148361fa.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 04:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780312320; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUX3AKCgRG/dirSrMI8rNN2g4YqqbwRlww+qdVKtjTOMY/AQmDpVasQdzufc9w6F2Y
         LRnJcdo5c9ft1P57Ga/hDJld0JxEdlU3N02KtEiEv6kbq6We88B0I0opIY+tSIPoGpdu
         3C/pmNfVvKPJRObgiJOhZYJtBfYTPsnTQkNdKXJ2Y9bT0Je2PUo5XOFnRrZw2BmY7did
         Itnw6rDsqxMhEq+pQv+2ycFV/UnRwtp6SKLbhNJVnZKtgRaFEBdkcqTn0mV2NV4TFfFg
         D7Ct8kSZAxULcGmuWHDXVmZn9UYDiEwxTHFNZO+yILiIMzB4PA9rYqk8ZIoZR/M15VNP
         uSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gkL8gzHaH95ivbWHNAfJEuvQzWUQ9brGRQ3o+4Ufqk0=;
        fh=TUck8HYLQD3M9WBUn/LrbSlXofXqCUAwF/sB3KNoSq4=;
        b=a212qBNgBYEd2ndklw/8ROJxPM2mWQ4Fgz2y1aUO7sBnUI/nCi43qi4b4XJL6jAYEI
         J6tYgkxs7aMvoCR2Dz/vmUiSHehQb/nh2bloSkVJhm09hPqyKiJCcrfjzrg/qaAGfW1g
         3W3Rud36NZXnkMXPyXSMUEUGsBZep9+J/lxezTsv2BehEi9i8DT3pQ9K5l3O24LugGnw
         oxre10Iz16p4/mFdHGGXVXR+x4SKnmFTDLw+5dgDPIVfAhEF99231uN+dei4650SusmL
         nu1mmyuXuCLdSsPYgzKYJPBCFFuvuGHm2Shg+QxQFn+vp7ALwJ49u6ro7mLVGqsAo0SM
         rf0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780312320; x=1780917120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gkL8gzHaH95ivbWHNAfJEuvQzWUQ9brGRQ3o+4Ufqk0=;
        b=YBt1I18NnSHl5dwR5RqA+Psb38siM/sf5HsWpIqBH7Y2ylweZouzRdlyi41qk9ZYq9
         4MITcQN+ATzcAVMJJ2gmT/mINqC1Tb6BqYDiSGVjIwY/MgmAUSuPDfu1rtrV7cIa/Z7o
         By2q3CTtXZs2fIJvQYjgbhWpiiHBSRNmAPUsU4A7Yh9mMa28gNZ/h6s/DY3ny2oE8oA8
         tae2EO2PjxcwGp8VpkV3iA7Rax6a0zqtVgS7t94odLO647pbfz0co5CTas2BQuucoi7s
         fU8wcQWUwsnGMZbi3B6QS1MVt3vNG/zscUDN8eKRiOCe8j4NNsHonpjMI+poWuRDLoph
         pWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312320; x=1780917120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkL8gzHaH95ivbWHNAfJEuvQzWUQ9brGRQ3o+4Ufqk0=;
        b=UTOn7A7AIAJhe3wrRSIscTKpN53I9lchcHxp17RadRFd37gDwRz/DQ2y+QDsr9GP2T
         ZWEtQTqyapOs30miagvuRqqNSvnxrnZCLztWw99fIqdB543lTZt8Zjzcv18HdWgPaAiE
         ZqSSoL/cxTzGWYG61xFmBAI4Mt9IJ6eOjQDvfzBxydeXfk+n9l1gUiUvRE6fpwDeDGml
         Xbmr/D8bRRNPO66v1ju6jRSq6FuitaNqSs1NjP68xz9utalET7NjKUwTuARtbI8QWuX4
         yWPZ3HkmHD+b3BGe8j9Cslznc1s7yjyA9NprAIVywtlGBCJM8cI+8cfLkO/sbXMRaiiq
         v23w==
X-Gm-Message-State: AOJu0YxjBQTqsaGUZslNN50O99KyQ4S9eGiD+ctTkebWU8iT2780EemW
	uQwm0evZMrNN3RDJNze0B6RlTbZt5WO+fnAH2/1HMu9CqUHWjHzzKw+blR+CRTbMSAWZ1z25SQC
	SM49rAOMGycRPxyfwrQoWvm8OAan2Bl8=
X-Gm-Gg: Acq92OEhIMEBit+QhP2WXhJxri40dNdBlGHGAIhM134eQSq0QuCWr8GR+Ut3n+RdjAf
	1C+i2jN+o+jYS45KIeu41SrvjYTnfpxj3oMdQcMv1JEx5ajedgKy/ecAugn9bhzcoSDY7D2WyRh
	6xzBojUy9IzUK0S17xquXMbyHJ9KexNAL5aGSAuUGL8heR9++FqCR3w9OkgiWn/RUu9dGGPWaMX
	WveRhv07TjabCfVljleQ2y81PF86RWxq5M6YkbeCxtZ1DBhq8BInEAa0eaa3905W/xYseB0rTPp
	sEYysx6tHF6DfuXyWUnbc7RdS2+nbCgCAo1XTRhyX2JeOAz1sNom
X-Received: by 2002:a2e:a90f:0:b0:396:892a:7392 with SMTP id
 38308e7fff4ca-396892a75c4mr9613571fa.29.1780312319159; Mon, 01 Jun 2026
 04:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
 <20260524132824.54918-4-muchamadcoirulanwar@gmail.com> <20260528170840.54173bb7@jic23-huawei>
In-Reply-To: <20260528170840.54173bb7@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 1 Jun 2026 18:11:46 +0700
X-Gm-Features: AVHnY4IaJKeU316-BdlSnXxw4wjZPLsu5BeYIZhXkBm0IWLZZkKFsQJ29ovO0Ik
Message-ID: <CAO26r3R5+xYQM=_uxF32MQRuxkhpeY3bTwq6M3o8dPCr8-kdnA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/4] iio: position: add Rust driver for ams AS5600
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 17:08:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > Features:
> > - Circuit breaker pattern for I/O error resilience
> I'm not sure why this is particularly useful, but maybe I'm missing something.

> I mention this below - it works (sort of) because right now you just
> do reads with no state changes.  In general device recovery is way
> more complex than what you do.

Fair enough. It's over-engineered for what this driver does. Simple -EIO
propagation is enough since the sensor is read-only and the Mutex
already limits bus access to one reader at a time. I'll remove the circuit
breaker in v4. The read_raw path will just propagate errors from
try_read8/try_read16 directly.

> I think we need a separate discussion on how to do device recovery.
> It is at best a black art and very device specific if bus corruption occurred.

> On a read you can maybe get away with this but on a write we have no
> idea if it wrote or not and that write may or may not have had side
> effects. If you lose a write, the only always correct thing to do is
> a device reset. Other stuff is very device specific.

Agreed. Since this driver is read-only today, the whole mechanism is
solving a problem that doesn't really exist here. If device recovery
patterns come up as a broader R4L discussion topic, happy to participate.

> > +                let angle_h = match hw_guard.io.try_read8(AS5600_REG_RAW_ANGLE_H as usize) {
> > +                    Ok(v) => v as u16,
> > +                    Err(_) => return Err(hw_guard.handle_io_error()),
> > +                };
> > +                let angle_l = match hw_guard.io.try_read8(AS5600_REG_RAW_ANGLE_L as usize) {
> > +                    Ok(v) => v as u16,
> > +                    Err(_) => return Err(hw_guard.handle_io_error()),
> > +                };
> > +
> > +                let angle = (angle_h << 8 | angle_l) & 0x0FFF;
>
> This is the sort of thing we'd never do in a C driver because we have well
> defined meaningful functions / macros for doing this.  I'd like to see
> something equivalent in the rust code of.
>    Bulk read int a two byte array. i2c_smbus_read_word_data() or swapped variant.
>    Unaligned endian read  get_unaligned_be16()
>    Masking to extract the 12 bits that are valid. FIELD_GET() whatever.

Switching to `try_read16()` (calls `i2c_smbus_read_word_data`) plus
`swap_bytes()` for the byte order, then mask:

    const AS5600_RAW_ANGLE_MASK: u16 = 0x0FFF;

    let raw = client.try_read16(AS5600_REG_RAW_ANGLE_H as usize)?;
    let angle = raw.swap_bytes() & AS5600_RAW_ANGLE_MASK;

Rust doesn't have FIELD_GET yet, but a named constant serves the same
documentation purpose. Single call, no manual byte assembly.

> > +                // Read the 12-bit angle as two bytes. The AS5600 hardware
> > +                // freezes the internal angle value on reading the high byte
> > +                // until the low byte is read
>
> Would be very unusual if the device does this but doesn't support some form
> of larger read. Would be nice to be able to do that in a rust driver.

Yes, the AS5600 supports word reads over SMBus. I was being overly
cautious with the byte-at-a-time approach based on the datasheet's
latch mechanism description, but a word read achieves the same atomicity
from the hardware side. Using it in v4.

> > +        channels_alloc[0].info_mask_separate = (1 << iio_chan_info_enum_IIO_CHAN_INFO_RAW)
> > +            | (1 << iio_chan_info_enum_IIO_CHAN_INFO_SCALE);
>
> I believe there is a kernel rust equivalent of BIT(). Can you use that here.

This should use `kernel::bits::bit()` for consistency.
The status register check already uses `bit_u8(5)` but the channel
setup didn't follow the same pattern. I'll fix this in v4.

> > +        dev_info!(dev.as_ref(), "AS5600 magnetic position sensor ready\n");
>
> Too noisy. dev_dbg() at most.

I will change this to dev_dbg!().

Thanks,
Coirul
