Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53783 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964798AbcJVRdP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:33:15 -0400
Subject: Re: [PATCH 07/13] staging:iio:ad7606: Factor out common code between
 periodic and one-shot capture
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-8-git-send-email-lars@metafoo.de>
 <cc407e3d-ab6c-095d-f42e-a9a0b31366de@kernel.org>
 <3c0825fe-98bd-d583-0eb9-4d010b8ebc00@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f8d8f2bb-d2b5-dd46-a50f-bf3abf99679b@kernel.org>
Date: Sat, 22 Oct 2016 18:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <3c0825fe-98bd-d583-0eb9-4d010b8ebc00@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/10/16 18:20, Lars-Peter Clausen wrote:
> On 10/22/2016 07:02 PM, Jonathan Cameron wrote:
> [...]
>>> +	ret = ad7606_read_samples(st);
>> I personally always slightly prefer the 'good' path to not be out of the
>> 'direct' flow.
>>
>> Still minor point and I don't care that much!
> 
> Somewhat agreed, but if I did
> 
> 	if (ret)
> 		goto done;
> 	iio_push_to_buffers_with_timestamp(...)
> 
> 	done:
> 
> It would probably be 5 minutes until somebody sends a cocci generated patch
> to 'fix' this ;)
I'm good at ignoring those ones ;)

J
> 
>>> +	if (ret == 0)
>>> +		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>>> +						   iio_get_time_ns(indio_dev));
>>>  
>>> -	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
>>> -					   iio_get_time_ns(indio_dev));
>>> -done:
>>>  	gpio_set_value(st->pdata->gpio_convst, 0);
>>>  	iio_trigger_notify_done(indio_dev->trig);
>>>  }
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

