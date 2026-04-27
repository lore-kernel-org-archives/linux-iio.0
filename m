Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5612D8DDB
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330081; cv=pass; b=RSl07N5L2uldd3SNh081WGYNX3uvj+lAsLIMi5Q1fjULUHQIuFLE+JtYIv6gXzlboeh9BbtVtryUwCcfD7A926+5sZhUCytDU/qZ6jShYkrh8OdLFtTRr+MZXo38nST3/HmIB8u4078oC2PJXFrE39sJQfWLK94G38Rv6ylb7pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330081; c=relaxed/simple;
	bh=g/DTIxvTg4VOQelNN5fyVayZnjVRxIBT5HWqH6MlSl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZGL0BIWbgERxxQ9q5BJRsTnNflLkvBa0UF9sIOqwxv9DHYNai+2p9gWTfO5AtgnCZhqu1KiIHg/gzY6afZMOTh0iqHNY8PM8HAlmujou63Epf+n2LqXrMeo827aIZD6o/I5eKqn94KfkzIes0izVOx1Xc2UggExvVLRYD0WX5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlRVkMkK; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlRVkMkK"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e7d983f50so119161621fa.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 15:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777330078; cv=none;
        d=google.com; s=arc-20240605;
        b=X+h3ZqHMgg5gkyhN4FXtJQ+O3AW1Sw3m/ONmGfyC6Fp/glaChIxf5tkdWgoQLyFqPo
         zBdjlgcBkoV52gpHUbP84aencPIiRePaPqhSyYfFwaFEdC230wyXz/0kcnHr/2ppj8Gr
         mMv/MD15BYC8eHhFI1UiYGH2Qp3wOfgkcRIwT4xBypOWbOt6CWene8wWh3nsylTJ4Y9J
         8VGrfZjPm4Q2Dh4HOUpD2wezjgGRXeI8aVSN6hAYATsSkhELyFLgkUiXN3Vj/skcWLxF
         ModDnbQ16flgI2huh2g3tNE3fYmoDiFSoyJ+2L0+I2oZJKzHAtFb3e7TEbpG7fxNKh6H
         nBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MT+vOPM5y+vsBTPBmYGzlZIHZ/PNs3is/SMtj1uJPXQ=;
        fh=qLJ+4JFmz1vQrBTovy9PF/p92cThQR3FR9VyeJh2so8=;
        b=j1lV7u3NepHyisoIC7af12nNK3ALCJSAyabaOkMb9z0ml6by9F+LjKaHjKoc7CYqF0
         6zU+fZeLsTTIas0MlTU+Mwr5yGCHfTu9ZYPa0iJTUWEvCu1HbK+JtBXWVEQhqETwqp6G
         FLmvjEqaR2qy9y4ROM65vjI2tAvF3/yZmxuLKUdWvxaLTZDX6bpp42Zm0rGWpTAyHIux
         Ue7KUg1+VTFmVBJF4soMvPfH/NZ2bONzSeEFKwpwNn2jy6frAVA5lsLXqv3cui1UWxdg
         YoI/4HSH3HG37fscLMIbLc0RsYuDVhaIJB3ugoH3RgQPperYt4Bo6OGzso+MX79M4hFO
         4Y0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777330078; x=1777934878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT+vOPM5y+vsBTPBmYGzlZIHZ/PNs3is/SMtj1uJPXQ=;
        b=XlRVkMkKX9lvflIP+Lcug6V8MSpmz+YS/uinPJCOhyRz/Jg3LnYm1pGZYU3b8Ikoe4
         P3xnfYYlaRqpqmMeygkprsa8D9ddLyifX1pWicvxg4czZ4WU9gShhkMHewt9SKgX209T
         LxoAzMJflxN5zXDGXm2xsAJRYl8Yb1sl1PMVPtP2ifkLzJ3sqJ5JJf5DnuKOg6iMS6Ne
         Ctrs40PG8B7SCQf96xvk9mXMu9LR0MWkQJLZ70IWYY+xyYHENmy92i7N2Oo9Sc+7qaIL
         Etb/VdB5D/IZ0CrKvjrIPVefrYzbC45L6IZVWsC9/ZG2Q9/UlssFEZhrcnMSRZ6hmLCw
         6Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777330078; x=1777934878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MT+vOPM5y+vsBTPBmYGzlZIHZ/PNs3is/SMtj1uJPXQ=;
        b=aI33MFIOiieu8YuJY7M+izoEyW807ZGrimnDK4VI41LGbZLvPyEITk8GqvyqOi0p1f
         IvUINZoeUxy8A5C6Ke3q6q2Sn+z/cMDCfqDpjnDCZyaVX/OlKAp6d7UV4s4z0JUKHQ0s
         4gj7p0121ydcNN13+GASyAuF+kjeUOR1AqDCieH/4tzh3svjWUeVaTV0qhFCLeJxlG41
         Sadg9RvcbJgrWZkhDLbQnXoGpxp4pyAp7aJfKjUntsh36gR7o2QC1ITxaAyLnAIYZUmZ
         os+ZZEQkw6gz885kcryuuqF2IOZAz7a4PEGy6aAqvREMY2obomANJz8o+eQvmoi4773g
         +iDg==
X-Forwarded-Encrypted: i=1; AFNElJ/TSsKwtOfEhgBXc+vG9VC1ylq6Hg2tglhJj5a4u+DRy8UZYmq/0wGiqc7hsUelRt3WCc5YllT55SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVL8BReqWFQ44uu8CDlHBaQ5WLr+8fXE02uKa016nT+fgAmeB7
	I+bgRB3b5Jy7LId10Ab1qMjrQyXMwiqikdNYEObMdZWAqvExOQ1CEl8vnEOpkLCeoy9U4ISbmQM
	Ee13+deeM5+bNAzlOCh1zZr/mnQv+goY3C8RC
X-Gm-Gg: AeBDiesrvc2Hi6NxzO6kiAi5R7LhQNG3ezqcNCjf6Zu903bfOA+2afD54uPRQMTuOUf
	1Hck5SVNTK5WK6Bm7cmPWFqXxtc0Cqnhz9+c3KmFhGjL+n9bzFPK+91RBxfbZHL0lgAZslkRxse
	6E8k157JqWw+Z50FY2Q8Hh2L743F7LFBwliVAq5CrF+Pi5rjMKstK2zXjNJuFX2GrgF1devn+Gp
	3/fo3nHxLPUU11l+OEankaFPLthk9hSa9RFI7cop2vYSOd17fUhmfVnq/Iaei06dM7j8xJoUdnz
	KEfDTeQQmBiSfsENKu7OxBqq94NhY2iJQqWvWccRGK6+IQNjBlZuBTNbt56+hibaN9wNZIfJ7pL
	SK3U=
X-Received: by 2002:a05:651c:210e:b0:38e:a8ef:b48 with SMTP id
 38308e7fff4ca-39240f7078dmr980321fa.21.1777330077925; Mon, 27 Apr 2026
 15:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-5-piyushpatle228@gmail.com> <ae9t0WuhKgcPkfIt@ashevche-desk.local>
 <ae9vKxTrqe90OsCN@ashevche-desk.local>
In-Reply-To: <ae9vKxTrqe90OsCN@ashevche-desk.local>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 28 Apr 2026 04:17:20 +0530
X-Gm-Features: AVHnY4J9R0_pCv29MGfhvCpfnsK57dLabbazQ_SlPDKlna2tH2XmzkxQ9x28bGw
Message-ID: <CAMB+xkZ6bw1y2Awhka9Hw8WU94=NW=n8A256aez-14YC-oj_Lw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] iio: adc: hx711: introduce hx711_chip_info
 per-variant structure
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Apr 27, 2026 at 05:08:17PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 27, 2026 at 03:39:35PM +0530, Piyush Patle wrote:
>
> ...
>
> > > +   chip_info =3D device_get_match_data(dev);
> > > +   if (!chip_info)
> > > +           return dev_err_probe(dev, -ENODEV, "missing match data\n"=
);
> >
> > Since we are here, it's not match data, it's driver data. "missing driv=
er data".
>
> And does it need property.h to be included?
>
property.h is already present in the driver

> Also check if dev_printk.h and errno.h are there (it may be that driver a=
lready
> uses device.h and err.h that cover these two).
platform_device.h pulls in device.h which covers dev_err_probe().
err.h covers the errno values. No new includes are needed for this patch.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
