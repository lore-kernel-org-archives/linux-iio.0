Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F33390C95
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739801; cv=pass; b=f8vIUWES+vaZxa7fB4NQ97oV/Z+RbBwN6MnpIrk0RvnkYiV/8aovW/d8DigS01+Cd0xRoz5ze6AnQLlr3+9TWK08Y6rT74ymMZ7puEmPGUiGuCmWx6m03cwCZubJOCfRrcCqRBMbZ4BrmSgeAfTbZJTczI4saeg5BMVzWKQom3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739801; c=relaxed/simple;
	bh=2RedkTW30Wz4PVzid6XSIxwtrRyZ78EWTGCjN5m+6S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTTr2CgX1xjQDPe9hbOO82LT7Ex8xSU5YBi5dCUAfrhfcVxkmzFWInVtWz5gfxvZ7vRqgZD52oKH6wiCBbB2oGB/rH57WvAgGK1XmeDkDDHBuG3B30gxqKPj5a5JqLC4+QeYtl3G4w5Fb04xI9qCQWNpZ1MInP9FClRSMFmKru4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPOD+X7B; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPOD+X7B"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651bc83e74aso10150315d50.2
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 13:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779739799; cv=none;
        d=google.com; s=arc-20240605;
        b=VNV6lPdWLdf+eN/7rHx/Ke+/l+wPcxxq8Yb2WUIjhaKhIDkmXsAXeSGhMn8FKiRqHs
         K/MqjVjUtjtmF/MNAloWdoPYxkQvozfhAozVT45td1mk2gBjNi5u7vtAC9pip5/xUami
         /AUFo4lwVGAVeOFZklEDAeQBwbDqX0HhRzBZ8nvsv8iRggPoS/kMkeShXjTPeU1l8QYi
         h7ZgzjYEp+QIccktjVRCuhoMPzpepKi2QdetPXe4zKVIWQRf2pnZzIS3QSJ4gbt65xqA
         T6cp/TSyleXK4x/qM5Yu07COr2R0AOwVnbvziDjCY6zMQ/1umSvGJ6SYVd6q1kbZOx7O
         x82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V8S7A2LzGi9IwYzOZDU54V50Uf52f5bs0m7EFal7bdA=;
        fh=KExOhwb4H5oHtbcLdMvlOZZydWan2EqASmvoDJyqdns=;
        b=aPiPIb4HiTxG2EIgLKsUWRxX0TiHvZG+rO0Q3XmgonNBH/oLNrtK/W5dHjMrP8fLzU
         tHnXlRwa/p4YEOtSBQz6Ut6GP6wlajmzYqLYkMQzoppj+FC+ty+kHic+iJdZA9SNHA0E
         hOxDBWHyVYx/+ya3xe/x4zYL9+oc50oxG+wmL9hXYia7ofDK7VmwZqNnxC9SuMxO4Wn0
         ZBCXh5rXOc9ojiiBUTj4rNEBywvvHkVwKssExYdnTDvYPyk9xl8gISSxrv3Wq98XI44N
         ucBbo/QvAaQzj1RXjbyesu6Lkny7byof2sUTyWZTX8YiYbdPWBw9Ubkt4EqvkxaXntzh
         UuiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779739799; x=1780344599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8S7A2LzGi9IwYzOZDU54V50Uf52f5bs0m7EFal7bdA=;
        b=NPOD+X7ByW2QPL5VXMAg1N/DFmDZo5NaCsZZR3gW6GlcPCGQgF7WuqdYkRg4Pfp8bc
         En4rnjrRg0pg/FepfPVFoC60RjznzuCGZ+WMkad3vew4e69bPcd3ALie9rtRYfWXFNmk
         3FO/CTj1S2dEf9SE/bJdH8LrhQnygTC8UDZca6wa0LqN7MZs57R7ppx5tNF902uK4zdY
         q7DfGsZ9853VMrKleHxuGr+upTJ5hn7pe+UbPcvINHWr3m1q946jpd2UwfQU3fbifQ9g
         hsPGEXQaX3yFPDwQURzSinyor9imvDbUzrStYVRnurdYIt1VNv+BbRlI/LfODNQEwcGd
         T4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779739799; x=1780344599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8S7A2LzGi9IwYzOZDU54V50Uf52f5bs0m7EFal7bdA=;
        b=ASS1km/TLShHtFXhh0wZWMnwjfeUagS/HEDD6inbCmb7FxdCE8Q7aw1ASNVQTGFoWS
         mb02wUaRcAkm+yI+9fFVWEUKvkVbskT1v8zH3l4MskXg3dn0RUWim6/IUr5yTaZLF40v
         ITZ/NC1c9IoujZQjGJY5LZBheTkXcI/aNoNt013FNHwnzbajqIsTURi3WYjXhlLcdA6u
         CPYP8aiB/ZxrGskZoahzR9BJxd7+xJkdfDflWnCOP2piUIL+YQAvfia1IpjtxGrgOQkN
         wRT3zZis66EuIyRM0svQ9B128CVXA11C4E/fP/G2tIiaFyr6WepxUOE9KfxttTn40IAI
         sDCg==
X-Forwarded-Encrypted: i=1; AFNElJ8X8aSbkfahgc83cFeNfM+vYilEbcH88VGsWID9rAQmZq+gh4HJhPKu9hhyzh6DfIMmgfcUa5L4VII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3J0GmDuvUjgwdiHTaDw0rxw5Vx0TLr8Y04PDiZs+r/C4ACYY2
	qHxTHy5dPfHbu7z8baA9hvhxk/D3BVzeYswWmrQKmDQti+regHIN32okWimbqdwIJQECJuaTGnz
	7SjXTGDMKVPkKLvZj3b8F9KXPX5N2nA5MmEK3dJw=
X-Gm-Gg: Acq92OFL3w8WKy9mtIMalUOIuEnlPoB9dHtwdATxnq2HZe9wT1r6luOleDPoxuzWcwW
	mjrmagigLhmsUlWej4b7X7FM02y/b+w9T37RLIu+MOjuwZHZvxE+YI7/7n9SlRVjP1EYioNAALt
	A6K2Uw4bhuchdIQ7oxey4Gi3Li0Ul1v8yAk9rVh3u1ec3y7uMSjt40SxkB2m3/AMHC0m4o0pG4T
	i8J336HWxTH8awO1gEUFumYOnfQSZpcnf4b2i4DF7i6OpUl/WtclQoSzMmxya/eCs3uqkzLRbpE
	N5LpbFvrH/YUIYAUHZACM1GFPs/Odg==
X-Received: by 2002:a53:d048:0:10b0:650:11b3:3f4e with SMTP id
 956f58d0204a3-65ec98ddfe9mr12854113d50.32.1779739799343; Mon, 25 May 2026
 13:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahP3S9nOYN3pG-Fp@stanley.mountain> <CAKqfh0H0Z0xr4bAjctr9h95QTuEUTF1eCgBsRZVHn_KrkZZX3g@mail.gmail.com>
 <ahR1CUxzMkYDwVvO@stanley.mountain>
In-Reply-To: <ahR1CUxzMkYDwVvO@stanley.mountain>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 25 May 2026 15:08:14 -0500
X-Gm-Features: AVHnY4JKEwasvFbRd2zbbO8Xkk3eA46FEYb-vrw3-jof4gBxKDr_lN_jC5JDwo8
Message-ID: <CAKqfh0EEHCGct8F0VP1G+wv_NYUhqT3Bdfjos3NVGGbeAs09qw@mail.gmail.com>
Subject: Re: [PATCH] iio: core: fix uninitialized data in debugfs
To: Dan Carpenter <error27@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 11:13=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Mon, May 25, 2026 at 08:17:28AM -0500, Maxwell Doose wrote:
> > Hi Dan,
> >
> > On Mon, May 25, 2026 at 2:19=E2=80=AFAM Dan Carpenter <error27@gmail.co=
m> wrote:
> > >
> > > If *ppos is non-zero then simple_write_to_buffer() will not initializ=
e
> > > the start of buf[].  Non zero values for *ppos aren't going to work
> > > anyway.  Test for them at the start of the function and return -EINVA=
L.
> > >
> > > Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer()=
")
> > > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > > ---
> > > The original copy_from_user() code was better:
> > > https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buffe=
r-is-complicated/
> > > ---
> > >  drivers/iio/industrialio-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Codewise looks good but often times people will prefer
> >
> > if (*ppos || count >=3D sizeof(buf))
> >
> > over
> >
> > if (*ppos !=3D 0 || count >=3D sizeof(buf))
>
> In this context, I feel like either is acceptable since zero
> represents the number zero.  I have a blog about that which I have
> been trying to promote.  #SEO
>
> https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/
>

Interesting article, and I do agree that either is appropriate, just
wanted to give you a heads up in case Jonathan or Andy ask you to
change it.

best regards,
max


>
> >
> > Regardless,
> >
> > Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> >
>
> Thanks.  And you're other comments with regards to -EINVAL and
> -ENOSPC are obviously correct.
>
> regards,
> dan carpenter
>
