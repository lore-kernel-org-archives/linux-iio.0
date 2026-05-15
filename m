Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8F37C0E9
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872960; cv=pass; b=rA+rJu9BlE26GwqD4prqF3XHobnyvH0N9IGaqbtBHiDgoXYZwfzSTFCBi3OuOwRYKgGoOgx2SkqrzZ1t6gnX8kvzu/EgUjCQVtCCwc6hCawx34kjeN2Qtze7VHdBc7kQ8SRVL+4Z66wDjdI0bYA4iNwG3wqw+0Eh0OePimEADk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872960; c=relaxed/simple;
	bh=CmEabtso8fytfCC/XdPirdcB0ToUBjauUPZD/bbMsm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2yAphNFY6idCkS3zqoRsBdfOoYLaLw/EwDssvqdn98OI4AF2n7AWvT5Fjx6b37HZivkaM6aZXOi8nKc81OcsqzIQmaRK8g++in1VADHARq2+8iQlO/1/dWvna1L4XnUGK/h3YPgtQN+1givpi4j29d4/v7AqDPRaOfDOVz3Ahw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qULyBhdm; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qULyBhdm"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c364b893aso429834d50.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 12:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778872958; cv=none;
        d=google.com; s=arc-20240605;
        b=VgJOI7SQn7vDBIbzx/ssLjZt2thnyDvz9ID6kYFGy/jTgvX4sfwDgzh1gkf4ILE7PU
         P1tfb+qvI1mY1tMc+F3SV8KjfQk2BdMJlQjf6g4Mscy0iODVB6AVdi9jvXSLMmoOnRXs
         XByf66XWeX9H2EfFbjRRb1bWp5BKqTHIa/XJovwOaL9yxCwWW5c3M9oJZlURXU8vQLJY
         WcdlcfN2gV02JjYHTT3E+Gb5nEKjY9JlGgO7fHUhldl/9vcWEPze0Gi4NdCzDEF2RSGC
         Yfm0SOytV4pU8g2ixqfwlghHlg4IL4JDYR7EUF9qnnSz5hoL2o2jnmy6Z6nJGGsdUo/l
         FBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BdLEiNbmOgInlweBjXEfSGJrQ7wVbhJbBzYaPn06QlE=;
        fh=uuvQEYNr9r81zbPO+ZkCZqnP3mZ1LMNSVVvvo8utkw8=;
        b=l2tCkST5TNFo9XY57bv3l8Z426nnfXP2VU/BIj+cMvPkbAunAuQj+eu6Rmlk8yM3Wx
         EA3UMOFHpbsu6VvuPSu08p3v6gefmi2Y+914s6R6Nvj7lC7D42NdWHVVd1daMwVXRCGR
         9Xi/9FBzM1eYpwlwRgLWXLLk1ckp2m+EqOOal2r7QUiFjS54Tct/uRxqFsIai+pyYF8z
         Iy5ObmW0sk1uFcomtjb5S9Ta0n008o4gPK/RWP7K/kubRclcY9cME/Xe8iHdLuHzYAuQ
         QRsBQRUP6NuFhdUKRueabniSoqclv1dgh5vkhKtjCz5nx86DcnClZhV2MDX4qfHNmk/r
         VniQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778872958; x=1779477758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdLEiNbmOgInlweBjXEfSGJrQ7wVbhJbBzYaPn06QlE=;
        b=qULyBhdm68v6IlQ//wliyHrgfazHg26HFbhqq8PqSp4VK8/KN0OxkWuIu728rEXV54
         0GWXo91/IGcv+wm/LeIzss5R3k1/Mb/uahTJzWPApQGAAWPJ+SSlLxx/x+KW5VzraJM8
         lCqelBNmGLwpa+BBfNhl6wNe+5bd6hXMxiGD7QeG/q7+gSpibNz3nUQW7vhrvahwYbLn
         LH5yu0I6reySCB3i+vzmmiySIalRVKx2mI9468FXQENL0zPBWcvjPKxgXEHojsEsVAJw
         X0GrWwG+42K9NuDuqyomA1cy8z+90QHWzh32f/oYAMHLyhQwWLZWFmaaR8HBoCEUYeBc
         YxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872958; x=1779477758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdLEiNbmOgInlweBjXEfSGJrQ7wVbhJbBzYaPn06QlE=;
        b=DTc1FyouxsvyL0Y1kzp9SBQ3ROOV7vmmY4TgtuGbUodVHEd5M+N55ue88AQmf02uqI
         BK5hcNID+vfNLIiptrzXyug6WsUcNM1w1qUL9EaC/aWBceriD5ojauThuhAuuKE5I+Xx
         EucJFU8J3T3gc1qN0Ml/se4WtldubefcSNJnk12aPJ88QyUIY2s6BmTLXWLzV+ZHXKyj
         /0SGM4nfD9SSZ71yZo/uz6I7lRGNSlMzfynki+0m1exUoDZsm5Aprg0BnHVQ4591wGd0
         NbwK0nCd+Z2j6zf3ZfhZbPNJJhzjl+Nipk7WQEFbIRcxt//4Ra3I+MgMIGybeZdEDlTz
         a82w==
X-Forwarded-Encrypted: i=1; AFNElJ/FDOdSM8gqdSVyWZ/HYMecXUdlNgHcM8nVcl3+ijyNmJQEZROgvYdZrxoEbpzdDpJdhAe5jt2ln6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQuvyyxeE3tEU04qKbWmDuPDpl8Xa7Awyrnr4/44hbZw5JTUW
	4AxXVwTe/AAea9yHSeiwOkj11pc6FIRxBiQS41yYJpXXr9IFKHB/mcT9Wpg29M0Ag9aSyO1DwEf
	ZRGPYJYrYiTNrbNYb3XPXPGGJvPKM2Vg=
X-Gm-Gg: Acq92OE46vhLIxVqHNUhlB+Akm+C9nCz/caAPz86d+v3jtxUEmTqdtOwbhyJykAexne
	DqSKGtvD26mZVuBtb/BatLqi8h028J4XZjbydx9KKd94YhtB8LEWxYI4scM95Rs27pJQZurAKk/
	xtpWgJt1fJnvUBCniVvl5Rb/t1ssxHiFG/wpMMQ12rcSucxlZebJnUlrY0Kh1xafnm0v2JXn6Bd
	txtLgR/WrxuuvbvMcbzVagbtxjF1+va+iitWIMeQJuNy26I84cKgnvZXhIa7fxCluxaEPzvUsIP
	9WtOEoY=
X-Received: by 2002:a05:690c:e4d7:b0:7bd:5cc4:3e5c with SMTP id
 00721157ae682-7c9593b7a63mr54259307b3.3.1778872958310; Fri, 15 May 2026
 12:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
 <agb5hiF6GhNwGa6c@ashevche-desk.local> <20260515152005.355fffaf@jic23-huawei>
 <CAEk1YH7jYFHPJFEZrsW9Nuzy0RAiYa_HdQfx3nbv=Wnp=2-qxw@mail.gmail.com>
 <20260515155508.4c606a23@jic23-huawei> <CAEk1YH4-AAVJtO+22x4vC-f-8UVYQKaAvEJxskrUQ7gKMBNsPQ@mail.gmail.com>
In-Reply-To: <CAEk1YH4-AAVJtO+22x4vC-f-8UVYQKaAvEJxskrUQ7gKMBNsPQ@mail.gmail.com>
From: Damjan Georgievski <gdamjan@gmail.com>
Date: Fri, 15 May 2026 21:22:26 +0200
X-Gm-Features: AVHnY4IIh-6c9oX86gOgWVJ6MV0uZtNUiCZORL6MtX9-WYYwPIpDKdf1kZxHg7g
Message-ID: <CAEk1YH6pM_rWDb4N5wGeE8su-C2dibPa8kQD1OPRZYxvrpqAiA@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: only set IRQF_ONESHOT when thread handler is provided
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > Not sure which exactly driver ended up triggering the warning, is it
> > > possible it is " hid_sensor_prox"?
> >
> > I believe hid should already be fixed.
> >
> > c47ac75f5f24020cc0c8b835457a7637ad450939 iio: hid-sensors: Use software trigger
> >
> > Maybe something is missing however. Can you check if you have that commit?
> > I think due to it coming in late last cycle and me travelling it went in
> > during the last merge window.
>
> I'll test again on top of v7.1-rc3 (which I self-compile for other
> reasons) and on 7.0.7.arch1-1
> I did keep this patch since some of the 7.0-rc1 when it first broke.

Thanks Jonathan,
I can confirm that the issue is indeed fixed in both 7.0.7.arch1-1 and v7.1-rc3

I was sitting on this patch too long, didn't occur to me to retest without it.
(also wrongly used git log to see if there are any changes to the wrong  file)

Thanks again and sorry about the noise.


-- 
damjan
