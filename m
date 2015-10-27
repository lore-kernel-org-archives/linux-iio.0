Return-Path: <jeff.dagenais@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1445963139-2158-2-git-send-email-jeff.dagenais@gmail.com>
References: <1445963139-2158-1-git-send-email-jeff.dagenais@gmail.com>
	<1445963139-2158-2-git-send-email-jeff.dagenais@gmail.com>
Date: Tue, 27 Oct 2015 12:34:24 -0400
Message-ID: <CAJTXvSjXGnm9eochAAhE2rKC0Lg1yVVv3QooPAu76sMK+Cskaw@mail.gmail.com>
Subject: Re: [PATCH] iio:dac: fix i2c_master_send return code misuse
From: =?UTF-8?Q?Jean=2DFran=C3=A7ois_Dagenais?= <jeff.dagenais@gmail.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Note: I've made these changes from searching i2c_master_send in v3.19
-- drivers/iio/dac only.

On Tue, Oct 27, 2015 at 12:25 PM, Jean-Francois Dagenais
<jeff.dagenais@gmail.com> wrote:
> Contrary to most kernel functions, successful call to
> i2c_master_send returns the number or written bytes,not 0.
>
> However, these callers return the value as is without converting
> the return style to conform to the expected standard.
>
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
>  drivers/iio/dac/ad5064.c  |  5 ++++-
>  drivers/iio/dac/ad5446.c  |  4 +++-
>  drivers/iio/dac/max517.c  |  6 ++++--
>  drivers/iio/dac/max5821.c |  8 ++++++--
>  drivers/iio/dac/mcp4725.c | 10 ++++++++--
>  5 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index c067e68..0ff1107 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -598,10 +598,13 @@ static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
>         unsigned int addr, unsigned int val)
>  {
>         struct i2c_client *i2c = to_i2c_client(st->dev);
> +       int res;
>
>         st->data.i2c[0] = (cmd << 4) | addr;
>         put_unaligned_be16(val, &st->data.i2c[1]);
> -       return i2c_master_send(i2c, st->data.i2c, 3);
> +       res = i2c_master_send(i2c, st->data.i2c, 3);
> +
> +       return res == 3 ? 0 : res;
>  }
>
>  static int ad5064_i2c_probe(struct i2c_client *i2c,
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 07e17d7..9a49941 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -512,7 +512,9 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
>         struct i2c_client *client = to_i2c_client(st->dev);
>         __be16 data = cpu_to_be16(val);
>
> -       return i2c_master_send(client, (char *)&data, sizeof(data));
> +       int res = i2c_master_send(client, (char *)&data, sizeof(data));
> +
> +       return res == sizeof(data)? 0 : res;
>  }
>
>  /**
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 5507b39..0f3d81fc 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -117,15 +117,17 @@ static int max517_write_raw(struct iio_dev *indio_dev,
>  static int max517_suspend(struct device *dev)
>  {
>         u8 outbuf = COMMAND_PD;
> +       int res = i2c_master_send(to_i2c_client(dev), &outbuf, 1);
>
> -       return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
> +       return res == 1 ? 0 : res;
>  }
>
>  static int max517_resume(struct device *dev)
>  {
>         u8 outbuf = 0;
> +       int res = i2c_master_send(to_i2c_client(dev), &outbuf, 1);
>
> -       return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
> +       return res == 1 ? 0 : res;
>  }
>
>  static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index 28b8748..56f9252 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -278,7 +278,9 @@ static int max5821_suspend(struct device *dev)
>                          MAX5821_EXTENDED_DAC_B |
>                          MAX5821_EXTENDED_POWER_DOWN_MODE2 };
>
> -       return i2c_master_send(to_i2c_client(dev), outbuf, 2);
> +       int res = i2c_master_send(to_i2c_client(dev), outbuf, 2);
> +
> +       return res == 2 ? 0 : res;
>  }
>
>  static int max5821_resume(struct device *dev)
> @@ -288,7 +290,9 @@ static int max5821_resume(struct device *dev)
>                          MAX5821_EXTENDED_DAC_B |
>                          MAX5821_EXTENDED_POWER_UP };
>
> -       return i2c_master_send(to_i2c_client(dev), outbuf, 2);
> +       int res = i2c_master_send(to_i2c_client(dev), outbuf, 2);
> +
> +       return res == 2 ? 0 : res;
>  }
>
>  static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 43d1458..166b607 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -39,12 +39,15 @@ static int mcp4725_suspend(struct device *dev)
>         struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
>                 to_i2c_client(dev)));
>         u8 outbuf[2];
> +       int res;
>
>         outbuf[0] = (data->powerdown_mode + 1) << 4;
>         outbuf[1] = 0;
>         data->powerdown = true;
>
> -       return i2c_master_send(data->client, outbuf, 2);
> +       res = i2c_master_send(data->client, outbuf, 2);
> +
> +       return res == 2 ? 0 : res;
>  }
>
>  static int mcp4725_resume(struct device *dev)
> @@ -52,13 +55,16 @@ static int mcp4725_resume(struct device *dev)
>         struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
>                 to_i2c_client(dev)));
>         u8 outbuf[2];
> +       int res;
>
>         /* restore previous DAC value */
>         outbuf[0] = (data->dac_value >> 8) & 0xf;
>         outbuf[1] = data->dac_value & 0xff;
>         data->powerdown = false;
>
> -       return i2c_master_send(data->client, outbuf, 2);
> +       res = i2c_master_send(data->client, outbuf, 2);
> +
> +       return res == 2 ? 0 : res;
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.1.4
>
