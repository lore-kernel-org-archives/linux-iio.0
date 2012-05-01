Return-Path: <josephdanielwalter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4F9EEFB2.8030201@metafoo.de>
References: <1335813977-8096-1-git-send-email-josephdanielwalter@gmail.com>
	<4F9EEFB2.8030201@metafoo.de>
Date: Tue, 1 May 2012 10:08:14 +0600
Message-ID: <CAFDqYy0ErgwdUviwCBigYmpaV0__t3PMNg_XWOptSvdjeLwoww@mail.gmail.com>
Subject: Re: [PATCH] staging/iio/meter: fix the coding style problem
From: joseph daniel <josephdanielwalter@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <w.sang@pengutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 1, 2012 at 2:01 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 04/30/2012 09:26 PM, joseph daniel wrote:
>> Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
>> ---
>> Hi Lars,
>> =A0 =A0 =A0 Thanks for review. how about the below change?
>> =A0drivers/staging/iio/meter/ade7854-i2c.c | =A0 =A06 +++++-
>> =A01 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/i=
io/meter/ade7854-i2c.c
>> index 1e1faa0..52bdb05 100644
>> --- a/drivers/staging/iio/meter/ade7854-i2c.c
>> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
>> @@ -181,6 +181,7 @@ static int ade7854_i2c_read_reg_32(struct device *de=
v,
>> =A0{
>> =A0 =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> =A0 =A0 =A0 struct ade7854_state *st =3D iio_priv(indio_dev);
>> + =A0 =A0 uint32_t value;
>> =A0 =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 mutex_lock(&st->buf_lock);
>> @@ -195,7 +196,10 @@ static int ade7854_i2c_read_reg_32(struct device *d=
ev,
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> - =A0 =A0 *val =3D (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] <<=
 8) | st->rx[3];
>> + =A0 =A0 memcpy(&value, st->rx, sizeof(uint32_t));
>> +
>
> Uhm, yes, you are right st->rx is unaligned. The memcpy is not necessary =
though
> if you use get_unaligned_be32. Sorry for the pointer to the wrong functio=
n.
>
> Btw. there are a few other locations in this driver which could use the
> put_unaligned_be* and get_unaligned_be* functions. Would be great if you =
could
> convert these as well.
>
>> + =A0 =A0 *val =3D be32_to_cpu(value);
>> +
>> =A0out:
>> =A0 =A0 =A0 mutex_unlock(&st->buf_lock);
>> =A0 =A0 =A0 return ret;
>

Thanks for review. i will be glad doing those changes. i will send
patch as soon as i get free.

Thanks.
Joseph.
