Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00241363D
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102083; cv=pass; b=Q2SjBpGRJ43C9w/0F//jrEJz6QQoMj1XhnGh+9qO9jIiOZJZEIevJFA4MkN0UCynaPa/eGUHykjAMLrO/aEox4+ytFNEPj1EON5SHfRC0cVjtC/aUnLKv9ZJLAcJxnuDCXkZh/6azbkmz/VCcyv/zm+QBpmDd4a80TjtMOSKGfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102083; c=relaxed/simple;
	bh=eHGHo1CpzP+Lhry2jDKXXEgAfPF4V1nf1rNJycM0IZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkxN5NS8avpbr4OB7k/SYA8GHyQ4NNwW26IUvLv4qd9GRyvzpd3896RDLGSr+KT0XfoQAW3JzgTf/PQ6ErKm59wpR8Pruld0Jj+IP3IkYMw/sS8fV+m8aeF315a128eLM7VMOsk+kMpHle+pvtFMvO5K+Bsg8MKeTg+ZAdLwRB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEDQcYYX; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEDQcYYX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30749947917so2890458eec.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 07:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102077; cv=none;
        d=google.com; s=arc-20240605;
        b=CzqryeNRAyDDRTTAuB+0pCDg8gTCmF6L7l8G0Ng/A1MPjfI/iJe2LvYKA8kT9y3ec3
         EYbYJy5kK3z4Ec6YKIcgPS4js5MDLPskJIhvcAYOx3e9y6Bw7LTOkyP+iGC91uVen8Nd
         meb+WdilIZS043MmBs4bA85lZuzYiky6ZizAQ+7oo+WIiuJUsZetqcA1hIvgjMSiJUA/
         L47Nj2OwHm+uosiB0mNLysUyMY3o7VnrL2FvmT6wm5Ng2MRBn5g5mPCG9w/4z2mBNFP8
         gRhTZ5Qg/scDb4ZTKQEuLFaR7kD79CG+fb4TMMIRq//hPVd/uGMy9OTtEo7XV3YC4lQ0
         qzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
        fh=62OZMEnihY/HkOCxVjyF/hrUSwzUp4LxoO6EtTVj/OA=;
        b=Ts13cHWz+ibgdsubehqCmH0ckCRSi997Ck6ZUxo281v9lS7j4wvGQn/tzEmNJk2pEf
         nqu5l+TACbiRxTL8bzLQ8PFcwSRh3diInUOsEVUwpc0gitvmJ6LZPUezCy91Ux9SzVy1
         sNW6A6Rq4bOJlw9sgGqFVrX03D5KqRU4znTSa48kSjp5k+ntJ0x3ZnK59YC/loiEdOnL
         IU8bAfzcAPtKiTYjHMUYA9heHVXiPLQ7zVUWok/rX0/dkVRftaWYOZegcP99RtsQh7PH
         GyCAzie2npR1LczTtd1U47pDqdz51JARqV1o0UWRRtwZLYfzWo2qcW+wPbp6BOyI+UKH
         GYCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102077; x=1781706877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
        b=GEDQcYYXmyqDTIeTwRUeJGjkgrgVo4QvCPnJpFto2PCMedbmf6U86eQL8mQzXpK7KB
         VIcIsjPFjnPZtqjm+frmahsCAFcV/Tpc/oitHdYuiF0Ffi+0cRZmuqrXDUcf+G6s9TGC
         /bzSIVTtAwpbDrFirH3japNOGBYg3M1htuK759cGRP60+yjTFW5fLes48bA0LLAa+XcY
         4kzfilYX1T+jE4SR2K1U8f2SUC6TvKPwYZBok08tpVVWloEVr2vFsnhxHQ40EbNbde1m
         atKqXT/ycgTAmLOV5EyI56oWW2pd/Ulhw2vv2HgWj1rkJdpLctB+8zAWCHnjTUXQUrzg
         0Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102077; x=1781706877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
        b=LL2t7GprFJGnZqeO3Cv/TvHclAsiBXsz4N61YyADDA2ysXorEjOtoN9P3VNhQfWCTW
         qLo27EdgF7UIDtcV3o9O+PHiLE4KdEKyQaFNfi/2vVp9D/NsCKELhUK6LOyOs1zKcpbK
         fiGNBBnK6Nw/zDe6this7AgHoJv7KxcT0YYGKEQOQMGab9FAZorLVnMPjDWehiVUONN5
         Pn9lXwn6z23PVBrA4Pm1Wz+AeOKw/BjvAqyy2+ZuT9wFSV8a92Rii6yNyLjquhaQDPIT
         cFEHNX+lFH0i/KxRFMCr81qXCLN4GCKjkib4Jph+jJAJTh9HjHGleQ0bLZjjQJuxvCEe
         qouw==
X-Forwarded-Encrypted: i=1; AFNElJ/DQXFL7lv7b8Q5ItGyMAemcMYLd30M8XId1YAaPde5h1XumcB9OJ/UccpYbvYhBsKd2pa65QX4Qp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXqOI4cF+KON9nzuXwwf6NQi6M9zT5xH3KTLQ5fpLT4eeEfY1
	obCdExwtjYtOBQrQy/27E9nX5w9NG6XoOR5XJW2BVjexcFyohXf2nDGdQD6M+pufisf/8M91+C5
	9EPACZiNZ8XgRGvnOLYlN4cKilbQkj88=
X-Gm-Gg: Acq92OHZmUJGxAI1C/soCj4n0TeYybSbEEYaCgS9jw0mOLxGgtM+GZ1vCrdr393nRzp
	YjhrfXH/Or086Zy6muYAeUEun6PEEmZjDygBbMrsu4ZOgoODWVvqN9mqyYvs1OmeX6AHTUIkdYs
	0c2Pjk10ATcHFqL8l/DzU+S4r4YbMOXkF6yybwldGBOmXGBJdonYTRlXwbDNR1ASmVSN9Ipe3O6
	LqPXmJUjcgIgkPwepJvb+tWfdEHXgZtZNzr62p91qSBxPz0RMnre08Vz/3XGP0PpswKFtrqNFdx
	CxqeC41X+nJJu0wydZ0=
X-Received: by 2002:a05:7300:4311:b0:304:d32e:65f5 with SMTP id
 5a478bee46e88-3077b7d84c8mr15465647eec.26.1781102076873; Wed, 10 Jun 2026
 07:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-5-clamor95@gmail.com>
 <aihkNekrgfu6-6Q_@ashevche-desk.local>
In-Reply-To: <aihkNekrgfu6-6Q_@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:34:25 +0300
X-Gm-Features: AVVi8CdXjWV2Xn6oo1ydHrhUl2T2tO1QvChE8BglKpS9ooBB10CdbUEM-do5fqk
Message-ID: <CAPVz0n2WG=35W7Z8USDck+xQ4sQSxkfhJR9oeYGe_vBkkXGKFg@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:06=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:28AM +0300, Svyatoslav Ryhel wrote:
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
>
> ...
>
> >  struct lm3533_als {
> > -     struct lm3533 *lm3533;
> > +     struct regmap *regmap;
> >       struct platform_device *pdev;
>
> And this pdev is probably not needed. But I haven't checked the whole lot=
 of
> the patches yet.
>

It is needed since it holds childs pdev (dev would be better, but not
in this patchset), you cannot get childs dev from regmap since regmap
holds cores dev.

> >       unsigned long flags;
>
> ...
>
> >  struct lm3533_ctrlbank {
> > -     struct lm3533 *lm3533;
> > +     struct regmap *regmap;
> >       struct device *dev;
>
> Ditto.
>

Same here, dev holds either LEDs dev or backlight dev.

> >       int id;
> >  };
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
