Return-Path: <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] iio: pressure: bmp280: fix runtime suspend/resume crash
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1469651578-6085-1-git-send-email-linus.walleij@linaro.org>
Date: Mon, 8 Aug 2016 19:48:56 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 Akinobu Mita <akinobu.mita@gmail.com>,
 Matt Ranostay <mranostay@gmail.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Christoph Mair <christoph.mair@gmail.com>,
 Vlad Dogaru <vlad.dogaru@intel.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Marek Belisko <marek@goldelico.com>,
 Eric Andersson <eric.andersson@unixphere.com>,
 Neil Brown <neilb@suse.de>
Message-Id: <282AB1B2-89D0-4B87-A932-D67B5FC6C0FA@goldelico.com>
References: <1469651578-6085-1-git-send-email-linus.walleij@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Linus,
I can confirm that the crash exists.

But is it possible to download / pull the patch from somewhere?
It did not yet appear in linux-next. Is it applied to some other git =
repo?

Unfortunately linux-iio isn't available in patchwork.kernel.org and this =
patch didn't cc: to lkml.

And the trick I just recently learned how to download it from gmane does =
not work any more.

Finally markinfo does not appear to have a binary download either which =
preserves subject&headers.

	http://marc.info/?l=3Dlinux-iio&m=3D146965159217655&w=3D2

Well, I can still pull from this e-mail or copy&paste into a text file, =
but sometimes formatting can go wrong.

BR and thanks,
Nikolaus


> Am 27.07.2016 um 22:32 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> In commit 3d838118c6aa ("iio: pressure: bmp280: add power management")
>=20
> For some reason the code in the runtime suspend/resume hooks
> got wrong (I suspect in the ambition to cut down boilerplate)
> and it seems it was tested without CONFIG_PM and crashes like
> so for me:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address =
0000000c
> pgd =3D c0204000
> [0000000c] *pgd=3D00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 89 Comm: kworker/1:2 Not tainted
>  4.7.0-03348-g90dc3680458a-dirty #99
> Hardware name: Generic DT based system
> Workqueue: pm pm_runtime_work
> task: df3c6300 ti: dec8a000 task.ti: dec8a000
> PC is at regulator_disable+0x0/0x6c
> LR is at bmp280_runtime_suspend+0x3c/0xa4
>=20
> Dereferencing the BMP280 state container properly fixes the problem,
> sorry for screwing up.
>=20
> Fixes: 3d838118c6aa ("iio: pressure: bmp280: add power management")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> drivers/iio/pressure/bmp280-core.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c =
b/drivers/iio/pressure/bmp280-core.c
> index 6943688e66df..724fefd4af00 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1079,7 +1079,8 @@ EXPORT_SYMBOL(bmp280_common_remove);
> #ifdef CONFIG_PM
> static int bmp280_runtime_suspend(struct device *dev)
> {
> -	struct bmp280_data *data =3D dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct bmp280_data *data =3D iio_priv(indio_dev);
> 	int ret;
>=20
> 	ret =3D regulator_disable(data->vdda);
> @@ -1090,7 +1091,8 @@ static int bmp280_runtime_suspend(struct device =
*dev)
>=20
> static int bmp280_runtime_resume(struct device *dev)
> {
> -	struct bmp280_data *data =3D dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct bmp280_data *data =3D iio_priv(indio_dev);
> 	int ret;
>=20
> 	ret =3D regulator_enable(data->vddd);
> --=20
> 2.7.4
>=20
