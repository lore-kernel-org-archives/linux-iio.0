Return-Path: <SRS0=y1s9=7N=google.com=bleung@kernel.org>
Date: Thu, 10 Aug 2017 20:25:56 -0700
From: Benson Leung <bleung@google.com>
To: Thierry Escande <thierry.escande@collabora.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org, gwendal@chromium.org,
	bleung@google.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: cros_ec: Relax sampling frequency before
 suspending
Message-ID: <20170811032556.GA9629@decatoncale.mtv.corp.google.com>
References: <1502403410-5233-1-git-send-email-thierry.escande@collabora.com>
 <1502403410-5233-2-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <1502403410-5233-2-git-send-email-thierry.escande@collabora.com>
List-ID: <linux-iio@vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

On Fri, Aug 11, 2017 at 12:16:43AM +0200, Thierry Escande wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
>=20
> If an application set a tight sampling frequency, given the interrupt
> use is a wakup source, suspend will not happen: the kernel will receive
> a wake up interrupt and will cancel the suspend process.
>=20
> Given cros_ec sensors type is non wake up, this patch adds prepare and
> complete callbacks to set 1s sampling period just before suspend. This
> ensures the sensor hub will not be a source of interrupt during the
> suspend process.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>

Remember to copy the original author, Gwendal Also, this is an iio patch,
so you should make sure to send this to linux-iio@vger.kernel.org and to=20
Jonathan Cameron <jic23@kernel.org> as well.

> ---
>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  1 +
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 49 ++++++++++++++++=
++++++
>  .../common/cros_ec_sensors/cros_ec_sensors_core.h  |  2 +
>  drivers/iio/light/cros_ec_light_prox.c             |  1 +
>  4 files changed, 53 insertions(+)
>=20
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drive=
rs/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 38e8783..116da2c 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -292,6 +292,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
>  static struct platform_driver cros_ec_sensors_platform_driver =3D {
>  	.driver =3D {
>  		.name	=3D "cros-ec-sensors",
> +		.pm	=3D &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		=3D cros_ec_sensors_probe,
>  	.id_table	=3D cros_ec_sensors_ids,
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 416cae5..a620eb5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -446,5 +446,54 @@ int cros_ec_sensors_core_write(struct cros_ec_sensor=
s_core_state *st,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
> =20
> +static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st =3D iio_priv(indio_dev);
> +
> +	if (st->curr_sampl_freq =3D=3D 0)
> +		return 0;
> +
> +	/*
> +	 * If the sensors are sampled at high frequency, we will not be able to
> +	 * sleep. Set sampling to a long period if necessary.
> +	 */
> +	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> +		mutex_lock(&st->cmd_lock);
> +		st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data =3D CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
> +		cros_ec_motion_send_host_cmd(st, 0);
> +		mutex_unlock(&st->cmd_lock);
> +	}
> +	return 0;
> +}
> +
> +static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct cros_ec_sensors_core_state *st =3D iio_priv(indio_dev);
> +
> +	if (st->curr_sampl_freq =3D=3D 0)
> +		return;
> +
> +	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
> +		mutex_lock(&st->cmd_lock);
> +		st->param.cmd =3D MOTIONSENSE_CMD_EC_RATE;
> +		st->param.ec_rate.data =3D st->curr_sampl_freq;
> +		cros_ec_motion_send_host_cmd(st, 0);
> +		mutex_unlock(&st->cmd_lock);
> +	}
> +}
> +
> +const struct dev_pm_ops cros_ec_sensors_pm_ops =3D {
> +#ifdef CONFIG_PM_SLEEP
> +	.prepare =3D cros_ec_sensors_prepare,
> +	.complete =3D cros_ec_sensors_complete
> +#endif
> +};
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
> +
>  MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> index 8bc2ca3..2edf68d 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> @@ -169,6 +169,8 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors=
_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask);
> =20
> +extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
> +
>  /* List of extended channel specification for all sensors */
>  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
> =20
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/c=
ros_ec_light_prox.c
> index 7217223..f8658d4 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -279,6 +279,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
>  static struct platform_driver cros_ec_light_prox_platform_driver =3D {
>  	.driver =3D {
>  		.name	=3D "cros-ec-light-prox",
> +		.pm	=3D &cros_ec_sensors_pm_ops,
>  	},
>  	.probe		=3D cros_ec_light_prox_probe,
>  	.id_table	=3D cros_ec_light_prox_ids,
> --=20
> 2.7.4
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZjSPEAAoJEB8J9XsKL+ZYsZ0P/j9YHmdYjVsu+S/heVkxrtUb
/DLqtoIWPREhmPVXVIwg9mgbe5H9pgQchZgXSwTOtv8qGehlb3ZM5e2L5v5CZ1eK
rE5gh/st1a1q/5qE8/2xNsptMjoLNNFX/WpCD9yJTH6N61SPKBF9c+tJWccyS+m2
83ha3ald9pSosu+2gUAHpdvCjdchE5RIIw7ORmX7eeoohUF4SWU86qRyaJ+7XfgY
KhSotMhAUWdS32q0oz6hAVhxDKZRhf1hzFKaiVtiPE4mr+rCYzs9W79eASYGFvCx
M7gnz5ktHB0iXznIs7auTovXKNjwb3wQ7VuP0t80qOyfWan8NLkBhJzwwqNvMEm+
GsHy52S/AsepbYY/WUgDSMp2SiFFKjWHagvCg1TTEb1CZjgL0BNuC1nLNtfKKK1V
nndy2G3t77HJF4xeVdoEzynsbUz9j4a1Dg1nPx10m6LOZ6fu/h5kExR8PB6j/HWD
l8BuA+QgU3feLlBDnFkBoHnwhOjjdx5sO02PATSn91jd6r9nN9ygHCqxO2TH3W8R
dfR+1brbs1KpsSwgNCgRbjzCe24rFEDnvqWFjRSShp9WB2WHmKTuXN7uIPl4Uujx
sH8aznz5kiWKLR44epHRREvEw4TkkH03W1S7mo0usWpttA9jmuMtGp1fDSrzaODd
yddeoPNJNrjfXl08Nxsz
=w2DW
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
