Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3839B949
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266436; cv=pass; b=o4FeBTLxcYln51rjhl68HKxnLh2Zuq0eo8UStDhnW87qJWIZrssoDnosTxnkzUvuK9SGUqZF9VATnpaFff/bobQcbIVLvBxxVFFBfdkrZpEXgl334AHT4zGf8eMglTY3I72L3baBjyJbTiJv+F+a27jXJhW96/r0oU1Jy0USJEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266436; c=relaxed/simple;
	bh=4nry2qzy5pcCzAM5woH+HOmFMTfIBTI3KVX7x2x4kfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNQkf/X3xVYmZCukaWew2Eb8YZa1LGZil/iqaNdO40gpIjCiKCIedbMviC8ppn7aZ+iRnOBzY3A+/4fCsN8QnE0ICU/mNnayAz9RG+tJ2TBPjaKqKAwC2mecX9l6k+O2kvS27+7YTpgApJOBuWk4PVRCyG8HdGl//4h4gIp4jN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkBD3ak5; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkBD3ak5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6689033d0c3so4129687a12.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 04:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774266434; cv=none;
        d=google.com; s=arc-20240605;
        b=NO+3PIQzRd23EkXp0xxnM/5Pj5vVBNjVDpH6vnSXhy5EdzM7ebA0u2n0rPLnDrzhOo
         Z4QqtAMsZwFJ1lBaGLOhbTDsBykGT/rSfe5ssoZc/Figjn/KlvK+RnDn2v9/h30D3FwU
         A4GFzNsudkse1Z2MGZFcUsI1UD6BfVwn/RW2t9Aw3fwtBGloj8laH6XENr+FcC+ZwFqo
         rlCJ8gl9L7cGYHcxts3tycHPkfar9tXI1BchRVmN++Xk8R3yxPi+Ghm6rf9eS0Yi5sob
         71Tn52kWy6F4yMO/wsYpxYYKyQ9wz9FK0/OYgQJKIDzWr31z/VOOQGC+XQzG94zLYiai
         bYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QUJUjulURT0vpMbu4RaHS8o5NCexbA+knxvjmiKjiF4=;
        fh=cltfnVJDkRVJn5KpXw8VAUkyFz8HN856/CTgMyRPMVQ=;
        b=XdcxETqK+oZ9DSrVi17VZiFDzt19mK8bvokN+qYRIeW3ch82IzHavTF/U23DdKWDyu
         md3FR02qmp0qINRB2yJ75eevyQf80AQsNxdbIfQsMFBsrxfDkzlaaDm1jE0YZfq0dyxF
         26yk8dAu0IulM8+IghSexxPdtM4yhbd50rZ4br3svE2SY6QBCJWKxfBLqF4yjhbX71cn
         Bj8u9dBF4NTkB7+/EL65WdQJtw/YG/AIrnVfvvifxY5swItssttwrpd0aP3+/W0oi7T2
         nD2hkN8oerNj3qZUd2Y4nRC/k9YOiHBGCtdBvox139U/rbe2qL9rR/IX5mtehKX45ovY
         mWZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266434; x=1774871234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUJUjulURT0vpMbu4RaHS8o5NCexbA+knxvjmiKjiF4=;
        b=bkBD3ak5oAisJnsH4PpYJ8wjAViMT79GTt+9X8OvP8z+n9lgcVTMqEXpBZr32kxBRw
         NieMkROZNyZ5yzDIqEnKzVmXXUygFteakZMlsRTePnGnE0jjoHkPt1C2zRXBS9phJAoD
         B81qFffIggUjXlVPYm7ieba61/MfmV26R+2HxTkOxEMnDA0J+MHg0GoSKpJOKT2vwl16
         6OPxbpUqRoPE3Fo0kSyuMV+RaXNTVGvUxTbYquX2tEkpF9Q/JEukvMMOyxOBxPIPqyPm
         7tDzlqCoO1emYyYu5WgLz1SRDxG3j+1EX8txRF+EF3lQBDaKe4mk9yYOB+BIanWwenpm
         xVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266434; x=1774871234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUJUjulURT0vpMbu4RaHS8o5NCexbA+knxvjmiKjiF4=;
        b=jr6wrJwiPkhpReDjwgGQeroqeE2XB46+fpR6JoCeiPsVhSgW4W71GcrFcI7/O7OMX4
         lsmfn1eyHso3MBaPU98ackRLFXTs5A1TxDaGdNc8p51nmmzipcSd1+mb4Tbc3bxJHoKD
         hsVQFnPeYUudF2rSsN/fDX8J0Cau3zpkJe4vzNFKYp5RAT5okBlXgnUhkuknNa0+KORi
         CpjiRXriZePC1TSwUxSL46cA5vuavThZL5Fq8jFgNHV0SRTJcIcFjKdj2zG+yPT6upnm
         bgUpgo5cpxdwUARQ6SAt2IGtlZlZOV6MJtvVoeeHGOxwXQXNwrvceKIDNfyngiUqEFvZ
         c14g==
X-Forwarded-Encrypted: i=1; AJvYcCXA5Eg9HUivlTQx0G0Hnu6TMJOOU4/b5HBUtXxRQe1MbDeyfs+SCt3mMICB4Hzvyjs4rkyUgAmNgI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKI0DkfIsc4PGq95awOnu+AQHdB6zsTxLtm6hi/RGGXnxLFLi
	TA0H1gJwcyL4qnClLhuU0sDdri2zHnGenie/Rr31C3ntor2IP5FsNQBMj7vS3tzMzoPbaA0tzjo
	eb5fy4VBTeyxyGjO9pe+ObvIXIpaE/7Q=
X-Gm-Gg: ATEYQzwprcY+wnzWpyjm2J0qBRfzg9MZZpR8oczmKRFlKjadn/ozzRsbow7j0T5LMeq
	v5M0ueuPWx7ZtZtq7llqyIFp5k1Hwun64kx3ifmsV4P6HfhhJCGsXI0nDaoXNiQpeXCneELIqog
	sxoOHhSzTdBSJ6Vkvki5EFl+2OKqzVoONVv4Hrv26o7bw88mOBkgAwQ/QC61mZtJ0o9TT52Q40p
	kX4T8CmStf6Mb4TmbCGCifpBByAaLMBlyJh9dsHpma6FT5h8GSKweIcHbvFam69HW7FsI3L5WKE
	r5fKpnrspNiWA9DLs0qgK+o7rMiI1Fd4mqKOIS1Svf5iPZ8TTwmVpDscQR4XwF8vX2iN8W+2oQX
	hUWgIbLk=
X-Received: by 2002:a17:907:6b06:b0:b97:f050:d115 with SMTP id
 a640c23a62f3a-b982f0c310amr932278966b.9.1774266433441; Mon, 23 Mar 2026
 04:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
 <20260323074505.3853353-4-sai.krishna.potthuri@amd.com> <acEbZ0O3HKrGx0u1@ashevche-desk.local>
 <8c8fa211-6244-43d3-9350-856301075e2b@amd.com>
In-Reply-To: <8c8fa211-6244-43d3-9350-856301075e2b@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Mar 2026 13:46:37 +0200
X-Gm-Features: AaiRm51igNpVP2kCtjt-uVTIXp5cT3pPNV4OvOgkKtoQyGTUIfXrJkbDCsd2ufI
Message-ID: <CAHp75VdcrfJn=VBnjJbA8QQnstaTay+39bumJiLt796fXsKmTA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: xilinx-xadc: Add I2C interface support
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"saikrishna12468@gmail.com" <saikrishna12468@gmail.com>, "git (AMD-Xilinx)" <git@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:32=E2=80=AFPM Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Monday, March 23, 2026 4:22 PM
> > On Mon, Mar 23, 2026 at 01:15:04PM +0530, Sai Krishna Potthuri wrote:

...

> > >  int xadc_write_samplerate(struct xadc *xadc, int val)  {
> > > -   unsigned long clk_rate =3D xadc_get_dclk_rate(xadc);
> > > +   unsigned long clk_rate;
> > >     unsigned int div;
> > >
> > > +   if (!xadc->ops->get_dclk_rate)
> > > +           return -EOPNOTSUPP;
> >
> > > +   clk_rate =3D xadc_get_dclk_rate(xadc);
> > > +
> >
> > Unneeded blank line.
> >
> > Also, don't you asked for options?
> This callback is defined for all other platforms except I2C.
> Currently for I2c interface we are not supporting any configuration, it
> is used only to read the channels.

If the callback defined you should use its value and not hardcoded one, rig=
ht?

> > >     if (!clk_rate)
> > >             return -EINVAL;

--=20
With Best Regards,
Andy Shevchenko
