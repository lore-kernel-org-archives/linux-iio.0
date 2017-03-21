Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36017 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757685AbdCUTwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 15:52:42 -0400
Received: by mail-it0-f67.google.com with SMTP id 190so2668386itm.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 12:52:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <087b03c7-9480-67b8-4c95-4248a1381500@kernel.org>
References: <1489995561-6988-1-git-send-email-gs051095@gmail.com> <087b03c7-9480-67b8-4c95-4248a1381500@kernel.org>
From: Gargi Sharma <gs051095@gmail.com>
Date: Wed, 22 Mar 2017 01:22:05 +0530
Message-ID: <CAOCi2DGWWBNNqtE8+C1tAuXLct_5EJcjpx64WEmn1d-3qaw0zQ@mail.gmail.com>
Subject: Re: [PATCH] staging: ade7754: Replace mlock with buf_lock and
 refactor code
To: Jonathan Cameron <jic23@kernel.org>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 22, 2017 at 1:15 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/03/17 07:39, Gargi Sharma wrote:
>> The IIO subsystem is redefining iio_dev->mlock to be used by
>> the IIO core only for protecting device operating mode changes.
>> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>>
>> In this driver, mlock was being used to protect hardware state
>> changes. Replace it with buf_lock in the devices global data.
>>
>> As buf_lock already protects operations in ade7754_write_frequency,
>> there isn't a need to acquire the lock inside ade7754_spi_write_reg_8
>> when writing to the register.
>>
>> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> Question inline.
>> ---
>>  drivers/staging/iio/meter/ade7754.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/m=
eter/ade7754.c
>> index 024463a..eb03469 100644
>> --- a/drivers/staging/iio/meter/ade7754.c
>> +++ b/drivers/staging/iio/meter/ade7754.c
>> @@ -29,6 +29,15 @@ static int ade7754_spi_write_reg_8(struct device *dev=
, u8 reg_address, u8 val)
>>       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>>       struct ade7754_state *st =3D iio_priv(indio_dev);
>>
>> +     if (reg_address =3D=3D ADE7754_WAVMODE) {
>> +             st->tx[0] =3D ADE7754_WRITE_REG(reg_address);
>> +             st->tx[1] =3D val;
>> +
>> +             ret =3D spi_write(st->us, st->tx, 2);
>> +
>> +             return ret;
>> +     }

> This block doesn't fit with the description.  What's going on here?

When the function ade_spi_write_reg_8() is called inside
ade7754_write_frequency(), we are writing to this( ADE7754_WAVMODE)
register. When writing to this register we don=E2=80=99t need to hold the
buf_lock since ade7754_write_frequency() already takes care of that.
This block of code does not use the buf_lock since that is taken care
of by ade7754_write_frequency().

Gargi
>> +
>>       mutex_lock(&st->buf_lock);
>>       st->tx[0] =3D ADE7754_WRITE_REG(reg_address);
>>       st->tx[1] =3D val;
>> @@ -430,7 +439,7 @@ static ssize_t ade7754_write_frequency(struct device=
 *dev,
>>       if (!val)
>>               return -EINVAL;
>>
>> -     mutex_lock(&indio_dev->mlock);
>> +     mutex_lock(&st->buf_lock);
>>
>>       t =3D 26000 / val;
>>       if (t > 0)
>> @@ -451,7 +460,7 @@ static ssize_t ade7754_write_frequency(struct device=
 *dev,
>>       ret =3D ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
>>
>>  out:
>> -     mutex_unlock(&indio_dev->mlock);
>> +     mutex_unlock(&st->buf_lock);
>>
>>       return ret ? ret : len;
>>  }
>>
>
