Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C533284B36
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027091; cv=none; b=c9apBrmtopU/E2WufavdsWUUt7qUHb2pOrmEDodUdSw1Zwy/mCoGGZQ7LOtfW7i/gNe/hme4C8o7YndQ++XoNBSJtZP8aX9g16B5fA8y96zFCJ2pNtcEpU0IGXjQfCodbpaAW352WzWJF1+771SC0LcYff4+9UKijv01HrKccwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027091; c=relaxed/simple;
	bh=x6D6h1D+QVALJyJ8ILdl83zNlUA9XoJiXvEQE5vzs3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOVjKEApY8+hX6K2FPXroObnz0xvtFt3sFMVPyI0lBsm+XV1aVnuCNQ4elF/mkauAHuKbNKOtx/xGmKAARRgnygsVHrvoDILcSRHA5M/SLIf4xSF0KAqaoZCQTc/2eLGHCLktndvvK+OGFVt8IfDHcQWB5PCjYRU5u3goWqG8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqV+MKpe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqV+MKpe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so2861684f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770027089; x=1770631889; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x6D6h1D+QVALJyJ8ILdl83zNlUA9XoJiXvEQE5vzs3Q=;
        b=lqV+MKpeOb1Z7wiKw/IomRxuLN24cDZEg26t0RFkSWXpn41+gzQYh8s+82IQpSogtS
         0Xhjki5hxdH+Cu4Bz2nlOnlJaP1APomI0hcd50XFR6HzuPoXqFTtLjzIISVnETscObWV
         BqKsHDkbFWVxgrFY1xHZ6JkD0K+46+ujMQtDBpFnfgyikCRkm3uHek3JMCCv+S3xLNG/
         xbB7pucQ1w2mOg5KUFjzlKri6xjFY5HMPQT2MIWf1Jw2rQVHn7PLFm0Mo9pGOoSh8j0A
         BefgcDMM9MMV0W5HReTFfw8yZ3kdVj8ElmQGv4ywGEO6P3p7Db8B77erDbAlLkMij4UP
         qqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027089; x=1770631889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6D6h1D+QVALJyJ8ILdl83zNlUA9XoJiXvEQE5vzs3Q=;
        b=eChhXM1+o11Vi1CCtdkE15J1wGQqCsjmad2GIGS9pepLAVvu5Ok42l+JPlAGR9ZQi8
         XMCT4PivSBgpsCdMO4q3GcLm/iVrbokAjAkRyScwzsaAWl87x7b33GcZlr23G0kB6Vy5
         sfpekcmhhSQfKH4r+YUfmxJtzWpGBGC5qLMDHQj084sayTzgHaA0o51xAkd/k15welAl
         vaBVYfIgJLRvySGNX9WhCFP6u9FBNxQ3YyfJgK7vWpAcJVJk8PWXewi8sQQ5uFf5TBOh
         01ONXEFvpG9QCh3J3Db8pv0vj5YqBvmd5HN7VLLmBDbf3oQa93WTzUItB9VDZNzgNmFF
         7Ufg==
X-Forwarded-Encrypted: i=1; AJvYcCW211qX4ZqajEyRZk9KkKxAOTuSOUMaUC+XWjoqZ35JKcwZAsCh6kakxYKa7cZe1YFy+2Ck38annFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTW1q8SwiydZkcKvaQdUgPWTQCX0UE/ockmvhatwGR6WW4QNaw
	VrssZ5DzED06RmrKe37Ftbv8RDdUZw2/F+gUFV40/nneV18vd6LksUPa
X-Gm-Gg: AZuq6aJ024N8C4rfHYRzjxT7/6qK9DUa7l+JFz8i9vxAe0PDVUhi5IolE3rYLqNhCPF
	/17WelwGbR+MuBi8mvVRphZUoOLarvt7Umz+vKj81rx0TIBmIUbuN+j2IR8IO8ZhCcFgaI0CXi8
	18KIbM0LUEjg/q9Qa2Czg7a5kzqsSvngTijlBvQE/vHfezPjOp6zVF745Fx+pYkPqthJF7IeVgu
	W65c5fCOJNdxKsNHnD7lmDmPRtyjbT2sfNGHznlljZewNQO+TQiq+GxrlO4N4fxMhbIxGNmNUfj
	0KsBOthPYRjls2tzAE0K77CQlQcQhg8lqs5FjcEXo2waO3o88NBjRQA8Vp/fGeaqzXc9EyWGJEQ
	MJ1d4tqYQFZuZ/pT3tiSlt8RAz+lIbWzqzBFCd9dT98lhSUgaMmccNgAXOoT6OfiPboTN5pLW5h
	3cq4gG/4FipwYAK7Mu1+1M+gFOJa2FrQ==
X-Received: by 2002:adf:f2ce:0:b0:436:1b1:6cbd with SMTP id ffacd0b85a97d-43601b16ee1mr4892757f8f.6.1770027088509;
        Mon, 02 Feb 2026 02:11:28 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323770sm44040609f8f.32.2026.02.02.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:11:28 -0800 (PST)
Message-ID: <b06bee455950f59ea3f2cdcd37ec4f6d1be68b39.camel@gmail.com>
Subject: Re: [PATCH] iio: trigger: fix use-after-free in viio_trigger_alloc()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 10:12:10 +0000
In-Reply-To: <20260131124416.19576731@jic23-huawei>
References: <20260131092333.247931-1-salah.triki@gmail.com>
	 <20260131124416.19576731@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

On Sat, 2026-01-31 at 12:44 +0000, Jonathan Cameron wrote:
> On Sat, 31 Jan 2026 10:23:33 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
>=20
> Hi Salah,
>=20
> This is a definitely case of the fix not being anywhere as simple
> as it might look at first glance.
>=20
> > Once `device_initialize()` is called, the reference count of the device
> > is set to 1. The memory associated with the device must then be
> > managed by the kobject reference counting.
> >=20
> > In `viio_trigger_alloc()`, if `irq_alloc_descs()` or `kvasprintf()` fai=
ls,
> > the code currently calls `kfree()`. Using `kfree()` in this case bypass=
es
> > the device's release callback and can lead to a use-after-free or memor=
y
> > corruption.
>=20
> In some cases yes it can cause problems, but please show me an actual
> path to this in the description. It should indeed be tidied up.

>=20
> >=20
> > Fix this by calling `put_device()` instead of `kfree()`. This ensures t=
hat
> > the memory is freed properly via `iio_trig_release()` when the referenc=
e
> > count drops to zero.

Not the first time this pops up and I actually thought it was already fixed=
. But it seems we
never got v5:

https://lore.kernel.org/linux-iio/20251110035838.37029-1-make24@iscas.ac.cn=
/

Andy already fixed it for the main iio_dev allocation:

https://lore.kernel.org/linux-iio/20251112145735.2075527-3-andriy.shevchenk=
o@linux.intel.com/

- Nuno S=C3=A1
>=20
