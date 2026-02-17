Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFCC4C6C
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336228; cv=none; b=D9pU4nDspcMSuByZqX5q4v17OMPMRDVH6Nc2eRXjiwjWMu+uysZt3uPPW/82QEExZC6YcKXdi1SSt9hXh3gUQm5EUt7VZp1k0ukhGRzZBHjhoykK15XVgAuf3R3Vbttg7yQ/aE9KpA72XaOGhySqp+c6/5Q9dZigQT3O1u+RYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336228; c=relaxed/simple;
	bh=KqWSYmoe1gwHCzwLn/Y/QlhXGc4KV4LVs+VRcOcr0d8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmMqEqMCgf4cBHNocQXSCcwPENdn86RBfHBPFZJEuSIdCXEcPjXjq3YQESML8GgVYRCBpHJUA86deZJObDU5pNLbeaVadeMnfyX6I4rJqfg8tto1EKqa4/y4vJJ8NW6j7KhuRhAnqQo5IQ2bIV9xaujwg5sRGG/q+BG7lo+CG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3OH7bjr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3OH7bjr"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43770c94dfaso5004979f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771336226; x=1771941026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KqWSYmoe1gwHCzwLn/Y/QlhXGc4KV4LVs+VRcOcr0d8=;
        b=D3OH7bjrPZBzeu4HBh8HKwcm56qPFA3PElGejON2ZONYS9PJSTLdkMZrPISg8WvEV3
         fUqxy0uiG/X6sLt1sIXB6yCMlCeYz0pkaCKUtBIWOD0usHAga/zASFFlZBHvOagzA200
         4tm8fTba/OGHqG8bKujqNdUVDJiPlU8KfCB7JvdsIm0jNXeSiUh49N3UVCBFZIvhxq3p
         26I8x5y5a6gV93Wlm8n4KUc3UYak3yINTOXhy2Wl4ufLISJLU7/iSd4TADXPYhbTWe66
         tes9t2DYSzDm0E0BDI1q/aqnlxkvsQdG3uFZ2+b0AR+AkUe8nbirGLidC1MWb9xaL+wX
         V2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771336226; x=1771941026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqWSYmoe1gwHCzwLn/Y/QlhXGc4KV4LVs+VRcOcr0d8=;
        b=dla60iyFI8QBLTAh4rvMUbdkiailMAFcu+xVCGVG5pqT9YAfJjA0mD09Gf53dmve4n
         EiVufM06yUmLXhhj4oJulm9am/fX6T4TFW2KF2sVg+TdPd39fhsbECLS6vrgJ8kTgWrh
         BkxmcxjRGAVPRPRUfHXnHzr8TLF5ueyZqUjlPcHOXEao0j4Mwz5+Fc8OylccBwQTEJCS
         gZgdZFqi+Umhnpk2EQno+Qf1FuxgSc1ssmLn4zou1XIBcK/MY0nn9Wc2jw+fcFddmCKh
         SSsDgfBvUSvEvSEoOd8tJNQ7gBL07/7RroFgXH/0/rCRLZObrvag/xUYhnJOeiQUS4wJ
         Dk2g==
X-Forwarded-Encrypted: i=1; AJvYcCXPktW+P77cb8ljy6Yu7ifJTDac0HcWRy7jdK3e0QdIdsQUaztwaUyQ5NGFM2/CP46hMCyEijlhCOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0V41iIp1eQjiSHRIqdUBu0D5WdwtZhTR4IT9d5g22kmd8AWe
	22sz7MmbTHx8ZRhryLFta9ZqNQBVM6dkOxwePbEq3/KigZXstrngAhAw
X-Gm-Gg: AZuq6aI8DidIcPtULji2jQ00j9hJBqwCxso8eu28GfuvAYQItVf2R5NbmlbRyRxv7JC
	H+fSHv7nMZCDBGjwsD0stMaVtAY5UnswrNhSoA/Z4Ic6H2jGIvsl8K96wgwrLy4uLyn7sfclKRh
	8yLwJc5U3gDm3NVjTkmwU4HhQa01Vd4T8nUmUCpXNoVZLaoAfwoVHk0LjQyvK1qPh8AZTDQDtps
	VMmNLGPLABk87Jk0bf85fX6EfyY+gueaHbeAe2ATuN7fDwZsd9V1hOR6fFk08XwCGn7sXsyylTH
	D4mJvZFcvO0Qx1NLOE4MQdPG5qSQdwalJ2qTclmHCQDfRuNTb+qcZO9bwflcEjvE1zfS55m4sTT
	0wkUyjVln0QKCCxpdOmkdBgD/kpr8I/093a/dnIrBZkiR8ShzDkIH9W93JpU7vXJJ8G0RGv9v8Q
	D4JsjJajnn6NWDq53spwdkzA5syamU698=
X-Received: by 2002:a05:6000:220d:b0:435:bd00:cb4 with SMTP id ffacd0b85a97d-437978dd6camr25877144f8f.23.1771336225517;
        Tue, 17 Feb 2026 05:50:25 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm28189227f8f.15.2026.02.17.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:50:25 -0800 (PST)
Message-ID: <96b05a514d229b23ea0917447607dd7390ec0e2e.camel@gmail.com>
Subject: Re: [PATCH v3] iio: trigger: use put_device() in
 viio_trigger_alloc() error path
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Salah Triki <salah.triki@gmail.com>, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 17 Feb 2026 13:51:08 +0000
In-Reply-To: <aZLZN6sD9H9dF8Np@pc>
References: <20260215222348.186806-1-salah.triki@gmail.com>
	 <aZLNX6Ifw68k-zu5@smile.fi.intel.com> <aZLZN6sD9H9dF8Np@pc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-16 at 09:45 +0100, Salah Triki wrote:
> Hi Andy,
>=20
> You are absolutely right. My previous version (v3) was logically flawed a=
s
> it could trigger the release callback before the necessary fields were
> initialized, leading to an unsafe irq_free_descs() call.
>=20
> Since I don't have the physical hardware to perform runtime injection
> tests,I relied on manual code path analysis and clearly failed to account
> for the side effects of put_device().
>=20
> I'm sending a v4 which takes the safer approach: moving
> device_initialize() after all potential failure points. This way, we can
> safely use kfree() and irq_free_descs() in the error path without
> involving the device lifecycle prematurely.
>=20
> Thank you for the catch.

Please just use the same approach Andy did for iio_device_alloc(). I posted=
 links (in one of your
versions) to that and for the discussion we already had on this same functi=
on some time ago.

- Nuno S=C3=A1
