Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499634;
	b=cNOBgu85EGBssatCwa1AvYRQ3Al5csXe0FaoC5UdbXc3RXw198AmKxkznauTBRFaOTnS
	 UCEpVXvnMh08F8D1AwTqVzErWZTs4fUQIdviWN/gL/3FfxU6pPumzz66vNWPd6201M7Hl
	 S7cbU3ZBlC9Cl3yePnM40mZjGKNHAxLZ0OtI2kUz3Y4FnOY3gIyEmLrEMMAwO/KHxls9C
	 h+EzOIU16q7sfsbfRcihTk+FoE6zW9A5wbZHrNqvZpHmxeh8FpwNxZa2c8ci5mcjBJjwV
	 xvf9MxDJLB8R/wIZTGNcAUBYtAQkFhcjbXZycOGcwdiosfCB+O4qA2K1BbdCalJvtZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499634;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R+g/8idDbgA8vZ4++Po+Q5wmNFGkrw9IEO4z4KBDrwY=;
	b=bNhgFeMIbTMA/o0xs3P5OMoFa+BbDpAFSTiRcUIvNJIbWJ6SbYo6hT42WtYDwII+QwSa
	 zoKCT8uGzMr89BmTx0+euZkTz8/AUM2IDdfVV1ANW/KxUPTAcOTZFb3XXYMtD/ZOErTDk
	 ggLDbmKnNgMOGBQgdb2kM9moqLtspmaXafNkU61ZDNawONuEmZnJEk2B53crGdwon/xNj
	 Sd5AVWN76Jb+zAND+Qa+N16Pv2NajCNm04gz1IBTbGFmFMfZh8OYa3hIdK+EVjVwlzrY8
	 CoLFIElitQQnKPmFyfZMTO/mLMSDX0GZI1FHEHhu7ogcyqtlmqhGSBSH6Wj8sZCU65Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0fvYdli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213F606A324;
	Sun,  1 Nov 2026 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0fvYdli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CDE1F000C1;
	Sun,  1 Nov 2026 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499634;
	bh=R+g/8idDbgA8vZ4++Po+Q5wmNFGkrw9IEO4z4KBDrwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V0fvYdliqhKXXOcp30fznMOryeACdwJbyOyEgJ07CiiJBf8vIW5gYzUakQ5m+bYV7
	 OhtdilPPYgezFbTHqZFEHpWe4kWqAhsrSfXLFGdhTV17p7Ut5cts/NSSjeGMNL52X3
	 gr6EOxIqreHCjLa/QJwBsjpEkQ7O7LXeysZn3xaXuRjitesZs6GFiKZhs75/QNxdJS
	 ohw/toq9h+Ylpn+o0bRco3y6+2ZNDhhxDZqAPjmCh30IqMMYNKKZxAOF661YOmDapp
	 X6v0MJvids6ORZDLf067bD4LUgXQDYegcvdkc4DFsEN+awYro5/8CEndOeBJRjgzpo
	 a1RAuY5sBd2pA==
Date: Sun, 1 Nov 2026 02:20:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH 08/15] iio: light: apds9306: push events to the IIO
 device
Message-ID: <20261101022027.61c4fe45@jic23-hlaptop>
In-Reply-To: <20261027-llm-char-misc-iio-v1-8-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-8-0d818334f6c7@linuxfoundation.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 17:19:12 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> Reading a light channel while threshold events are enabled can push an
> event through a pointer that is not an IIO device, corrupting memory or
> crashing the kernel.
>=20
> apds9306_read_data() derives indio_dev with dev_to_iio_dev(data->dev),
> but data->dev is the I2C client's device, not the device embedded in
> struct iio_dev. When the status register read by the poll loop has
> APDS9306_ALS_INT_STAT_MASK set, the bogus pointer is passed to
> iio_push_event() and iio_get_time_ns(), which dereference the event
> interface and clock id of a structure that does not exist.
>=20
> The bug was found by code inspection and has not been reproduced.
>=20
> Fix by taking the IIO device from the I2C client's driver data, which
> probe sets with i2c_set_clientdata().

I'd rather we just passed in the iio_dev given the caller always has
it anyway. Pass that instead of struct apds9306_data *data and
use iio_priv() in here to get that locally.


>=20
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Cc: stable <stable@kernel.org>
> Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iio/light/apds9306.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 7dd41136734f..79138422221d 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -462,7 +462,7 @@ static int apds9306_power_state(struct apds9306_data =
*data, bool state)
>  static int apds9306_read_data(struct apds9306_data *data, int *val, int =
reg)
>  {
>  	struct device *dev =3D data->dev;
> -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct apds9306_regfields *rf =3D &data->rf;
>  	u64 ev_code;
>  	int ret, delay, intg_time, intg_time_idx, repeat_rate_idx, int_src;
>=20

