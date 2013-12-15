Return-Path: <lars@metafoo.de>
Message-ID: <52ADA8CE.8090309@metafoo.de>
Date: Sun, 15 Dec 2013 14:04:14 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: cm36651: Changed return value of read function
References: <52A5284D.4080906@samsung.com> <52AC3E47.4010007@kernel.org>
In-Reply-To: <52AC3E47.4010007@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/14/2013 12:17 PM, Jonathan Cameron wrote:
> On 12/09/13 02:17, Beomho Seo wrote:
>> Hello,
>>
>> I have fixed cm36651 driver.
>> Some return value of callback have been changed to IIO_VAL_INT.
>> If not IIO_VAL_INT, driver will print wrong value(*_read_int_time) or not print(*_read_prox_thresh).
>>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Applied to the fixes-togreg branch of iio.git
> 
> This is going to cause a merge conflict with the reworking of the event
> handling in the togreg branch, but the solution is simple so shouldn't
> cause any problems (hopefully I'll remember to metion it when I send
> the pull requests!)

Actually the patch should be split into two parts. The first hunk is a fix
for the a problem which is already present in the current (as in Linus tree)
version of the driver. While the problem, which is fixed in the second hunk,
is something I introduced with the conversion to the new style event
interface. So only the first part should go to fixes-togreg and the second
to togreg. I don't think there will be any conflicts that way.

- Lars

>> ---
>>  drivers/iio/light/cm36651.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
>> index 21df571..0206eab 100644
>> --- a/drivers/iio/light/cm36651.c
>> +++ b/drivers/iio/light/cm36651.c
>> @@ -387,7 +387,7 @@ static int cm36651_read_int_time(struct cm36651_data *cm36651,
>>  		return -EINVAL;
>>  	}
>>
>> -	return IIO_VAL_INT_PLUS_MICRO;
>> +	return IIO_VAL_INT;
>>  }
>>
>>  static int cm36651_write_int_time(struct cm36651_data *cm36651,
>> @@ -494,7 +494,7 @@ static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,
>>
>>  	*val = cm36651->ps_ctrl_regs[CM36651_PS_THD];
>>
>> -	return 0;
>> +	return IIO_VAL_INT;
>>  }
>>
>>  static int cm36651_write_prox_thresh(struct iio_dev *indio_dev,
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
