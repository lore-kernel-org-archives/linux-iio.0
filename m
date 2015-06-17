Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <942e9ba3437c35f946e6979ca63469941f81f289.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
	<942e9ba3437c35f946e6979ca63469941f81f289.1434492557.git.knaack.h@gmx.de>
Date: Wed, 17 Jun 2015 13:09:10 +0300
Message-ID: <CAEnQRZD0yUgHKgcQ3tmctfYTLVnAKh0y-9yEmZ=EMYprwc5HAw@mail.gmail.com>
Subject: Re: [PATCH 4/7] iio:light:cm3323: drop barely used variable
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 17, 2015 at 1:17 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> In cm3323_disable() ret is just used to check for errors during I2C write.
> Consolidate the write and the check to save a variable and two lines of
> code.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

I don't really like this. It makes code harder to read.

Other opinions?

> ---
>  drivers/iio/light/cm3323.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index f88a0ed..8945e0c 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -106,12 +106,10 @@ static int cm3323_init(struct iio_dev *indio_dev)
>
>  static void cm3323_disable(struct iio_dev *indio_dev)
>  {
> -       int ret;
>         struct cm3323_data *data = iio_priv(indio_dev);
>
> -       ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
> -                                       CM3323_CONF_SD_BIT);
> -       if (ret < 0)
> +       if (i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
> +                                     CM3323_CONF_SD_BIT) < 0)
>                 dev_err(&data->client->dev, "Error writing reg_conf\n");
>  }
>
> --
