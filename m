Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, "Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: RE: [PATCH 6/8] iio:magnetometer:bmc150_magn: protect
 runtime_resume with mutex
Date: Mon, 20 Jul 2015 17:45:48 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F06BBA6@irsmsx105.ger.corp.intel.com>
References: <cover.1437090791.git.knaack.h@gmx.de>
 <d6c36de684250b41333124b476b0d29bab00b22a.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <d6c36de684250b41333124b476b0d29bab00b22a.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: 17 July, 2015 11:52
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; =
Dogaru, Vlad
> Subject: [PATCH 6/8] iio:magnetometer:bmc150_magn: protect runtime_resume=
 with mutex
>=20
> Protect bmc150_magn_runtime_resume() with a mutex, as done with other
> suspend/resume functions.
>=20
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magneto=
meter/bmc150_magn.c
> index e1f804b2b244..ac0cdbde813b 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -1052,9 +1052,14 @@ static int bmc150_magn_runtime_resume(struct devic=
e *dev)
>  {
>  	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
>  	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> +	int ret;
>=20
> -	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> -					  true);
> +	mutex_lock(&data->mutex);
> +	ret =3D bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
> +					 true);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;

This function does not have mutex_lock/unlock because it is called with dat=
a->mutex locked.
I should have added a comment to specify this.

Whenever we wake up the device, bmc150_magn_set_power_state is called after=
 locking
data->mutex. This in turn calls pm_runtime_get_sync which will immediately =
call
bmc150_magn_runtime_resume. Trying to lock the mutex here would lead to a d=
eadlock
(e.g. when trying to read a value through sysfs _raw).

Since this driver uses autosuspend delay, the situation is different for ru=
ntime suspend since
that is called after 2 seconds in a separate thread. This is why there is a=
 mutex locked in runtime
suspend but not in runtime resume.

>  }
>  #endif
>=20
> --
> 2.4.3
