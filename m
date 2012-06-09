Return-Path: <lars@metafoo.de>
Message-ID: <4FD33871.6080107@metafoo.de>
Date: Sat, 09 Jun 2012 13:50:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio: Add support for multiple buffers
References: <1338406594-14550-1-git-send-email-jic23@kernel.org> <1338406594-14550-2-git-send-email-jic23@kernel.org> <4FD216B2.7080504@metafoo.de> <4FD33EC3.3010505@kernel.org>
In-Reply-To: <4FD33EC3.3010505@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 06/09/2012 02:17 PM, Jonathan Cameron wrote:
>>> [...]
>>> @@ -534,31 +453,186 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev, const long *mask,
>>>  	return bytes;
>>>  }
>>>  
>>> -int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>>> +int iio_update_buffers(struct iio_dev *indio_dev,
>>> +		       struct iio_buffer *insert_buffer,
>>> +		       struct iio_buffer *remove_buffer)
>>>  {
>>> -	struct iio_buffer *buffer = indio_dev->buffer;
>>> -	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>>> +	int ret;
>>
>> drivers/iio/industrialio-buffer.c: In function ‘iio_update_buffers’:
>> drivers/iio/industrialio-buffer.c:460: warning: ‘ret’ may be used
>> uninitialized in this function
>>
>> I think there a missing 'return 0', before the error handling. Right now the
>> code always sets active_scan_mask to NULL.
> The setting to NULL definitely isn't right, but we do still need to
> free the compoundmask.  I'll fix that up.

Only if compoundmask != active_scan_mask
