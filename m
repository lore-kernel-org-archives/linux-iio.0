Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D49305673
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302656; cv=pass; b=Zjiryc5VP+6hOxWm/v4re7wrG4+t2kOfOCfJgRRDk6+2//8t03hfVrxmKbN5DxkEjS1qYGJtMv/0jsP/ELAKZhIHAo8NDSn8uxtaLgxBxmmlypbA1Qw1LE9ix+GRfwknliACteSuPXtHHsvUFip66BBncYWyozkzbRt8STqaxj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302656; c=relaxed/simple;
	bh=dqkqR4BnOVQZ1yByVkkIKp5wLe1EcgY0DOuGCt7r8gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrtYw1QsRd8FeCOBLYE5xKmqPN94IbP7/ha6zjCJBtuyJ0oa5q4H4IwIromL1CzLvchHMPKpsllUrpvS2yn9b/h0PnmCJRkmu/lVJX7nku7RM6VQGbt2ECL154cyNjesPzvCeMR/eYj0HJiRebXSLTwh52vORyKnvY1REsxdC/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbJ1IA3o; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJ1IA3o"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68dbb38aso810346e87.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 01:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302653; cv=none;
        d=google.com; s=arc-20240605;
        b=ja3hasZBm3sY/Kjm8r1IGbjWyZQO6FK/0YMWS++TTQ89JxHWQTvkrnyY82IIhwoqou
         dlhAbSpWA9kGPkS512S+j/kMhJFdmNSjD3ntQ3+xxM6+RZmgQ9oeMT+WMeNqPQEA0ajN
         iMTzmjU3wAr1WN4NF5eXMgwso8QHc+fiTlLKvTERawCqNUyZVzHfLQWZgp95PxXLD297
         44/VVyxQoShmbnMahwzuy15J5Od0zRstZrOrRKMwWyjtW+D46YPef1NXgL56qt2xNCMg
         dv0LAEi85REFg7+Jj1ledCPkJP+48fhbno2/muloZGvTClWVrma9XuXhwFvDoCwHCbuc
         KoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YypMuV9q9YXVfPhMTCupjt06XXyEV6MtVbgxq/LZL/4=;
        fh=TUck8HYLQD3M9WBUn/LrbSlXofXqCUAwF/sB3KNoSq4=;
        b=JqFebP7tdLPAF1rhd724GnupnG1ABFAZwXhGfXhZXX0kRKGVElrv8R0BaXOTyRjfQH
         ttYHEXHvqdZldUHNgtgRGKZxPnrClJ3Ks54vvN0V30NOLelMyTMBM9qEAthnU4TXVT4N
         jWpGUDJYVP0BDQTTkVKQZ1TMG4XPlB7FsbaZYq1HEMybTiE3vxVdhjXJgmouKiS7SQaP
         eyuJ/vFT49LU0tG6BAWf2W5YIrKG3/d61RJOh42ZPkIbraGSUc3sybrVrDxxEJz99k23
         37rBiOnIsQG5/UC51CN0DWs2BKgO0VWgbKcDcGWHCpMPogEtWo4uLwc2C1+UuPzluKDo
         cvnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780302653; x=1780907453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YypMuV9q9YXVfPhMTCupjt06XXyEV6MtVbgxq/LZL/4=;
        b=XbJ1IA3o9rZKqeJ/peV7u3sd4AJmq/DWhaPQ067PlO7lu0hq3GakpVKmLieyjaJGNO
         QgLFYA9Ay5m3kthbb2xgmqeVRnsXzwzrg/8yOE0u9NLr1+1aX5NIpQYw1lvuk2vBfmfy
         4eJQcyEvOVlqfvjxncw6uPMEYsIMQi1WuAH6cocK5lf7yGPFGAy5GH7pLaoj8hxfHnGw
         AJdH3BsmqR/Ud92B1LwDSqX5Q9crZrJBi7qmjApRu/mfifRRJBbbC1Nk8b/Z23bsrfpV
         x/p3fudziGgQilYE9KzO1KL4twQCyyv6//W3DfsiaDZ3HpPboHlkX9SjryD1Q8gYjyvc
         gXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302653; x=1780907453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YypMuV9q9YXVfPhMTCupjt06XXyEV6MtVbgxq/LZL/4=;
        b=EaHFLUNTXIhwvxiHGwQkpgw0Kv/8mB/wlMPS7DjCo/fBnKhGLYfj3OFxdss6SaQJ4g
         vugZ/9HkzPAWb3Sdbw8ni/wnhzvOxVcKsgxG5eQ6tHCAuyqhOO4vLADuompSo6uhA1N/
         uRjeN+49yZO6wXpjNFIMbKgqCga/3gAQbYfqY9ztAthbEUzF3hT51a9ST8iatYhUUKPu
         LP/3WWnOC0jEgS+qdae/edkC7jMdaiKYo1KhNjSCoAXq35ExTF7WPGvPaWMFp3rfsEdq
         1xCWKa4Ih5QLZ0VL5IayME2VyzzPxpCR6Jc1MhIWSGNfEeSIgkWT6Smf2Qjm0zj3uIxW
         lmkw==
X-Gm-Message-State: AOJu0YyHayy2vinA2knuleqxlsa+lCTvImQUUUa5r5VwlWEWN2rzKkDE
	nHGLGEtWnqDS8ndxwGgtAfWBvir84+mW5eH4Ji+eeoIw7HDXt9zNCIDGfTiFxzjbZlIULa8SA3I
	mBIcjx8b+Kow0ftTZSKhcj8diATEcdjQ=
X-Gm-Gg: Acq92OG9sQ4XFUHY4tFgP09Zd68OB4KIX2GPWvMWWbq6y/NUt1yLBIRwSL41lDK+j2+
	g2VhmoUADmDidcHP7LXzC6AkR+uxxmy4Zr3w3dTNF+s844gB3ZHjh6CJFFqWoRMhBgCB38idO0g
	XMzlGZlRYvlm8Xtbme73YEFJR6bpSmOi1mMpu+oukOKEcV5YBrurM9U7qhOgmsUKF/bgZS7Tlt9
	rKT6VNLV5bQxfZcmqkTR4/UN/pQI//tykuJUMTXiflPXwJkoa/y+yWpx24vpMdF7owgu/OXqRMB
	dCNMjnwyPQR6BL04p1W3S/Ae6EYQeXI77jaKrXOLYLTc/XRKr0+cHy5dD1Np3m4=
X-Received: by 2002:a05:6512:24ce:b0:5aa:6d83:800a with SMTP id
 2adb3069b0e04-5aa6d8381bdmr522214e87.16.1780302652412; Mon, 01 Jun 2026
 01:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
 <20260524132824.54918-3-muchamadcoirulanwar@gmail.com> <20260528170927.65168836@jic23-huawei>
In-Reply-To: <20260528170927.65168836@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 1 Jun 2026 15:30:40 +0700
X-Gm-Features: AVHnY4JErnspeaoP2OZI2ukHg5O69BCq1jevCR3XrllajWyDd-8YbOzEVDhD6E0
Message-ID: <CAO26r3QasDuUo2_7qrJfPtQer-UP6K6jzg9=RhDRT8OXN5BK-w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] rust: add minimal IIO subsystem abstractions
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 17:09:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> You'll need a lot more stuff before it makes any sense to be messing
> with claims on the state.  They only come in once drivers are dealing
> with buffers etc. I'd leave them until then.

> As above with the level of bindings you are doing so far, neither of these
> should ever be called.  They are not for use by drivers simply wanting
> to serialize things but about controlling the ability of the IIO core to
> change the fundamental data flow from simple polling to streaming data to
> user space accessible kfifos.

Understood. I was conflating "serialize concurrent sysfs reads" with
"prevent mode transitions", which are two different things. The driver's
Mutex handles the former; DirectModeGuard is for the latter and has no
business being here until buffer support exists.

Dropping DirectModeGuard entirely from v4: struct, C helpers, and the
trampoline call. Will bring it back when adding buffer/trigger support,
where it belongs in the individual driver rather than the generic
trampoline.

> Sort of. It ensures the state doesn't change.  Given buffer/trigger
> operations only occur when in a buffer state it sort of prevents their
> operations. That's not including stuff like setting up buffers though -
> just the data streaming.
>
> Anyhow, kick it in the long grass (drop for now) given you don't support
> buffer state. Good to see what this probably looks like though.

Noted. Good to have the shape sketched out at least.

> We only need to do this if the particular device the driver is supporting
> needs for the specific operation to ensure that no accesses occur to
> the device. We should not do this for reading stuff back that is cached in the
> driver for instance.  In many cases devices have interfaces where absolutely
> anything is safe in buffer modes.
>
> This is unfortunately going to be hard to do other than in specific drivers
> that knows those rules. + doesn't belong here at all yet as a rust driver
> can't get into a state where this fails and should never be relying on this
> for its own synchronization (e.g. between concurrent calls of read_raw()).

Right. The trampoline shouldn't be making policy decisions about when to
claim direct mode, that's driver-specific knowledge. Removing from the
generic abstraction.

> why .get() for this one.

I used .get() because NonZeroI32 is a wrapper type, meaning we have to
explicitly extract the
inner i32. Since the other variants use a plain i32, they don't need
it. I'll add a quick comment in
v4 to clarify this.

> The data accessed in c by iio_priv() is zeroed, not uninitialized but
> I'm not sure that's what you are referring to.

You're right, `iio_device_alloc` uses `kzalloc`, so `priv_` is zeroed.
The SAFETY comment was wrong. Fixing in v4 to say "zeroed memory" and
note that PinInit overwrites it with the initialized state.

> Can channels be static const?  It is in most IIO drivers written in C.

Yes. Moving it to a module-level static in v4. That removes the KBox
allocation and the lifetime question around `indio_dev->channels`
outliving `priv_`.

Thanks,
Coirul
