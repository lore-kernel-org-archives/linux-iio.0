Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8B3A63EF;
	Mon,  4 May 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911906; cv=none; b=iMbv7aYQzTR/zpU7Wz+fPdqPdieJs1SvPA3W/TYEsKSryfunTXjHtqhm9UHlifWCnsLxYJpRbuS6U4GY8ETaYy+jAhUF0cCTVLqKDqebGyOn9AbGi6qQeAa+u63YetelNVGE9RPUKpu5uShgpxcCZqKMFLsnhzkVdfI7J/Cuu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911906; c=relaxed/simple;
	bh=1xH2x8mzzNZiyi36nrGRtA9DlaOn1UAhaFFIxv4IEJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4d5wXqrDHdSWWzpeAqhnTnHYnx6/8zPWgYIJaUDj1s2rx8+IoyGDckRtPjSRFQrh+zGMqWQR9hOEV4GiA7QZqyNXKm1krmILjn3RhnIWwRADr+zbXWjeXd5nKLNXr/OaTZnQncWQ5wFugUvi7rWWKh0lTPYgD6us5HpuftLaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbS5Y4pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbS5Y4pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A510C2BCB8;
	Mon,  4 May 2026 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777911906;
	bh=1xH2x8mzzNZiyi36nrGRtA9DlaOn1UAhaFFIxv4IEJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LbS5Y4pfaJxTh3JILr+/B0k89eelLk8CFMmWWjW8/C4fsVYc24NAcI0WseLlXu3Oa
	 tSoFmpbGWjr0H+Waw30GRwXgl6Dp4OGAX7aog4FGv38eVfSkIDNRvxqARhYbxQY5TJ
	 5tkvh7xJOcXaAvQscZDgyzBg0C16dlc8v4J/dcU/lrxIl7Ops+CNZS+ji0aK2fqGU4
	 6HxuwNyymTbebPg28RSKL0MwWin9wukWJS2WqjxUMBmtm2TcBv56MlJsZOU+irOHlp
	 38mZrNWOcmj7JKfXvh6FW3zW4yiHxSul2gaW67JPmi9O4mfANuHX/BuOBvZHEwGNfu
	 99GA36gmmgtQw==
Date: Mon, 4 May 2026 17:24:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, lars@metafoo.de,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
Message-ID: <20260504172457.4d7c7390@jic23-huawei>
In-Reply-To: <20260430190642.3434650-3-sanjayembedded@gmail.com>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
	<20260430190642.3434650-3-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  1 May 2026 00:36:39 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> Remove redundant per-driver entries already covered by wildcard paths
> under ANALOG DEVICES INC IIO DRIVERS for drivers/iio/adc/ad* drivers.
>=20
> Keep entries where specific maintainers exist.

This seems to be where it's gone wrong - if this were followed
I'd be fine with it.  Actually also applies where there is
a specific reviewer listed - not sure we have any where there
isn't also a maintainer though.

>=20
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Substantial enough change from anything that I think Nuno would
have tagged that you should have dropped his Acked-by:

> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  MAINTAINERS | 158 +---------------------------------------------------
>  1 file changed, 3 insertions(+), 155 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 34b67d010e87..bd14e15f04c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -451,17 +451,6 @@ W:	http://wiki.analog.com/AD7142
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/input/misc/ad714x.c
> =20
> -AD738X ADC DRIVER (AD7380/1/2/4)
> -M:	Michael Hennerich <michael.hennerich@analog.com>
> -M:	Nuno S=C3=A1 <nuno.sa@analog.com>
Specific maintainer. Why is it going?

> -R:	David Lechner <dlechner@baylibre.com>
> -S:	Supported
> -W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-ad=
c/ad738x
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> -F:	Documentation/iio/ad7380.rst
> -F:	drivers/iio/adc/ad7380.c
> -
>  AD7476 ADC DRIVER FOR VARIOUS SIMPLE 1-CHANNEL SPI ADCs
>  M:	Matti Vaittinen <mazziesaccount@gmail.com>
>  S:	Maintained
> @@ -481,16 +470,6 @@ W:	http://wiki.analog.com/AD7879
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/input/touchscreen/ad7879.c
> =20
> -AD7944 ADC DRIVER (AD7944/AD7985/AD7986)
> -M:	Michael Hennerich <michael.hennerich@analog.com>
> -M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> -R:	David Lechner <dlechner@baylibre.com>
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> -F:	Documentation/iio/ad7944.rst
> -F:	drivers/iio/adc/ad7944.c
> -
>  ADAFRUIT MINI I2C GAMEPAD
>  M:	Anshul Dalal <anshulusr@gmail.com>
>  L:	linux-input@vger.kernel.org
> @@ -1415,15 +1394,6 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,a=
d3552r.yaml
>  F:	Documentation/iio/ad3552r.rst
>  F:	drivers/iio/dac/ad3552r.c
> =20
> -ANALOG DEVICES INC AD4000 DRIVER
> -M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> -F:	Documentation/iio/ad4000.rst
> -F:	drivers/iio/adc/ad4000.c
> -
>  AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> @@ -1435,78 +1405,6 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,a=
d4030.yaml
>  F:	Documentation/iio/ad4030.rst
>  F:	drivers/iio/adc/ad4030.c
> =20
> -ANALOG DEVICES INC AD4062 DRIVER
> -M:	Jorge Marques <jorge.marques@analog.com>
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> -F:	Documentation/iio/ad4062.rst
> -F:	drivers/iio/adc/ad4062.c
> -
> -ANALOG DEVICES INC AD4080 DRIVER
> -M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> -F:	drivers/iio/adc/ad4080.c
> -
> -ANALOG DEVICES INC AD4130 DRIVER
> -M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> -F:	drivers/iio/adc/ad4130.c
> -
> -ANALOG DEVICES INC AD4134 DRIVER
> -M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> -F:	drivers/iio/adc/ad4134.c
> -
> -ANALOG DEVICES INC AD4170-4 DRIVER
> -M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
> -F:	drivers/iio/adc/ad4170-4.c
> -
> -ANALOG DEVICES INC AD4691 DRIVER
> -M:	Radu Sabau <radu.sabau@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> -F:	drivers/iio/adc/ad4691.c
> -F:	drivers/iio/adc/ad4691.rst
> -
> -ANALOG DEVICES INC AD4695 DRIVER
> -M:	Michael Hennerich <michael.hennerich@analog.com>
> -M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> -R:	David Lechner <dlechner@baylibre.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> -F:	Documentation/iio/ad4695.rst
> -F:	drivers/iio/adc/ad4695.c
> -F:	include/dt-bindings/iio/adc/adi,ad4695.h
> -
> -ANALOG DEVICES INC AD4851 DRIVER
> -M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> -M:	Dragos Bogdan <dragos.bogdan@analog.com>
> -R:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> -F:	drivers/iio/adc/ad4851.c
> -
>  ANALOG DEVICES INC AD5706R DRIVER
>  M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
>  L:	linux-iio@vger.kernel.org
> @@ -1515,31 +1413,6 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
>  F:	drivers/iio/dac/ad5706r.c
> =20
> -ANALOG DEVICES INC AD7091R DRIVER
> -M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
> -F:	drivers/iio/adc/ad7091r*
> -
> -ANALOG DEVICES INC AD7191 DRIVER
> -M:	Alisa-Dariana Roman <alisa.roman@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> -F:	Documentation/iio/ad7191.rst
> -F:	drivers/iio/adc/ad7191.c
> -
> -ANALOG DEVICES INC AD7192 DRIVER
> -M:	Alisa-Dariana Roman <alisa.roman@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> -F:	drivers/iio/adc/ad7192.c
> -
>  ANALOG DEVICES INC AD7292 DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>  L:	linux-iio@vger.kernel.org
> @@ -1584,15 +1457,6 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,a=
d7625.yaml
>  F:	Documentation/iio/ad7625.rst
>  F:	drivers/iio/adc/ad7625.c
> =20
> -ANALOG DEVICES INC AD7768-1 DRIVER
> -M:	Michael Hennerich <Michael.Hennerich@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> -F:	drivers/iio/adc/ad7768-1.c
> -F:	include/dt-bindings/iio/adc/adi,ad7768-1.h
> -
>  ANALOG DEVICES INC AD7780 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  M:	Renato Lui Geh <renatogeh@gmail.com>
> @@ -1611,16 +1475,6 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
>  F:	drivers/iio/amplifiers/ad8366.c
> =20
> -ANALOG DEVICES INC AD9467 DRIVER
> -M:	Michael Hennerich <Michael.Hennerich@analog.com>
> -M:	Nuno Sa <nuno.sa@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/ABI/testing/debugfs-iio-ad9467
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> -F:	drivers/iio/adc/ad9467.c
> -
>  ANALOG DEVICES INC AD8460 DRIVER
>  M:	Mariel Tinaco <Mariel.Tinaco@analog.com>
>  L:	linux-iio@vger.kernel.org
> @@ -1654,14 +1508,6 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
>  F:	drivers/iio/amplifiers/ada4250.c
> =20
> -ANALOG DEVICES INC ADE9000 DRIVER
> -M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> -L:	linux-iio@vger.kernel.org
> -S:	Supported
> -W:	https://ez.analog.com/linux-software-drivers
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> -F:	drivers/iio/adc/ade9000.c
> -
>  ANALOG DEVICES INC ADF4377 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
> @@ -1866,12 +1712,14 @@ L:	linux@analog.com
>  S:	Supported
>  W:	http://wiki.analog.com/
>  W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/debugfs-iio-ad9467
> +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>  F:	Documentation/devicetree/bindings/iio/*/adi,*
>  F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
>  F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> -F:	Documentation/iio/ad7606.rst
> +F:	Documentation/iio/ad*.rst
>  F:	drivers/iio/*/ad*
>  F:	drivers/iio/adc/ltc249*
>  F:	drivers/iio/amplifiers/hmc425a.c

