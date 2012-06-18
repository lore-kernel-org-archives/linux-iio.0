Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FDF236D.9000900@cam.ac.uk>
Date: Mon, 18 Jun 2012 13:47:41 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 01/10] iio: iio_buffer_register: Skip channels with
 negative scan index
References: <1340019903-13305-1-git-send-email-lars@metafoo.de> <4FDF1A43.7010701@cam.ac.uk> <alpine.DEB.2.01.1206181414060.26163@pmeerw.net> <4FDF2036.7030303@metafoo.de>
In-Reply-To: <4FDF2036.7030303@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/18/2012 1:33 PM, Lars-Peter Clausen wrote:
> On 06/18/2012 02:15 PM, Peter Meerwald wrote:
>>
>>>> index to a negative number, which will cause iio_buffer_register to ignore
>>>> the
>>>> channel.
>>
>> ah, nice, I wondered about the same thing :)
>>
>>>> --- a/drivers/iio/industrialio-buffer.c
>>>> +++ b/drivers/iio/industrialio-buffer.c
>>>> @@ -285,6 +285,9 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>>>>    	if (channels) {
>>>>    		/* new magic */
>>>>    		for (i = 0; i<   num_channels; i++) {
>>>> +			if (channels[i].scan_index<   0)
>>>> +				continue;
>>>> +
>>>>    			/* Establish necessary mask length */
>>>>    			if (channels[i].scan_index>
>>>>    			(int)indio_dev->masklength - 1)
>>
>> whitespace before/after<  could be improved
>>
>
> That's not in the original patch, Jonathan's mail client seems to like to
> mess-up whitespace when quoting a mail. You'll get used to it ;)
>
Yeah, sorry about that.  No idea why it happens and only does it on my
work machine so never bothered chasing it up!
