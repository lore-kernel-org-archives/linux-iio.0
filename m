Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F50346782
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313601; cv=pass; b=aLWioinxJDtNmI0H96nOS/C5nWmhmNnAdlynKufbFuToBeCDGcUo6uS9zV5RJH/Xs/QqCRWD1Ar9RqbFqMTAaTHo1FbR5cFgl5rXwJGB+62k51WwV/Mu1Sw3GqgoW44io5v3GVMqr5e2HQhSt1Gxjh9lJQPQPRhszusoYSzhfFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313601; c=relaxed/simple;
	bh=2EkJKyz4kt+nX/YiRPXOU9Y/RomvRxwf410SJENTcWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+OO6gWxmcNyOYFySWa1wWNd+XAs0Av5uMyioUvO62USCKdMQbQccjEJAg2hNeB8joY5OJyB0IgCAo+Y0OKVgPfwys9oBn2AxkYCnlhmswSfMRn5DFjAjlKC/6G/nnEM51aJPg0dD+7Tei3wpI0WgCQHcwaxHcscXA6uTHfAs3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFkyQjd+; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFkyQjd+"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3965bc493caso18761341fa.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 04:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780313598; cv=none;
        d=google.com; s=arc-20240605;
        b=egdMoUaxt6fMLnqczWNGVcAujcUUl8yRgJ037UVuw9nTDD+y08c1Ol46w1Ty+eS6HJ
         Q3JziR0FXWFwfl4vP4z0JqEMpgMt6N8QyjYRkWGPEdBbh9ykad2hb/P7vcz2bP3m4d5x
         xRU0Ezt46X5/i2IjjZstSrrT6TnfTe6T/PIVWR5IFoT+6r/LeGujnXddOetbFLowBbUg
         OpVQPKt/nTdNmQ23cS58TjwXxVytTsqneDDcFv3llawVQqTYVm5WUbQAVcIZVjVJ4yK+
         mvrSxDviLkXH1uyQThPbmBrsvBLOQHiCIzvj0WfOEHHcSLtpcRWNtTflE/33VNetoSdC
         YEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9AFofBAYz8Sa57QxDZuZAkdSqVfumktDj0aUTcAMgtk=;
        fh=vyHJbdCyJ5wbKY6Q7Osa6se+lxmUgtZps652b5hOgqk=;
        b=GxgYAMFS/pI2lu1mp0X7t9sfPsQUyrufV7eP2x9yFjIKC+PZBkwQ04ilT7efnu8CV+
         RRPvuFo5a0UdFU8W39721uOLMHy8HLak/cCx5AK5t57UbOeXhYN0ieLSi096syqhnlpd
         wc/EpNUuPyIAJ+at8dlO2yWrCZfMtPxej/xYWooU/ct3JiuUhp5D6DXEECqamhbZat1V
         PKb1bhrsQz2BQE+L/NW0nd0ygu2zGlXc5dvnB3Vtntp5T0y0cjPc3+wHhAkvp4J4OwzI
         s3tilWfNMnD9iOmEXcR2SnrcpSrGM+oRxCPHDPpGcNSlvH9Tok0BuSP2thBjCk1EyJcS
         yMmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780313598; x=1780918398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9AFofBAYz8Sa57QxDZuZAkdSqVfumktDj0aUTcAMgtk=;
        b=RFkyQjd+tZd1FOBaAp15q39WaJJiCzGoREKNKGqPu3dSTR+GNsrF1b/CpST6zUtKGu
         f4kq9DWOHhJSkz/VOY8XPYFQmeznmwsjCdFTOR/LYAiFttwS4Q6SPrOvNOCFi5WfuueI
         cXP5m+4WsVJHXZTs+ecvMFYcODngfHN2zhVVCZgrYvvt66qyB4TDJ/ZbSkxGBZMngHqh
         2HydpqD+W0PCOpabm+y0L/0mpxjKEIbsL5BMXowZDoSHnJciWHNqak++wr+Acsy7TV1q
         JoTawqLcTPNrZ9oo1PJeKwZegMRjVTobLC/+pxmBsxfMaXBHlFeUE3sc020+H2RJtwej
         9tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313598; x=1780918398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AFofBAYz8Sa57QxDZuZAkdSqVfumktDj0aUTcAMgtk=;
        b=awGsV4Lvtp40BuV+6ALxgRGrTarHMEj9LE+baSw6ZJHtJof4jynjD2HX9EzobqFdYM
         U/8dAJKpk2XJvgPIjIRGqfFmikDzNqVoOhiYM381hqgfc0iRqtyvoH9SfzWAjpdHRGnu
         2IqoiT31k2uOn0bnFkXzf5uFyaZFQNLD6KQpD9qztBW4bnzCCZiGYmS8c9EYCiApLUml
         l+uVuXyVeL8lIOXFIghHJP+sDt3KeQu5HlVNNrWXx3FrQy54CQmxm8cujEiFIrlfvOhC
         sW1CJBy42MjCnV4tfxGNSKFLtG5yEsZH9WZHTl3Ixvbc5F4gNizGhEu9SWMeORYCpKzm
         JM+g==
X-Forwarded-Encrypted: i=1; AFNElJ8hE2abdE8FIQ6EdhfhgGv5vNDL+iC1QtPJeqAVARBvePxiLZeccS1D5JwNpylVp1G3jexxXPuomzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPU2qmxMJkPTj8pgpjWcLxW/GizudND63mwIarlx2LAfLIhUWZ
	/1zkngOAJDbFKNi3ctt7j5z1ctTFmH609RqLOOekdqk4wvchv+n3pDzTSeF1cDymwCZyQsGVoeU
	8t8rj29bM+f92D73mQ1qJXo2PYX8DlPc=
X-Gm-Gg: Acq92OFB3mTFJE7UmdmXQy8nAUMT8ka6hslL5Dj28RrZeerwNYv2M8yZi1TQVNsPUr5
	O+3rAp04+muN6hn2dD/J9AQdQ6MzCKasH5hkLnONkLRmBt72mg+xfBOtzxLdsjTWzjtpKo5HZvY
	NPzeRdzgoiFpQMZBrtNdJWF+AwgwNPxbttgUX6FCiaoe0NMlfiDj5rbQk3aBZEyhlziNo/RO/xT
	wdLBN8sjmndxAyRCKbLi4hInpX1bbPw+IR1Ns82P+L4qG6F0PAOARGXAk1dQYRkUD/VfwIf1LBB
	Na/IyzN3/P9ja8xX7XSvbyK9a646xd5dPwzLTDJA4GASXpBOrl5f
X-Received: by 2002:a05:6512:689:b0:5aa:b6a:738e with SMTP id
 2adb3069b0e04-5aa6092a284mr3457717e87.44.1780313597763; Mon, 01 Jun 2026
 04:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-4-muchamadcoirulanwar@gmail.com> <20260529053803.3256031-1-branstj@gmail.com>
In-Reply-To: <20260529053803.3256031-1-branstj@gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 1 Jun 2026 18:33:04 +0700
X-Gm-Features: AVHnY4IhtGOIH_QUtVZymfWopC_MaNartaHjSBgct--I-duvHtzGa7eq2I4G5jU
Message-ID: <CAO26r3QseHMqX7iQ5B3BRk5wf0_3i1XY+xr6BmY8u4M50ufE6A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/4] iio: position: add Rust driver for ams AS5600
To: Brandon Saint-John <branstj@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Igor Korotin <igor.korotin.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 May 2026 05:37:00 +0000
Brandon Saint-John <branstj@gmail.com> wrote:

> > +//! Datasheet: https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
>
> Small nitpick, but going to the above link doesn't resolve to a pdf.
> The link that works as of today for me is:
> https://look.ams-osram.com/m/7059eac7531a86fd/original/AS5600-DS000365.pdf

I'll update in v4. Looks like ams reorganized under the ams-osram.com domain.

> > +fn err_enodata() -> Error {
> > +    Error::from_errno(-(ENODATA as i32))
> > +}
>
> Later on it's probably better to add ENODATA to kernel::error::code
> instead of the helper.

Agreed, the `err_enodata()` helper is a workaround. Will check if
ENODATA can be added to kernel::error::code directly for v4, or at
minimum leave a TODO comment.

> > +#[derive(Clone, Copy)]
> > +struct As5600Io(*mut i2c_client);
>
> You can replace the *mut i2c_client with an ARef<I2cClient>. The
> kernel::impl_device_context_into_aref! macro is run on &I2cClient<Core>
> so you can call ARef::from on dev instead of casting it to the raw pointer
> to hold it.
>
> Then it saves you from repeating a few different parts, like redoing unsafe
> impls, recasting back to I2cClient<Core> in try_readN, etc.

Good suggestion. I'll restructure around `ARef<I2cClient>` in v4, it
eliminates the As5600Io wrapper, the manual Send/Sync impls, and the
unsafe casts entirely.

> > +impl IoCapable<u16> for As5600Io {}
>
> None of the read_u16 or IoCapable<u16> are used at this point, so those
> traits/methods could be dropped.

Per Jonathan's feedback, I'm switching to a word read for the angle
register, so `try_read16` will actually be used in v4. But the As5600Io
wrapper (and its IoCapable impls) goes away regardless since I'm moving
to `ARef<I2cClient>` which already has the Io impl from patch 1.

> As a side note, in the most recent rust-next branch, there are a few changes
> with IoCapable so maybe worth rebasing at some point to get those changes.
> IoCapable isn't a marker trait anymore so I get compile errors trying to
> rebase there.

I checked and you're right. `IoCapable` changed upstream, the empty
marker impls in patch 1 won't compile against rust-next anymore.
Will provide proper implementations for I2cClient in v4.

> > +#[pin_data]
> > +struct As5600Priv<T> {
> > +    #[pin]
> > +    io_lock: Mutex<As5600HwState<T>>,
> > +    channels: KBox<[iio_chan_spec; 1]>,
> > +}
>
> Could As5600Priv/HwState hold the As5600Io directly instead of a generic T?
> As5600Priv was not generic over T in v2, and since As5600Io implements
> Io/IoCapable and the sensor only uses the I2C bus it doesn't seem like it
> needs to be generic, at least at the moment.

I will make this change in v4. I agree that simplifying the struct to
use a concrete
type is the better approach here.With ARef<I2cClient> replacing
As5600Io, the struct
becomes As5600Priv { io_lock: Mutex<As5600HwState>, ... } with no type
parameter."

> > +            m if m == iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize => {
>
> Ideally in the future, the iio_chan_info_enum_* variants can be wrapped in
> an Rust enum with an #[repr] attribute. At this stage, match isn't as
> useful as it could be since you still need to call "if m == ...".

Makes sense as future work for the IIO abstraction. Would make the match
exhaustive and eliminate the catch-all arm.

Thanks,
Coirul
