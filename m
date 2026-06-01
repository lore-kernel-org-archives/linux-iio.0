Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00502386450
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300742; cv=pass; b=YmtKitZWPC2DrcLNmFhZmxzhcllauH2TIJllJTWye4zcPYUle52DDqoRYeJ0i4OPXDtPRNJR0Ju56M4LBxt/90vF09xnmpGhJJOsHe7i8KT2l0872WPxqX4yL1dPzbAOaBo2LpdesXPI1CSVZKhmqlxZyRF2OA1NWqOkWW//i9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300742; c=relaxed/simple;
	bh=V7Ql/9p1unLinsp66SsCPFbS+OHsOQm19LRXTI5ej9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5VLDlmvkHqNXJ5p3RRuUSOrOVwNQU5QAN1iy3UgJUtsLvB8TcWFzaapnD6/qDggTFdnfyvTVwgMELtluvWU1ZVtKB4t/9aw4zarvFfZAspi40dlyJbzsqNTH2PnevraiW2rddKHBzA+NJtXMclCiYpwwBOnyeyjIsGCqRGStRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/TIviO3; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/TIviO3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39676d82b7fso11962211fa.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 00:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780300738; cv=none;
        d=google.com; s=arc-20240605;
        b=d58R4Y9gHLzno8jZp2gbDZfUsrCDxBdFHUT6a8+pvmtwfKSUtftST68hxmuhdK/3r3
         Y/xpOJs/vfGddBKBsDaZ0A2aAr33JaRlUy5w4OGm91N1urqFIECgHnZoPjVWhSA7fXyC
         o3YebmA1baJ1URVVTFiZ7dalxaeHZHjmtYnkm7ubuFxvLqh8rhW0WBjkxvCWFA0RJ1aB
         MM5IE8I/0ufJ/cqAtX4/J/abpkho6YA5BsETJGpdv9+z7tpDVGbAeXk4dEWaemjxULA4
         sdAST9Kxw7NrbSL9D5M7FCa+LG9yBykqy/rbDPhChIxH+y1f57JHUsUxe9wyenm1Fz6n
         SLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gw5mADG5Zp5fneWdHkjEnq3pC/Jdzn69El9XLkNg9f0=;
        fh=TUck8HYLQD3M9WBUn/LrbSlXofXqCUAwF/sB3KNoSq4=;
        b=WQZ4iGXaIptZrazQdHQo6pKGHsHsDRT/Mdp15Zwma3KivbF5LpljTrYvZ9DyFEjNOy
         73PD2MR3lj11BGqgIFQa9rJADxSw3qr37OENv9n3TnoS/ntj8RlR3q6kaGuSI6bqE8Gy
         dxHNYiht4AigMArI0I5U3UQmrA6eIYMUjpDOeSeAow3cMRCoa1WOB+UrlH8x+o8aVi9y
         uEhZotEQ3BgOukJ/VhpWJfsz0NDl2c306Q9QJz5Qs7ItDidJJUoFXmhxaj9ch9UEsaZN
         0E9KPPRzHgQk9e8ZtHB9yTLIlOyyCIu2gxrh52G1GbVw1vll03RKEfMub53YrJI/W6NB
         ztwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780300738; x=1780905538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gw5mADG5Zp5fneWdHkjEnq3pC/Jdzn69El9XLkNg9f0=;
        b=M/TIviO3+IdQ2wYULwKOhcaYp8qJxJhJq8sRaxNr5KB7sq+Hx1z+HvBrREVkChXX2u
         oop1RsSNIIQtgMMEnE9EWV/HO6GTfF/ft9O1gt8yyzVLqkie+WaLmbSSH6Dc751QVoLA
         XMHEJ6kOfQAh2IVC77Ym1AMdn8Eij75dN3yTxGTT4SP3xA3T1Zpa7IfGoyS0L7nEZunC
         7d86p7K5D9CvbLp9twVViyWoJ90okuOrKJKsgpR6YJMnG4Cenrh3sNbGkK52XibVAYj8
         HG/T3idrqV0HU7kBfBmgTWOSNtXspDeODL+RMYCkgUjePmbbb+fg/+ZDlFeunTfrrDKL
         l39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300738; x=1780905538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw5mADG5Zp5fneWdHkjEnq3pC/Jdzn69El9XLkNg9f0=;
        b=h6kL0oNBb0MM5dYzhSnlYuKq1IBNSOGJdoBglaI4S8yPL32vePHxcdlatunKeIAw0+
         yLlRRAoPJU0Bsrfjr7m1YhRhBjAbAPbE32KyXX7/aZfsvF96kEbNmupvbJxtwj8TZwbr
         7puvg7v+9VQH+QMOiTZ3h1ySpzlXSeyRhZJvKJvLOe5dj+0EW6GAi8Kr16fZR2AWKw1v
         /hx7Bbz9UBw+R2q/tVtiDOcSZBm0ZIq/7yOPmNci8DtQAT6V5h9ucvtqtgfVC3b/uP/t
         08jX9Fjus0ybsKwMrHe6b+b/pzkXdZn23avOEZx5vPijwlPAyLXepvKh3m+ytLj1/Jil
         vvVw==
X-Gm-Message-State: AOJu0YyX96bh9HL/EzPyMfuLcXyiOY60ylgCIVYpuvZkQi9PkcKSpo3E
	Mc9SQDact7VtlJKJP9Ak3UVd5fWqGl5JsdrFSS97iH9lxFVyOedHDrIwZDMeef29lWy07xlyQUZ
	o8+QzjEzEsmzMhPkObE+TVQKBx72s7UQ=
X-Gm-Gg: Acq92OH+TYulPnO3Skns1CT+1oLhNnowBdFwmfqsG1D67Zs6DoWsEOaoF1duI0fg4/H
	fwFvqdcOWFY3Fswlsr4haBOyqZvBjh5SXBuX9WhyN1yNe/OcFdOLSaiq+V2WUo+iN5Q8kHbRlnp
	DueM5SnYwLeGtV4vfiT0w5v+RMocttDComYNuDsaBNIrjZS+svQFVdtSn/iytKuYZ24xchbSc7k
	gmVTvgjhfVjdfXuSpPv0T2oV+9n6+ntITUm4yUiZDEj/Q0hiE9+2r1mbkphs6qr5A4hip5on22A
	TuF8syXgdBsgt76SAPVhpwFKOMLqd7cDAbXZGfBfVO6YWxFSdm51
X-Received: by 2002:a2e:bd16:0:b0:393:71d3:d019 with SMTP id
 38308e7fff4ca-39664f55a5cmr25462861fa.15.1780300737938; Mon, 01 Jun 2026
 00:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
 <20260524132824.54918-2-muchamadcoirulanwar@gmail.com> <20260528162557.2b0b28d9@jic23-huawei>
In-Reply-To: <20260528162557.2b0b28d9@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 1 Jun 2026 14:58:45 +0700
X-Gm-Features: AVHnY4KF2DyZ81KbFuSX1FvXzI2swPrAfN2HkxU2JK4xxfSbKvHn_rMQOt28btY
Message-ID: <CAO26r3QZyVco2aZRqPSyWr3d-SBAVEknkaeNDM4g5DFCr3-2aw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] i2c: rust: implement kernel::io::Io trait for I2cClient
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 16:25:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> My main concern is this currently takes away the clarity off smbus
> naming and replaces it with the impression this is how i2c reads and writes
> are done in general.  How will this support other forms of access?
>
> How do we have lots of different types of i2c supported?  Simplest being
> the ones regmap supports today. There are 7ish in drivers/base/regmap-i2c.c
>
> Or if the plan is to only support register style interfaces why not only
> allow for use of regmap?

Some context on how we got here: in v2 I added standalone SMBus methods
on I2cClient (smbus_read_byte_data, etc). Igor reviewed it [1] and
pointed out that the agreed direction is for I2cClient to implement
the generic Io trait [2] from Zhi Wang's driver-core-testing work.
That discussion happened during Igor's own i2c-adapter series. I
offered to take it on, and he confirmed bundling it in my series was
fine.

I take your point about losing the SMBus naming clarity. The underlying
calls are still `i2c_smbus_read_byte_data` and friends though, the Io
trait just provides a uniform interface on top with bounds checking via
`io_addr()`. The call sites in the driver use `try_read8`/`try_read16`
which map 1:1 to the smbus byte/word operations.

For other I2C access types (block, raw msg, etc), those would need
additional trait methods or a separate abstraction. Rust regmap bindings
don't exist yet, so this is the available path for now. Once regmap
lands in Rust, drivers that fit the regmap model can use that instead.

[1] https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620

> One other comment inline. I'm seeing what looks to be a check for an
> 8 bit address whereas smbus is 7 bit addressing.

> Except smbus standard addressing is 7 bit.
> Need space for the read / write bit.

To clarify, `maxsize=256` here refers to the SMBus command byte
(register address)
range, not the device address. The command byte is a full 8 bits
(0x00..0xFF = 256 values). The 7-bit device address plus R/W bit is
handled at the adapter level by the I2C core when the client is
instantiated; it's not part of the register access path that Io wraps.

The `io_addr()` bounds check ensures `offset + sizeof(access) <= 256`,
i.e. the register address stays within the valid command byte range.
I'll add a comment in the code clarifying this distinction since the
naming is confusing without it.

> Unrelated change.

Dropping the trailing-period fix from this patch in v4.

Thanks,
Coirul
