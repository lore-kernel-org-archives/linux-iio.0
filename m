Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CD391E6D;
	Tue,  2 Jun 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402011; cv=none; b=BErRzqc2XOt3foO384xeDOFgwYyFGDqp/yb8Mx1F93ZPjjUk8H5xkEvwO8tCr8v/xnoCzYiOXlTBMaDCmBlbAhtcx/ykkaOjCWiQ6GiUkkC7ks3HhQFF0erUPM6iz4BBjMaIMqZJDVPqUbAju3yJjxOruQiILP+unyuSgDu7yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402011; c=relaxed/simple;
	bh=4Ib1HZSwprKjDZ/HBqLJ79bSipqyf1w+Seee7XKf6eg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBAZDbFRW8zAXfSKgQP0/pm3xWd+D2Nn4MDpuxngkvXeQFrZficBIgrvQ5EhVcH4w/cD9HzTqbDYJGnRha+T8VcGcwKV5Y7dqFGuMQRocOE//7NOqNY7969PCYPfIsDiLrokGcmDxCBL+MNJvClXwIiVDJ0SqhYDkVdCbyIhXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9z37o56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9z37o56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C4A1F00898;
	Tue,  2 Jun 2026 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402010;
	bh=yUAN4g0wGB09Drb9QYW00b2yzOFrzF2qEiVD7nuUHmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m9z37o564W5v9RvWD8+pXaHZnLvQC7MUjE+8fd+xUjg4G+sYgqFGbnlIUpsFJ7eGz
	 LPVkewdkHYuU09dhIJN2w9rxGRBZSm1oFggCFE+AasbOWTaRnqeY+ccqhaByiQDQjS
	 LCu4um7OJ3s1TAtWtu5uv6kpLx+DPIjEPSw5RUjcfNtsgsbekVxOfw5hNfoREHjo8L
	 FAA9ZgktiM9sKInYbaUSlinXx4nD3dFNsde9GJgX0FcX0w1g08WKTFiwUJoVGJcPDD
	 950rRqAIuz3xUKMHWfNjehlh/8W8id+pkZ04ZgtQD/Rn9FnbI+l301yK4Kcskgd3DS
	 bvHJIfIleIv/Q==
Date: Tue, 2 Jun 2026 13:06:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Subject: Re: [RFC PATCH v3 3/4] iio: position: add Rust driver for ams
 AS5600
Message-ID: <20260602130642.068b24ea@jic23-huawei>
In-Reply-To: <CAO26r3R5+xYQM=_uxF32MQRuxkhpeY3bTwq6M3o8dPCr8-kdnA@mail.gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-4-muchamadcoirulanwar@gmail.com>
	<20260528170840.54173bb7@jic23-huawei>
	<CAO26r3R5+xYQM=_uxF32MQRuxkhpeY3bTwq6M3o8dPCr8-kdnA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +                let angle_h = match hw_guard.io.try_read8(AS5600_REG_RAW_ANGLE_H as usize) {
> > > +                    Ok(v) => v as u16,
> > > +                    Err(_) => return Err(hw_guard.handle_io_error()),
> > > +                };
> > > +                let angle_l = match hw_guard.io.try_read8(AS5600_REG_RAW_ANGLE_L as usize) {
> > > +                    Ok(v) => v as u16,
> > > +                    Err(_) => return Err(hw_guard.handle_io_error()),
> > > +                };
> > > +
> > > +                let angle = (angle_h << 8 | angle_l) & 0x0FFF;  
> >
> > This is the sort of thing we'd never do in a C driver because we have well
> > defined meaningful functions / macros for doing this.  I'd like to see
> > something equivalent in the rust code of.
> >    Bulk read int a two byte array. i2c_smbus_read_word_data() or swapped variant.
> >    Unaligned endian read  get_unaligned_be16()
> >    Masking to extract the 12 bits that are valid. FIELD_GET() whatever.  
> 
> Switching to `try_read16()` (calls `i2c_smbus_read_word_data`) plus
> `swap_bytes()` for the byte order, then mask:
> 
>     const AS5600_RAW_ANGLE_MASK: u16 = 0x0FFF;
> 
>     let raw = client.try_read16(AS5600_REG_RAW_ANGLE_H as usize)?;
>     let angle = raw.swap_bytes() & AS5600_RAW_ANGLE_MASK;

That swap goes back to a pattern we ripped out of the C code years ago
and why we have the smbus swapped functions and regmap support fort htat.

If a given part always does the bytes in opposite byte order of smbus
then it should be handled as part of the read function rather than every
word read having to be followed by a swap.  Here you only have one so
it doesn't look that bad, but for some other devices this is the common
call sequence to ready almost anything.

> 
> Rust doesn't have FIELD_GET yet, but a named constant serves the same
> documentation purpose. Single call, no manual byte assembly.

A named constant serves only part of the purpose. The main gain from FIELD_GET()
is we don't have to go check if a shift is also needed.  I'd strongly
support work on getting something similar for rust as it makes for a lot
more consistent and readable driver code.

Basically I want all the useful helper stuff we've built up in C to be
available in Rust.  In cases like this one I would prefer there was never
a legacy of doing it any other way!

Jonathan

