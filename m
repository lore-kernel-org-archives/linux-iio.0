Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B3355F4F
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606099; cv=pass; b=cr6FwqVGeSKnIwNYSw+1r8KQXyqLfXgWNiTmAuM6QqIKIMwKpkWl8aCXuTg8ERyFRhoCkTPINwrsegumz3t0115N4NO6D4k3ksmkmYolUWmD7qUpPUNzEBgfKvdtHZSbSqnI5tX8mV3TsqPUiPXh2ql252uwhuwgY9wkHecgK9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606099; c=relaxed/simple;
	bh=KgYE8NY18HH8TRen0NPS97WUyL/0h7qMH3OxN9kHuxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHLUXuyKQxQnTv9GVMVReQpY/oPHMqvAD6gU0HmUjPRGZCk6hrAQxtVgsvIAz13ygJS+4mnyb+k8OhEAOFGj8XyBfEKgIWnFU3mnrwqtcigaKFuOuA8CR7x9Tm86so5HJBI4LD19EA+HA9NnfrJprfPEKDr9UgSuzUGkSjicV3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCQnophj; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCQnophj"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d73352cf2so1819054f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 06:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776606096; cv=none;
        d=google.com; s=arc-20240605;
        b=jug30xwHV/DsRBMNrNu3PZ0uSTgvTK8RwKdmwjREhX7R1VPhB9yP4seS+EL5cEnlFA
         b0ndy4o0B15p1ZegttmTPRoo6nV7jj0W6z8DOkiWkoGk911JXZ1kuWhfjdptOt/W6R2I
         wCje3ZNA34A9/k7jtgqzB3CvnFp5vl2NHPiBjENvlATEIBrvjVHpaFZdTNzv4vwBUx0U
         iUnGdMbFWfyhwATg2RAVGFKvYPqni2w4F79gvcyQXL7xXt88/6Q9tMVbOzT1u1Gecsyv
         MJQmZzHh6Vc7diC0ZVRr6tYykF5lpo0JSJeADM21vpbNjTAfnQMN3eSLRbIaXVfS2hAi
         YVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bhvXeg9WDuDCHAGv1q3jriiZNOjr7t2RCHZ5SrorAsY=;
        fh=EYV+Nt/d7zFRYBystCAZqlSMiHLHD152lvaPyNoo5V0=;
        b=XRpLpfVGqIdb1y1nIwiNPka4dcWluYEKQJtGBzxpB9nSIxVhsKwOx/8/OuI6aoFRkp
         GuEbccEYlRlEz8D0/cnBjCri7EHhCrWxpraWTM2q853h6qfIXbEKVhLcCQmhhh+7edzQ
         4D/nfutu99CyPCTptWl+Bb4kH5E+QJwhAK1vyXRsBWLcQrYa82mj1jQE0ZWpOXyqsif8
         oVf/8j6KSyIFMdplHN0lTQfJXkKn9lE5YpSxRxIqvxUos6GI+tbcm7RTeildMCX2MQZE
         Rpxh1dni6vz0hZHXK72l+cOaB0kqJe0QBedXbQ9RRov0RBGso2tjM0xOGMZA+Ur1ZN36
         pr8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606096; x=1777210896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhvXeg9WDuDCHAGv1q3jriiZNOjr7t2RCHZ5SrorAsY=;
        b=eCQnophjr+vW1uUybVJzj76qKJtV7yIc/bd2Z8e8tmc0LVDXUO8XHzm7VWQ2ANto8z
         VMy8mpLRZI55R2VlVI5bvWHPUnG6sREqwG8BUzpdbXrVvIcX8UvxKAmvmu+bVGo2xWeI
         C+HJWRObMylqbbeUJYLB6NUYQ8w6FzcS35ychEbUpaj16p8yA3ByT9e/MNL+EY9NsCsI
         wwGzWeRg99QNy8Jiu25yE3k14MCRWsYzZi9o2giERc21068A8jbGQ4bEATx1l74w5mWp
         dJkoFFTOSMER0t/lpht1dA09NuF5z11QXfSYndGUAY0lqhGtC8zIwdNZKGQGjyPIegzo
         pz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606096; x=1777210896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhvXeg9WDuDCHAGv1q3jriiZNOjr7t2RCHZ5SrorAsY=;
        b=Fq0LL4W6yML5G4k1CLE4bxtwlcsiHfLbeGe8Y5aNGuSfaNAiFFIdEo+rDxY2KZUsev
         RDKX4Pbg9Tgnza6Dsy6PyHR94ZWa5yLwNlhyI6W7z/SGAD5YUfPh2IoBKApZ/4oz4eC3
         wVVYww3AH8yOZWRNaqEzDHUFuxrmb2GyO9IiSqoXpvlaEH+culVNT8jn20L2VtcwsHen
         Nn8giaY/2fwaftziF6pD0Q7Xd09ynFjDuGt9h1xOAIkLvVlnp2p5FwPU6uJ1Eva6GMdf
         5lAGiCERzEd14hPIgAIQRVakd85Mpn3utcdnZ5QddPeDCMjmVKUMghb1nkkmJCiDVG4y
         dqpw==
X-Forwarded-Encrypted: i=1; AFNElJ/GCRL3iVtShQj+K16ZootShfzxMelpn0dWcR81kxsOSOBYvdpCDOclUVxNBhwrJ4GvU0fy2/iKmZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBdO21lWH3cXwZqK6PhjnVYi04e/E4iyPKKuLHZZYxd/PgrVR
	nT8EQ4atRoRoZaxltmMjH88ZeFc68RvEYzQaXm5FLdnRZ9CfCdlO1NR6/aos+CUrKpWdyZ2TqPo
	6KTkEzotr9b7geCySZXF1QNUBNDFVq3g=
X-Gm-Gg: AeBDiesRfH3ZD6eGo9VY4Dj1c5WpT/W9YNnAYaRuSY7qBfEHYLWHpBB3AJrQBPIAe/v
	8HO+NBym/9eh2k4tWVmqT/CnfTPlWmO6kTz5qo7TG1ViEldRr9xDJpu4AZdH6Y853e9TgRQl4ST
	5AmqpDI/6lL5DU30ecFB1jbjCq7ly02PtnG23b4y1dz/U81PuyyyOum9oph5BmJiLn+RxkoDihz
	a1L+zrIdcIqTM60ZC3aQ8NCk+7xi5rRCyxfqBmwdOdXBiLVXf20uINo8+YTPlIZI4mZUSuTEMoZ
	Zk+H1tvfoFQIOIIfJZM=
X-Received: by 2002:a05:6000:2508:b0:43d:7e6f:3816 with SMTP id
 ffacd0b85a97d-43fe3e14ecbmr15264222f8f.40.1776606095936; Sun, 19 Apr 2026
 06:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419083125.35572-1-clamor95@gmail.com> <20260419083125.35572-4-clamor95@gmail.com>
 <20260419143346.45ed78c2@jic23-huawei>
In-Reply-To: <20260419143346.45ed78c2@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 19 Apr 2026 16:41:24 +0300
X-Gm-Features: AQROBzC9oRegsMB0JD377mwqYwXM9XZykSe1t4A6lF1Rs8q0BlhM7AMgugsjju4
Message-ID: <CAPVz0n1qrSYr16zSSqRHuTWVkRfdC+c9w+mxAhtzgfHzL41XFw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] misc: Remove old APDS990x driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 19 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:3=
3 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 19 Apr 2026 11:31:24 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The Avago APDS9900/9901 ALS/Proximity sensor is now supported by tsl277=
2
> > IIO driver so there is no need to keep this old implementation. Remove =
it.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  Documentation/misc-devices/apds990x.rst |  128 ---
> Sashiko AI reviewing is now running on anything that hits linux-iio@vger.=
kernel.org
>
> I'm slowly getting into the habit of checking out what it finds though
> I'm 500+ emails behind so it might not be that thorough today :*
>
> Anyhow, it caught an easy one here.
>
> This file is referenced from Documentation/misc-devices/index.rst
> so that needs an update as well.
>

Good catch, index was not updated, I will do so in v3.

> There is the obvious point of ABI compatibility raised as well, but given
> we don't seem to be getting much push back on that maybe that's not a sig=
nificant
> concern.

I did not found any ABI in the Documentation/ABI regarding this sensor
using grep, maybe you are more familiar?

>
> Jonathan
>
> >  drivers/misc/Kconfig                    |   10 -
> >  drivers/misc/Makefile                   |    1 -
> >  drivers/misc/apds990x.c                 | 1284 -----------------------
> >  include/linux/platform_data/apds990x.h  |   65 --
> >  5 files changed, 1488 deletions(-)
> >  delete mode 100644 Documentation/misc-devices/apds990x.rst
> >  delete mode 100644 drivers/misc/apds990x.c
> >  delete mode 100644 include/linux/platform_data/apds990x.h
