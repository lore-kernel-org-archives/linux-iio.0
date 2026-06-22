Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED991BF33
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782086964; cv=pass; b=tj2zc41skHyIUfkhU5zgdMmtTQM13+vJOP1kfSy6qiOmENzho93T3haQXSd6h3Zi7RL5Q2CZTFJpIP8doPxjT03lRfcrLXROhPAJLnYGfPysOjoTQKh1OMhEADqjdpichteIANp+mDZW0w2L1UUsnXcE5Qk3KomDhi0ruL17m24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782086964; c=relaxed/simple;
	bh=tJWgxbnhAq81DwIaWo6hvawWv37dgX0prh89deKA6hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ffvqli+Oh6h2dSvCYAf1hBG3XlJmfWyHdTeMJjjfn4emSqe0RlumT86HXYqdYXKXWiYFwaW/tVpSXOeNVHV+kM4E5jlWu/e9D2vtiRsCQiEzTvSC6vVEsa+a0Zf+nAwIirjh2syAhd0wh8XN3ZV0YMdgKeVjN3giqJv7U4Q5sGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1fHexGG; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1fHexGG"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7ff0645d1d0so32219037b3.0
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 17:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782086962; cv=none;
        d=google.com; s=arc-20240605;
        b=cvHBqpjYGKkrKV4HFwWdniZ2LpuuZOA91spsf4HpITneYxLFHsC2ekYwA/jLnnfW5I
         doGCbHTzMofvNDYk4Vb43Oc2vZk/7Bxa10JR5CA7B43igHXHSfjauSJTur78eHbAPFCf
         9Tfj2gQlrsd4gtAJ6wzZAGhxCMEPSZr7KyuQVmloRjEViC+U/1a7xEXRdNLwZX/Ow+s3
         vqxitk7llfoLSc0kCsFZnz1T14vNj05DDyk/zirEuIEiV+y0V6AvgUMXrImR1jXsR/p3
         pRZcG94v5FNFlXyG6c8ChCU3YBquMYQHEjypahdwB3P4sKvcFioISf+ixWr5GqQWnyFa
         XYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJWgxbnhAq81DwIaWo6hvawWv37dgX0prh89deKA6hs=;
        fh=SePE1x0JZBSO5ix2FtkcoBRvin5iYes5JN/5Vma+ua4=;
        b=RQe4by2qFLHcLtVZazu+RVkBXdLqC0P3sGzF5SdBvsRK9zn4q1cRvOU2+SZEqWbTBP
         qjzdrZMfCkHUtiuTvcQY4mcjhuRSr8USK7AgM6wgkMqh9rWmbIp3sgJVBlCTrIW81Knz
         PhPOnpdJre2PXiuH2iirxdgK+GTPqUJv60UWB+YbVwH3SDkiTTKUBaBcicM/jDGPOl2Z
         /pBFgHuQLraNRZn9Y9KnnmtHwMfG3J52yBGR1t9rEdNzi3uFZGahEG6TtPmkmwhqVh4Z
         Ewr913/2+3611faamBO15fa8fVeoXbVeOxjbnLu8V8uSKV7Tifvua//wUst24e70fjyu
         nw5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782086962; x=1782691762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJWgxbnhAq81DwIaWo6hvawWv37dgX0prh89deKA6hs=;
        b=m1fHexGG2lZZw1yhJqXXsAU2YR2MWlWYlI4hiNWVvWezqFiCs30RpfWuiYs4zrpQUX
         uJjLZ4OCyH9JBWFPiIcfAYhzEC1/CypREVyCCL/2NKF0T9HUcE8e9EpLZirUkl3pTU+p
         5dNi9LyXCBGvVluMSD6MjXQmWNzKNMG4SY2EPmURayQhfJ9MIqH5VU3rWTSZS+nk2Idy
         EDdyYKwMSlTUc41PVoYlzYkSLf8cRBTDhnPMrapejBGnVW2IpjLnZiCrLDvfee8GH3VJ
         +tx+Dpi9cb9YHGSmdlsV1CVC9Tkl1jCtKzEXLvZHI2VUpp6MXVIRTDC0nvvXCtFZj0KI
         vyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782086962; x=1782691762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJWgxbnhAq81DwIaWo6hvawWv37dgX0prh89deKA6hs=;
        b=dyg1kcp9ucRZRKdktuRje++L+8ekNUux/PfHuUy+D23ekAvpUv1XKosOhNjHM5ScnP
         QR98o12y6WRsCl5ipA9TNowhM7udflNxU3KQTYPlG9jr6B5uSiFyjV2wYDDolgTfE0/C
         hyzycNHmJcFujHpjDBOvqVzkk90tjZBv4uUC5q905wzGS4KouavltSsR2Sa7wVqSfREt
         4x1BcAUunWerayp1poyLHUWJfjG0BNK7yBhZgKC12Kip30FZwdThVPZiF2+qUn6439es
         qZRJHbmzZkzqKAGktbikG9YDjzkMJK5oiY2zf3ziqyCvTTb55njU6PS/nRsTYFaUJwfs
         r9gg==
X-Forwarded-Encrypted: i=1; AHgh+RrZt5fk3rz8QdWKRDke9MoRntPpZALR38fMwb31nGHDiPDwDEhE9FKNPPdw4oMWwJw2kR/zm7VhO2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGMX8Ed0ukDvucyfH6GAT/Ubg2wIBHZ4ugBEsTBBfC7m876Ut
	ISL25cXXLbMBUq4CzjWIHk2tV0SEqpJDHSk2T3ZW4AW0vYM8JSzZyGCBn2GNH8XeFUxZFROs52t
	s8YrG1BIFVpcv8mXWV7E84Tr2XiXQkTs=
X-Gm-Gg: AfdE7cnaejfBB8USYZwoEduooGFk8ttXrWBR3FrHP/wK99FlAcmBj/Zr+zajRRQUiu9
	1EKfm8v2KDf8NVWFt9l6m0OHddxMiSgzFCUPvoJ6f4jGLvhQH1+ZADtPvYqV/IimdO/V9Ygdxtf
	yMfISn497By/zdc0SFruhnHXoEzt/vcvH/BZFdSI8Lckde1fwQF29ka2dzoCzYs7hgeT13JbIkH
	kQbO/Fpt/UlvRCyLuMZotcFvc6X1A1MnZH2tDAZz2BEwX9r2F/BXDaBMMgYy6cACR+daw==
X-Received: by 2002:a05:690c:6e89:b0:7e1:fbf:aa7f with SMTP id
 00721157ae682-80135258384mr123232397b3.34.1782086962289; Sun, 21 Jun 2026
 17:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621004626.66629-1-m32285159@gmail.com> <20260621004626.66629-3-m32285159@gmail.com>
 <20260621203303.0f8c5d08@systembl0wer> <CAKqfh0HUih0q9PEh+5pwwMuBBkm6nsaZP9e2yPjHO3+Yccuvgw@mail.gmail.com>
In-Reply-To: <CAKqfh0HUih0q9PEh+5pwwMuBBkm6nsaZP9e2yPjHO3+Yccuvgw@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 21 Jun 2026 19:09:11 -0500
X-Gm-Features: AVVi8CeBoDXrbtClH1kwVIj7-gXFLAcOq-X0zP7Ou8EwKuQ0ysQLks4_-xoHIkc
Message-ID: <CAKqfh0G1dcn4MLQ5jxjM8aDHVu=z-NEAR-y=xMjfOiW7M_HF-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor driver
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 7:05=E2=80=AFPM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> On Sun, Jun 21, 2026 at 1:33=E2=80=AFPM Joshua Crofts <joshua.crofts1@gma=
il.com> wrote:
> >
> > On Sat, 20 Jun 2026 19:46:24 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > > +#include <linux/array_size.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/cleanup.h>
> > > +#include <linux/crc8.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/export.h>
> > > +#include <linux/i2c.h>
> >
> > I am a numpty as I also forgot to mention a missing
> > mod_devicetable.h header.
> >
>
> D'oh, I ought to look at my includes a lot more closely as well.

Forgot to mention, I'll be away for 2 weeks starting tomorrow so it'll
have to wait :(
