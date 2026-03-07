Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7A1F4634
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879653; cv=pass; b=qBCK1ZZWp/eNxG/Ukuni8HPbxL+oH5sH3uIKYrmO7XpbexH/PxpWFiz9GTiVYPRiYdQjsDCr8ZG2n3TfZyOdWmgEZMeyPZB/6oBCA1Z7XiK55OIboCiuFGpSVxpVnwMwCCB4486fRCfUMJ6F9Adsvw+KM6xVx6QhiEqsvwcbXg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879653; c=relaxed/simple;
	bh=QrNHWt/NjBxhCFukOjw6YBPO82Y8b672DtxaW+liljk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vq62DZR9HUMF0p5g10NPJjvYwlQJII2EIQaYZjYBOoDhgq1VyIlBR/VOoCXOnoj6IIs6pFDjoKFlVRpl/6my9fbPF9zfXcRbCsnozC2jv5ufsCDm/NEzz7qwx+3kJGIa+g2oVt+fKOh3OowBVwh1Ob6QQ/7o1wS5dK/4z1tjft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7Pqt3By; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Pqt3By"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so2342341a12.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:34:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772879651; cv=none;
        d=google.com; s=arc-20240605;
        b=FTglo3l456tez/ab2dSLOjM94aJysud/bvw5Ld6Rd8lvVw6o1WUM+ZOAq/DT5PE/BG
         IzM9VbWmLM5ykitYr8OmdQhBFKtJI92umGs19m7oUPUUgxoFqge3rTKtfOTXPzzY0/Bg
         65Kylsl3whcdhxrTV1Yi91qKsxpIYC2b+bygsU6g+hQgBla88tIfc5fzGlUkuFB8EQW7
         BpPvcyUbW5bYdEfSAKibaY5MFZcdjKZazHm909jPk5m85APch3A9IBz2Ko83PK4bRPZF
         Azcf4+fjg4qu9rYHB+HJ9SWg0+eJs5I9Lu5keLypp8FQlgLHjhaJ1/dUZbqCi/+GSFKj
         HGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8NWlvPoZ7ltoj+XhxpAICMBNDxxPBfCzVEOnstG4pMA=;
        fh=VVxCeQ+2sf15bjondv8z2Oegt/yRNZBr8ln9kGMo1RE=;
        b=kNLzV0+QOD4QMRHL4bCkvoJ3n/9mOczPserz04E4vbmwie/cutIa0kVQyFJbyzWO3r
         0o+7WR1PITzL3UYN1KS/Tmy8uxE8R1TbFwBXkZ/Ziao3DfTyx/b++hES/wtauy0ePiFR
         LeJXudOHFGY+ZY2tleEyo+hCjBLlNpQvGHnGYRhxcSDboRiqR8WDRCwA7qVy8ikaWzPF
         lZXCgYrAqaIfxr1+w4NNaTsF8EuycyNna8RBS9P8KHtTFIWUwNjLMUhan+2K8CY3LYI+
         Frv2xdIuYRHQ+2BTfJqm4gApmJ5ABFwa/Uz9z1dpDKMQ1tStd+xmGBwQR5YuOnsFMbZo
         Q1JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772879651; x=1773484451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NWlvPoZ7ltoj+XhxpAICMBNDxxPBfCzVEOnstG4pMA=;
        b=L7Pqt3By103cvIT+1zd5e/QG1FQA4JCEd1RgHiwx/wf3RZxSsNYSUOwERQBWbdYz8X
         7QWq8E5J3tz5wAxM8kN9Gif8mAPkSk+Sa9fHeiGMCgifncJwqOdsDomuCjnCrg5r6inM
         hr0hYAN1qsKbvcaLhPZ6kd8FwpQG+NB66FaE7qFlJFZqIhP94VvZ54G9xbUtPE5qEgmV
         0xaBszH3DpVz1CLCHqDMv8JC5D34cGqVNyJlDvbnC0dth/pH7hhWX9jrvRqzK7YJnyQJ
         YD0RvL6XZkCiJE07K30sfPQqkcnyPGQ7NWSwSDNONmGhtaDZ8jcUxaBDKkDE/ZCDO2SL
         efWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879651; x=1773484451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8NWlvPoZ7ltoj+XhxpAICMBNDxxPBfCzVEOnstG4pMA=;
        b=QMwq/EnrjGp71A6QYV/+4QkE1whZwNohKNJgoo/RAZ4Qro3cN+MbnIa/bLPBQ8kOBa
         JKZ7ZgTsfrIzE56REGRDhCh7MeOocMXpohIlFX24wAx619MUM+ggqSFeMI0LWoNEGN2f
         u+0mR2s4jjG27CacZFUx6EuniG7lWeWk2yK8zaLpxpHaLkC2l6FWSls9+YgTXaMwUsuE
         Hul4O37/PKT73LK6MyDa5+eel5DExR6++3QvEXAOl6xbYW+Rms2W3XF1dU0euFW6XKxS
         Jehbi2I61hv0PjQcy2GQGiyn0wjMSwDA4F4zYMUDcVfJLje094ZqTfLN8PaoyqISb5A8
         v/fw==
X-Forwarded-Encrypted: i=1; AJvYcCWF6h7hgxxPfMOW0fcaqVIrGXNjGIlyL4qahG99/9oA+YNIQw/+iyDP/JRB4+r7sKbJGTipLgyyxvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxSqDX83gjG9+uKaIvk2l7oyB/C5JN2U60XDfpiTRe/2MBrDV
	/VXTwY7wMoMgHfQgjXDYKLEpzeRsIkmovXLS9hayLLvNC9AT90cUbmp/W2f961+vO4F4HwrFk5h
	nV1A5jEIIdpmlWKJKpiIYDmFZlt8WIC4=
X-Gm-Gg: ATEYQzx6fJvvF594OQ4WAHceMPZvFek1lrp+xvELdcuB0Ff7W9eSkKWmbckbGPe8kCG
	jAYy8Vq+Oib4q2Yp4x3xfUFNNje1IgQlctlpfzeVDGMp86HUUrQQ++B7hfKpN48ToNrNGDsSVmR
	cb0tKfG8pSoUOPbkA+AIMjgJ4fLdcRPxK8APr/Y63ZJ5WWfj/PlEhuN2Vyi5QTh/kkIfc1yi0NP
	KtQSVL/dlCDXh5kwgbT+CGLJPRKDRdk6f0PKFDohxGSNOvCO8AzQU3/ogag8qNHqtgl7NlMq1m8
	KJ/lxSxrkY76/ApSalNhKT7QTFGHeOS1B39MVlpTO0Gau/XKWz48w/egIvRYZn3Xl12QZQ==
X-Received: by 2002:aa7:cb43:0:b0:660:dc23:f41b with SMTP id
 4fb4d7f45d1cf-6614285cdcemr3590340a12.6.1772879650484; Sat, 07 Mar 2026
 02:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
 <20260307101758.50091-1-rajveer.chaudhari.linux@gmail.com> <20260307102634.6eaafab5@jic23-huawei>
In-Reply-To: <20260307102634.6eaafab5@jic23-huawei>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Sat, 7 Mar 2026 16:03:58 +0530
X-Gm-Features: AaiRm51yOSIWS1VrMvnTd052EafV49JEkWzbZLkx8uAXoRnnpN6G6JmX7O7vkdQ
Message-ID: <CANS1UbgiBCH63zv8uQF_EDmct+YCRgiFH+1zA9sskF+tQ_rzEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] iio: accel: convert to guard(mutex)
To: Jonathan Cameron <jic23@kernel.org>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, andy@kernel.org, puranjay@kernel.org, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

I am sorry for making things confusing, do you want me to re-send V3
on a new separate email thread?
Or I should keep this in mind for future patches.

Thankyou,
Rajveer

On Sat, Mar 7, 2026 at 3:56=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sat,  7 Mar 2026 15:47:55 +0530
> Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com> wrote:
>
> > This series converts manual mutex_lock/mutex_unlock pairs to
> > guard(mutex) in three ADXL accelerometer drivers. Each conversion
> > also simplifies error handling by removing goto labels and
> > returning directly where possible.
> >
> > v3: Remove remaining goto labels completely as requested by David Lechn=
er.
> >     Return directly from functions where ret variable is not needed.
> > v2: Split into one patch per driver as requested by David Lechner.
> >     Ensured each conversion also simplifies code flow.
> >
> > Rajveer Chaudhari (3):
> >   iio: accel: adxl313: convert to guard(mutex)
> >   iio: accel: adxl355: convert to guard(mutex)
> >   iio: accel: adxl372: convert to guard(mutex)
> >
> >  drivers/iio/accel/adxl313_core.c | 15 ++----
> >  drivers/iio/accel/adxl355_core.c | 81 ++++++++++++++------------------
> >  drivers/iio/accel/adxl372.c      | 16 +++----
> >  3 files changed, 45 insertions(+), 67 deletions(-)
> >
>
> Hi Rajveer,
>
> Small process thing.  Please send each new version as a separate email
> thread.  It can get very hard to follow when we end up with deeply
> nested threads so most areas of the kernel prefer to just associate
> them via name of the thread and possibly a link in the cover letter
> to the previous version.
>
> Jonathan
