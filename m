Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973336D9EA
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018070; cv=none; b=eOChMAzBLxBkBUnDYzJgz4sI+RGUcjUUSTog48UFn/0kfnEhXjgv7FGniFST5sVc4Zu3v8IBIXs3cyQbYz/PbbuP4AghzluUVPpC6/YyDLybT0jiitOdmAtxB+6iwibBHSQ+k44UDipmVbyaMr9hjwnXqqkhIrHYGqRPeNDzM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018070; c=relaxed/simple;
	bh=+tEFNeMJqealBw0no60GL8D7cRXJeTaVv4VStbDXnws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du6Aj/r3Jf9ZGAWjo9V5bgYSV8DgUSoKIbpxyuMEimBvpNhx1ZiZcHIWs/VtrcWYJnCgn/VtpumH52L78G/McHJA9FS6QsLdnHTgLW34TaxG++aLBh39giT247x5RE0XDH5xN9ecZhmMLyUKKBCm54Cf+eDTh/K3kgOPZ7mrnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5aDOMFS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5aDOMFS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso4956569f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018066; x=1777622866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+M/ttk8qWJ/8in12tRHu4bpC1EaQngIhE3ms4JRyXk=;
        b=V5aDOMFSyxhtsO6Ae5pCKOet7uX5yv7iEWnuxfnxXJds95WU6/MxbJDi0ZiRLS5vzS
         G1On4U/ai38XffTJbZpzQ+V+4PeINVJ7JRixPDPJHLSQ08yr8++u735bQB7l1ZdK2bAX
         iGEOAojNdMzlkIKt4PhDr9TExszUhCbI51pbcfwFW/B6hwlHuMIHPhoTE2OE6nxmmq3j
         H049TI7kE2v1ZcMpHL5oVKLL2rVip5Rm/JJZ7Z4UMPElIS5hd9ddNdIhNpF2UJBagv5+
         iZ3C4ehg6dl9fz8q5vVa4Rggei2qbZiRiUUwnGddmMpg9jzi6V6+U0NeKEWC6I6LTXhE
         bFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018066; x=1777622866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+M/ttk8qWJ/8in12tRHu4bpC1EaQngIhE3ms4JRyXk=;
        b=F5rq3bZ+2KFt6etGpvC2bZR/up+2KFXmQUWZiO0d1Y6WuXLkABQ+xkgUmtHCYfawmY
         m6Q0VQ3SK/ITv6X0hLpdnhI+A/fhGlaGrMgaWVgG5h7GBXkBa9IvDbJsPEpj0bDKdQj7
         jYmL9klZ6sOVwpjHVgpZB54r0QeMv6KdbBNR3jo2l2UwTXoWHWODrfl88OjAQNAk98RY
         dY/ggFDYCDlDdAfkN/VIvI5VJMY6BrhwVHe6aKGwC6Ci6Fe62GUl7rQOgQiIwGrCUGYb
         2uHw0PmE65xG+d8GhfmoPesA7FevzJ3ntb6ygam48ImStJ1cb069wCxdOOyk6lUPxdKP
         aDaA==
X-Forwarded-Encrypted: i=1; AFNElJ+DLo806IzM2q9hkcpx0VQOu5ih5wWWdi5pg0SDtAsWSzoq8a/S2OyDv0Qoalr5g9yiP0IX7xir8eE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Cr0pLe75NDgcZKmgkI3FXiUs/tZ/8B668KgWugF8LWEkbakK
	Fz8xVrI0Z3lRn8oS7mkSvW3dorf8E+1K89p8Z5iIBWt+UIXKQTOkOfv8
X-Gm-Gg: AeBDieumtW5pAcqh41J5173GtXoooHQAZ4kwWaMsbwUv/eKu0pMGre+9uw9CEbWvZK3
	7BwHMkHsjBsSpVNaZvM4hr0vxiA5XoWxt4jDkgKP1Q6I8LcDlN5RcW9t1fNbkUoX5yvZrjVLT+2
	BnO0RqH1iNlWFX5z8y5EjjRYhGTb1oLaoW6V+77I8vPKuKDHj2/Wy0LjSq5yLIPRAN1/AlABccz
	XgC2+CuRXiaA14g2VhZla/otN5TN2cLq6aqX4cEbouCfHYNmbvaipfpHbYrUArS62VK1FcHhFju
	CeriLNrOooN9Ii4jQNrVXM0Rb7FtHWsBZmTnOFbrBapzkuR4xz/D9468JA8D1e3INSd6LVF6pO5
	yz0g7x5CIe1+C9Y7KpqJ15KXLCyml9NVAhsur2iNT+tu5S8OYMGtoKJ81HVcnOUS1M3UsdP6Ohm
	v65uocM/oESZyTKPnHj91VfhRiCgHqi3jpvg==
X-Received: by 2002:a05:6000:178a:b0:43d:a58:b076 with SMTP id ffacd0b85a97d-43fe3e1e252mr48882987f8f.44.1777018065891;
        Fri, 24 Apr 2026 01:07:45 -0700 (PDT)
Received: from nsa ([185.128.9.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm61329730f8f.17.2026.04.24.01.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:07:45 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:08:37 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	demonsingur@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
Message-ID: <aeskNzhWtKPNYb4R@nsa>
References: <20260421165856.2245598-1-sanjayembedded@gmail.com>
 <aenU2WZnVJ-esibn@nsa>
 <8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8C4ED753-72A9-4A34-920D-A5C5E8DB1840@gmail.com>

On Fri, Apr 24, 2026 at 07:22:37AM +0530, Sanjay Chitroda wrote:
> 
> 
> On 23 April 2026 1:46:32 pm IST, "Nuno Sá" <noname.nuno@gmail.com> wrote:
> >On Tue, Apr 21, 2026 at 10:28:56PM +0530, Sanjay Chitroda wrote:
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> 
> >> The listed maintainer analog domain email for Cosmin Tanislav is no
> >> longer valid, and he would no longer maintain this driver(s).
> >> 
> >> Replacing email maintainer with list, to keep it valid all the time.
> >> 
> >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> ---
> >> Changes in v3:
> >> - Following input from Nuno and confirmation from Jonathan,
> >>   replacing domain specific maintainer with mailing list.
> >> - Link to v1: https://lore.kernel.org/all/20260418211336.1800221-1-sanjayembedded@gmail.com/
> >> ---
> >
> >While you're doing this, could you take the opportunity and also update
> >this entry?
> >
> >https://elixir.bootlin.com/linux/v7.0/source/MAINTAINERS#L1837
> >
> >Thanks!
> >- Nuno Sá
> >
> Hi Nuno Sá,
> 
> Are you suggesting to have separate change to add mailing list in analog devices and iio driver which you pointed ? 
> 
> This change is specific to email debounce due to Cosmin analog domain account.

Yes, it makes more sense for it to be a separate patch. I also suggested
that one because it's an entry covering a lot of driver's and
includes Lars which has been silent for some time now so maybe it's better no
to "spam" him like that :)

> 
> Also, I had take a glance on MAINTAINERS, it looks there are good amount of drivers which are maintained by you and Michael Hennerich from analog. If you suggest I can plan to add analog mailing list in all respective places in separate change.
> 
> This way all analog device maintained drivers will have mailing list of analog.com

Yeah, I'm not sure if it makes sense to go change all of those. I would
focus on bouncing emails and we (ADI) need to make sure to also include
that list from now on.

- Nuno Sá

> 
> Kindly share your thoughts on the same.
> 
> Thanks,
> Sanjay Chitroda 
> 
> 
> 
> >>  MAINTAINERS | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index c981cbdff500..6498f0aed1ff 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
> >>  F:	drivers/iio/accel/adxl355_spi.c
> >>  
> >>  ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> +L:	linux@analog.com
> >>  L:	linux-iio@vger.kernel.org
> >>  S:	Supported
> >>  W:	https://ez.analog.com/linux-software-drivers
> >> @@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> >>  F:	drivers/iio/adc/ad4080.c
> >>  
> >>  ANALOG DEVICES INC AD4130 DRIVER
> >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> +L:	linux@analog.com
> >>  L:	linux-iio@vger.kernel.org
> >>  S:	Supported
> >>  W:	https://ez.analog.com/linux-software-drivers
> >> @@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
> >>  F:	drivers/iio/dac/ad7293.c
> >>  
> >>  ANALOG DEVICES INC AD74115 DRIVER
> >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> +L:	linux@analog.com
> >>  L:	linux-iio@vger.kernel.org
> >>  S:	Supported
> >>  W:	https://ez.analog.com/linux-software-drivers
> >> @@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> >>  F:	drivers/iio/addac/ad74115.c
> >>  
> >>  ANALOG DEVICES INC AD74413R DRIVER
> >> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >> +L:	linux@analog.com
> >>  L:	linux-iio@vger.kernel.org
> >>  S:	Supported
> >>  W:	https://ez.analog.com/linux-software-drivers
> >> -- 
> >> 2.34.1
> >> 
