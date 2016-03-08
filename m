Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36039 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbcCHVQW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Mar 2016 16:16:22 -0500
MIME-Version: 1.0
In-Reply-To: <26a4b9ab8ae9b40f9c96c51f12c977fdad36532f.1457459537.git.gregor.boirie@parrot.com>
References: <cover.1457459537.git.gregor.boirie@parrot.com>
	<26a4b9ab8ae9b40f9c96c51f12c977fdad36532f.1457459537.git.gregor.boirie@parrot.com>
Date: Tue, 8 Mar 2016 23:16:20 +0200
Message-ID: <CAEnQRZBsQ4_XPBXfuWu4WL_qLG7fo3ynsWfQ51v=Ya2O6-jXyQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Fixes: 3145229f9191 ("iio:pressure:ms5611: power
 regulator support")
From: Daniel Baluta <daniel.baluta@intel.com>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 8, 2016 at 8:00 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:
> When not compiled-in, regulator layer will return a NULL pointer when
> trying to get a reference to any regulator using devm_regulator_get().  As
> IS_ERR() does not consider this an error, the ms5611 probing operation will
> try to enable a NULL regulator, which will invariably cause a kernel
> crash.
> This patch fixes this situation by using devm_regulator_get_optional()
> instead of devm_regulator_get().
>
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>

$Subject should be here. And the commit subject should be something
more appropriate like:

iio: pressure: ms5611: Fix crash when ...


> ---
>  drivers/iio/pressure/ms5611_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index 37dbc04..a2a871b 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -387,8 +387,8 @@ static const struct iio_info ms5611_info = {
>  static int ms5611_init(struct iio_dev *indio_dev)
>  {
>         int ret;
> -       struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
> -                                                  "vdd");
> +       struct regulator *vdd =
> +               devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
>
>         /* Enable attached regulator if any. */
>         if (!IS_ERR(vdd)) {
> @@ -398,6 +398,10 @@ static int ms5611_init(struct iio_dev *indio_dev)
>                                 "failed to enable Vdd supply: %d\n", ret);
>                         return ret;
>                 }
> +       } else {
> +               ret = PTR_ERR(vdd);
> +               if (ret != -ENODEV)
> +                       return ret;
>         }
>
>         ret = ms5611_reset(indio_dev);
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
