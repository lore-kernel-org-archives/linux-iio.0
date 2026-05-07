Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A623B2FD4
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150484; cv=none; b=szqC7FaazzcnjlcqdLu8j86nQPTu8tcTctm8tMPbHQN75z0OUiNzW9sV4XPy73/gjchKZCfWKeMLS3VCpSIXNfTu43b44SKcHGds9Y8LDXA9FxPP4Kb628aV1h/4TsEJQSjetOa7l3H0di1KcrYz8XPfTEGn14HiCv/D8xngWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150484; c=relaxed/simple;
	bh=YuJrFzdtf7AR1Zmt4X3yr1/w0FNojkETQaTo+ZtlD3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWM3+W2HVZRHKOrW21lVeC42uxkRJb+4ojmiSw3W34ARmXjvS2SoDJRZwSHkGd4tzU157H6fgBh5wRfZdBfsjmRY5QioeYFaQv3zLRkXyr7fe52R9wJq8E1yaaG0fTxBBStqgP4t6zTSnSmvwBkuEcjswTxfKtYBhyEzsAMZsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwfL4eYF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwfL4eYF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44da2de25f3so499995f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778150480; x=1778755280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mOQND5LIBsFU7QewwrJ5aIqphJuwq/G8dVD1J3o1PE=;
        b=CwfL4eYFHgFV9kZYK7FxdkWOXd+Gsn8pXiWGiLkzut32w5KSkslB0G32cawwbhDCuM
         uIy7OlvbkFcYSaP/AmLsOI4x8OTeX+PaL9YNlA9nME1dIt4CWlEwnjN2WPuaVJt3COQK
         DdbFNquO03XUoHPeddcpTD/p/qBZRaDSkJwtcl0qd86h7fvx47ctp0uGQXZVex1Ju/Lg
         dW8UKcpNatwUxOdKKsZCQ193I27Azzzf9XkXSH2oQC8/b/AHa/LZVHVs/T+P6UkMIdZ5
         qO/MA9x822yDhGP+aPcUrtXvsZSHXtpncgy+Rh38YzptsMAi4IvtUxPeF+v3DSjsMMYs
         1k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778150480; x=1778755280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mOQND5LIBsFU7QewwrJ5aIqphJuwq/G8dVD1J3o1PE=;
        b=HyUFOpWTrHPeTLTPvP+7lr+Ofzh1SGgpEMqQoZdAz/tn0qx53jl0yc0BqBogPRmIUC
         CNA2p8+xvAIaXf/MvXezUQh+NcTV8IpMqTCbt/F5D57rumb0ceRMxPXYlhtYc+tCDGm+
         6I/NYk9gmVHjQFurA/Y5fjWLKJJ71NMUWQUQzPwGzadKa8PHnp1fG6rrpBREn+lcSoOK
         gBrRFYw8hGe98aPKRKAmZFOS9Ky4yLSsSHiQ06B0pgdrf/p7Ow7wXrdm22BI/Z0KBIFU
         BKsrUlG1PTonPJsGq+qVhUv35gvr9fh4e/6/b2HJk2Ac0kJpX1h3fyqZFvz6HH50ns27
         WgMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8t+RB1StBNwi7M3qmUX/4CCcFSSJ1x0B7e4xgDYce8+t2ERkg0GOT20WNaM+p1NwpA76v6kKU52oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPjI0s3p1gYDDdZF2tkZHDixnHIdyfag5fJcRFbitIwPRrcSS
	wb2gX1pYQhDinHXGhAL+5NUlyjbti0Ip0fxnQ+1WFJZO/Hd9/ElTiFCV
X-Gm-Gg: AeBDiet0JJKjmATSlx50zu/OFTw/EhxncYxuutCMWoc93VfhV37XO9joufosE4lH7CX
	2pgsRbUKG1m7SJ8uTAw9BYA8+TIltJt251CWr7LmGNrc+C4mbPSa/I+Q+6DAhaZ18i/CttmFbEf
	8GE1pXGJHQUx+bFhI53v0DlOzXq2Uu+pK6j2flNTGE8y3gRJkKVRLIDuQQv287FWe/wNNY5eCtM
	5+raAnshzqwXV2MQKRfULYfmkpruq4Wa9CFxQnRnfBtMJHwmEM7NKnXpUaVdTXR0ZQwiFnLNzMI
	gnLR0xC722jk9/wDtai5fU8j3pUjvnCkgqmiCR8PdcW5tJU+LR18GTpcAvcQ1uQGvrNUFBL8SZF
	CuVDNCyCMnEW0I6eRxEuVcC+oSXtdwDwJt6djWCGgxZI/R+SD13JrTyAiGSl207/amxrSDuIGpq
	w6ytIe2hOVxEJ13S9phLL1ohibPK9+9nmQLasfhT4FTuWoqMHiKuMsDA0Q6POI7yoVFo0MHiySA
	FGo/HiHnNyto6VMosr8j43r
X-Received: by 2002:a05:600c:4f53:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48e51f44577mr117945475e9.22.1778150479956;
        Thu, 07 May 2026 03:41:19 -0700 (PDT)
Received: from orome (p200300e41f1c9800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:9800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5389da63sm115701645e9.4.2026.05.07.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:41:18 -0700 (PDT)
Date: Thu, 7 May 2026 12:41:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Francesco Lavra <flavra@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: linux-next: manual merge of the iio tree with the iio-fixes tree
Message-ID: <afxrsImVuCp9d1gL@orome>
References: <a361f317e3aff614a00ddc8ef908d820@kernel.org>
 <20260507112938.369b6a1b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3ywpc4lpncriwvm"
Content-Disposition: inline
In-Reply-To: <20260507112938.369b6a1b@jic23-huawei>


--w3ywpc4lpncriwvm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: manual merge of the iio tree with the iio-fixes tree
MIME-Version: 1.0

On Thu, May 07, 2026 at 11:29:38AM +0100, Jonathan Cameron wrote:
> On Thu, 07 May 2026 12:05:27 +0200
> Thierry Reding <thierry.reding@kernel.org> wrote:
>=20
> > Hi all,
> >=20
> > Today's linux-next merge of the iio tree got a conflict in:
> >=20
> >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> >=20
> > between commit:
> >=20
> >   cba48e44357b ("iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO bu=
ffer")
> >=20
> > from the iio-fixes tree and commit:
> >=20
> >   7216b9f7e9fe ("iio: imu: st_lsm6dsx: Fix check for invalid samples fr=
om FIFO")
> >=20
> > from the iio tree.
> >=20
> > I fixed it up by using the version from the iio tree. This is now fixed
> > as far as linux-next is concerned, but any non trivial conflicts should
> > be mentioned to your upstream maintainer when your tree is submitted
> > for merging.  You may also want to consider cooperating with the
> > maintainer of the conflicting tree to minimise any particularly complex
> > conflicts.
>=20
> Thanks. That's the correct conflict resolution.

Thanks for confirming. I was halfway tempted not to report this because
it's pretty obvious that the issue addressed in iio-fixes is also fixed
by the commit in iio. I don't know if Mark or Stephen would usually not
report these, so thought I'd better play it safe just in case.

Thierry

--w3ywpc4lpncriwvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmn8bEgACgkQ3SOs138+
s6FslA/+NnHO+tL6NZn+TsSWZqxrWoWFQTdE0isVpYXs96UunXv6ku/eXCHF3dxT
ovIwEhPi66X1fH+Mlx0bjKMbUcZ7yxfe48Z+l/78z08cHoqm8GTSF9HDxKnXwwhp
oX7jurq8iiGyWadhG4uF/B/FIL4QsUKFofJ/G8vOLI+h/bRWnwHuDEwx4NU7RxcB
pSoqpwNyqQ7tKyq1dT97RbqIO/LpLCS33ndqRbhZVVM23LVBbfR0E8PFU1KtvCmL
IA8hJAA8YvDKWIhWGug4H/ybkocTQlGap+xReT26zGBhpzPpmo28V0GTp8qImDKy
X2VSX20K/g/raBjBRGsFl4p1s2Pr9SJXvB021csXrIQvExzy3h5mt86j+YOolhOi
Uh4R1WAfwwsiVmF+wI2HXcXGBlXeiE6Z8izpBX/i+6NCDGYLLPQ4E46RqBvxZM9k
A4n7cd+SnZ/BWsH+2DxrKH9sn5SCMwg6Giwey/0FlFXEp/97ukwsmcC+UiMhQ+as
BWtxvKaOt7FAdUEQxqkc6LuC8JEnpqmjnWqW0DR1wuuu+NAOlYPKHCnGeGeZ12Ev
8muF/c1TRp6Srp0ESB5M4ICZq3wajuUMMf8qkdahU7HlNlB3X+VZGjyEbIyEJQSF
ZxOiNqlYHmqHB0LEzeIYdapBvZCPyRePOtWPID3CkcxTsxt0XMQ=
=R9FL
-----END PGP SIGNATURE-----

--w3ywpc4lpncriwvm--
