Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628B384CD6
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801101; cv=none; b=oof8EKLyJb4FmLEX3ELNtkBeozDaA2q04TlWKcmhdUXWFClGAqMyZmTKxOaYVfdUT5fih6L4hIBBd0/wfL1wlfl4pIf2mhNbcmg/wQsZO1LyhQz8VQ89tV3FZZxUBEqlgtJni5wynikfJJf1PakDuun4oNFE1CvGKI/zeilguOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801101; c=relaxed/simple;
	bh=VPCes/pYY8bxUmk6YNQvuVtULoRfSEjW4LyQg/Ls+Uo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NDtKWHghFvqKMyBTgMmUxKJd9McEGM9lTZ14wKz7RktarXzvXStkf04jTYnPy5uq+yWECzwlTh82XRp84c9pqdNrtyC17j9gWOf62udLPSvF425JKL33nrGv06JcT/fG4ew2K0oFCLWMVpuNZGIfJPJjcPQs87flMAyDmdmIcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+/yGtId; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+/yGtId"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49557167508so45760035e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788801097; x=1789405897; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qbDexYd6+PKsSzsVWnrFCCOHf6ko5It3bTklp8wNC0Y=;
        b=h+/yGtIdEn/ateyoPsk6Q6S+MfKONVI1A+CMihlXTqrN4MZllDqkEGd239DuO+LhB/
         IeS25wVlt1mh2sniPe8BYVEse8R8bsE2Ai7XTmUe1uK7ATIDKLV0loY+1Bgbn2vYtPPi
         BfOMs2yX6t+IFmvYLElE0u948fISMBXlkydnLBBs3bOVZEi5wHciZx/Rg2U6rU/o7uxQ
         4G/1Bz5p2M1wY2cxqkProybmZ+n276LZAdfl3B3Wl0t84GKTdGivP6tjT4104Rx7zi9I
         oKG4X6Z3sSSe/FarTW8Ri4weVmhBrPkayHYHwPhmvS6ybO1o0v3bFRjPFhJ0hGTXGBPK
         D5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788801097; x=1789405897;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbDexYd6+PKsSzsVWnrFCCOHf6ko5It3bTklp8wNC0Y=;
        b=f9X7895xa/mcw9B0BQWdVTgfT07dWuqA0EGN84aKrqK3l8W6ONlUwv8H2fb6QuhmIc
         mz9rEvhPlbVcxZibOXArcJSdxLP9JehrflBmg+nmmFftKE0O7EtNZB2Q201UPLgZbkLR
         dS3aL0x02vKEGdftb3+GEJ9XCTcPxnr4BV7JpRxyJIqKWMRbZ7r94xx5ojZ3FVECtRaE
         uVeJJ1xbs7CC1IHshRKMgGHTzQNPP1AUI1/RY6SAUeZ9CB+iDle96p72609VDKZgL0Bo
         gMtnxonK99Y1G2jhJo8mm2dvhfcikofvyLfKJvrggYeprXHacGgYb9eRoY5WNoA8inAg
         46sA==
X-Forwarded-Encrypted: i=1; AKwUvBwI5uZ22zT3tztwg7Cfgpg08OfyzXXjEL++MmGcf+SAllEib0gLoGMxeyjbkXyamR9QM2xyKTyhnyw=@vger.kernel.org
X-Gm-Message-State: AFuF++muWkIt+Z8oa2u/qVoFCrc+tN4oO4c0zleWwkMa1aH2I741ZKcO
	Q+he/0lrjEd6XYM11jcbe1I7mAqNkcFxN24xEMDDX9RhC+YrIUVY829v
X-Gm-Gg: AYBFou1SZxk5iDvAkokCNtbX2xZUcx7ROBHlq4PCxC97wvwNdYixl9nrDvQjhj5cayF
	qQTmQCprw2CJgXq1B/mZWuWheNXqgdqo/ESKod2eJucmLSNg+NpfhdLplSHvW0pbEytEvk047IL
	SWiAZkXg6V+eKNLiAoRYTNrbuTC3M2RD9CBipKWYjgf2l9tj42s8pIiRcA0h2PSCdNjngXzIRfi
	MvHDyVKt3I3A065ZJ2e2PcdNd3YPL8tDZh9P2lO6y8cacYISVCg+KlQudYwLtJGKgxBvXu1sLiH
	DL7Vv3N9+oFEugYfDqVy8z1cRnX4jTIejjusqXr9OdszFdRbzMHiw6wrRJWBZ5new1zumsyxcAZ
	kseJiEkf6KBL0m6oRYPa9kchSSgqkn31bxUp3Wv3jLZQf62M4pMdtgfcClxTU2wPHBIu2QlYV/M
	8sFwkNv2Cugf/pJQKOONwpVkC3Gaz863pB9YQ9/XCWarF7BHXzKD4Y9XY+B4JCCi7NpIrPC+bC2
	A==
X-Received: by 2002:a05:600c:4f89:b0:49c:f617:7cf with SMTP id 5b1f17b1804b1-49cf7f32d0amr374243735e9.0.1788801097274;
        Mon, 07 Sep 2026 10:11:37 -0700 (PDT)
Received: from localhost ([2001:4bb8:178:2f30:d3da:48f5:116c:5642])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75cd8d0sm303360125e9.2.2026.09.07.10.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 10:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 19:11:34 +0200
Message-Id: <DL992E7Q18ZM.2PAM4UQKPJ1BQ@gmail.com>
Subject: Re: [PATCH v8 4/4] iio: light: veml6031x00: add support for events
 and trigger
Cc: <sashiko-reviews@lists.linux.dev>, <linux-iio@vger.kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
 <20260901-veml6031x00-v8-4-532cb4f2168a@gmail.com>
 <20260901132208.EE64C1F000E9@smtp.kernel.org>
 <DL49BADYC1U8.2N2F6YW5ZR5S2@gmail.com>
 <DL4X3IXEI8WK.OOFNRSU7FGRW@gmail.com>
 <20260907025826.414c570a@jic23-huawei>
In-Reply-To: <20260907025826.414c570a@jic23-huawei>

On Mon Sep 7, 2026 at 3:58 AM CEST, Jonathan Cameron wrote:
> On Wed, 02 Sep 2026 16:58:09 +0200
> "Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:
>
>> On Tue Sep 1, 2026 at 10:19 PM CEST, Javier Carrasco wrote:
>> > On Tue Sep 1, 2026 at 3:22 PM CEST, sashiko-bot wrote:
>> >> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
>> >> - [High] Use-After-Free of iio->pollfunc in IRQ handler during device=
 unbind or probe failure.
>> >> - [Medium] Unintended I2C read of configuration register when pushing=
 timestamp to buffer
>> >> - [Medium] The interrupt_users counter can permanently underflow duri=
ng error recovery, breaking hardware interrupt control.
>> >> --
>> >>
>> >> commit c87f3d48e1ee614fc184995b816c8f8679a6b774
>> >> Author: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> >>
>> >> iio: light: veml6031x00: add support for events and trigger
>> >>
>> >> The device provides a shared interrupt line to notify events and data=
 ready.
>> >> Add support for configurations with and without an interrupt line, pr=
oviding
>> >> events and trigger support when an interrupt line is available.
>> >>
>> >>> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/vem=
l6031x00.c
>> >>> index 3d5a27a0baaed..7bd7975eb1a76 100644
>> >>> --- a/drivers/iio/light/veml6031x00.c
>> >>> +++ b/drivers/iio/light/veml6031x00.c
>> >> [ ... ]
>> >>> +static int __veml6031x00_set_trigger_state(struct veml6031x00_data =
*data, bool state)
>> >>> +	__must_hold(&data->irq_lock)
>> >>> +{
>> >> [ ... ]
>> >>> +	data->trig_en =3D state;
>> >>> +
>> >>> +	return 0;
>> >>> +
>> >>> +clear_interrupt:
>> >>> +	veml6031x00_set_interrupt(data, !state);
>> >>> +
>> >>> +	return ret;
>> >>> +}
>> >>
>> >> [Severity: Medium]
>> >> Can data->interrupt_users permanently underflow here during error rec=
overy?
>> >>
>> >> If an I2C error occurs in __veml6031x00_set_trigger_state() while dis=
abling
>> >> the trigger, this error recovery path calls veml6031x00_set_interrupt=
() to
>> >> revert the counter, but fails to update the software state (data->tri=
g_en).
>> >>
>> >> If a subsequent successful disable happens later, the counter will be
>> >> decremented again, potentially underflowing to UINT_MAX and silently =
skipping
>> >> all future hardware writes.
>> >>
>> >> [ ... ]
>> >
>> > That is not true because the error path will *increment* the counter t=
o
>> > re-enable the IRQ and keept it consistent with data->trig_en. If an I2=
C
>> > operation fails, the trigger will stay enabled in the device registers=
,
>> > and therefore data-trig_en should stay enabled.
>> >
>> > I tested it by adding some hacks to force that situation, and what may
>> > actually happen is that if *on top* of that failure, the I2C operation
>> > in veml6031x00_set_interrupt() also fails, interrupt_users will be
>> > decremented (as it should, because the interrupt could not be
>> > re-enabled), and *then* a second call to disable the trigger will set
>> > interrupt_users to UINT_MAX.
>> >
>> > Although this is very unlikely, the fix seems to be trivial:
>> >
>> >  if (state) {
>> >  	data->interrupt_users++;
>> >  	if (data->interrupt_users > 1)
>> >  		return 0;
>> >  } else {
>> >  	+	if (!data->interrupt_users)
>> >  	+		return 0;
>> >
>> >  	data->interrupt_users--;
>> >  	if (data->interrupt_users > 0)
>> >  		return 0;
>> >  }
>> >
>> > Note that this fix is not a hack to just get rid of reaching UINT_MAX,=
 it
>> > reflects the fact that the previous failed operations lead to a disabl=
ed
>> > interrupt and an enabled trigger in the hardware, and there is no need
>> > to act on the interrupt again when trying to disable the trigger a
>> > second time.
>> >
>> > I will add it for V9 after testing it with some hacks to force that
>> > scenario.
>> >
>>
>> I am trying to reproduce that scenario with forced errors, and even if
>> those two errors happen during the first attempt to disable the trigger,
>> it's not really possible to reach interrupt_users =3D UINT_MAX.
>> The 'buffer/enable' attribute is set to 0 by the core even if
>> set_trigger_state() returns an error code, and the next time
>> 'buffer/enable' is set to 0, nothing really happens because
>> set_trigger_state() is not even called.
>
> I can't remember why we do that. Oh well. Seems it is useful here.
>

I instrumented some more code, including iio_trigger_attach/detach_poll_fun=
c()
and current_trigger_store(). When set_trigger_state(false) fails
(which I forced), iio_trigger_detach_poll_func() returns without releasing
the pollfunc IRQ from the trigger pool, but iio_disable_buffers()
continues disabling the buffer.

The next buffer enable adds another consumer to the pool without calling
set_trigger_state(true), since the trigger is already in use. The following
buffer disable removes that new consumer without calling set_trigger_state(=
false),
since there is still one consumer left in the pool.

So after the first failed disable, subsequent buffer enable/disable cycles =
do
not call set_trigger_state() and the original consumer remains in the pool.
That leaves the buffer/enable attribute in a meaningless state: it gets
updated from the userspace perspective, but nothing really happens behind
the scenes.

Is that intended? Maybe there are historical reasons for it, or maybe there
was no cleaner way to operate after an error in set_trigger_state(), or
maybe this should not work like that.

This is what it looks like after I instrumented the code:

# All good, the trigger was disabled, and now it gets enabled:
echo 1 > buffer/enable
[   50.590395] IIO trigger veml6031x00-drdy0: attach: before: pool users=3D=
0
[   50.596562] IIO trigger veml6031x00-drdy0: attach: pf->irq=3D188
[   50.602537] IIO trigger veml6031x00-drdy0: attach: after get_irq: pool u=
sers=3D1
[   50.622654] IIO trigger veml6031x00-drdy0: attach: set_trigger_state(1) =
returned 0

# Forced failure in veml6031x00_set_trigger_state(false):
echo 0 > buffer/enable
[   64.608971] IIO trigger veml6031x00-drdy0: detach: before: pool users=3D=
1
[   64.615267] IIO trigger veml6031x00-drdy0: detach: pf->irq=3D188
[   64.657138] IIO trigger veml6031x00-drdy0: detach: set_trigger_state(0) =
returned -13
[   64.664968] IIO trigger veml6031x00-drdy0: detach: callback failed: pool=
 users=3D1

# From now on, set_trigger_state() will not be called:
echo 1 > buffer/enable
[  104.047282] IIO trigger veml6031x00-drdy0: attach: before: pool users=3D=
1
[  104.053494] IIO trigger veml6031x00-drdy0: attach: pf->irq=3D189
[  104.059502] IIO trigger veml6031x00-drdy0: attach: after get_irq: pool u=
sers=3D2
[  104.067023] IIO trigger veml6031x00-drdy0: attach: NOT calling set_trigg=
er_state(1), notinuse=3D0

echo 0 > buffer/enable
[  117.354867] IIO trigger veml6031x00-drdy0: detach: before: pool users=3D=
2
[  117.361070] IIO trigger veml6031x00-drdy0: detach: pf->irq=3D189
[  117.366975] IIO trigger veml6031x00-drdy0: detach: NOT calling set_trigg=
er_state(0), no_other_users=3D0
[  117.376297] IIO trigger veml6031x00-drdy0: detach: after put_irq: pool u=
sers=3D1

Best regards,
Javier
