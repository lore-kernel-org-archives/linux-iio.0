Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:53055 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935714AbcJVRUG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:20:06 -0400
Subject: Re: [PATCH 07/13] staging:iio:ad7606: Factor out common code between
 periodic and one-shot capture
To: Jonathan Cameron <jic23@kernel.org>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-8-git-send-email-lars@metafoo.de>
 <cc407e3d-ab6c-095d-f42e-a9a0b31366de@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3c0825fe-98bd-d583-0eb9-4d010b8ebc00@metafoo.de>
Date: Sat, 22 Oct 2016 19:20:00 +0200
MIME-Version: 1.0
In-Reply-To: <cc407e3d-ab6c-095d-f42e-a9a0b31366de@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/22/2016 07:02 PM, Jonathan Cameron wrote:
[...]
>> +	ret = ad7606_read_samples(st);
> I personally always slightly prefer the 'good' path to not be out of the
> 'direct' flow.
> 
> Still minor point and I don't care that much!

Somewhat agreed, but if I did

	if (ret)
		goto done;
	iio_push_to_buffers_with_timestamp(...)

	done:

It would probably be 5 minutes until somebody sends a cocci generated patch
to 'fix' this ;)

>> +	if (ret == 0)
>> +		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>> +						   iio_get_time_ns(indio_dev));
>>  
>> -	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>> -					   iio_get_time_ns(indio_dev));
>> -done:
>>  	gpio_set_value(st->pdata->gpio_convst, 0);
>>  	iio_trigger_notify_done(indio_dev->trig);
>>  }
>>
> 

