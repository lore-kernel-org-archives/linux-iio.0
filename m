Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F02D978C;
	Thu, 28 May 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984559; cv=none; b=X/T+913PkI763446M+S1EsMLF813t3e3VmDmpDD7sATzlCt9W45u/zWWTKlxfxLnuYUcBFaXA+2dTqoYjP6q6Niur58837HgZLiBDkhnGt4S8aSggYCIFbeG4qrY7mwg07TmDa1l9jFrGuXj2Ev5lmGcF6ROgvGC42upb08KI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984559; c=relaxed/simple;
	bh=IxrPXoH658SkckVnIbCopKCcHDO2FFhETPHCFvamvZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MN7PNMtdswgY3qbDoe6DAgIB5Uwu1JlxOyneVikDpX7haCcLhNUi5Ot3KIOwYViTuw8pU60MD91i1GHJajPuT2ZY1kdaJ+5FYnBmuS6Gl5zDTSm0gc0yzqVnJSxLE3nUbZpjNK4aq47BG+uT0j1I+DWw/TUpMFJICBplZrB6baE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwmogFoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwmogFoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33AB1F00A3C;
	Thu, 28 May 2026 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984558;
	bh=1UBki7NxZx2yc6MnQd7B8u3erCUZ5o67B7ZH6oHnupo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DwmogFoTgW0aSLmxzdEMrq83+w+/KF9vpE0KyqZI3OoHg8fE5EcGHpVgCQ0/7VHc6
	 NNLVWyy1Z2L7b5ZELi7iqeC6cOjsTmdKWtj2KqNivvknyMwtsEmvyM+Kx/kQsPal8Y
	 DgT469G0uR6aOBvJy+6wY8ifnFgw8tQ7SZdsojeTVBFnNcIOanB79pAi2cbAbGvsjo
	 PVzDfor3/ofjtK7RkyknJzHlR1IJOb8BfYDcP1AFqFhnd+NWlP0melTbiHrIiHBTPX
	 dMiMxT/qj7VGhCFuOB+AQj/cpXdzUGho0IGpCMcheYT4BcfVjdxSY6sXZcaVV2OhWo
	 76I2ybTVg7m9Q==
Date: Thu, 28 May 2026 17:09:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Subject: Re: [RFC PATCH v3 4/4] iio: position: as5600: add Kconfig and
 Makefile entries
Message-ID: <20260528170910.3b513fa7@jic23-huawei>
In-Reply-To: <20260524132824.54918-5-muchamadcoirulanwar@gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-5-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 20:28:23 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Add build system integration for the AS5600 Rust IIO driver.
> CONFIG_AS5600 depends on I2C, IIO, and RUST.
> 
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Combine with the driver patch.  Separate patches for build files
provide no value.

> ---
>  drivers/iio/position/Kconfig  | 14 ++++++++++++++
>  drivers/iio/position/Makefile |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> index 1576a6380b53..dab9310e8079 100644
> --- a/drivers/iio/position/Kconfig
> +++ b/drivers/iio/position/Kconfig
> @@ -6,6 +6,20 @@
>  
>  menu "Linear and angular position sensors"
>  
> +config AS5600
> +	tristate "ams AS5600 magnetic rotary position sensor"
> +	depends on I2C && RUST
> +	help
> +	  Say Y here to build support for the ams AS5600 12-bit
> +	  magnetic rotary position sensor with IIO channel support
> +	  (in_angl_raw and in_angl_scale).
> +
> +	  This is a Rust driver that exposes the 12-bit raw angle
> +	  and radian scale via the IIO subsystem.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called as5600.
> +
>  config IQS624_POS
>  	tristate "Azoteq IQS624/625 angular position sensors"
>  	depends on MFD_IQS62X || COMPILE_TEST
> diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> index d70902f2979d..2d26f6d6ace3 100644
> --- a/drivers/iio/position/Makefile
> +++ b/drivers/iio/position/Makefile
> @@ -4,5 +4,6 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  
> +obj-$(CONFIG_AS5600) += as5600.o
>  obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
>  obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o

