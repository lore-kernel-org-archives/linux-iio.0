Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792566157;
	b=wNpse8vlOtwd5QffHf+U6eFTtKPPW5tv+uTBt6tc2M//wjmwc3siE3jk1zfmxgyGdw4I
	 d8WOqYb+zDWv0AnXnUtSafwkLyr18EEJsyf0TtBjSEZdNz8V03T2XItNKjisQUIk+IQzH
	 SSyHlK34Sd70TtNbtu1Z2Jm7r8sCl2NOGQRCvT6nN+hcNz/idfSWwjMwTfDixdzGv46v9
	 fET8rDzAoXsB7AuIggSi6c+uVoUXUhtfs9WOa5hyN9f+n0VEfcpa8xcCpYQVKl04OpRQd
	 7BeIT9k3MqQhSt8nqL+q4LSUa/ltJkGQMZcZa49CuJrv44vN+wlHIYuFUSMpGrhZqVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ScI2PR6LLaTrA1CijXDQyJr+PpnB33pyJUIbjOPXVkE=;
	b=zLCLk5UKVDY180ww2gV9bl61a39FE755QS0qFXjtRYzFR9L6YdrJHCQA5ucS9U9qvyN1
	 RBUcN3OU39h/CvDuktwgZyiG3Yu7ut6iOzeL68EI3Alm+EfGb3J9PphQ9F7PbRc2gFE7M
	 +jJasFiN0ko1XOpdFmRehZ893qASBSbRy2Z95pjmXmnw9geqKpvS7wL5ImbmT+DMypA2s
	 8COBJFXwLHFW/DD2KAI0T+9zbPOvQksrfWITyuNkEdGTGP5Fltadp51M2mNLqqcRQ7M/d
	 nNYeLZEzgzr33/tuTEXsFykI8JsJW0qgivN1o5QTilHOO2NgtrXqOls79Givu+mXfKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dydAQVFD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CA606A31C
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 07:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dydAQVFD
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so3901441fa.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 00:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792566155; cv=none;
        d=google.com; s=arc-20260327;
        b=iVb+RHY3prGEq44pP1yEpQxGHFOcI3fzh1swSlg6H5Ld7bn3IopT02t7TdQJspfJDV
         N3/PrzbtF+RpPpaGFysrnsMXlkK5gGJ67DssDX0YmxMtAv0ZoWi0cBZH0oD9nc2WI9V1
         WYD5ug3/SkbMEiJV3pquHBJ6eGauTmWBT0nRNtgzU4GLtMibqlNkYJPJ/rAcwAvmNmTL
         oORjn/W0GD9LbO2f5E2LLt2kJxjc2MefOMJDTiJGuJDCq5DLF4fQ91sC50BjnAolRRd6
         cPGbbERcn+YPQh3xwG/movux0hkJ/ZnjLrNozc0/ep1V7mWRHWhp05rIq3H2++Z0rA9A
         QA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ScI2PR6LLaTrA1CijXDQyJr+PpnB33pyJUIbjOPXVkE=;
        fh=AF4iUpe1UHekqbue7CDBndVxwFpy9+FgehOqtQ52vJw=;
        b=OHYtqPNqX3WfIZ5aZ7hPIKGQG3c9rkvc5gmRHqmNq2FWuoRmzM/EYWFbBuWpTmFvqG
         Mbb7CJ8iSKAmasVDGOC4zvkpMzD84ZzQYEFrwkccjG+4eG6k4/u1G76jG0zMoaDaJCzO
         sKBo4sYfxnw1Hd2X+vDSsSlFT/PlcL0pEl9I1ot/4SLkjPAmqPDWOhfuW4pgSS2rqGgt
         fCTuTqJX/ix1iTkeCrlzladOtuJ5ho9oO6WB9UG/F8prHY2mnB7oGEjJTVQBGfIOSPTt
         KX7iKjnhS09/1fs3eAyOGAU+bm8e7X7i0gg46K42l9Ete7AyqKMELx14ZfOGbkJReOMf
         J1VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566155; x=1793170955; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScI2PR6LLaTrA1CijXDQyJr+PpnB33pyJUIbjOPXVkE=;
        b=dydAQVFDCmszIweiK1I6g87TOuPuZr7IuJihgHtNx0uWoscuIm8HOVg80pHAaTauwB
         CiiGRfFqiFjx3r006HaN4o5QxN5ZhQ/QQz8SROfF5ZDR2JJgvjEXT0wPAtnWOoI2AlFu
         Ibe/HNRzdOzEEE/MZVg3SN0OR72vkjm6xHP/riv3Lw9ZoTzITob7RCGU71xFhbnVu/AT
         t31z6K7bsRPKQM2FWOMRd6y5yQOxspK7YY0fjenhhPd3/EkCet2IHS8MWGGVi4lbPvcq
         DsFzyrQgP2xLJ4G5LaVEaq1CNRsvfvv2luqBqonUd+2ySIzSHNFwfxNY4yPZ0w93EJtC
         amCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566155; x=1793170955;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ScI2PR6LLaTrA1CijXDQyJr+PpnB33pyJUIbjOPXVkE=;
        b=cTIWbP/1YzYp27BZey+ihW4zkilgKqMGZScNv8Z3+oF9t2Dq9iGG/aA9h+z1G2T58s
         HENCpPw4K0xuhbyiG8S2/PMecajvrNdRrdun3U+KauHQF9EJ71R4xY2ZkArtJ7reTgIq
         aTTlTijj07YwRjw5NnryL3DsQv5vzKnl997O3Yhsgx5Vqyj91VUTxpgxi53VtyjCdTIZ
         wREzqt56SHgZMKH+iKmQAGcnYYRFiMJAFG6zX0z39zgFTpT1qxOLUUjA/eiHriAcfxVs
         LX5hlLfd9hhjgd8UsxPX8qE8Sei2sqm0hnQJaaagAxdKx8QOZj748XTPZQxdRjuacHW3
         bq0A==
X-Forwarded-Encrypted: i=1; AKwUvBw1szWdDcQgxjqaMedjTMT6MXl8sHdB94hzNIzO2+gLvNBZD40Cbuf6VaVRMkU0uOUMlmg39RQYgtA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLthxsoBRAtH14m9Jf976FFd/OhmR16REzd7hBm4H6ocHLfTELh
	JSA/l5Y5IFYq3YILgMu0C1pUlhvxWvnyV8jbeSwc9gYYnF2VXOAEcGVIJBTzF1CQVJYinp8Igfp
	pgeLsvO5YMrnnll/Q1z1XK3To5vsjE3E=
X-Gm-Gg: AYBFou3EngkwOEv/bj8DQREJnyRqTUelJFDbAqusQsW9+BIDU0A12L4k2KjC75mSx1P
	9FIYzUn4JSdHMIQ0HWjHRvytPb9/IL34J3Kubj7Vy8IBnF49dyttz8xekf2vyq6sMaNJ+TIJma0
	eAtUgnA9vrpxWBOcY2Kos10f7m0DBwa4unDef7MtcpGgSJbG6DJYreiTDQqmJdhWvoLaN3OGHmZ
	+MzA51pIdYLlg5F606b3jx3nylKuPfqYRfUjShAGurRbRat+QtoAGo113KsiYXFqsz60DIE3LRE
	R/VmHQA5BUhVFUHSefwqXZlDJ9nEUvN6Qr9/+422Dr2YspCk4w13gL+g904VNXOi5iRY9PCXzH4
	Q6f3Jkt3fVDrFnDq6hv9jj3sO+HYEgpJRmmVTjOXej/CPFCWDf4ULZzok
X-Received: by 2002:a2e:be90:0:b0:3a7:635c:d56c with SMTP id
 38308e7fff4ca-3ab4edf6d7dmr9603521fa.7.1792566155073; Wed, 21 Oct 2026
 00:02:35 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018-adt7316-error-codes-v1-0-1970b7e242ac@gmail.com> <DM8FXLI78NYT.1211XFYSRH5P7@gmail.com>
In-Reply-To: <DM8FXLI78NYT.1211XFYSRH5P7@gmail.com>
From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Date: Wed, 21 Oct 2026 08:02:23 +0100
X-Gm-Features: AclHuK8t7geITgCelH7NvQN5uToH4QCPhBjI31ls-GZ-beJJ-UXA196JduQkipo
Message-ID: <CAJsKa+4+raxftmYPT5yyU6EnP=jEnngOy4PSGaztUgL-N+cXkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] staging: iio: addac: adt7316: error code and probe cleanups
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 02:58, Ethan Tidmore <ethantidmore06@gmail.com> wrote:
>
> On Sun Oct 18, 2026 at 4:41 PM CDT, Raffaele Tranfaglia via B4 Relay wrote:
> > Two small cleanups for the adt7316 driver.
> >
> > Patch 1 makes the driver return the error codes reported by the bus
> > helpers instead of replacing them with -EIO, so callers see the
> > actual cause of a failure.
> >
> > Patch 2 removes the dev_info() printed on successful probe, as
> > drivers that are working properly should be quiet (see
> > Documentation/process/coding-style.rst).
> >
> > Tested on arm64 QEMU, with i2c-stub providing the device:
> >
> >   insmod i2c-stub.ko chip_addr=0x48
> >   i2cset -y 0 0x48 0x4d 0x01
> >   echo adt7316 0x48 > /sys/bus/i2c/devices/i2c-0/new_device
> >
> > - probe succeeds and no longer prints a message
> > - device_id reads back the stub register value
> > - writing 0/1 to "enabled" updates CONFIG1 (0x18)
> >
> > Error path, instantiating the device where no stub chip exists:
> >
> >   echo adt7316 0x49 > /sys/bus/i2c/devices/i2c-0/new_device
> >
> >   before: probe with driver adt7316 failed with error -5
> >   after:  probe with driver adt7316 rejects match -19
> >
> > Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> >
> > Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> > ---
>
> This is the current policy regarding AI and staging [1].
>
> Thanks,
> ET
>
> [1] https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh

I see, thanks for sharing.

Thanks,
Raffaele
