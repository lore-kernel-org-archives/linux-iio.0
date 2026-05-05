Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28830BB91
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973811; cv=pass; b=JBlM1WenhKFHqdLJi83D9YjCuCwuDFbOL6qlSCg8E/LFxnt0E+qJIlBe4JIAQYI2GQ3JjQWxjm8cbgqqcaQRbrfiB+0YjbSz/fkxoKi4XqqC9Iqiw6WdjnoCY6eeVVWwFJpV7iH9nRg0M12IFxVgiGyhuSMqtKDWvcSJW0lL0KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973811; c=relaxed/simple;
	bh=wnp8gE+6ZOu9sg+YVamKOgsRE5iv4d5c0sNUD/nfkWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9vZvss4h6k7IDidplVrinaf/tfprtg55dbgq4h+V0sT0WaaJz8LXX2W2sFpPybPx9uIX0DZmOU2+V/7xhnMbqur7qlsz8PV5ZMYR7c+W3MbaBOrBBtkYprPWBIsiufuxpY+zxidRZpEfgA+4ffO1xPdv98XSPBv1y6TvxunMms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEuRPxvX; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEuRPxvX"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e7d984096so56652861fa.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 02:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777973808; cv=none;
        d=google.com; s=arc-20240605;
        b=Qdl0QeREU/vZQxst6phcHHqnljYRQglMtnztRH/pXSyhs74vp7b4aCJb/sgOlgp0eA
         8pLNFaNbG5tYvz530YvM1UaSn4Mmny0r+TpQVcswxKfJIDIpKTho+TsDhVrppECvcd/H
         /sML0BWEAdck7S/BIPyJLWFBJdzhk+Q1JPPC533sj8ilpvBpOLiMrCcv1X+FFy5zmj9J
         oxrkHm2mEWKrPTrVT0HOJ+HLcHTtk/JcY89qZ6HVjs0oqG1bYGDG15Oe+vEHCbCAVgNv
         hC+U7Er3hD5LaY2hTEvMvsmvCQyYH/ANKsFKjVfFr6AkHuaF1xe19LMf/eUmAcBGWKMe
         sa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wnp8gE+6ZOu9sg+YVamKOgsRE5iv4d5c0sNUD/nfkWc=;
        fh=3nPzJ9+h/aTU26wDtzreteIiPBfKi6Cn0U3FP8rYfTs=;
        b=M4UTZ/Mejsf4kU1ojm8f0EPPFiWSC6w/T6U1QzdFBT9LsDFwYT/LtLl9ejvklrFhqT
         FtRx/s1vEWrLmghmDa38y+ci+VdXE/G2Nn/KoyynXokFJNRG3NWxt+qsx/wwYjlzeyfW
         O/9cM0rtfH99qqoWgVpD66eNHKy/wULZRRXFNp5CY/sv24Umw/R+0HzE9hioAi4n5HT/
         XplLH4hqr9VzKk4pYTxCWOHYoU3Hpjt0rYF4ic2+Yx4tA7HM6dOmuQnVbs4PVhWqdvw4
         XFTNtGsCTtR3ArsqXXs2mnYNW/MgcrVfkYu1QlbOz5nTOxSjHD82837fN+zacAfMrwe+
         PFBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777973808; x=1778578608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnp8gE+6ZOu9sg+YVamKOgsRE5iv4d5c0sNUD/nfkWc=;
        b=PEuRPxvXVHLxjQpEnh4CeeJJe9cmyizbCljtRmn3EbVtRHSnPsYurfqAicgsGP11mi
         Ru3yuuILUfzQAxAvoHeFoXpbbBkXy+9kCRzp0OGHjrwZ+DoY9kT3qw9sT9UVLgmIl9lC
         F5DNHhILuzLYgNYsC6gCK3A2Vs+sEQMhBAO2l6LAnWXRuiHQupVI1+nVkiqsdSiLpZRr
         7/gBBpiWEsR/5bf4HpDad1Z8nWYaQw5uPYfZHpDYiiJRhk8QJ/HuF3+OCW+HbGH8hktV
         EOTOSY4D/jZh7Od9CT9n+cGiFo+nKcviwaOjd12huhav1a7dmJCZDvYWuyrqKhCZgo/d
         TIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973808; x=1778578608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnp8gE+6ZOu9sg+YVamKOgsRE5iv4d5c0sNUD/nfkWc=;
        b=V8JapMjPwQLJXyPhrW2irARrQm6hD4Gt7lVwchNXnmmkscD0yWWSxy0ACn1+vaBii5
         4qtXnghJf5d5QCzgeSOyw2FloMqOgvH8kHeXGnTJDqAaQJPiN0DQTmXBBLi7V+ehpG0n
         cQvR11/t6sYZRedCaIYUZAZsL//l5saNM3tLDAOcMSy1GcPo4BvUcq0Co54zYUGXHbVz
         X8qQPz2Uv6ti3eKl54wtTZVzoHXumLEo4oUaHavM5P4TpgWPmmEfXq9YZ1Vf//gbAj4v
         taKiEJXwjWJZiq+UzOGJH6maKuEyBaAKYNOO/NQRNPMFZ99J+SKDazhmfsdwKM1Z9bVc
         mPQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Gfe8jc6cE5yD95pwA7sdpyH12yiZuY1Nzy2lCuNe7wMLqz6LTeLcNBtTleYyS9jVKAw9lSbRe+4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLuXPpJpEQu3uCgeG/LwLZ3+rc2YogCCJSFODNste8+tAoGqU
	mrtZ7JY17S9Ta3uZwMdRLEaFl28JHn7PF0RS72Xih22Gsx/q48f1U5QzK66qILike3+5PfIWVYi
	JEHvAStoAF3igDArl8b9y7c4v177R9uQ=
X-Gm-Gg: AeBDiesgnKPnE8m10VUed5UENy3yqmheE/s+H6rXBO0aTe+r6e8FsK0RsfyPyaz7dMr
	jy+jLAejKrDIgcO795jvjH5xC35yNDJ+DRmIedJLybolAhZtFfDHtZd98PfT3Z+51iJPVpzKjo1
	mqdYE5IsOpQQB6072nb+AQMeGkxHWbozQYowH+aHSLdL3yGTjkdn1WZPbPRszmR4nn7V/NC8NVy
	mvzD4LR20AOWoKQ8JuUzHsWLiI9Wb0s8AA/rtaZrtNk1Wj73bbuNUWX6R+GVNK0KSXOcJgPu2Kh
	O6l+PglV09X4RE/6xIIxTJx3i7tRyeoBlfmEAoKVMSFA1cIha1AYoDxNxMbF/B/C7ZGAmqU51S2
	MbRnQ9+jXXVgwRKZ0cD07f/s2updv
X-Received: by 2002:a05:651c:4196:b0:38f:20cc:2bb9 with SMTP id
 38308e7fff4ca-393783bc7dcmr44604211fa.5.1777973807410; Tue, 05 May 2026
 02:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505090247.74555-1-salah.triki@gmail.com> <afmzOM3s_TCYxXyt@ashevche-desk.local>
 <afm4U2nsfdyihSEG@pc>
In-Reply-To: <afm4U2nsfdyihSEG@pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 May 2026 12:36:08 +0300
X-Gm-Features: AVHnY4KVfmP4ns7ReHTrnpwgEb5W_Vjcwkka8IRBLAhWu2q-3VarKmK0Wdn87ZA
Message-ID: <CAHp75VcGr9w3z7rP_nkf0BpfKBK5CZUsyNEwFuDAQcJWw0gtTg@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: ens210: Fix missing I2C functionality checks
To: Salah Triki <salah.triki@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 12:28=E2=80=AFPM Salah Triki <salah.triki@gmail.com>=
 wrote:
> On Tue, May 05, 2026 at 12:07:04PM +0300, Andy Shevchenko wrote:
> > On Tue, May 05, 2026 at 10:02:47AM +0100, Salah Triki wrote:
> > > The ENS210 driver uses both `i2c_smbus_read_byte_data()` and
> > > `i2c_smbus_read_word_data()` during the read and probe phases.
> > > However, `i2c_check_functionality()` was only checking for block read=
s
> > > and simple byte writes, which could lead to hardware interface
> > > incompatibilities or errors on certain adapters that do not natively
> > > support SMBus word or byte data transactions.
> > >
> > > Add `I2C_FUNC_SMBUS_READ_BYTE_DATA` and `I2C_FUNC_SMBUS_READ_WORD_DAT=
A`
> > > to the functionality check mask to ensure the adapter supports the
> > > required operations before communication begins.
> >
> > Can we rather modify the driver to use SW emulation for these cases?
>
> I'll update the probe function to check for I2C_FUNC_SMBUS_EMUL instead o=
f
> the individual functions.

Hmm... But will it work with the drivers that do not provide EMUL, but
the native functions?
Please, carefully check all this and come up with a solution that
works for most of the cases if not all.

--=20
With Best Regards,
Andy Shevchenko
