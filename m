Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECC3290A9
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502079; cv=none; b=fnkWLFss81RMb3lfqnbrnP8f48t/uuUnvAg3KcRmRS6hUfkpmDV7YxczYxm+WfJfz5uq++xDIs4Hd55qdoB/XH0mdmSnSnnJuYtlN2gbq7B5CqaP5xbunYRr0ymNbfCLQFeEEJ/5qnAjVRTsw2Wb9HBvLnIPVkUn8zL1OBHYI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502079; c=relaxed/simple;
	bh=IgXwTtAGGSh+9hwv9Hf7xQrK8lqm1+gizPiM9/I1ezU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFA++LHn17aK8a+3kelNPvOyFqLT30TxvQtuXDHNxD4ga2LRvrIHU61l5oxCnGfKDojF7mgb5TUW5QwsFq45e+pxBKx6EOhJb3A1wzMlTx7M1/mrTHW1lQ7CfYvhROteY91+g9/+ceMxCDgaN0LcGyOwaNA9VrmyDKtw5h38JaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyhddBQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyhddBQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E6C2BCB0;
	Mon, 11 May 2026 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778502079;
	bh=IgXwTtAGGSh+9hwv9Hf7xQrK8lqm1+gizPiM9/I1ezU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eyhddBQ1LP6+f0/E/2CeVmITyvxksm0CQT8EwRmeIWEcnMfV3t1cBfVYyLULdzrZb
	 D9E9jn6HykKQGLwcawBSz05AjudPeBJsJ8B5M3RhAySzJz+5Na+dsCSjpvqzapWvX1
	 g0ekmNK//t8FbBod/l+BWOZWuXEgQXxzp3wgLqdcQG5EM02JDn6JaHqP6VAjcHwGvj
	 VaQG+0tuW0KGrTctQRfwDjBUCi9bVAgHws8abLFw3lwKyLa/fMFORFxAHYTl/otTeF
	 1ULh1p89k1XzpGaU+PWbhZc44Dw6/p4u1xvzVLskjCEfOz2T5Z3J59bQGghxu3001j
	 fNR0PEfhkNQsg==
Date: Mon, 11 May 2026 13:21:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 0/4] iio: light: add driver for Broadcom APDS9999
Message-ID: <20260511132112.66246dc8@jic23-huawei>
In-Reply-To: <cover.1778491503.git.azpijr@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 12:14:42 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> This series adds support for the Broadcom APDS9999 ambient light
> sensor. The APDS9999 is a digital proximity and RGB sensor with
> ALS capability, featuring I2C interface, programmable gain and
> integration time.
> 
> This chip is considered by Broadcom to be the 'successor' to the
> APDS-9960 which has technically been discontinued.
> 
> The initial driver implements the ALS/Lux functionality using the
> green channel, which approximates the human eye spectral response.

That's not normally a good approximation unless it is also has
very bad colour curves for green!  Better than any other channel
on it's own but still not good. If we had calibrated sRGB it would be:

 Something like: 0.2126R+0.7152G+0.0722B
for example.

The lux vs white light and lux vs incandecent light are fairly linear
so 'maybe' it's good enough but it's a bit of a stretch to describe it
as an illuminance measure which is what we'd need for it to be measured
in lux.

So I'm on the fence at the moment.  We might be better off teaching userspace
code to do it's own approximation if it has an RGB sensor.

Jonathan

> 
> Sent as RFC to gather feedback on the driver structure
> and DT binding.
> 
> Jose A. Perez de Azpillaga (4):
>   dt-bindings: iio: light: add DT binding for Broadcom APDS9999
>   iio: light: add support for APDS9999 sensor
>   iio: light: add build support for APDS9999
>   MAINTAINERS: add myself as APDS9999 maintainer
> 
>  .../bindings/iio/light/brcm,apds9999.yaml     |  33 ++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/light/Kconfig                     |  10 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/iio/light/apds9999.c                  | 325 ++++++++++++++++++
>  5 files changed, 376 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
>  create mode 100644 drivers/iio/light/apds9999.c
> 

