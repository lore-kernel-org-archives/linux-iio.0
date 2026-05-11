Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D53E557E;
	Mon, 11 May 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507527; cv=none; b=Df9BHVeC+FRo/N8yCqWQJHsrZsCVcNHEkpE1y82pmACUaOn77Zpp3szRRZMML0Zl5XU8RtmWnPM5d8YwY7OpkhDxDsiOLeNfPXJyUMRuNrGL/xZK5u7dlL0iyfeP1U1xr/396Z4jTPcOSyadsidUmBe4VpzlGc68/w5JBqXaCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507527; c=relaxed/simple;
	bh=3MOLGGAjZMaGDJ4KO3ibP0i185lRfKS/csYyWZqaOgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATNk49Bhfpaz06HGlsrbQ7MaYZ/ZcK4b1iVkpdnJbF1rgEIe3wLAaQGd1wqezwGLetO8SZ2UK58x59ynPFa65aYiucD+MGQAJr/Zszie6kHMsKYWOCT4WLaRzY2kiFPtHOgzRYF5dh+MkFticf40YofAl2AOKE7V8U3UN6RSr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6CILY03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6CILY03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CD6C2BCB0;
	Mon, 11 May 2026 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507527;
	bh=3MOLGGAjZMaGDJ4KO3ibP0i185lRfKS/csYyWZqaOgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I6CILY03WXAENXWM2QJ14ZqUGhZmpnAOOppPJtrBNFS+UUteycF8YGsMO0UpUo4po
	 IFhP6tIcwLN+FXBV9N57JSJZw5d9MUT/fIXW9kB8eabyod785vMRTVa8sNKuQID7FA
	 gudLKO/5lQZNXluTGDN6usphCpRbzFVbraRdlX3160BlC5FaWgQiob60TgAgiamm5i
	 bUwkPsXmSbXdoHjDBGm/ea1x96dcKaMSQKKIueKbpaz3sJ1yk6jsnu4JgE+2xbbya4
	 bxbh0q9HX//+LVGlQbS8NmqVvhaMrcVBHga509WIGMNiDvyY4Q4CGZDLusI2+cd6fI
	 AolW5zVrgIkbw==
Date: Mon, 11 May 2026 14:51:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <20260511145158.1252ef87@jic23-huawei>
In-Reply-To: <20260510191010.155380-1-nikhilgtr@gmail.com>
References: <20260510191010.155380-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 00:40:08 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Hi,

Hi Nikhil.
Thanks for your driver

Before I look at it, a quick comment on use of RFC.
Generally we only use that for drivers that either have a series
of specific open questions (driver structure doesn't count for IIO
as we have a 'lot' of examples!) and those questions should be
at the top of the RFC.

The other exception is where you know something is not ready for merge
due to some dependency or similar on other code.  Occasionally done
as a quick hint on how we might solve a problem that is raised.

Anyhow, just send this without RFC.   You'll get comments anyway!
Probably more of them as many reviewers are short on time so will
only briefly glance an an RFC if at all!

Jonathan

> 
> This series adds initial Industrial I/O subsystem support for the
> Melexis MLX90393 3-axis magnetometer and temperature sensor.
> 
> The MLX90393 supports both I2C and SPI interfaces. This RFC
> implements support for the I2C interface while keeping the driver
> structure transport-independent to simplify future SPI support.
> 
> Currently supported features:
> 
> raw magnetic field measurements for X/Y/Z axes
> raw temperature measurements
> configurable gain/scale selection
> configurable oversampling ratio
> direct mode operation through the IIO subsystem
> initially I2C support for this driver
> 
> The driver has been tested on Raspberry Pi 5 hardware using an
> actual MLX90393 sensor connected over I2C. Raw magnetic field and
> temperature values were verified through the IIO sysfs interface.
> 
> A custom transport abstraction was used instead of regmap due to
> the MLX90393 command/response protocol semantics and repeated-start
> transfer behavior. This approach was discussed previously on the
> mailing list and seemed preferable for this device.
> Link: https://lore.kernel.org/linux-iio/20260424114818.1290b029@jic23-huawei/
> 
> The implementation intentionally focuses on a minimal and reviewable
> feature set for the initial RFC submission. Support for SPI,
> buffered capture, triggers, interrupts and runtime PM can be added
> incrementally in follow-up work.
> 
> The DT binding schema has been validated using dt_binding_check and
> the driver has been checked using checkpatch.pl --strict.
> 
> Feedback on the overall driver structure, transport abstraction,
> IIO ABI usage and DT binding would be appreciated.
> 
> Thanks,
> Nikhil Gautam
> 
> Nikhil Gautam (2):
>   dt-bindings: iio: magnetometer: add Melexis MLX90393
>   iio: magnetometer: add support for Melexis MLX90393
> 
>  .../iio/magnetometer/melexis,mlx90393.yaml    |  39 +
>  drivers/iio/magnetometer/Kconfig              |  10 +
>  drivers/iio/magnetometer/Makefile             |   2 +
>  drivers/iio/magnetometer/mlx90393.h           |  76 ++
>  drivers/iio/magnetometer/mlx90393_core.c      | 724 ++++++++++++++++++
>  drivers/iio/magnetometer/mlx90393_i2c.c       |  71 ++
>  6 files changed, 922 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
>  create mode 100644 drivers/iio/magnetometer/mlx90393.h
>  create mode 100644 drivers/iio/magnetometer/mlx90393_core.c
>  create mode 100644 drivers/iio/magnetometer/mlx90393_i2c.c
> 

