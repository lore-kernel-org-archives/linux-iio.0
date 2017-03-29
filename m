Return-Path: <SRS0=mqMI=3G=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1490790791-5694-2-git-send-email-singhalsimran0@gmail.com>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com> <1490790791-5694-2-git-send-email-singhalsimran0@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 29 Mar 2017 19:16:11 +0300
Message-ID: <CAEnQRZCDO=qHY0c4-aXV12SiUTT3Jzndu=pY6qjx_=ATxrQBKg@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 1/4] iio: common: st_sensors: Replace
 ternary operator with min macro
To: simran singhal <singhalsimran0@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 29, 2017 at 3:33 PM, simran singhal
<singhalsimran0@gmail.com> wrote:
> Use macro min() to get the minimum of two values for brevity and
> readability.
>
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> ---
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index c83df4d..7a68fdd 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -39,7 +39,7 @@ static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb,
>         *res_byte = err & 0xff;
>
>  st_accel_i2c_read_byte_error:
> -       return err < 0 ? err : 0;
> +       return min(err, 0);
>  }

Appreciate the brevity but this certainly doesn't make code
easier to read.

In linux kernel err < 0 signifies an error and be replacing
comparison < 0 with min() we some hide the meaning of this.

thanks,
Daniel.
