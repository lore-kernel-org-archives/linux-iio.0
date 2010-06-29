Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1277481314-31717-6-git-send-email-jic23@cam.ac.uk>
References: <1277481314-31717-1-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-2-git-send-email-jic23@cam.ac.uk> <1277481314-31717-3-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-4-git-send-email-jic23@cam.ac.uk> <1277481314-31717-5-git-send-email-jic23@cam.ac.uk>
	<1277481314-31717-6-git-send-email-jic23@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Jun 2010 18:30:21 +0800
Message-ID: <AANLkTikmE_e6bf4w4eo8SuNm2xxRDl8qyCSSuzWNDIPl@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio: remove timestamp field from trigger and
	pass instead through pollfuncs
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Barry.Song@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Delete redundant timestamp copy, it makes much sense. But i think
time_stamp is more like a common field needed by all iio devices.  If
we will have a common iio_state as my patch, i think your this patch
is really good to me. If no, maybe deleting time_stamp  in state
struct and keeping the common layer timestamp makes more sense?

On Fri, Jun 25, 2010 at 11:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
> =C2=A0Noticed this in passing. =C2=A0The trig->timestamp value was simply
> =C2=A0used to pass the timestamp into iio_trigger_poll and to functions
> =C2=A0called from there. =C2=A0Lets move it to a function parameter to ma=
ke
> =C2=A0code easier to follow.
>
> =C2=A0drivers/staging/iio/accel/adis16209_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/staging/iio/accel/adis16209_trigger.c =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A03 +--
> =C2=A0drivers/staging/iio/accel/adis16240_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/staging/iio/accel/adis16240_trigger.c =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A03 +--
> =C2=A0drivers/staging/iio/accel/lis3l02dq_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A09 ++++-----
> =C2=A0drivers/staging/iio/adc/max1363_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/staging/iio/gyro/adis16260_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A04 ++--
> =C2=A0drivers/staging/iio/gyro/adis16260_trigger.c =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A03 +--
> =C2=A0drivers/staging/iio/imu/adis16300_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/staging/iio/imu/adis16300_trigger.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A03 +--
> =C2=A0drivers/staging/iio/imu/adis16350_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/staging/iio/imu/adis16350_trigger.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A03 +--
> =C2=A0drivers/staging/iio/imu/adis16400_ring.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/staging/iio/imu/adis16400_trigger.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A03 +--
> =C2=A0drivers/staging/iio/industrialio-trigger.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 10 +++++-----
> =C2=A0drivers/staging/iio/trigger.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 12 +++++++-----
> =C2=A0drivers/staging/iio/trigger/iio-trig-gpio.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A03 ++-
> =C2=A0.../staging/iio/trigger/iio-trig-periodic-rtc.c =C2=A0 =C2=A0| =C2=
=A0 =C2=A03 ++-
> =C2=A018 files changed, 39 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging=
/iio/accel/adis16209_ring.c
> index 3b42a65..ad71538 100644
> --- a/drivers/staging/iio/accel/adis16209_ring.c
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -68,10 +68,10 @@ static struct attribute_group adis16209_scan_el_group=
 =3D {
> =C2=A0* adis16209_poll_func_th() top half interrupt handler called by tri=
gger
> =C2=A0* @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> =C2=A0**/
> -static void adis16209_poll_func_th(struct iio_dev *indio_dev)
> +static void adis16209_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16209_state *st =3D iio_dev_get_dev=
data(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&st->work_trigger_to_ring);
> =C2=A0}
>
> diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/stag=
ing/iio/accel/adis16209_trigger.c
> index cd901a4..1487eff 100644
> --- a/drivers/staging/iio/accel/adis16209_trigger.c
> +++ b/drivers/staging/iio/accel/adis16209_trigger.c
> @@ -23,8 +23,7 @@ static int adis16209_data_rdy_trig_poll(struct iio_dev =
*dev_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16209_state *st =3D iio_dev_get_dev=
data(dev_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger *trig =3D st->trig;
>
> - =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig, timestamp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging=
/iio/accel/adis16240_ring.c
> index 08fef63..5cced2e 100644
> --- a/drivers/staging/iio/accel/adis16240_ring.c
> +++ b/drivers/staging/iio/accel/adis16240_ring.c
> @@ -62,10 +62,10 @@ static struct attribute_group adis16240_scan_el_group=
 =3D {
> =C2=A0* adis16240_poll_func_th() top half interrupt handler called by tri=
gger
> =C2=A0* @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> =C2=A0**/
> -static void adis16240_poll_func_th(struct iio_dev *indio_dev)
> +static void adis16240_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16240_state *st =3D iio_dev_get_dev=
data(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&st->work_trigger_to_ring);
> =C2=A0}
>
> diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/stag=
ing/iio/accel/adis16240_trigger.c
> index d58b405..2ba71fd 100644
> --- a/drivers/staging/iio/accel/adis16240_trigger.c
> +++ b/drivers/staging/iio/accel/adis16240_trigger.c
> @@ -23,8 +23,7 @@ static int adis16240_data_rdy_trig_poll(struct iio_dev =
*dev_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16240_state *st =3D iio_dev_get_dev=
data(dev_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger *trig =3D st->trig;
>
> - =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig, timestamp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging=
/iio/accel/lis3l02dq_ring.c
> index bc0de78..28d95ed 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -103,10 +103,10 @@ static struct attribute_group lis3l02dq_scan_el_gro=
up =3D {
> =C2=A0* lis3l02dq_poll_func_th() top half interrupt handler called by tri=
gger
> =C2=A0* @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> =C2=A0**/
> -static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev)
> +static void lis3l02dq_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> - =C2=A0struct lis3l02dq_state *st =3D iio_dev_get_devdata(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 struct lis3l02dq_state *st =3D iio_dev_get_devdata=
(indio_dev);
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&st->work_trigger_to_ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Indicate that this interrupt is being handl=
ed */
>
> @@ -128,8 +128,7 @@ static int lis3l02dq_data_rdy_trig_poll(struct iio_de=
v *dev_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct lis3l02dq_state *st =3D iio_dev_get_dev=
data(dev_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger *trig =3D st->trig;
>
> - =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig, timestamp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio=
/adc/max1363_ring.c
> index 896973d..1e0ad9d 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -112,7 +112,7 @@ static int max1363_ring_preenable(struct iio_dev *ind=
io_dev)
> =C2=A0* then. =C2=A0Some triggers will generate their own time stamp. =C2=
=A0Currently
> =C2=A0* there is no way of notifying them when no one cares.
> =C2=A0**/
> -static void max1363_poll_func_th(struct iio_dev *indio_dev)
> +static void max1363_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct max1363_state *st =3D indio_dev->dev_da=
ta;
>
> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/=
iio/gyro/adis16260_ring.c
> index 05e7a69..97d7660 100644
> --- a/drivers/staging/iio/gyro/adis16260_ring.c
> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
> @@ -59,10 +59,10 @@ static struct attribute_group adis16260_scan_el_group=
 =3D {
> =C2=A0* adis16260_poll_func_th() top half interrupt handler called by tri=
gger
> =C2=A0* @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> =C2=A0**/
> -static void adis16260_poll_func_th(struct iio_dev *indio_dev)
> +static void adis16260_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16260_state *st =3D iio_dev_get_dev=
data(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&st->work_trigger_to_ring);
> =C2=A0}
>
> diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/stagi=
ng/iio/gyro/adis16260_trigger.c
> index 54afd9e..de01537 100644
> --- a/drivers/staging/iio/gyro/adis16260_trigger.c
> +++ b/drivers/staging/iio/gyro/adis16260_trigger.c
> @@ -23,8 +23,7 @@ static int adis16260_data_rdy_trig_poll(struct iio_dev =
*dev_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16260_state *st =3D iio_dev_get_dev=
data(dev_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger *trig =3D st->trig;
>
> - =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig, timestamp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/i=
io/imu/adis16300_ring.c
> index 4dee670..6b25f12 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -75,10 +75,10 @@ static struct attribute_group adis16300_scan_el_group=
 =3D {
> =C2=A0* adis16300_poll_func_th() top half interrupt handler called by tri=
gger
> =C2=A0* @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> =C2=A0**/
> -static void adis16300_poll_func_th(struct iio_dev *indio_dev)
> +static void adis16300_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16300_state *st =3D iio_dev_get_dev=
data(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&st->work_trigger_to_ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Indicate that this interrupt is being handl=
ed */
>
> diff --git a/drivers/staging/iio/imu/adis16300_trigger.c b/drivers/stagin=
g/iio/imu/adis16300_trigger.c
> index a55f383..64036cd 100644
> --- a/drivers/staging/iio/imu/adis16300_trigger.c
> +++ b/drivers/staging/iio/imu/adis16300_trigger.c
> @@ -23,8 +23,7 @@ static int adis16300_data_rdy_trig_poll(struct iio_dev =
*dev_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16300_state *st =3D iio_dev_get_dev=
data(dev_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger *trig =3D st->trig;
>
> - =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig, timestamp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/i=
io/imu/adis16350_ring.c
> index c70816d..28c13ef 100644
> --- a/drivers/staging/iio/imu/adis16350_ring.c
> +++ b/drivers/staging/iio/imu/adis16350_ring.c
> @@ -81,10 +81,10 @@ static struct attribute_group adis16350_scan_el_group=
 =3D {
> =C2=A0* adis16350_poll_func_th() top half interrupt handler called by tri=
gger
> =C2=A0* @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> =C2=A0**/
> -static void adis16350_poll_func_th(struct iio_dev *indio_dev)
> +static void adis16350_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16350_state *st =3D iio_dev_get_dev=
data(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&st->work_trigger_to_ring);
> =C2=A0}
>
> diff --git a/drivers/staging/iio/imu/adis16350_trigger.c b/drivers/stagin=
g/iio/imu/adis16350_trigger.c
> index fbe246a..76edccc 100644
> --- a/drivers/staging/iio/imu/adis16350_trigger.c
> +++ b/drivers/staging/iio/imu/adis16350_trigger.c
> @@ -23,8 +23,7 @@ static int adis16350_data_rdy_trig_poll(struct iio_dev =
*dev_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16350_state *st =3D iio_dev_get_dev=
data(dev_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger *trig =3D st->trig;
>
> - =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig, timestamp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/i=
io/imu/adis16400_ring.c
> index 8f7d257..95f53b2 100644
> --- a/drivers/staging/iio/imu/adis16400_ring.c
> +++ b/drivers/staging/iio/imu/adis16400_ring.c
> @@ -84,10 +84,10 @@ static struct attribute_group adis16400_scan_el_group=
 =3D {
> =C2=A0* adis16400_poll_func_th() top half interrupt handler called by tri=
gger
> =C2=A0* @private_data: =C2=A0 =C2=A0 =C2=A0iio_dev
> =C2=A0**/
> -static void adis16400_poll_func_th(struct iio_dev *indio_dev)
> +static void adis16400_poll_func_th(struct iio_dev *indio_dev, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16400_state *st =3D iio_dev_get_dev=
data(indio_dev);
> - =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D indio_dev->trig->timestamp;
> + =C2=A0 =C2=A0 =C2=A0 st->last_timestamp =3D time;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&st->work_trigger_to_ring);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Indicate that this interrupt is being handl=
ed */
>
> diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/stagin=
g/iio/imu/adis16400_trigger.c
> index bf7c603..aafe601 100644
> --- a/drivers/staging/iio/imu/adis16400_trigger.c
> +++ b/drivers/staging/iio/imu/adis16400_trigger.c
> @@ -23,8 +23,7 @@ static int adis16400_data_rdy_trig_poll(struct iio_dev =
*dev_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct adis16400_state *st =3D iio_dev_get_dev=
data(dev_info);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_trigger *trig =3D st->trig;
>
> - =C2=A0 =C2=A0 =C2=A0 trig->timestamp =3D timestamp;
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(trig, timestamp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
> diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging=
/iio/industrialio-trigger.c
> index 0f8ba14..0d5f15b 100644
> --- a/drivers/staging/iio/industrialio-trigger.c
> +++ b/drivers/staging/iio/industrialio-trigger.c
> @@ -173,7 +173,7 @@ struct iio_trigger *iio_trigger_find_by_name(const ch=
ar *name, size_t len)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(iio_trigger_find_by_name);
>
> -void iio_trigger_poll(struct iio_trigger *trig)
> +void iio_trigger_poll(struct iio_trigger *trig, s64 time)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_poll_func *pf_cursor;
>
> @@ -185,7 +185,8 @@ void iio_trigger_poll(struct iio_trigger *trig)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry(pf_cursor, &trig->pollfunc=
_list, list) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pf_cursor->pol=
l_func_main) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pf_cursor->poll_func_main(pf_cursor->private_data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pf_cursor->poll_func_main(pf_cursor->private_data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 time);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0trig->use_count++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -198,8 +199,7 @@ void iio_trigger_notify_done(struct iio_trigger *trig=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (trig->use_count =3D=3D 0 && trig->try_reen=
able)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (trig->try_reen=
able(trig)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Missed and interrupt so launch new poll now */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 trig->timestamp =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 iio_trigger_poll(trig);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 iio_trigger_poll(trig, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(iio_trigger_notify_done);
> @@ -401,7 +401,7 @@ EXPORT_SYMBOL(iio_device_unregister_trigger_consumer)=
;
>
> =C2=A0int iio_alloc_pollfunc(struct iio_dev *indio_dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void (*immediate)(struct iio_dev *indio_dev),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*main)(struct iio_dev =C2=A0*private_data))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*main)(struct iio_dev *private_data, s64 time))
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->pollfunc =3D kzalloc(sizeof(*indio_=
dev->pollfunc), GFP_KERNEL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (indio_dev->pollfunc =3D=3D NULL)
> diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.=
h
> index 832de15..4699586 100644
> --- a/drivers/staging/iio/trigger.h
> +++ b/drivers/staging/iio/trigger.h
> @@ -21,7 +21,6 @@
> =C2=A0* @pollfunc_list_lock: =C2=A0 =C2=A0 =C2=A0 =C2=A0[INTERN] protecti=
on of the polling function list
> =C2=A0* @pollfunc_list: =C2=A0 =C2=A0 [INTERN] list of functions to run o=
n trigger.
> =C2=A0* @control_attrs: =C2=A0 =C2=A0 [DRIVER] sysfs attributes relevant =
to trigger type
> - * @timestamp: =C2=A0 =C2=A0 =C2=A0 =C2=A0 [INTERN] timestamp usesd by s=
ome trigs (e.g. datardy)
> =C2=A0* @owner: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [DRIVER] used t=
o monitor usage count of the trigger.
> =C2=A0* @use_count: =C2=A0 =C2=A0 =C2=A0 =C2=A0 use count for the trigger
> =C2=A0* @set_trigger_state: [DRIVER] switch on/off the trigger on demand
> @@ -39,7 +38,6 @@ struct iio_trigger {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pollfunc_list_lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pollfunc_list;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct attribute_group =C2=A0 =C2=A0*con=
trol_attrs;
> - =C2=A0 =C2=A0 =C2=A0 s64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timestamp;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct module =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *owner;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int use_count;
>
> @@ -120,7 +118,7 @@ int iio_trigger_dettach_poll_func(struct iio_trigger =
*trig,
> =C2=A0*
> =C2=A0* Typically called in relevant hardware interrupt handler.
> =C2=A0**/
> -void iio_trigger_poll(struct iio_trigger *trig);
> +void iio_trigger_poll(struct iio_trigger *trig, s64 time);
> =C2=A0void iio_trigger_notify_done(struct iio_trigger *trig);
>
> =C2=A0/**
> @@ -144,13 +142,13 @@ struct iio_poll_func {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_head list;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*private_data;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void (*poll_func_immediate)(struct iio_dev *in=
dio_dev);
> - =C2=A0 =C2=A0 =C2=A0 void (*poll_func_main)(struct iio_dev =C2=A0*priva=
te_data);
> + =C2=A0 =C2=A0 =C2=A0 void (*poll_func_main)(struct iio_dev *private_dat=
a, s64 time);
>
> =C2=A0};
>
> =C2=A0int iio_alloc_pollfunc(struct iio_dev *indio_dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void (*immediate)(struct iio_dev *indio_dev),
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*main)(struct iio_dev =C2=A0*private_data));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void (*main)(struct iio_dev *private_data, s64 time));
>
> =C2=A0/*
> =C2=A0* Two functions for common case where all that happens is a pollfun=
c
> @@ -163,4 +161,8 @@ struct iio_trigger *iio_allocate_trigger(void);
>
> =C2=A0void iio_free_trigger(struct iio_trigger *trig);
>
> +
> +struct iio_simple_trigger {
> + =C2=A0 =C2=A0 =C2=A0 struct iio_trigger trig;
> +};
> =C2=A0#endif /* _IIO_TRIGGER_H_ */
> diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/stagin=
g/iio/trigger/iio-trig-gpio.c
> index 3c0614e..f93cc91 100644
> --- a/drivers/staging/iio/trigger/iio-trig-gpio.c
> +++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
> @@ -42,7 +42,8 @@ struct iio_gpio_trigger_info {
>
> =C2=A0static irqreturn_t iio_gpio_trigger_poll(int irq, void *private)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(private);
> + =C2=A0 =C2=A0 =C2=A0 /* Timestamp not currently provided */
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(private, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
> =C2=A0}
>
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/driver=
s/staging/iio/trigger/iio-trig-periodic-rtc.c
> index d8c58cb..b0b52f8 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -98,7 +98,8 @@ static const struct attribute_group iio_trig_prtc_attr_=
group =3D {
>
> =C2=A0static void iio_prtc_trigger_poll(void *private_data)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(private_data);
> + =C2=A0 =C2=A0 =C2=A0 /* Timestamp is not provided currently */
> + =C2=A0 =C2=A0 =C2=A0 iio_trigger_poll(private_data, 0);
> =C2=A0}
>
> =C2=A0static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
> --
> 1.6.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
