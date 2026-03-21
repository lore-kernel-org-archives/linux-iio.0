Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A512FD1C2
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116435; cv=none; b=g92XclO8WpgKcpPVI4Ks3Cj7ECAM/Ske83m/V4yGv/lAkbHKY+9lxq8wI4QBOdQngS9hAPbNjK3/wNb5XzX32Q8ivEuxBOQfcPNAUwKxRNnzNsPmRbw1B5ACo3Y9Er8s6Y/taioXXv1dyunYBLxUxlr+GWuHmq7tczL+BjP3HoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116435; c=relaxed/simple;
	bh=8THp6pHVwDEbrJOFj8ZOj66tjDce4Inw49Gpnln1zHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXqhnxWap3brDoP0FCEtWRd6Tka4imeWb7dR/wmG6dO2qgsBjCjTIKkoXW6MDRToC0GaMmRc4x0TgdReEl5CC77N3SBTtA2Kaie0sZmMjVFwZHCsLjmy4y6YuuQqx28GlMvgTKuFqJ+qEEgTvm+KA3XNzg57rAkZz0o+vLHa584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDsPe/ex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDsPe/ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961F2C19421;
	Sat, 21 Mar 2026 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116434;
	bh=8THp6pHVwDEbrJOFj8ZOj66tjDce4Inw49Gpnln1zHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NDsPe/exzvr4hi8GKQRolR5V7E39WjsbAk2mN1CJtYRRTvSv/X8NBxiP0oghbdDH9
	 j3Jhvb3zJU7gLE5EVU2pcnwY8ry2a9HOGnHjyVXfUzQefkVVQY/Kq17YK8ojPnnCXQ
	 /8Wfz3ryDrRAP/n8BUKoiFpRP5qpIJEoZHdrtdvqQkqTwmRY9Lv7LQuKjUF6lpiPVY
	 lyCdX8e7hWAH8kQlXiKcQ8K6eD57IS2WoJTQSuSONUz3fOKfOaQa7OsJfX0o4DCfII
	 21dElroQU94rZgFl6d5qw0acydW1ITxhlA0PO3Z7a4Z/dirWRHvzvXCzTGfr0K4Qwu
	 PVmi3mslrmZpg==
Date: Sat, 21 Mar 2026 18:07:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, anshulusr@gmail.com
Subject: Re: [PATCH] iio: dac: mcp4821: add configurable gain support
Message-ID: <20260321180707.73a7ad60@jic23-huawei>
In-Reply-To: <20260319165216.351668-1-nikhilgtr@gmail.com>
References: <20260319165216.351668-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Mar 2026 22:22:16 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Add support for configuring the DAC gain using the GA bit.
> Expose gain control via IIO_CHAN_INFO_CALIBSCALE.
>=20
> Scale is updated dynamically based on selected gain:
> - 1x gain =E2=86=92 2.048V full-scale
> - 2x gain =E2=86=92 4.096V full-scale
>=20
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---
>  drivers/iio/dac/mcp4821.c | 140 ++++++++++++++++++++++++++++----------
>  1 file changed, 104 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
> index 748bdca9a964..f9f97917bc9c 100644
> --- a/drivers/iio/dac/mcp4821.c
> +++ b/drivers/iio/dac/mcp4821.c
> @@ -12,26 +12,43 @@
>   *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.p=
df
>   *
>   * TODO:
> - *	- Configurable gain
>   *	- Regulator control
>   */
> =20
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/types.h>
> -
Hi Nikhil,

Don't do code recorganization in a patch doing anything else.
Also, it's fairly common convention to have subsystem specific headers
in a block at the end for a driver in that subsystem.
>  #include <linux/unaligned.h>
This is the oddity.  Was a result of a mass change from
asm/unaligned.h to this that didn't include reordering headers.

Given you are touching the driver anyway, it's fine to move that up to
under spi.h, but should still be a seperate patch.


> =20
>  #define MCP4821_ACTIVE_MODE BIT(12)
>  #define MCP4802_SECOND_CHAN BIT(15)
> +#define MCP4821_GAIN_ENABLE BIT(13)

Put this in order. So above MCP4802_SECOND_CHAN
> =20
> -/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
> -#define MCP4821_2X_GAIN_VREF_MV 4096
> +/* DAC uses an internal Voltage reference of 2.048V */
> +#define MCP4821_VREF_MV 2048
> =20
> -enum mcp4821_supported_drvice_ids {
> +/*
> + * MCP48xx DAC output:
> + *
> + * Vout =3D (Vref * D / 2^N) * G
> + *
> + * where:
> + *  - Vref =3D 2.048V (internal reference)
> + *  - N =3D DAC resolution (12 bits for MCP4821)
> + *  - G =3D gain selection:
> + *        1x when GA bit =3D 1
> + *        2x when GA bit =3D 0 (default)
> + *
> + * Therefore full-scale voltage is:
> + *  - 1x gain: 2.048V
> + *  - 2x gain: 4.096V
> + *
> + * Scale =3D Vfull-scale / 2^N
> + */
> +
> +enum mcp4821_supported_device_ids {
>  	ID_MCP4801,
>  	ID_MCP4802,
>  	ID_MCP4811,
> @@ -43,6 +60,7 @@ enum mcp4821_supported_drvice_ids {
>  struct mcp4821_state {
>  	struct spi_device *spi;
>  	u16 dac_value[2];
> +	bool gain_1x;
>  };
> =20
>  struct mcp4821_chip_info {
> @@ -51,16 +69,19 @@ struct mcp4821_chip_info {
>  	const struct iio_chan_spec channels[2];
>  };
> =20
> -#define MCP4821_CHAN(channel_id, resolution)                          \
> -	{                                                             \
> -		.type =3D IIO_VOLTAGE, .output =3D 1, .indexed =3D 1,       \
> -		.channel =3D (channel_id),                              \
> -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),         \
> -		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> -		.scan_type =3D {                                        \
> -			.realbits =3D (resolution),                     \
> -			.shift =3D 12 - (resolution),                   \
> -		},                                                    \
> +#define MCP4821_CHAN(channel_id, resolution)					\
> +	{															\
> +		.type =3D IIO_VOLTAGE, .output =3D 1, .indexed =3D 1,			\
> +		.channel =3D (channel_id),								\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_CALIBSCALE),						\
> +	    .info_mask_shared_by_type_available =3D					\
> +			BIT(IIO_CHAN_INFO_CALIBSCALE),						\
> +		.scan_type =3D {											\
> +			.realbits =3D (resolution),							\
> +			.shift =3D 12 - (resolution),							\
> +		},														\
>  	}
No idea what went wrong formatting wise here, but that needs to go back to =
normal!

Why is it calibscale as opposed to scale?  A x2 multiplier presumably affec=
ts the
scale userspace should apply? calibbscale is for adjusting due to minor dev=
ice differences
not this sort of major range adjustment.

> =20
>  static const struct mcp4821_chip_info mcp4821_chip_info_table[6] =3D {
> @@ -122,13 +143,25 @@ static int mcp4821_read_raw(struct iio_dev *indio_d=
ev,
>  		state =3D iio_priv(indio_dev);
>  		*val =3D state->dac_value[chan->channel];
>  		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
> -		*val =3D MCP4821_2X_GAIN_VREF_MV;
> +		state =3D iio_priv(indio_dev);
> +		if (state->gain_1x)
> +			*val =3D MCP4821_VREF_MV;
> +		else
> +			*val =3D MCP4821_VREF_MV * 2;
>  		*val2 =3D chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		state =3D iio_priv(indio_dev);
> +		*val =3D state->gain_1x ? 1 : 2;
> +		return IIO_VAL_INT;
> +
>  	default:
> -		return -EINVAL;
> +		break;
>  	}
> +	return -EINVAL;

Why?  Original code was at least as good if not better.

>  }
> =20
>  static int mcp4821_write_raw(struct iio_dev *indio_dev,
> @@ -140,34 +173,68 @@ static int mcp4821_write_raw(struct iio_dev *indio_=
dev,
>  	__be16 write_buffer;
>  	int ret;
> =20
> -	if (val2 !=3D 0)
> -		return -EINVAL;
> +	switch (mask) {
> =20
> -	if (val < 0 || val >=3D BIT(chan->scan_type.realbits))
> -		return -EINVAL;
> +	case IIO_CHAN_INFO_RAW:
> =20
> -	if (mask !=3D IIO_CHAN_INFO_RAW)
> -		return -EINVAL;
> +		if (val2 !=3D 0)
> +			return -EINVAL;
> +
> +		if (val < 0 || val >=3D BIT(chan->scan_type.realbits))
> +			return -EINVAL;
> =20
> -	write_val =3D MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> -	if (chan->channel)
> -		write_val |=3D MCP4802_SECOND_CHAN;
> +		write_val =3D MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> +		if (chan->channel)
> +			write_val |=3D MCP4802_SECOND_CHAN;
> +		if (state->gain_1x)
> +			write_val |=3D MCP4821_GAIN_ENABLE;
> =20
> -	write_buffer =3D cpu_to_be16(write_val);
> -	ret =3D spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> -	if (ret) {
> -		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> -		return ret;
> +		write_buffer =3D cpu_to_be16(write_val);
> +		ret =3D spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> +		if (ret) {
> +			dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> +			return ret;
> +		}
> +
> +		state->dac_value[chan->channel] =3D val;
> +		return 0;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val =3D=3D 1)
> +			state->gain_1x =3D true;
> +		else if (val =3D=3D 2)
> +			state->gain_1x =3D false;
> +		else
> +			return -EINVAL;
> +		return 0;
> +	default:
> +		break;
>  	}
> +	return -EINVAL;
Move that up into the default.=20

> +}

Thanks,

Jonathan

