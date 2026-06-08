Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150DC3EF675
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948768; cv=none; b=M3WmlLrEusZ5zkA6g1UArNz1oaoaljf128aPBNDe5Tr3h7b+IQmNXV/Uo7MrqsFyl+e68SUvpqglnfZTc+4hOJAo97H7AsOa33yIHyYlis0QXF9uF11dY2T4RqiOmnspRS9bQ6ONCNF518meAtuSJsVYWk5QPdkxx7sNAciYtFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948768; c=relaxed/simple;
	bh=eIkudAsms1viMe11dRPbHuAxtuazJ44ayF/3sq8SzN4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kx76FD/gOo9ekNfxskp+t/JFXmiQ2qQNw906VFYSZVrgZR+10NbE4zVfX5Pv/f5xSH6r7oNqB8B5Jg9l9mR2acgnzyUwksJZR1pK74IvMIK3f4X+SNu1SfA4BdpV3n+EGsUIo7oK9sju+NA8S6xQjE6KTwia8NEInRMDOHy/0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G58CXV04; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G58CXV04"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b3e03939so40283045e9.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948764; x=1781553564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYGs88NJU9z+tNEXbi0VCq+yc7XxEqkjAT3JtoHX62Q=;
        b=G58CXV04M3xI3sEq8tL/CECoTKkiR9efN+dy8jM1ClrawBmto0dkl793wDjTzriGGT
         +uWJME3LNKWCFWYwhzU4zc1Yq2vj3jYnfeyNENefz/CpT0mYPopf5Eev2RbYbu7k0kEO
         Bw96lIHvF7wLcluh5Zv55GJb8Ul4wuZ0PolJR2QSi88LLaP14wOOuo889vRvJyqij8sF
         ciLQzCVC18xH+2votq7DRt4EKTcey/Wtdifj6+/3451TTB9nV9LRcfK3v2AJ/TmMIKUc
         3gt6JuYvrjz+OekM42X1sccz1WQkZ9XQ7gO1HcFu7FPGxlyAMN3PGzQa0iZOuieD3ixt
         16Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948764; x=1781553564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYGs88NJU9z+tNEXbi0VCq+yc7XxEqkjAT3JtoHX62Q=;
        b=YTURMk1PaVn/8Gcj1xAX1V9sg6kuwpC0lAIxtos1C11Tgv1GQ8IQ2P3Grundp5i+8w
         cSyogcQ6e/ZVinO1W6FdCuLXQe+izDV+8vq8zWg6hSL/yCWGHfGEtIpdZNi+uOe/PLah
         A291XEZndHjg595sVV6ME9c5M91rZsetFkI/95i505OF88ew7PYXnclNxW71+P8IvkRp
         pzRmoQkizJchaOR8SeqE55EPSsMNWI9c9Agngxd8Faskj16CtzWcu00c0H80X0Ev+oLL
         sE1bB7BjiE8rQ36+2+IFVGsnl9x2v4oQkEYOlAoOSa9LKeXKapb1Cd4OybUmZIs7fFo1
         jgvw==
X-Gm-Message-State: AOJu0YzkxeE6psvdH/R7MOpzY3/qea1jQWsRShtSHfewYNFc5MUnwqlF
	tFx8gq16k79SUVrQeqtvbuDxB9qssT+73rwgGatFzpgwhfqwoNXyo4aQ
X-Gm-Gg: Acq92OENs3r4h+l2XA4sCQTo8xxrleuFywnABlda6bkFUsiwvPewYOZHYgK/PmPpRFa
	HGMEB3uPJyfuoqIM+oXqsQweklbRAptHa32wEwua9f/g0ZOg5EeOJklZ2Hpc1idzy0q9LNUsikF
	bC7EtnKvFvPXkZRAOEefkX2+rjntsoG4aIfwjFAdPNVQHYl5IalUPeX9XvhIOluC32YtdO0mbzK
	FCALGQ0vJk5hmyjIwM81iZoJaC1IavTQp59fkStb1modfHVGapwSTmP3Og4RminKp0It+qIfDzN
	2EajjvgTEi1OilSgfVif9bsJ4/F2TrS1kCLloNob7/iBUjIG67RDt1kd1P96DkLiuMpp/9vY5Gl
	CjFPk3Y642nAcW267iyDet1q0j0DMwedcMZkJoJ+bXavaHueDtXM0XhChhCr+OImEiR90fMHN1U
	nz3ORtfvsGmfhSvTZ7j4ccw0EVUqlHfMHH80Ha3p75mkoanD5zKwsABaJ9QQkyecqtY8GSF+c9y
	/q+TwO7sm2a
X-Received: by 2002:a05:600c:4509:b0:490:c28c:e077 with SMTP id 5b1f17b1804b1-490c2d33c0fmr211939185e9.17.1780948764220;
        Mon, 08 Jun 2026 12:59:24 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm408933735e9.5.2026.06.08.12.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:59:23 -0700 (PDT)
Message-ID: <f1d569e66abbe0c065f0f4f889f82f8e9343a2c5.camel@gmail.com>
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>, Joshua
 Crofts <joshua.crofts1@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, sashiko-bot@kernel.org
Date: Mon, 08 Jun 2026 21:00:30 +0100
In-Reply-To: <aiMg71I2O6a94g3o@ashevche-desk.local>
References: <20260604084307.640053-1-jic23@kernel.org>
	 <aiFBEn_DKx5f6ekv@ashevche-desk.local>
	 <20260605145000.0ae0356e@jic23-huawei>
	 <aiMg71I2O6a94g3o@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 22:18 +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 02:50:00PM +0100, Jonathan Cameron wrote:
> > On Thu, 4 Jun 2026 12:10:42 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Jun 04, 2026 at 09:43:07AM +0100, Jonathan Cameron wrote:
>=20
> ...
>=20
> > > > =C2=A0				=C2=A0=C2=A0 indio_dev->scan_bytes, GFP_KERNEL);
> > > > =C2=A0		if (!bb)
> > > > =C2=A0			return -ENOMEM;
> > > > +		memset(bb, 0, indio_dev->scan_bytes);=C2=A0=20
> > >=20
> > > May I suggest different approach, id est use __GFP_ZERO instead of hu=
nting
> > > correct pointers?
> >=20
> > That's a weird beast when combined with a krealloc so I was a bit
> > nervous about readability (and less so whether it was correct).
> > It should be fine in that we will either get stale data or zeros
> > because we always use this path to allocate the buffer so if you
> > think it is obviously fine then I don't mind.
> >=20
> > The oddities are that if an object grows within a slab but doesn't need
> > a new one we are relying on those bits happening to be zero based on th=
e
> > original allocation doing __GFP_ZERO as well (as it's the same call)
> >=20
> > I'm nervous though as that region off the end is sometimes used for
> > debug objects and I really don't understand that bit of slab well enoug=
h.
> > If it actually does this, then seems like we'd end up with a lot of
> > nasty corner cases so I assume it doesn't.
>=20
> Such a bug will be a serious issue in mm. I don't think it exists.
> But, of course, chances are not completely 0.
>=20
> Current users (not a comprehensive list)
>=20
> arch/arm64/kvm/nested.c:92
> drivers/firmware/efi/capsule-loader.c:61
> drivers/gpio/gpiolib.c:5198
> drivers/media/platform/amphion/vdec.c:329
> drivers/net/ethernet/intel/ice/ice_lib.c:3044
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c:785
> drivers/net/wireless/ti/wl18xx/main.c:1582
> drivers/nvme/target/pci-epf.c:708
> drivers/spi/spi.c:1411
> drivers/usb/gadget/function/uvc_configfs.c:880
> fs/ceph/mdsmap.c:322
> fs/smb/server/ksmbd_work.c:123
> lib/tests/slub_kunit.c:273
> sound/soc/meson/meson-card-utils.c:49
>=20
> Also note the kernel-doc for krealloc_array(). It has some note WRT __GFP=
_ZERO
> and it means the flag must be supported. Also there is a note in mm/slub.=
c.
>=20
> > However, I couldn't convince myself enough not to just force a memset o=
f the
> > whole thing.
>=20
> I personally would go with __GFP_ZERO.

If I'm not missing anything, this should also be proof that the flag should=
 be fine:

https://elixir.bootlin.com/linux/v7.1-rc7/source/lib/tests/slub_kunit.c#L27=
5

- Nuno S=C3=A1
