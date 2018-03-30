Return-Path: <JManeyrol@invensense.com>
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: imu: inv_mpu6050: clean set_power_itg and fix
 usage
Date: Fri, 30 Mar 2018 14:18:24 +0000
Message-ID: <CY4PR1201MB0184F6D97E130EDE10F8D771C4A10@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB01847FB4C7079B9ED2FD5773C4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>,<20180330110056.7c4cc691@archlinux>
In-Reply-To: <20180330110056.7c4cc691@archlinux>
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0184F6D97E130EDE10F8D771C4A10CY4PR1201MB0184_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_CY4PR1201MB0184F6D97E130EDE10F8D771C4A10CY4PR1201MB0184_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,


you are right, only turning power off will decrease the counter even if bus=
 communication is failing.


Version 2 of the patches are coming soon.


Thanks.
JB

________________________________
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Sent: Friday, March 30, 2018 12:00:56 PM
To: Jean-Baptiste Maneyrol
Cc: linux-iio
Subject: Re: [PATCH 1/3] iio: imu: inv_mpu6050: clean set_power_itg and fix=
 usage

On Mon, 26 Mar 2018 13:59:03 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Rewrite set_power_itg in a more clean way (failing now don't update
> the reference counter) and fix usage in init function (setting
> power on one time is sufficient to ensure chip is effectively on).

I agree the new structure is an improvement, but I'm not sure
I agree with the description.

For starters please make it clear the reference counter bit
only applies to the decrement case (I believe)...

Few other comments inline.

Thanks and definitely good to clean up this slightly confusing code
and error paths.

Jonathan


>
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 44 ++++++++++++++++++------=
------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 7d64be3..9f97f4f 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -185,26 +185,29 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_st=
ate *st, bool en, u32 mask)
>
>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_o=
n)
>  {
> -     int result =3D 0;
> +     int result;
>
>        if (power_on) {
> -             if (!st->powerup_count)
> +             if (st->powerup_count =3D=3D 0) {

Why this change - they are the same test? Should be mentioned in the patch
description at least.


>                        result =3D regmap_write(st->map, st->reg->pwr_mgmt=
_1, 0);
> -             if (!result)
> -                     st->powerup_count++;
So previously it was incremented only if result =3D=3D 0 which was
true if either the regmap_write was fine or the value was already 0...

This doesn't match with your patch description.


> +                     if (result)
> +                             return result;
> +                     usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> +                                  INV_MPU6050_REG_UP_TIME_MAX);
> +             }
> +             st->powerup_count++;
>        } else {
> -             st->powerup_count--;
> -             if (!st->powerup_count)
> +             if (st->powerup_count =3D=3D 1) {
>                        result =3D regmap_write(st->map, st->reg->pwr_mgmt=
_1,
>                                              INV_MPU6050_BIT_SLEEP);
> +                     if (result)
> +                             return result;
> +             }
> +             st->powerup_count--;
>        }
>
> -     if (result)
> -             return result;
> -
> -     if (power_on)
> -             usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> -                          INV_MPU6050_REG_UP_TIME_MAX);
> +     dev_dbg(regmap_get_device(st->map), "set power %d, count=3D%u\n",
> +             power_on, st->powerup_count);
>
>        return 0;
>  }
> @@ -850,14 +853,11 @@ static int inv_check_and_setup_chip(struct inv_mpu6=
050_state *st)
>        msleep(INV_MPU6050_POWER_UP_TIME);
>
>        /*
> -      * toggle power state. After reset, the sleep bit could be on
> -      * or off depending on the OTP settings. Toggling power would
> +      * toggle power on. After reset, the sleep bit could be on

Toggle implies an off on sequence so can't be used here if you are
just turning on.

> +      * or off depending on the OTP settings. Toggling power on
>         * make it in a definite state as well as making the hardware
>         * state align with the software state
>         */
> -     result =3D inv_mpu6050_set_power_itg(st, false);
> -     if (result)
> -             return result;
>        result =3D inv_mpu6050_set_power_itg(st, true);
>        if (result)
>                return result;
> @@ -865,13 +865,21 @@ static int inv_check_and_setup_chip(struct inv_mpu6=
050_state *st)
>        result =3D inv_mpu6050_switch_engine(st, false,
>                                           INV_MPU6050_BIT_PWR_ACCL_STBY);
>        if (result)
> -             return result;
> +             goto error_power_off;
>        result =3D inv_mpu6050_switch_engine(st, false,
>                                           INV_MPU6050_BIT_PWR_GYRO_STBY);
>        if (result)
> +             goto error_power_off;
> +
> +     result =3D inv_mpu6050_set_power_itg(st, false);
return inv_mpu6050_set_power_itg.

> +     if (result)
>                return result;
>
>        return 0;
> +
> +error_power_off:
> +     inv_mpu6050_set_power_itg(st, false);
> +     return result;
>  }
>
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,


--_000_CY4PR1201MB0184F6D97E130EDE10F8D771C4A10CY4PR1201MB0184_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hello,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">you are right, only turning power=
 off will decrease the counter even if bus communication is failing.<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Version 2 of the patches are comi=
ng soon.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.<br>
JB<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jonathan Cameron &lt;=
jic23@jic23.retrosnub.co.uk&gt;<br>
<b>Sent:</b> Friday, March 30, 2018 12:00:56 PM<br>
<b>To:</b> Jean-Baptiste Maneyrol<br>
<b>Cc:</b> linux-iio<br>
<b>Subject:</b> Re: [PATCH 1/3] iio: imu: inv_mpu6050: clean set_power_itg =
and fix usage</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, 26 Mar 2018 13:59:03 &#43;0000<br>
Jean-Baptiste Maneyrol &lt;JManeyrol@invensense.com&gt; wrote:<br>
<br>
&gt; Rewrite set_power_itg in a more clean way (failing now don't update<br=
>
&gt; the reference counter) and fix usage in init function (setting<br>
&gt; power on one time is sufficient to ensure chip is effectively on).<br>
<br>
I agree the new structure is an improvement, but I'm not sure<br>
I agree with the description.<br>
<br>
For starters please make it clear the reference counter bit<br>
only applies to the decrement case (I believe)...<br>
<br>
Few other comments inline.<br>
<br>
Thanks and definitely good to clean up this slightly confusing code<br>
and error paths.<br>
<br>
Jonathan<br>
<br>
<br>
&gt; <br>
&gt; Signed-off-by: Jean-Baptiste Maneyrol &lt;jmaneyrol@invensense.com&gt;=
<br>
&gt; ---<br>
&gt;&nbsp; drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 44 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-=
-----------<br>
&gt;&nbsp; 1 file changed, 26 insertions(&#43;), 18 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_core.c<br>
&gt; index 7d64be3..9f97f4f 100644<br>
&gt; --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c<br>
&gt; &#43;&#43;&#43; b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c<br>
&gt; @@ -185,26 &#43;185,29 @@ int inv_mpu6050_switch_engine(struct inv_mpu=
6050_state *st, bool en, u32 mask)<br>
&gt;&nbsp; <br>
&gt;&nbsp; int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool=
 power_on)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (power_on) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!st-&gt;powerup_count)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (st-&gt;powerup_count =3D=3D 0) {<br>
<br>
Why this change - they are the same test? Should be mentioned in the patch<=
br>
description at least.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =
=3D regmap_write(st-&gt;map, st-&gt;reg-&gt;pwr_mgmt_1, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!result)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st-&gt;powerup_count&#4=
3;&#43;;<br>
So previously it was incremented only if result =3D=3D 0 which was<br>
true if either the regmap_write was fine or the value was already 0...<br>
<br>
This doesn't match with your patch description.<br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usleep_range(INV_MP=
U6050_REG_UP_TIME_MIN,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INV_MPU6050_REG_=
UP_TIME_MAX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; st-&gt;powerup_count&#43;&#43;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; st-&gt;powerup_count--;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!st-&gt;powerup_count)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (st-&gt;powerup_count =3D=3D 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =
=3D regmap_write(st-&gt;map, st-&gt;reg-&gt;pwr_mgmt_1,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INV_MPU6050_BIT_SLEEP);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; st-&gt;powerup_count--;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return result;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (power_on)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; usleep_range(INV_MPU6050_REG_UP_TIME_MIN,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; INV_MPU6050_REG_UP_TIME_MAX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(regmap_get_device(st-&gt;map), &=
quot;set power %d, count=3D%u\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; power_on, st-&gt;powerup_count);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; @@ -850,14 &#43;853,11 @@ static int inv_check_and_setup_chip(struct i=
nv_mpu6050_state *st)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(INV_MPU6050_POWER_UP_=
TIME);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * toggle power state. After reset, the=
 sleep bit could be on<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * or off depending on the OTP settings=
. Toggling power would<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * toggle power on. After reset, th=
e sleep bit could be on<br>
<br>
Toggle implies an off on sequence so can't be used here if you are<br>
just turning on.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * or off depending on the OTP sett=
ings. Toggling power on<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * make it in a definit=
e state as well as making the hardware<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * state align with the=
 software state<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; result =3D inv_mpu6050_set_power_itg(st, fal=
se);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return result;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D inv_mpu6050_set_p=
ower_itg(st, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return result;<br>
&gt; @@ -865,13 &#43;865,21 @@ static int inv_check_and_setup_chip(struct i=
nv_mpu6050_state *st)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D inv_mpu6050_switc=
h_engine(st, false,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INV_MPU6050_BIT_PWR_ACCL_STBY);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return result;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto error_power_off;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D inv_mpu6050_switc=
h_engine(st, false,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INV_MPU6050_BIT_PWR_GYRO_STBY);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto error_power_off;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; result =3D inv_mpu6050_set_power_itg(st,=
 false);<br>
return inv_mpu6050_set_power_itg.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return result;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;error_power_off:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; inv_mpu6050_set_power_itg(st, false);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; int inv_mpu_core_probe(struct regmap *regmap, int irq, const cha=
r *name,<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR1201MB0184F6D97E130EDE10F8D771C4A10CY4PR1201MB0184_--
