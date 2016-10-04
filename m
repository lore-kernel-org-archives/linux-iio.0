Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <e6514e00-7c15-3643-83c6-79a44f98410b@metafoo.de>
References: <20161003192702.24361-1-jic23@kernel.org> <20161003192702.24361-5-jic23@kernel.org> <e6514e00-7c15-3643-83c6-79a44f98410b@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 04/18] staging:iio:accel:sca3000 Fix clearing of flag + setting of size of scan.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 04 Oct 2016 13:28:30 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org
CC: knaack.h@gmx.de,pmeerw@pmeerw.net
Message-ID: <DAB9A23D-09C9-419E-9988-C6FF1F625EB5@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 4 October 2016 09:59:51 BST, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 10/03/2016 09:26 PM, Jonathan Cameron wrote:
>> diff --git a/drivers/staging/iio/accel/sca3000.c
>b/drivers/staging/iio/accel/sca3000.c
>> index 36a52d02ee0e..8af7d83e658d 100644
>> --- a/drivers/staging/iio/accel/sca3000.c
>> +++ b/drivers/staging/iio/accel/sca3000.c
>> @@ -1491,6 +1491,19 @@ error_ret:
>>   **/
>>  static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
>>  {
>> +	/*
>> +	 * Set stuff to read to indicate no data present.
>> +	 * Need for cases where the interrupt had fired at the
>> +	 * end of a cycle, but the data was never read.
>> +	 */
>> +	indio_dev->buffer->stufftoread = 0;
>> +	/*
>> +	 * Needed to ensure the core will actually read data
>> +	 * from the device rather than assuming no channels
>> +	 * are enabled.
>> +	 */
>> +	indio_dev->buffer->bytes_per_datum = 6;
>> +
>
>Shouldn't this be dropped again when switching to kfifo for the buffer?
Good point...

J
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
