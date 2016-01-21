Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160121091238.GA9430@IND12F0122>
References: <20160121091238.GA9430@IND12F0122>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 21 Jan 2016 11:21:53 -0800
Message-ID: <CAKzfze_t39zoDv16ng04NpVLW1PG3n5WtCnvVp=Amh4EKme2FA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: replace clk_get() with devm_clk_get()
To: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"ciorneiioana@gmail.com" <ciorneiioana@gmail.com>,
	"hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jan 21, 2016 at 1:11 AM, Gujulan Elango, Hari Prasath (H.)
<hgujulan@visteon.com> wrote:
> From: Hari Prasath Gujulan Elango
>
> This patch replaces the clk_get() with devm_clk_get().
> Accordingly,modified the error paths and removed clk_put() as well.
>
> Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
> ---
>  drivers/staging/iio/adc/spear_adc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
> index 712cae0..4ac0f54 100644
> --- a/drivers/staging/iio/adc/spear_adc.c
> +++ b/drivers/staging/iio/adc/spear_adc.c
> @@ -288,7 +288,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>         st->adc_base_spear3xx =
>                 (struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
>
> -       st->clk = clk_get(dev, NULL);
> +       st->clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(st->clk)) {
>                 dev_err(dev, "failed getting clock\n");
>                 goto errout1;
> @@ -297,7 +297,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>         ret = clk_prepare_enable(st->clk);
>         if (ret) {
>                 dev_err(dev, "failed enabling clock\n");
> -               goto errout2;
> +               goto errout1;
>         }
>
>         irq = platform_get_irq(pdev, 0);
> @@ -356,8 +356,6 @@ static int spear_adc_probe(struct platform_device *pdev)
>
>  errout3:
>         clk_disable_unprepare(st->clk);

Shouldn't errout3 now be errout2.. having a gap would seem odd.

> -errout2:
> -       clk_put(st->clk);
>  errout1:
>         iounmap(st->adc_base_spear6xx);
>         return ret;
> --
> 1.9.1
