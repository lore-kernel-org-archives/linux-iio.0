Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE09421EFD
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470340; cv=pass; b=bzTHxSjYaOrPPVzcrBJp0JY4V54OtlPBRB4zKbA7zs8zD8KSCfKPxFv2T9DzQO1pZKzeNk62lAIF2leTJygaP7gfhHnbi2OWTo9IdIAQtkfDqvM6bTmPR9zmcdt4b4zDp7S4AGf1difOcwyEMZjA2RF6iWG02G2F85NxzrFKOz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470340; c=relaxed/simple;
	bh=+ZuNuXyZq56kISmknigfJ8GbjLF67fjTjtAOLkNV/xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEPinAbs7PC8vUd/GC/S/M1j6HHdhrDNXaYnPeow9VhYBHNOaxDUfUjEME28OfbD7Tx2Pi2PSuIEzB/omaCL5Bmg4JWpKZZtrltJ2Uwf3ngn8sPKnugpT0Ed4JmMZIYvgTCAyLIxkPIiMO14dcaDjOgzhYtLUCXk3ilcjj0Bj8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk5CV3kE; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk5CV3kE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3598df39444so693958a91.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772470338; cv=none;
        d=google.com; s=arc-20240605;
        b=SRwennf1rtSsv7qEARL5RkvGvcTV/njqSdnLKMKHKWxkAs8hNC/JFPTtOvZxBZq4Cg
         G19St2l/Nb5TdfgTwc+p0rtrDmfszBUuP0bcxiBS3WqapMw1eSjbh3L1WffGAXzXSM+Y
         LTVi2JA9Wybzyno5kobTsQrdfej8hQ+Yvnv1O7DgUZPIKDgX8aOL3DJ1uz3p7bjPtE4q
         RJCUd43ot9box4qr/18LSI1KJrVhPU3NDHjzck94tAeTf5roqZ/AKAie1csgwA65OoAr
         PoPIugvDQIXl+Sm4Jo0uMo1kqMYA3IjaOoaIQrFJTTrWVaYzLJYKZeBkHpC572Cy0viO
         NFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+X96fMKnX/6EI3fs7N38f+cAp4Q0EG39gKrN+3VgiD8=;
        fh=W0yUdPs2LGFv3dNFdAFx8Bb7XKmeKrDh4a0K+ZvC2kg=;
        b=A2uagiJ4egk9d2H2b5+EmRVtdh4unHb69inPn//lFjWYwuBEDdh5e3XDLKphUBs+Ci
         pSBLJ0Qo5mbMH9RXZ9/iDrgUBD13QNe9mN/bHkFwmzA0r9i79Tw4+sUM7A8USmplD37r
         L570XWl8NzyyOQreJ3eaqT19+SMTXTSeFBsMezWHyTnpXsJfkSrazCwDs3m5ytaWlTIb
         K7yBRs8F+naQD8OpvcI3FCeGwzxQPyTmOpNW/SRWZpOqIIe6nSt5NZCp+UwvNeOzMVtq
         qXR6Wgvjnbcy9n0huWsq0jUjJEgkz1Z7Btp1dMosa42g1iEXNhVofdcVFDe8Q1rCfeWD
         ay7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772470338; x=1773075138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X96fMKnX/6EI3fs7N38f+cAp4Q0EG39gKrN+3VgiD8=;
        b=Mk5CV3kEL9OVuLyo9tR/Mu1j5luSa71gAA5e0NsHfPydRPk2eAu3i2gGtmgP+KKj5F
         Z1W9hk/2i66v/ALJPYUUtJO0dNZ21t+ltsQgSWXXlo7mZzwIKO9cz9SieEtqzjWR4IXt
         el5l9fxUxQPuzCVH6VVht2zDc56qrRJNyrub3Cn6I6ksKr13avhLeovI+M+f6lk/bgAn
         j6E51YFSQ9DvthcQdBnIsSiv/GERHIqxlwFLSr4t1Yv1bANMIyVgLcl/WdBk7YL8Dcx3
         RyA5Z77c+gHxlsXtYAcuGuKlfKSfYzTu7AYyy396WdlY5rKDP+F3f91ncM+HRkOwGMBb
         kIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772470338; x=1773075138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+X96fMKnX/6EI3fs7N38f+cAp4Q0EG39gKrN+3VgiD8=;
        b=ee5Jl5vJREuaOQ25kl0WGeYLlp4S6jEiI4L7g7Ln7VoRp/W3+CG+rW+0lKGxH44bCG
         5FswCS0kM8OoRp0HGkssOBUlWZrYPcnhMs7Zs7nHK5Wjt7xdb+8dEA0KFmUWrDUu/18X
         e133IxmLOv5uGz03Fk4ExYImhOU5+5xT1eyPS4CHdLiUO5Yh8JJfOKrkSZpme7yMyd6q
         94b2UNe81INsuh8Z/hVlRH9diNthPujCHGmPO5z79jwb/IfQkOn3mFMNpQ+do57/OZyR
         pbhIpuMkUmd7AMvRkCH8rfkH/pL0Y8FahOOYwgm0uS5XJyZl0QZ3jIBDseCa8uf4Wp5p
         3PZg==
X-Forwarded-Encrypted: i=1; AJvYcCXja7f6dBKOtZyldGQ2SPNi/vqIV2I+iUs6exQ8/onyyik5QjlWrRFI9+0COVBUDbPuRYyBAnxHhDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8BUzJ53ric8qDymZWJLQUlIBuC9XDt4u+E2edV7Kra3z5yAO
	SGmz2Xc3tFUvBXR+gz1glJH71xmf0Es/tpS3b/R16q1khAZFD1o2W0IE7UFfHAKbS537cuGvgvO
	8wu88/cVt2vOJYBYLOGZTn+sk+SvEanA=
X-Gm-Gg: ATEYQzx8/DomLNhLYiI0RDPedCIPblZsWNWaIDv4BXO6erEEZ0uJdmNRtNFILjMCQoc
	zu1Ijwdksms+FEq0VAjqseJfCbswgN5v0ZRFlA4WYD1VpkrPMt7kk0k3bC0Vt3H9JyEmXXT8Pah
	KlkzY5U5hRQRICJdxSpndYofkcUaaChoy9ms4Q7sPy6vkzH6gSPYASoaMix7r+MkF965r0cnvnj
	UKuMi+Bt05j16QssoZ+/3J/LK8Klk3akeh6APWDc0ph7y3FVMWWY80MNQpHoQalR0s9ktwBG7VG
	cAnklKCK
X-Received: by 2002:a17:90a:fd97:b0:349:3fe8:e7de with SMTP id
 98e67ed59e1d1-35965cd1066mr6831647a91.28.1772470338469; Mon, 02 Mar 2026
 08:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
 <aaW93QGdN25mqFUA@ashevche-desk.local> <aaW-DC64WCxYYcgY@ashevche-desk.local>
In-Reply-To: <aaW-DC64WCxYYcgY@ashevche-desk.local>
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 3 Mar 2026 00:52:05 +0800
X-Gm-Features: AaiRm52trWAFOVRQeky49eXgW9rYzGLT5-Fdvkk0rEpdWvhwOkijwnB3-iCMlYw
Message-ID: <CAN4SLj0KKO-zYEeKcuNYou+PKOMprwcPDdDrYYji2tYNJrOqDw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1119: Replace IRQF_ONESHOT with IRQF_NO_THREAD
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 12:43=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Mar 02, 2026 at 06:42:11PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 03, 2026 at 12:00:04AM +0800, Felix Gu wrote:
>
> ...
>
> > >             if (ret)
> > >                     return dev_err_probe(dev, ret,
> > >                                          "Failed to allocate irq\n");
> >
> > Also consider dropping this duplicate message as the callee does it alr=
eady.
>
> (In a separate patch, obviously.)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Hi Andy,
I will draft a patch for it.

Best regards,
Felix
