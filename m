Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B1340290
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166583; cv=none; b=qM3w1ESujJjiZiKSogHI8tVXSOSOhRB/rIzWFSK4hOSTjE6/hBuvjWdVLrFnW6G/9nWEdWzF+/SAySbhbbA32Blj9bsOSpXyMTAE9rBcH2TzuiOEvTk+Zc+VvRQ9xtgoT+hD5dxX5VVcTytuu6qjEgIA8ooPBrdFW0ku4vWcwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166583; c=relaxed/simple;
	bh=xbUf5FSd3RGLMyp4pwto3xlILvjlfs6fnWPMVV4Z2nM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gU3sAvVWj6bhgaT9Gc9qA1Sb6LtaVCvDSGw4T0WCE+1UVp2QlLPUSAUG0j+9QAdsROE3W9xTfHPM+mvj670M/DAgSULf0TopByQEMbU+GhGdRpjeqjxBYULhSSzThJiEEGd/uI76olpchsywgI06JLdI/ugXi/6wGR1d+e5fCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TYqfsmjN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TYqfsmjN"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359a16a400so1935672f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769166578; x=1769771378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbUf5FSd3RGLMyp4pwto3xlILvjlfs6fnWPMVV4Z2nM=;
        b=TYqfsmjNQpksOzXdeneMvXh+O6bDM8nH5xF1BX3r1OCsHSjeZKEb+fExifa4yrp5T/
         /MNQEicib6EWRcV1cQIxjcaGGr/ttroc2ceo4H6fBfbkb+soZ3ydcZ9twrRhE7+lHXLI
         DBngFoaJ2tBwIlTUpmkyi70XLH486JbmDQShlbBKYLYUirgP7tvp2YOkYvFRsbT60UuS
         +9CIu3MdcA4Gb/hKGQX5tx3pIpfK6zvdSv9aF7cjB7GnwHc8oKHYiNsL2mjXAXMNYBAP
         3WCe8IidTW+OEYZzH+28RN6s2yloSHGcT61QeEI1Hh90nEaFxMgYvRYtFPqNe79yElpI
         ZSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166578; x=1769771378;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbUf5FSd3RGLMyp4pwto3xlILvjlfs6fnWPMVV4Z2nM=;
        b=kAXP9+BJ0uxN8danlkxrSrlyJpWTZY8iZe4DyyAgWDpmxycmiq359j8/pnez5EX7fI
         TeVlqj6S9JpNHiAVegzGhBs8efHjalTiM35F4mCwzYDwrK9ne/jxIbh+5JA6DRBs5hTT
         ZV5jY0Kl2TZxAJ2e8XsOrKHxiERtM1xNob+zDOmQIxer+GaSwy4TQeTnd6pIeyBzgf0R
         99YpmKO5wr7oAOzudAXAa2vgqjyPU205MdLbg10b3dXAURmmCmT0FAFrDDz6vE8hQ6G/
         l8Rm2Z5U2gF6r+uNq5tb3pceNsXtjDCuuut7gUJFBC6vGfG6C2KSizoC9jVU24s7/T1H
         RKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVipsxrLnQUZE9GAWuqMN5pE/oQg472EPRMPtfz9zgVoycp4qg3sjmHs9G649I6ySU/QZ4UG+Fedtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1p7Xl2dcdBiYsUm4f+hjDeDG2hUVc5ZIh8ZkSeM5HN3UmcqAB
	0XrKdQ7Bgi1am4S6ZrtuVPRua0ZfvruIGb2Zlx2WftJbz7SMvYaplWfCEx0+6zQ+IKg=
X-Gm-Gg: AZuq6aKYI6jW3k+41eAl9sD+PiGsxGlnCBud00mpIR9uli8Q3ZJkihjwZaeJFyUOnpv
	7vEC4XPaZlzmUCD4dksy2J9RycSTjUT795LmM5VxvgAfIZuvpKSk0EgT3oSzNToPF7dCufsbO9O
	pAijAnAIcwq5vPP+ZqoMeySJwme978mO9d2pPW7LmcC6uj5sO19eYzofhtWFugcE7y6PG1EEx/i
	MW/LUqg2KyNUISCpvi43fCAyjw3Hk7fZLKZvQ4HFwY+iHcQc08ex6r8OTQcFxwTpmmStZRXAUvw
	uZ2rO5KwFHWwKI5Qvwh0zClpnzUDuhRQVyjKfUYCmDW1GjzjyOtRrKmg2Cid6pU3hYvw8jlJmZK
	22G3BqBFh/dKhZBdlwjN2VmASB25zl/rm08w6gxiYF+KO4OT54qenWHgb7v9+HSSOhtCN
X-Received: by 2002:a05:6000:2505:b0:430:f742:fbb9 with SMTP id ffacd0b85a97d-435b15952c2mr4262892f8f.23.1769166578378;
        Fri, 23 Jan 2026 03:09:38 -0800 (PST)
Received: from [10.203.83.237] ([151.19.16.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm5959916f8f.2.2026.01.23.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:09:38 -0800 (PST)
Message-ID: <34d7983a594b40d6d98dce02c1cff843f689a275.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] iio: accel: adxl380: Optimize reading of FIFO
 entries in interrupt handler
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Jan 2026 12:09:36 +0100
In-Reply-To: <20260123095417.31b11fd6@jic23-huawei>
References: <20260119102317.1565417-1-flavra@baylibre.com>
	 <20260119102317.1565417-3-flavra@baylibre.com>
	 <20260122195313.53fde73c@jic23-huawei>
	 <aXMtnCnTXq96efmH@smile.fi.intel.com>
	 <20260123095417.31b11fd6@jic23-huawei>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-23 at 09:54 +0000, Jonathan Cameron wrote:
> On Fri, 23 Jan 2026 10:13:16 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
> > On Thu, Jan 22, 2026 at 07:53:13PM +0000, Jonathan Cameron wrote:
> > > On Mon, 19 Jan 2026 11:23:17 +0100
> > > Francesco Lavra <flavra@baylibre.com> wrote:
> > > =C2=A0=20
> > > > In order to minimize the time required for transferring FIFO data
> > > > from the
> > > > sensor to the host machine, perform the read from the FIFO in a
> > > > single call
> > > > to regmap_bulk_read().=C2=A0=20
> >=20
> > > It's a call to regmap_noinc_read()=C2=A0 not regmap_bulk_read()
> > > I'll fix it.=C2=A0=20
> >=20
> > This is interesting, does it mean the patch was never tested on the
> > real HW?

The driver has been tested (by me) on real hardware, both before and after
this patch.

> > Or maybe noninc is intentional?
> >=20
> It's absolutely intentional.=C2=A0 The device presents a single register
> address
> that has the fifo behind it (which is what we added noinc for years ago).
> So patch should definitely work.=C2=A0 Goes from reading that register N =
times
> in
> each call within a loop of M to reading it N x M.
>=20
> If regcache is in use this makes a difference as avoids corrupting
> registers
> after this point as the address increment expected in the hardware for
> a bulk read doesn't happen.=C2=A0 Without regcache it's just "documentati=
on"
> as
> at least for protocols used here its the same as a bulk read on the bus.
>=20
> So patch is fine, it just mentioned the wrong call in the description
> I'd guess this is because someone is working with a tree that has the
> wrong call in
> it but might be wrong.

I have this patch applied also to older kernel versions where
regmap_noinc_read() doesn't exist, so this is just a copy-paste error in
the commit message. Sorry about that.
