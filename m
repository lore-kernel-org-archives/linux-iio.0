Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9171B86C7;
	Sat, 21 Mar 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107049; cv=none; b=JyHXS1NVqSD1d8q+lwtLcTwl8BhyKTFJVr10pM81MHo2cPGrC5yJkbduRpf3gOUxFuxWZGUmv2i2KZLtTYdO2BjzZf6hrbW5iZHnkR5bSC9AW10ZheICFfx5oe2cxR2LODfFaj+WopzQkMpIFrWExqBTBduzpm3Af2oBJ0exASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107049; c=relaxed/simple;
	bh=piV2Fg42vYqtFS9ibkzMbE3g0iCeOEJCg9GsYcozZw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PA6zK+XwNACd5lU1g5Z2eK/zZgg9WqZY1j8w9DZWYjNMH4qyJcDRLOAFmjHxeJ1zxCQTmNwAjMyBq4ULzuv6lQnWC1twUklEZqMauSD7LRZWNcCR8kL7txpGAYZwG+dm/fjZgziX+Ll3rwDgEpuV7WLJF69ldAoI2FFZ+FLf0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPXkcpsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPXkcpsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB821C19421;
	Sat, 21 Mar 2026 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774107048;
	bh=piV2Fg42vYqtFS9ibkzMbE3g0iCeOEJCg9GsYcozZw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPXkcpsDoqiZcU/hxEh4ulzd9ZeXlZ9G1laHeedXtr4mpd8dJhhHtBaAhXKDedgHV
	 4FR5jyHRaJYVG52kq+cX9a+bV/2YvPlXhmZKfyPgHkgfNCW1SQAtXSqKfg8JxZQany
	 X9n2nKUghnuNOzlITNAUSd8dNwb6X7h+Lx6yqP3F+nO22PRTHXVXxRE3OEhLo0iBSp
	 DX0Boq4lxenQoM0SmL2CspUSsHFBRKH8VWJIuvmn/GHiOQuhw27blzs7o+tl/jljSL
	 erJ2BwGT9pdphbmXSlXxha3szSvVO5ViHzTGM3t+SGR3sQe0P6Lv8qvo4AS4LPHgY+
	 CIykHHflXbDpw==
Date: Sat, 21 Mar 2026 15:30:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David =?UTF-8?B?TWFyaW5vdmnEhw==?= <david.marinovic@pupin.rs>
Cc: andriy.shevchenko@intel.com, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: dac: ltc2632: add support for LTC2654 DAC
 family
Message-ID: <20260321153040.2494aa9c@jic23-huawei>
In-Reply-To: <20260320150957.105571-1-david.marinovic@pupin.rs>
References: <20260318135736.91564-1-david.marinovic@pupin.rs>
	<20260320150957.105571-1-david.marinovic@pupin.rs>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Mar 2026 16:09:45 +0100
David Marinovi=C4=87 <david.marinovic@pupin.rs> wrote:

> From: David Marinovic <david.marinovic@pupin.rs>
>=20
> Greetings!
>=20
> This is v3 of the LTC2654 DAC support patch series.
>=20
> The LTC2654 is a quad-channel, 16-/12-bit DAC with internal
> reference voltage and SPI interface, sharing the same 24-bit
> SPI protocol as the LTC2632/2634/2636 family.
>=20
> The LTC2654L-16 variant was tested on a Phytec phyCORE-STM32MP1
> board with the DAC connected via SPI1. The driver probes successfully
> and all 4 channels are accessible via IIO sysfs.
>=20
Process comment.  Don't send new versions in reply to a previous one.
It leads to them being well back in people's email history (depending
on the client and how it gets sorted) and leads to hard to read threads.

Convention is new version, new email thread.

Thanks,

Jonathan

> Changes in v3:
> - Patch 1 unchanged
> - DT bindings use fallback compatibles for LTC2654-L12 and
>   LTC2654-H12, which are register-compatible with LTC2634-L12
>   and LTC2634-H12
> - LTC2654-L16 and LTC2654-H16 keep separate compatible strings
>   as no existing compatible supports 16-bit resolution
> - 12-bit variants reuse existing LTC2634 chip_info structures,
>   so only two new chip_info structures are added for 16-bit variants
>=20
>=20
> David Marinovic (3):
>   iio: dac: ltc2632: drop enum and use individual chip_info objects
>   dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings
>   iio: dac: ltc2632: add support for LTC2654 DAC family
>=20
>  .../bindings/iio/dac/lltc,ltc2632.yaml        |  12 +-
>  drivers/iio/dac/ltc2632.c                     | 367 +++++++++---------
>  2 files changed, 188 insertions(+), 191 deletions(-)
>=20

