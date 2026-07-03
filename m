Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710F2E401;
	Fri,  3 Jul 2026 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040120; cv=none; b=IKONPDhTPxJPZgVsedoEkGvkbOz7Cu6sVRjGonKWIOwunKuqpb135GnSbkSBOSOrsIqhqEe+zQ6LlLlDGp/zz4RUeUf4GMwRkEM3OL+Oc3UrlzBU+TdGgVFkgD+jGKicXQugvtV8TA8jVUEajdh7ONAShNvaeT/HEsV8jR6GWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040120; c=relaxed/simple;
	bh=HtVHZDymtfrqpXV+bkgQ91HTnFq1ohJtSuj2rEX7SuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNjMsbDHNjEA5Nrjnh+sG5Pv8chJQCENVaV8b+PqWBGg9b1FmXBvloRtJ4hQMLEGtbqwVqTLl0Z+gJ8z2IHBD+FdqYnJnOiUCsKyFs2Jj08SS+/GhjTSq2jyOFEQLfP1L30Xlde/a83L5Fu7F78OwtNgx/uO0T5J0yPrzX5D6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqDqemX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqDqemX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368601F000E9;
	Fri,  3 Jul 2026 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783040119;
	bh=7z9+myaD9TBKeih0nvyRpQJnR/fwaZoRHcQmaulDjjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OqDqemX5Loh/4E6SQv6TpwXZnZRSc6/bhZadzgKJMuqQ5QeHv6yjrmxhU14tTlvT6
	 7WZzWK9yD2tCIYWjIhGAeSyzWBcKADxvVOMIS2xwOtlUIn3nbkt/yZCBLnpT9usxof
	 isDyolcLEdJsXGyJGRqoRt6LMPLhaYvaP4UzH5iAdzEtye3awyEksU1VBceJpucFuu
	 9s4aXfAxe33gqlXZ8E2z6aZXCYD9cJ8g4lIMnnVwDBvmwK/3aGuxorV143zOrj93Ap
	 TVoN72+ERwn18m3cFQxKSKGGcyIQzjtk2kbRfh7tDE2KhTBadqBB6fHEw8i511TyEp
	 yNw183Q2oyhnQ==
Date: Fri, 3 Jul 2026 01:55:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mert Seftali <mertsftl@gmail.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: iio: accel: dmard09: in_accel_scale always returns -EINVAL
Message-ID: <20260703015514.17f5a8bb@jic23-huawei>
In-Reply-To: <CAA3NooqF=FE+gQT-CzAUv7eo7D=wQB8JAeHuc=XNSB0KdSd=ZA@mail.gmail.com>
References: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
	<1235808b-34bd-4d9b-ba23-158ce3f113d2@vdwaa.nl>
	<CAA3NooqF=FE+gQT-CzAUv7eo7D=wQB8JAeHuc=XNSB0KdSd=ZA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:59:59 +0200
Mert Seftali <mertsftl@gmail.com> wrote:

> On Mon, 29 Jun 2026 21:06:..., Jelle van der Waa wrote:
> > Thanks for digging into this, I no longer have the device in question.
> > But the vendor driver can be found on GitHub:
> >
> > https://github.com/minstrelsy/mediatek/blob/.../dmard09/dmard09.c  
> 
> Thanks Jelle, got this from the repository;
> 
> It has the sensitivity, and it's used in the driver's own conversion:
> 
>     acc = raw * GRAVITY_EARTH_1000 / sensitivity   (then / 1000 -> m/s^2)
> 
> with sensitivity = 32 and GRAVITY_EARTH_1000 = 9807 ("about
> (9.80665)*1000" in the MTK header), so 32 counts == 1 g.
> 
> It also clears up that bit-twiddling i was worried about. The vendor does
> 'data >>= 3; data &= 0x1ff' plus a sign-extend of bit 8 on the 16-bit
> read, i.e. a signed 9-bit value (register bits [11:3]), and our '<<4 >>7'
> dance lands on the exact same number. So the 32 applies to what the driver
> already returns as raw. Self consistent too: 256 / 32 = 8g, which matches
> the +/-8g.
> 
> So this time i think we can implement it instead of dropping it:
> 
>     scale = 9.80665 / 32 = 0.3064578125 m/s^2 per LSB
> 
> happy to send that Jonathan, it's the vendor's 32, so same
> no-datasheet situation as before. or just drop the scale declaration if
> you'd rather not. Whichever way you point.

Thanks for digging into this.  Ideally good to fix it if we can rather
than just dropping the support.  If it looks doubtful dropping is fine
given it never worked anyway so it's not a regression :)

Which is basically me saying I'll take either - up to you!

Jonathan

> 
> 
> Thanks,
> Mert
> 
> 
> Am Mo., 29. Juni 2026 um 21:06 Uhr schrieb Jelle van der Waa <jelle@vdwaa.nl>:
> >
> > Hi,
> >
> > On 17/06/2026 17:53, Mert Seftali wrote:  
> > > Hi,
> > >
> > > I've been digging into IIO to learn my way around it, and the dmard09
> > > accelerometer driver caught my eye as I think its scale attribute has
> > > been broken since day one, so I wanted to flag it.
> > >
> > > The channels advertise scale:
> > >
> > >      .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> > >
> > > which makes the core create in_accel_scale. The trouble is
> > > dmard09_read_raw() never handles IIO_CHAN_INFO_SCALE, it only does
> > > RAW, and SCALE drops straight into 'default: return -EINVAL'. So
> > > reading the scale just errors out:
> > >
> > >      $ cat .../iio:deviceX/in_accel_scale
> > >      cat: in_accel_scale: Invalid argument
> > >
> > > and userspace is left with raw counts it can't turn into m/s^2.
> > >
> > > To be clear about how I found this: I don't have the hardware, I traced
> > > it through the core (iio_read_channel_info() -> read_raw() with the
> > > SCALE mask) rather than seeing it fail on a device. But the path looks
> > > unambiguous.
> > >
> > > I went looking to fix it properly; add a SCALE case returning the
> > > sensitivity, the way dmard06 and dmard10 do, but I couldn't find a
> > > DMARD09 datasheet anywhere. Digging through the list archives, it looks
> > > like the scale was declared in the original 2016 submission but never
> > > implemented, and the driver was written from a vendor source without a
> > > datasheet to begin with. So I don't have a real number to use, and I'd
> > > rather not make one up.  
> > Thanks for digging into this, I no longer have the device in question.
> > But the vendor driver can be found on GitHub:
> >
> > https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c
> >
> > Greetings,
> >
> > Jelle van der Waa  

