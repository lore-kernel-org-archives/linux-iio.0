Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160927181039.GA16272@sayli-HP-15-Notebook-PC>
References: <20160927181039.GA16272@sayli-HP-15-Notebook-PC>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 27 Sep 2016 13:03:00 -0700
Message-ID: <CAKzfze8K65dar8LPkQscSy=ESU7M-P=PY3-VsFS4P_ufvz4fPg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: temperature: maxim_thermocouple: Replace unsigned
 int with __be16/__be32 to fix endianness warnings
To: sayli karnik <karniksayli1995@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 27, 2016 at 11:10 AM, sayli karnik
<karniksayli1995@gmail.com> wrote:
> Fix following endianness warnings using sparse:
> warning: cast to restricted __be16
> warning: cast to restricted __be32
> Use __be16 type for incoming read data when storage_bytes equals 2 and
> __be32 when storage_bytes equals 4.
> Also, the patch fixes the following bug:
> Variable 'buf' which is an unsigned int (32 bits) points to a location where
> only 2 bytes of data are placed during spi_read(). These 2 bytes go in the
> upper bytes. be16_to_cpu() casts buf to 16 bits. When storage_bytes equals 2,
> (for thermocouple chip-MAX6675) this will work on Little Endian systems but
> will give invalid data on Big Endian systems. The patch fixes this bug existing
> on Big Endian systems for chip MAX6675.
> Additionally, the patch removes space after a type cast as suggested by
> checkpatch.pl.

See comments inline.

>
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim thermocouple chips")


Please CC the linux-iio mailing list in the future :)

> ---
> Changes in v3:
> Updated the commit message
> Updated the changelog to include explanation to the bug fix
> Fixed the checkpatch issue: CHECK: No space is necessary after a cast
> Added the fixes tag
>
>  drivers/iio/temperature/maxim_thermocouple.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index 39dd202..01cad6e 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -123,22 +123,24 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
>  {
>         unsigned int storage_bytes = data->chip->read_size;
>         unsigned int shift = chan->scan_type.shift + (chan->address * 8);
> -       unsigned int buf;
> +       __be16 buf1;
> +       __be32 buf2;
>         int ret;
>
> -       ret = spi_read(data->spi, (void *) &buf, storage_bytes);
> -       if (ret)
> -               return ret;
> -
>         switch (storage_bytes) {
>         case 2:
> -               *val = be16_to_cpu(buf);
> +               ret = spi_read(data->spi, (void *)&buf1, storage_bytes);
> +               *val = be16_to_cpu(buf1);

Meh don't really like having buf1, and buf2 esp since they only used
in one branch of the switch statement. And waste 2-4 byte of stack :).

I recommend something like:

case 2: {
        __be16 buf;
        ret = spi_read(data->spi, (void *)&buf1, storage_bytes);
        *val = be16_to_cpu(buf1);
        break;
}
case 4:
....


Or one could also change "unsigned int buf" to "__be32 buf"
And just do the following to fix the big endian system issue:

*val = be32_to_cpu(buf) >> 16;


>                 break;
>         case 4:
> -               *val = be32_to_cpu(buf);
> +               ret = spi_read(data->spi, (void *)&buf2, storage_bytes);
> +               *val = be32_to_cpu(buf2);
>                 break;
>         }
>
> +       if (ret)
> +               return ret;
> +
>         /* check to be sure this is a valid reading */
>         if (*val & data->chip->status_bit)
>                 return -EINVAL;
> --
> 2.7.4
>
