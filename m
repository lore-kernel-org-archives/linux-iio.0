Return-Path: <vlad.dogaru@intel.com>
Date: Mon, 20 Oct 2014 17:27:42 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH v2] iio: add bmp280 pressure and temperature driver
Message-ID: <20141020142742.GB6362@vdogaru>
References: <1412594578-12765-1-git-send-email-vlad.dogaru@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412594578-12765-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 06, 2014 at 02:22:58PM +0300, Vlad Dogaru wrote:
> Minimal implementation, can read temperature and data using direct mode.
> 
> Datasheet available at
> <http://ae-bst.resource.bosch.com/media/products/dokumente/bmp280/BST-BMP280-DS001-09.pdf>
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> ---
> 
> Changes since v1:
>  * report processed values instead of raw ones;
>  * use regmap cache for calibration registers;
>  * check chip id register on probe;
>  * minor style fixes.
> 
> I couldn't find an entry for in_pressure_input in the ABI specification, so I
> assume the units for kilopascal, just as for the raw value.  If needed, I can
> send a patch to add in_pressure_input to the ABI.
> 
>  drivers/iio/pressure/Kconfig  |  11 +
>  drivers/iio/pressure/Makefile |   1 +
>  drivers/iio/pressure/bmp280.c | 455 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 467 insertions(+)
>  create mode 100644 drivers/iio/pressure/bmp280.c

[...]

> +static u32 bmp280_compensate_press(struct bmp280_data *data,
> +				   struct bmp280_comp_press *comp,
> +				   s32 adc_press)
> +{
> +	s64 var1, var2, p;
> +
> +	var1 = ((s64) data->t_fine) - 128000;
> +	var2 = var1 * var1 * (s64) comp->dig_p6;
> +	var2 = var2 + ((var1 * (s64) comp->dig_p5) << 17);
> +	var2 = var2 + (((s64) comp->dig_p4) << 35);
> +	var1 = ((var1 * var1 * (s64) comp->dig_p3) >> 8) +
> +		((var1 * (s64) comp->dig_p2) << 12);
> +	var1 = (((((s64) 1) << 47) + var1)) * ((s64) comp->dig_p1) >> 33;
> +
> +	if (var1 == 0)
> +		return 0;
> +
> +	p = 1048576 - adc_press;
> +	p = (((p << 31) - var2) * 3125) / var1;

This 64bit division causes trouble on x86.  Considering the patch made
it to the testing branch, but not to 'togreg', would you prefer I submit
a v3 or an incremental fix?

Thanks,
Vlad
