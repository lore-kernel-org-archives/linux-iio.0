Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1463522523-25791-1-git-send-email-matt.ranostay@intel.com>
References: <1463522523-25791-1-git-send-email-matt.ranostay@intel.com>
Date: Fri, 27 May 2016 10:34:08 +0300
Message-ID: <CAEnQRZDqQNwWrWLQG3ACwG9tTrM6ecQ2xayD9jKGN+pOmxvmqA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: add datasheet names
From: Daniel Baluta <daniel.baluta@intel.com>
To: Matt Ranostay <matt.ranostay@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 18, 2016 at 1:02 AM, Matt Ranostay <matt.ranostay@intel.com> wrote:
> Add datasheet names for ADC channels to allow iio consumers access.
>
> Cc: daniel.baluta@intel.com

For next patches use the full convention: name + email.

Daniel Baluta <daniel.baluta@intel.com>

> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>

Looks good to me.

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  NOTES: Requires previous ADS1115 patchst applied first
>
>  drivers/iio/adc/ti-ads1015.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index a835423..8be192a 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -110,6 +110,7 @@ static const struct {
>                 .shift = 4,                                     \
>                 .endianness = IIO_CPU,                          \
>         },                                                      \
> +       .datasheet_name = "AIN"#_chan,                          \
>  }
>
>  #define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
> @@ -130,6 +131,7 @@ static const struct {
>                 .shift = 4,                                     \
>                 .endianness = IIO_CPU,                          \
>         },                                                      \
> +       .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>  }
>
>  #define ADS1115_V_CHAN(_chan, _addr) {                         \
> @@ -147,6 +149,7 @@ static const struct {
>                 .storagebits = 16,                              \
>                 .endianness = IIO_CPU,                          \
>         },                                                      \
> +       .datasheet_name = "AIN"#_chan,                          \
>  }
>
>  #define ADS1115_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
> @@ -166,6 +169,7 @@ static const struct {
>                 .storagebits = 16,                              \
>                 .endianness = IIO_CPU,                          \
>         },                                                      \
> +       .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>  }
>
>  struct ads1015_data {
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
