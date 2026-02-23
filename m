Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8834D4DE
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836023; cv=pass; b=SRdBGknpm/dK2TcplrLM8h4FX+vvYAKPIBTtmqbXu2Sf9qd7z982WYHIstKy5WMSix3DtMWP/adPlfnA3f6LbG9u8FmFA8gug7/1/zRIsq4zY7Yj3Qgkvo2VLDHFfUV+LsvrMiu/QMCIXvLzceJbiW36RolzZDatc1sSeE6nvug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836023; c=relaxed/simple;
	bh=msvXvD9vEVbfHJYNoQCFj7m522i9hYbLGsmY8TSHNCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvxAzmeQi8yPfE7f3ZAPuP3etax3B62u9xTY+Wx6aCwZN3kytiygQcFqcNwcJJcHqEWf7AV0om6XgwSEzoxnjV95cu/JXka97tgDY7jL5memrrPwIXEpb6bopAoeuy+rzNIHkYdrhRAMXliDFfrnDnt9u9xL1qIRJU0FBsWUSeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvm2BP1w; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvm2BP1w"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649ddc91c05so548486d50.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 00:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771836021; cv=none;
        d=google.com; s=arc-20240605;
        b=kgpCTM5hEIuM8d8/h2fmATXR22n72lj8qeKnRUGj5baOyOd0N3P5QEFUOBRri/9M4h
         LUGy6J8h71VmCG7/6+Ufyo1V2wxq33k61xdOYXFv4cZwBG9ipx7za3wDm4xtWL2SFikr
         1ACrz4UWAfKxQZHRxd1DUuYus8JCxXSNaV1Npg304WBcFmu3v2Xxc2zAsxu5ChNQUeCZ
         CTwLb9vXN6nEYERpCBaqWRn3AOPR7VTWIsOjAp1jsu4CTElRcfKFVG79o3K/ZwJI280V
         nf0bLZEEmi2FrR3odiJBr/VqSYcEqzaF1gc694el1r/S0y2oTNB7lxq7ySOWc/F2Qp4H
         2BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=msvXvD9vEVbfHJYNoQCFj7m522i9hYbLGsmY8TSHNCE=;
        fh=TJOzYdwEAA3euaBex7OVVOwONTga2OMLtOHl5Dl9KZc=;
        b=Lw0sYNnz8h/tZ1Q3mqVLkoMRPVNMOajUlekSKoxJyz2J4EWV17W4ZsTynuTxLKRG9c
         XmkxHZK1pRCfZVOIhY7CFsDVOSqQN+zsheJZlW1JVpP5KBw+Vjj9BxOucBo/wyjLzwvl
         g+SX/6L9JpO4TDoYWH918iwKnsQPUE/EDSHokB+tCywI0WHX6N2LlVzi60Bp4CuLVP1I
         /bKu/nyOY3oOPTkFfm8/q316owjwEeFRgoCYx3KDfgNNecEJtyrRta2VFWizogm+D57c
         nDr9i8E/vcmvPETlNF9J+Hd9OSrFXrYWlbzrXDr8qeLdE9cJT1Hqd2Y84qUNZ3EDdRB5
         DuFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836021; x=1772440821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msvXvD9vEVbfHJYNoQCFj7m522i9hYbLGsmY8TSHNCE=;
        b=Xvm2BP1wnnWeJh4Pbrn6IPHnYyqB4gZkP2shw0tF0+NT6/4Ws7dXiL78PLngQiu4Xy
         3CkeAWk409CetRZHujL7y6c+w3tQkjTpmjxgQC4yWUzEmtDfFwsslIF1UnmveCLq/4ss
         XVZIDPJhG83DZQV64U1If/tOKtYiv+BawV8mPfdnTk4Onvi4G9KMVlZW4f6OUWBWaNz1
         PMWepnVju/sDGZkhYmsDtP6ZDkDRb3REngKcQfwrLuWYsyYR9DubIz9EfT4h/oNPH0gw
         RfVFqXEYD2YKjYNBFu/NAAH1OVGwvRGoBzKsewbgKrGpFCg0p4BUEzDT2ogom+4Xrmd0
         FHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836021; x=1772440821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=msvXvD9vEVbfHJYNoQCFj7m522i9hYbLGsmY8TSHNCE=;
        b=V608IZjBDqGVhsVHJAtA91hNhur52UoLonAAODa42up9K82xpD0lqcOpuCPMGfn/zI
         eODz3Da9EC5KoWRuL6/J4mZlRkaqKesDJCVoxd+wqMRJY92zEsSt1DIA5psqsgFwGYEb
         YkkEG4meaCMuYDplpRzYw0Qtv+zk6zMrmmOs6SikzMC9tQmhFHk9cfMsdxEHCFpu0pcA
         8J6yMNGAHuWS/c/o8zK2/lCXE/F3vc6fbdTsgMdKSAKA+0cM0tco2GLgy+y2ouqnSyyW
         GQZZVbRw3Cz4ZGEWiUCVF3ulNwyWeiJcp84ggGcMEEMRUUr8NDbekcOWFpyWS2+iUsc4
         w0aw==
X-Forwarded-Encrypted: i=1; AJvYcCVuSgk6GR/G2qxrZFkTXSiuxUH2PXd6ezXH1rVeRvMQK9ZtNVU/ru5FrI8n7Gin/1q8a8je6xep/oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gv5J88j7geS6c8izp85g5fI8Li6eGu7ipUF2ZsLkXMb5imz8
	llpb8sESHkc11ZtK4L1wfvY6Q/EnZ92StJTBFzmQXwYFWCnC4M15NnfPNb0h4W9baHTgYAU3PQa
	o7+lYfscV9RlsAlz56E5TpWGm/Fld76Y=
X-Gm-Gg: ATEYQzyq9IrVD1v48UNxk1dz4W0h73U+Sxy8Fn18RioNkmOs3zsb0T+5iVsguPQXlI4
	uEn6GFB6ODuJnVGniWvl8MNjQM1h14bo3pH/aWJWOaZ51vgcKvFDkSYW5Kna0IWGzWavA3MfCkz
	njuFyYVW5B+JQsn06Tq6J+7uMl8BZ3x8IPF9CVl65OVeixHeY0RQPx4sPVK+1lkNS/9LeignLeB
	0EKK9YS25sN8ciWfIvJxvp4vnGASqN+R03arMN0CoqA0rsneu4Rl2LdDa1rd9rLufX72ulYa6UO
	2C4rIADA3YfRzG9iZ2lR07eLcnMtIYFoqB65CP2AXui6Wiu+23iq0e9UZpf+BHJvd34EhtxhUgp
	A5tB2bVKQ6Sv3D9WBFfhcXg==
X-Received: by 2002:a53:ecd9:0:b0:64a:ce9a:acd6 with SMTP id
 956f58d0204a3-64c78e377e7mr4653537d50.4.1771836021322; Mon, 23 Feb 2026
 00:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223082359.46403-2-giorgitchankvetadze1997@gmail.com> <aZwQszq2o4MlXpOS@smile.fi.intel.com>
In-Reply-To: <aZwQszq2o4MlXpOS@smile.fi.intel.com>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Mon, 23 Feb 2026 12:40:10 +0400
X-Gm-Features: AaiRm50tYad8YggrYbnO90IgnECipThY_sy9bELtl4XfhJdx96BShUn7f9Sq09w
Message-ID: <CAE7dp2oVSDKM2FArSfLtjjUTBm1RPWQNXrsvOgDNvg9G+URogQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7173: move opening brace to a separate line
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 12:24:00PM +0400, Giorgi Tchankvetadze wrote:
> > Place the opening brace of ad7173_calc_openwire_thrsh_raw() on its own
> > line to comply with the kernel coding style for function definitions.
> > Issue found by checkpatch.
>
> Is it the only problem like this in the entire driver?
> If so, feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks for the review, Andy. Yes, it is the only instance of this
issue in the driver. I verified with checkpatch and a manual grep for
function definitions with opening braces on the same line.

Giorgi
