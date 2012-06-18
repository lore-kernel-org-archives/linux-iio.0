Return-Path: <lars@metafoo.de>
Message-ID: <4FDF2036.7030303@metafoo.de>
Date: Mon, 18 Jun 2012 14:33:58 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 01/10] iio: iio_buffer_register: Skip channels with
 negative scan index
References: <1340019903-13305-1-git-send-email-lars@metafoo.de> <4FDF1A43.7010701@cam.ac.uk> <alpine.DEB.2.01.1206181414060.26163@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1206181414060.26163@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/18/2012 02:15 PM, Peter Meerwald wrote:
> 
>>> index to a negative number, which will cause iio_buffer_register to ignore
>>> the
>>> channel.
> 
> ah, nice, I wondered about the same thing :)
> 
>>> --- a/drivers/iio/industrialio-buffer.c
>>> +++ b/drivers/iio/industrialio-buffer.c
>>> @@ -285,6 +285,9 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>>>   	if (channels) {
>>>   		/* new magic */
>>>   		for (i = 0; i<  num_channels; i++) {
>>> +			if (channels[i].scan_index<  0)
>>> +				continue;
>>> +
>>>   			/* Establish necessary mask length */
>>>   			if (channels[i].scan_index>
>>>   			(int)indio_dev->masklength - 1)
> 
> whitespace before/after < could be improved
> 

That's not in the original patch, Jonathan's mail client seems to like to
mess-up whitespace when quoting a mail. You'll get used to it ;)

- Lars
