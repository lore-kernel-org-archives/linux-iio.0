Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92142147F9;
	Sun, 20 Sep 2026 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864472; cv=none; b=t6Wz7E6TXiBeCkSv8+Ge9Er3EIbGzj9GIFBRAErG6/g8AtOnv4wuBV6fMCjgHGoDjkVxB0+Wjme2xV1QSOynL3iICzoQSEnyxe3wyNnoQ5vrGo/He6i4pvKC5UXmo9T1BZxX+8rzbQd8OWyEIaajhVSAZ9Dm41DcVJAVHbvukfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864472; c=relaxed/simple;
	bh=wD4u27ceSQgWQ46kv3MvqHiHiVme3nzUStrmHJR6BwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScAWykdbnE11prc/iMjmPgfH7iBJQgYueGBIUCOCSQ4/FgzaRXsg6leJDM4QMjlncTFk5uz8CENvYI3Z1IEtEqx1vvlSXVKMRqbyJVJ7ab6BF26+1xm5bzI/31zhwQhT1MQ0ZXUv1e4Jz/DmQMLX9uiXdzlvRhFHc5Z9B4DKkew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/0KmN4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/0KmN4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D361F000FF;
	Sun, 20 Sep 2026 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789864471;
	bh=hIQ02hcVmV7rgzgXxzImukq7uXYS54Gr3ip95fsB8/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N/0KmN4MgQUBgLIFtPHhnhCLk+N3i3292qea5jtghzgQywDb1+VMbumzXrBlLoWT2
	 OPeUBSsuiX5jgN2ksbP93943FIKdoPhThvEkRvhbsYYGonntM7KO65BMdbCkXhU0Sp
	 X+YSot/4Eqo5/T+PlPCGrs7LnUj0X/qF4JItNosg0e0CpNaMugZjtV+JJmrk/aKuN/
	 mVcfzp4s5MUveaCp43+r3/j+yX9AhODgYsTtn4eBzH/3JXXgkzo6XWgJbNPFoHPM3K
	 6h9W64DfqAh3rNJgthlkV2UPbcQQLPBEWicLqtqb8MeJhJ8dsqtwdNT8K/4JIAd5hj
	 U0NM7rf+tu1sg==
Date: Sun, 20 Sep 2026 01:34:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <20260920013427.492a2d10@jic23-hlaptop>
In-Reply-To: <20260919223854.13437-1-m.abubakar365@yahoo.com>
References: <20260919223854.13437-1-m.abubakar365.ref@yahoo.com>
	<20260919223854.13437-1-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 03:38:52 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> This series adds support for the Sensirion SDP31 differential pressure
> sensor, an I2C device that also reports temperature.
> 
> Patch 1 adds the device tree binding.
> Patch 2 adds the IIO driver, which exposes differential pressure and
> temperature channels and validates each measurement using the sensor's
> CRC-8 checksum.

Hi,

Given we have another sensirion pressure sensor supported already (the SDP500)
I'd expect a brief note here on why it doesn't make sense to add support to
that driver for this new part.  Also check other similar drivers as sometimes
we get compatible parts from multiple vendors.

FWIW the two parts don't look to be that similar so probably a very short note :)

Jonathan


> 
> The driver was developed and tested on an SDP31 wired to the I2C bus of
> a Raspberry Pi 4.
> 
> Muhammad Abu Bakar (2):
>   dt-bindings: iio: pressure: add Sensirion SDP31
>   iio: pressure: add Sensirion SDP31 driver
> 
>  .../iio/pressure/sensirion,sdp31.yaml         |  40 ++++
>  MAINTAINERS                                   |   6 +
>  drivers/iio/pressure/Kconfig                  |  11 +
>  drivers/iio/pressure/Makefile                 |   1 +
>  drivers/iio/pressure/sdp31.c                  | 194 ++++++++++++++++++
>  5 files changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
>  create mode 100644 drivers/iio/pressure/sdp31.c
> 

