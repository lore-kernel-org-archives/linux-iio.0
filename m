Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751347143A
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665495; cv=none; b=QHvN0SQ7V1+ER36x4NYx2Ufc4vJa/Bu0D5+CeVtIRyK1f6oR+wzqAcl1yEr1Ai/Pqq2eCqcQBBb5DXJmGAY1MeNTzHNtYfUmybiRoQN1Hy6ssCrdNk5fmABSzr6z/y8dGZTHXCTcsxgue9wYuMrfD49LYpvtAsWjEAt3G8htZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665495; c=relaxed/simple;
	bh=P5WYgFdBB2WI7NKSLc+xkQveSUZZ4oR4RAnxRZ3sOk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNpR+lmOFHAyb1iMMYVBxiaidVqtnTUeoWUiKMifSJUcFiY/RPFjgkSqF8AQlu2M9hGS6JIbgMAWYtgScoktJjeBgg2fNv+76h32C7AhoLSvmaAWZ4tzo8ZWABiJujp4bDKtmjDAHFxmOAtkmMxFCsq8vzJ6TUJ9kqzecAj7CY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK32DNjg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK32DNjg"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so5811320a12.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787665491; x=1788270291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FWi5OWCgDbdxS/z+vG1uBzNcpx684WDjQnVfCGs5vMo=;
        b=dK32DNjg2scjX673JNJzWSquArEbN6lfZ+BV7iTjzCBBg3Plg74V1BLyPqifApojqr
         Lb9yDXxmFAg/nkVntEc8pW4aP4BopdzVENDYZHFoqoPVVuVwQv0U85+iqSx4AuNkacfW
         tW9mOrehmpbSwn24G30MyiLEBC2oK+iCzdaT88imi24lPKBJNnZGkdbrJyb1z9GdKQZg
         lWihaeiBhDs5MFqTGkS1RX3llc8PCaoTiMcYuCzHKqHww6uPcN0fGSfhe1koQ/ZJenOO
         gSQmKBdexhX6+nDTWm18mzqH0p783MoyQs02S37ionpGGMtM93pXRl+x1K4AeichmhqK
         Tzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665491; x=1788270291;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FWi5OWCgDbdxS/z+vG1uBzNcpx684WDjQnVfCGs5vMo=;
        b=X+6wTmr2dxUA3gMtrJXV4TEMGiowdBmBGbUhMJMxr11kdNOozJX3RHfLg/v/RRf6W3
         9VjOV9c2lJuGHTdMRKBxVgmAf1uQEE/Cp8apRrCAgeXg/geGi/q2JT8i2ATJWRIskyhd
         9rdyE4KgDMHtIwX1EwntVO13boL96RVFuoikfygQqVQ288LO6XfEEbWJpvfZ61mC19/v
         QkVE1FdMyx7eAPuKz0GZleN5IVgtvnPcQa5c7BW17sLqyiCsSpMlRmb1MRglDc5yZGwO
         CE2Y4qmJoS/gxljm8xIoOL8byivnXjaVTu3Oik3grrissvYCKfg9NBpcxZ1MHZJLfqoa
         lgIQ==
X-Gm-Message-State: AFuF++kGqIqr/v/OKAGtNFagRkCIFw7iuY/j6PxD3rrozkqmzMRo55Wz
	AWgJPiHymC6BXQDM2bExtBayob2pl5CT/4anfRvsN+g+6q+eKYnlH6h6
X-Gm-Gg: AR+sD13LPJ8juSqqvjvhW8TeFkva3D3KsR1EaRlY1J2RcUNAqjxo3usHUgXBB34Mlk0
	PbclLSaUjsKqTxrVPD1iKL8uqtkXRwAUAlM+PdgCNAKwenBGQlaV/mMWOOpjjQ/iVzqcV2HXFKH
	jGxAq6wbi6q65EIUE2LnBH5DaJwplICBR8SBfKJPUBInFGd9l308XfM5pdmCy1/V0wKxjCV34ni
	B2MnjHM4Ugc6JfKNGCTfnAnEFzvfaMcU58aNJE/93NjuYBkF85GjN8U0lj3Bp2D1XZJMB9OqwBP
	kQK6Gs7KM/gAlUDW6NdmoEmhNkkRDT2BDs6sgKO/3j32RgmW6tRs7heKdlH9NYkzXggJBdPSm7B
	INRWUGUB7X3GSqnnEPgmc4yOzo+nvuJ8ZwPWETtKxVGAcT0XaOjRoetkdbkjUIf9z/FgGUu9kpV
	L8nXYTrZlbBHNb4fzp6Pb7+QZG/D4Fydriz56LZsYUcnF9lx4jIZuLAOWF0gW+wKx1F3gHea3DF
	PVNlnASiIcJj7JICXMwOlhdYUSwNd48Bokumje5K/GvY3ux5WxpQvHz5ex1z9/1WgypDAWPt0LM
	N1+L9hDI119X3IoB+ShD1ILsDZTEEN8Ca/vZuy2pdi/lD8Dr1yLWQhnsvhQPeR3u6hKWZitPeB1
	/p0mrYw0RwSV5GFdwQ6B/SoG69osNda0XkruxU7FpJRrt4DmoJ6u0OejngosGWHDCagcyNJ6L5u
	l14fko
X-Received: by 2002:a17:907:9701:b0:c24:8af3:c92 with SMTP id a640c23a62f3a-c2504e504bbmr243031766b.3.1787665491183;
        Tue, 25 Aug 2026 06:44:51 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b59fsm2031244466b.12.2026.08.25.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:44:51 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:44:49 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Martin Kepplinger"
 <martink@posteo.de>, "Sean Nyekjaer" <sean@geanix.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Martin Kepplinger"
 <martin.kepplinger@theobroma-systems.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] iio: accel: mma8452: Drop unneeded lock acquire
 on read
Message-ID: <20260825154449.00002f6f@gmail.com>
In-Reply-To: <87y0dumiga.fsf@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
	<20260825-mma8452-open-drain-v6-7-9b252804ee80@geanix.com>
	<UFc9cC1VeohKw6lxQ8uulsfj9wJ_OqGUgGPTUnTX-zssKZ97aEC0Xi9nsAxv-tcf2DP5e85ElFZ8wPgxwG8l3g==@protonmail.internalid>
	<20260825121704.00004ed3@gmail.com>
	<87y0dumiga.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Aug 2026 15:35:17 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Joshua Crofts" <joshua.crofts1@gmail.com> writes:
> 
> > On Tue, 25 Aug 2026 10:27:45 +0200
> > Esben Haabendal <esben@geanix.com> wrote:
> >  
> >> There is no need to acquire data->lock when calling mma8452_read(), and
> >> dropping that makes it less likely to end up in an AB-BA deadlock
> >> situation.
> >>
> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >> ---
> >>  drivers/iio/accel/mma8452.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> index 7ef1a9a91c31..9ae2c3e60576 100644
> >> --- a/drivers/iio/accel/mma8452.c
> >> +++ b/drivers/iio/accel/mma8452.c
> >> @@ -504,9 +504,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
> >>  		if (!iio_device_claim_direct(indio_dev))
> >>  			return -EBUSY;
> >>
> >> -		mutex_lock(&data->lock);
> >>  		ret = mma8452_read(data, buffer);
> >> -		mutex_unlock(&data->lock);
> >>  		iio_device_release_direct(indio_dev);
> >>  		if (ret < 0)
> >>  			return ret;
> >>  
> >
> > Sashiko has something to say and I tend to agree at the moment:
> >
> > Could removing this lock expose mma8452_read() to race conditions with PM
> > auto-suspend and event configuration?  
> 
> Yes. I tend to agree as well.
> 
> > mma8452_read() can be interrupted by the PM auto-suspend worker, which puts
> > the device in STANDBY and disables regulators while mma8452_drdy() is actively
> > polling over I2C. This can lead to I/O timeouts or errors.  
> 
> Yes, and causing pain for other I2C devices on same bus :(
> 
> > Additionally, concurrent sysfs writes to event configurations invoke
> > mma8452_change_config(), which puts the hardware into STANDBY to modify
> > registers. The Standby transition flushes the hardware FIFO. If this occurs
> > between the mma8452_drdy() check and the i2c_smbus_read_i2c_block_data() in
> > mma8452_read(), the block read will fetch flushed or stale data.  
> 
> Argh. Yet another level of trouble.
> 
> Maybe we should extend the use of data->lock instead. Holding it
> 1. whenever doing read-modify-write actions
> 2. while holding the device in standby mode for changing registers
> 3. while doing suspend/resume
> 
> I was just adding support for a open-drain mode irq sharing you know.
> While sashiko-bot definitely is catching lots of valid problems, and
> fixing them is a good thing, this is starting to feel like I opened
> Pandoras box by touching this driver :D
> 
> I will try to wrap up a patch with the above described extended usage of
> data->lock, but hope we can find a way to get the irq sharing and open
> drain mode support merged, without necessarily having to fixing all and every
> possible existing bugs as a pre-condition, but maybe delay some work to
> later work.
> 

If they're pre-existing conditions then it's not required to fix those in the
same patch series, you can come back to it another time or someone else can fix
those.

Nevertheless this is an issue that will be caused directly by this patch if
applied. If your only goal is to add support for open-drain irq sharing, you
can probably just drop this for the time being and just focus on that.

-- 
Kind regards,
Joshua Crofts
