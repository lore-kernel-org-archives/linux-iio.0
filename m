Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 4/5] iio:light:stk3310: use correct names and type for
 state
Date: Mon, 6 Jul 2015 09:33:40 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F402216D8C1@IRSMSX109.ger.corp.intel.com>
References: <cover.1436024257.git.knaack.h@gmx.de>
 <e034d85ca54ed9f46c2d494fc4af7e7e67a2ad6a.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <e034d85ca54ed9f46c2d494fc4af7e7e67a2ad6a.1436024257.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: Saturday, July 4, 2015 6:57 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH 4/5] iio:light:stk3310: use correct names and type for st=
ate
>=20
> Indicate the bit number of predefined states, make use of these names and
> change the state type in _resume to u8 to avoid type casting.
>=20
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

+1

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

> ---
>  drivers/iio/light/stk3310.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c in=
dex
> 3650c0c..be715c7 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -35,8 +35,8 @@
>  #define STK3310_REG_ID				0x3E
>  #define STK3310_MAX_REG				0x80
>=20
> -#define STK3310_STATE_EN_PS			0x01
> -#define STK3310_STATE_EN_ALS			0x02
> +#define STK3310_STATE_EN_PS			BIT(0)
> +#define STK3310_STATE_EN_ALS			BIT(1)
>  #define STK3310_STATE_STANDBY			0x00
>=20
>  #define STK3310_CHIP_ID_VAL			0x13
> @@ -436,8 +436,8 @@ static int stk3310_set_state(struct stk3310_data
> *data, u8 state)
>  		dev_err(&client->dev, "failed to change sensor state\n");
>  	} else if (state !=3D STK3310_STATE_STANDBY) {
>  		/* Don't reset the 'enabled' flags if we're going in standby */
> -		data->ps_enabled  =3D !!(state & 0x01);
> -		data->als_enabled =3D !!(state & 0x02);
> +		data->ps_enabled  =3D !!(state & STK3310_STATE_EN_PS);
> +		data->als_enabled =3D !!(state & STK3310_STATE_EN_ALS);
>  	}
>  	mutex_unlock(&data->lock);
>=20
> @@ -684,7 +684,7 @@ static int stk3310_suspend(struct device *dev)
>=20
>  static int stk3310_resume(struct device *dev)  {
> -	int state =3D 0;
> +	u8 state =3D 0;
>  	struct stk3310_data *data;
>=20
>  	data =3D iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> --
> 2.3.6
