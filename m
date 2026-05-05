Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AE3C2770
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018379; cv=pass; b=TJnRqpfPo4USYqw08FtaA9u2NVqiKicLdgsbUrXbXSFwj06i2wV9XBviYRPfqRP38+Teplb0zsRaODxdKcO/R71QHCfvMsqnRkF2AtQGpa8O62Y1ezjNJ9RxIqF9Oyei6u7Izv7O0pmZ8Z3w4R6qsdLwjP9DG1yMYymZH3pHGpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018379; c=relaxed/simple;
	bh=t02uFHiF9+FiCEKQVUOY70hipSrA89k9j/NotVob/sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUVbntmJWNrORZbhMatiAx/fwaczRncxDtmwK4Z2RLTTx9ruHmrXtB3DVB3NWShsU69SPutO0RO9WFAub2Dyq+TrDRz0HcRE8LEQlqR34DgOwv7vy8La/TToBGFcqHgh7fug1t+ErgO9UCmqaMEx/uvLCiafmwEeGxPYv1m5p3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA+Fj5Q7; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA+Fj5Q7"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso2667821f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 14:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778018376; cv=none;
        d=google.com; s=arc-20240605;
        b=W/FeOICg1ki+xZ4QFEcRLxzEvQMD2U5WiuQQv7pkyRj9wtPivxj58AGVPD5HPuF/EJ
         fZDm6LfrKfoWvljj7iAkUJf0BvvYuuoVh8iVHUPr4OzbPLojviC4WMPOalSrJ2lP1Jxv
         CpkYBXlgv8G76Vn+8H4ERU1NUn9djD1W8Zgb1UCTHq3CrGSuz9dfv4HJrRBqHgyOulb9
         4JM4LUAuRFeHyD/pLHL43BGKGy9tpTHPrdhooMHfe/fifmlxwOsRlOd+X4DSLtiI3gZy
         IZSogy2/CNQ7r6Dq6XAFlT50C2KRz+rnl6lvrNwrbSiabhwCvjPZWBNMq4m+3N8UOZsO
         SBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t02uFHiF9+FiCEKQVUOY70hipSrA89k9j/NotVob/sI=;
        fh=srHSygM3QOnb7aQ5aiU4H6RslUesjaFCZKNb9N/Nazw=;
        b=k84taOSACIck9YuxtwMDFptFOa8OoD5uWIfKQWBd96595BS4m2azoSLJiDTkSDjDk6
         aJAxiGgPO3zpkBVYhiyT8ApCp3VcTH433hCb7mSkFQolNXxqXpF7cp4HIRYEawBwGSzY
         qDOoeY77RfCpJRGX/3xtyHaXCp0MTVmMfrcFsEuPPGdnhWYoAWudkdvRT3CrFU0rbRZ5
         cigaY7iBJK/SpTfV+DzKaNMNteeAtGVM3gj/fj33uBQYvhZEbjCjyXCTYOCaJv3d+jXb
         1LfCRvGKMk98p9oDCGnWK8YjvjNZRbD0dBkL3xw3HxzoPyhcGDECJeg+gkYGIHk3Zk3L
         z3/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778018376; x=1778623176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t02uFHiF9+FiCEKQVUOY70hipSrA89k9j/NotVob/sI=;
        b=bA+Fj5Q7s91TlwhEZdZpGc434uZa3zWUDCEYLUOjAmf/Qen35eDtW5kE63/MMO7l+e
         GEc61YlVne1GUPbzRdMaPk6ZaNBIBnEXy5KZ9gf+FcJt6fVAY/XXLvC8j857fYHfbC4i
         TMbfqATV7hBpazk1vNWfVgVMIWOgg91GB/GFmvOPHBxBv2RiWD3/Amqg9yAxsho4rBBq
         Il4SXo25CzoBltscDW3zUm3/LwgBU7Go+/MdQRmCxHxxDwNAWE2SX91Sy5cFT8RLNPGg
         tzhPMnZXH9YGutnKNkRZz8YGT8KBPtWodW362HSSv5Me/xBJHk/9TDH9XCuzDurfKkPr
         BwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018376; x=1778623176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t02uFHiF9+FiCEKQVUOY70hipSrA89k9j/NotVob/sI=;
        b=lJc9XnjjxHprd2Cj5W4+PsM/lcpzjXUX0QVgQV49fwXrFGj+o+WVG3RLqfwi8PciHw
         wEFCm/xFyXzi1B5rhArfBC5pJt2hwFd+FUaIeDxCDrOZPD5xjbO0gIs7bSN+tLwowcjB
         bKv+2D2oAc7/YH/0POnXpf/r6B9tWGJpL/kr/+y3wn9s8wj5Kpg15+Eut++FvUsqzryd
         r+HIDSYBqE54N8a/Ow3IGsc7LHI9J8jtubt2+N4B+IbYspdTO806GwIwuR+MlhGDRPUh
         3xs/Il4+ke4Zko+GJQl+evGDAZuRr4kZMVCSG6V25tZZevg2IYG05shjWw4Rhm82U29X
         JVrA==
X-Forwarded-Encrypted: i=1; AFNElJ/QC3tqGIOC3612q5EkdlGEs92rMZhKPnstAHi/1/4dlP/6ECNCjf2WamfWvYNSoNlHzcZf6wfTzbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAa0YlBpzSA/wHwVZKdO288tQOeAJiH5UNrDfY6PFCgalDPcPL
	TtmP+l3gIpNLtbv3AFa0DxIBlsxGyarB5RoEX7dnSGC9U6UeSZ2sjzWTlfE475AZ6vDv4vM6wTk
	0KxuEKA4PfnGdt4ceqlPco0Ix946yJZI=
X-Gm-Gg: AeBDiesq32/QOhZOq8uXFuarMoMS4Wi2BDX4K7Jv5kFWiapeatdbBq+IYtaRW0G8ahj
	gt1iCI+D4eh/59vbfka787J5u7RJ3ilpvApAWmJ5mK5OCYjOO+ccVW6lWZ/aMhVB0KCL224wO32
	dTL8/Q92ctJDJTBo+stZ8UUKNw9gUWo5UfNw2sBaHdHzMbXkUQMqBmpQfGGaNFzz73IPZMlDZSU
	/NXYwo8TQp8tlgyLyk69kzMZQie3L4vaqninAEDUzHn6KUUKVO6x9wTOOSe1WJemzFBxhp+Fa/W
	nIpWkA1whHX2o/SDVAWiP5+FFxc1DHX8IAo1ssvkYnu53obgKCgSx320LRwwMuq21jt4QU5EUjg
	zm4ggsGLr0olCBOQwcxJtg3HCMeb/UIZe+3nq4uvL1noJ9NoDgss02eMyRexMwu3J6sKruY5F8e
	F5gGKRzmve/RX7u9SIO62/vnITthh06rgS2b4xZ+xDczjYBCw1
X-Received: by 2002:a05:6000:4305:b0:44a:ef8c:de18 with SMTP id
 ffacd0b85a97d-4515cf125c6mr1441639f8f.25.1778018375768; Tue, 05 May 2026
 14:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com> <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
 <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com> <CAKqfh0Hx2Mfb3me2JOQs6hpEKsCexZ9hAuE2fOX1qRdoqg659w@mail.gmail.com>
In-Reply-To: <CAKqfh0Hx2Mfb3me2JOQs6hpEKsCexZ9hAuE2fOX1qRdoqg659w@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 5 May 2026 23:59:23 +0200
X-Gm-Features: AVHnY4Ke4aIo7eSJoSG8jNMyKzKwj9UX77xm96FxZoazrr0sHwHigsRlh6GWFrk
Message-ID: <CALoEA-xyt3S8B1Fb4Qr2GZO1JhoA-bmCEt61ikP-UEf4gnJacw@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 May 2026 at 23:42, Maxwell Doose <m32285159@gmail.com> wrote:
>
> On Tue, May 5, 2026 at 4:26=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
> >
> > Hi Max,
> >
> > > Looks fine overall but has this been tested on actual hardware? Just
> > > want to double check since this touches the set_mode and power_on
> > > logic.
> >
> > Fair enough, this series mostly concerned code cleanup and moving
> > away from older driver programming practices, so it shouldn't mess
> > with the functioning logic as much - however it would be more than
> > welcome if someone had the hardware to test it.
> >
> > > Also I will say it may be better to keep usleep_range() since
> > > it's more explicit, which will likely be better for the future to mak=
e
> > > it obvious. Also, I was taking a look at the docs for fsleep() and it
> > > provides "maximum 25% slack", which means we're stripping away almost
> > > 375us on one of these calls. And besides, it would eventually just
> > > call usleep_range() anyways.
> >
> > I disagree here. If you look at the documentation for msleep(), you can=
 see
> > that "slack" is actually an addition to the delay time, not a
> > subtraction. fsleep()
> > will always guarantee a delay of at least what's supplied as the parame=
ter.
> >
>
> Sorry if there was any confusion, I just double checked the docs
> myself, I was saying if we do fsleep(100); wouldn't that mean the
> allowable range is 100-125us? Might put some extra strain vs. the
> 400us we had before. If I'm incorrect on that you can call me out on
> that.

Okay, now I understand. From a scheduling perspective you're right,
it would be less strain. At the same time I don't think that was the origin=
al
intention - the author probably just slipped a random value relatively in
range to satisfy the max parameter.

Either way, we should perhaps take this up with the reviewers, as Jonathan
and Andy (and Sashiko) didn't have any issue with this.

--=20
Kind regards

CJD
