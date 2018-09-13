Return-Path: <SRS0=Myre=L3=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
References: <20180913035145.28056-1-songqiang.1304521@gmail.com>
In-Reply-To: <20180913035145.28056-1-songqiang.1304521@gmail.com>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 13 Sep 2018 14:43:35 -0700
Message-ID: <CAJCx=gk3Md910hfD2ZiTRNj6mv1nf+r6p_0tYMu7uKiEp4ZvOw@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: lidar-v2: replace i2c block access method
 with the one already implemented.
To: songqiang1304521@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, songqiang.1304521@gmail.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Sep 12, 2018 at 8:51 PM Song Qiang <songqiang1304521@gmail.com> wrote:
>
> This driver tries to access a block of data on a i2c bus and it tries
> to manually make a device command frame and a consecutively read frame,
> then uses i2c_transfer() to read data. But this has already been
> implemented in i2c_smbus_read_i2c_block_data().
> Sorry for not having this device by my hand, which is a little expansive
> for me, but I have another i2c device and tested with both i2c_transfer()
> and i2c_smbus_read_i2c_block_data() and they all ends the same.
> I'm not familiar with the SMBus, don't know if the lidar_smbus_xfer()
> function is the same as i2c_smbus_read_block_data()? The original code
> is commented with something I'm not sure, but I think if it's a standard
> SMBus, it should be able to use in here.
> Hoping for someone to explain.
>

Yes actually there is a reason for this insanity!

It isn't actually SMBUS (note the lidar_smbus_xfer function below it)
and has a odd way to read registers via I2C.
Basically the I2C_M_STOP flags is the reason you can use the standard
i2c_smbus_read_i2c_block_data().

Page 6 in this datasheet
* http://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf

> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> ---
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c  | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 47af54f14756..ca880ba8e820 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -63,23 +63,7 @@ static const struct iio_chan_spec lidar_channels[] = {
>
>  static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
>  {
> -       struct i2c_client *client = data->client;
> -       struct i2c_msg msg[2];
> -       int ret;
> -
> -       msg[0].addr = client->addr;
> -       msg[0].flags = client->flags | I2C_M_STOP;
> -       msg[0].len = 1;
> -       msg[0].buf  = (char *) &reg;
> -
> -       msg[1].addr = client->addr;
> -       msg[1].flags = client->flags | I2C_M_RD;
> -       msg[1].len = len;
> -       msg[1].buf = (char *) val;
> -
> -       ret = i2c_transfer(client->adapter, msg, 2);
> -
> -       return (ret == 2) ? 0 : -EIO;
> +       return i2c_smbus_read_i2c_block_data(data->client, reg, len, val);
>  }
>
>  static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
> --
> 2.17.1
>
