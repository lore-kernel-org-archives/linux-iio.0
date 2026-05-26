Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D23AEF50;
	Tue, 26 May 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811946; cv=none; b=A9aUqsuE6bkV188Nv2og4IwY23QciTtSs257pafpQ9XzkzYrOJ+9is8m2bncVkyLVxqpQhe8Q67pgirq25TAi41MFraka8CPu+aNQfRhFT5IHzNWh3BkExOOnLv162dmyalzMBmKEsPjvT2JhriC1Avc+udOKE/5vMTE3aOI6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811946; c=relaxed/simple;
	bh=RAZDgZybTsxV7F0Fross356NGYm/d8B+Zj5caDvivuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FERTMQjA8bntM0jSj/3kT98dGd1QdWUvBPznWBS0lWJ7gWJnzyDFTIng0tug1qRnTSFJOi+wyW4dHLzx5055T9RtUs4ujJEP2GuWoZIf8QgQHLR4VKmRxhU78jGSPVELfAUUzWlwe7QvUAsFY22GB+/Vz8F5xcKAzeF+SLndMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB6TzzYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB6TzzYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692D31F000E9;
	Tue, 26 May 2026 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811944;
	bh=gSSDYSlqPHqTPBhZPOHsll15IHiisRmIKULXHcoesic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mB6TzzYPdwv7njp0DHvXxZR5nf892jtYd3JhFGUBVzT2vB1vWaBngvhSRxoSLtHkd
	 pUDjdbdELzmTUeNglmsPEgejB45f1htzfJgNV5NF8WHjxYcesqHfyYcNZv70WjpkuV
	 02XG3aqcXdpCH6n3ckQ+5JF/5y0u3ez2of+fo88uDKp5bkoxs/GMgETbl3+7PqCchF
	 dgkJ9p9PgDF1dcsZkrAiiJRnLmDzPJJ4RMLgdV913KWFmQhhH632qsKVvQuhvEbp2M
	 KJ7N80oUn0kX3KZDGIIf+kB81SVqBd6i0r2LoQMEItA9JI6PKU4pqq+xHO+l7ej78B
	 +HSo/oSviGK4g==
Date: Tue, 26 May 2026 17:12:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] iio: add Sensirion SLF3x liquid flow sensor
 support
Message-ID: <20260526171214.750c2e25@jic23-huawei>
In-Reply-To: <20260524205112.26638-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 22:49:35 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> From: Wadim Mueller <wadim.mueller@cmblu.de>
> 
> Hi all,
> 
> this RFC adds support for the Sensirion SLF3x family of liquid-flow
> sensors (SLF3S-0600F and SLF3S-4000B).  Before I send it as a normal
> patch I'd like to ask three things:
> 
> 1. Subsystem.  Liquid-flow sensors don't seem to have a home in
>    mainline yet.  iio/ feels like the natural place for me, but
>    please correct me if hwmon (or somewhere else) is prefered.

I'm fine with this type of sensor in IIO, but open to hear from others!

> 
> 2. Channel type.  IIO has no flow channel type so far.  The series
>    adds IIO_VOLUMEFLOW with _scale in litres per second per LSB,
>    so drivers reporting smaller units only need a fractional scale.
>    IIO_MASSFLOW (for gas-flow sensors) was left out on purpose --
>    happy to add it in the same series if that's more usefull.

Would be good to have a little more detail on difference etc to have
that discussion.  Superficially I'm assuming this is a compressible vs
non compressible thing?

> 
> 3. Subdirectory.  I put the driver in a new drivers/iio/flow/
>    since there is no flow subsytem in iio yet.  If colocating with
>    drivers/iio/pressure/ (next to sdp500) is preferred I'll respin.

This is easy to change later if we make a wrong decision. For now I think
iio/flow is fine.

Thanks

Jonathan


> 
> Patches:
> 
>   1/4  iio: types: add IIO_VOLUMEFLOW channel type
>   2/4  dt-bindings: iio: flow: add sensirion,slf3s binding
>   3/4  iio: flow: add Sensirion SLF3x driver
>   4/4  MAINTAINERS: add entry
> 
> Tested with a SLF3S-0600F on a TI AM64x platform.
> 
> Thanks,
> Wadim
> 
> Wadim Mueller (4):
>   iio: types: add IIO_VOLUMEFLOW channel type
>   dt-bindings: iio: flow: add Sensirion SLF3x liquid flow sensor
>   iio: flow: add Sensirion SLF3x liquid flow sensor driver
>   MAINTAINERS: add entry for Sensirion SLF3x flow sensor driver
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  17 ++
>  .../bindings/iio/flow/sensirion,slf3s.yaml    |  49 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/Kconfig                           |   1 +
>  drivers/iio/Makefile                          |   1 +
>  drivers/iio/flow/Kconfig                      |  22 ++
>  drivers/iio/flow/Makefile                     |   7 +
>  drivers/iio/flow/slf3x.c                      | 264 ++++++++++++++++++
>  drivers/iio/industrialio-core.c               |   1 +
>  include/uapi/linux/iio/types.h                |   1 +
>  tools/iio/iio_event_monitor.c                 |   2 +
>  11 files changed, 372 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
>  create mode 100644 drivers/iio/flow/Kconfig
>  create mode 100644 drivers/iio/flow/Makefile
>  create mode 100644 drivers/iio/flow/slf3x.c
> 
> 
> base-commit: 3cd8b194bf3428dfa53120fee47e827a7c495815

