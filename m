Return-Path: <jic23@kernel.org>
Message-ID: <4FAE86B4.8060800@kernel.org>
Date: Sat, 12 May 2012 16:50:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Remove unused iio_device_put()
References: <1336741993-30310-1-git-send-email-lars@metafoo.de> <20120512141807.GA30846@kroah.com> <4FAE7296.90903@metafoo.de> <20120512143303.GA1972@kroah.com>
In-Reply-To: <20120512143303.GA1972@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/12/2012 03:33 PM, Greg Kroah-Hartman wrote:
> On Sat, May 12, 2012 at 04:24:22PM +0200, Lars-Peter Clausen wrote:
>> On 05/12/2012 04:18 PM, Greg Kroah-Hartman wrote:
>>> On Fri, May 11, 2012 at 03:13:13PM +0200, Lars-Peter Clausen wrote:
>>>> This function is currently unused and we do not have a matching iio_device_get()
>>>> function either, so just remove it.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>>
>>> No, I see a number of places it should be used.  Don't do "raw"
>>> put_device() calls, every one of them could be making this call instead,
>>> right?
>>
>> Hm, right in the new inkern code there are some put_device calls on
>> indio_dev.dev, I missed those, sorry. But we should really add a matching
>> iio_device_get() as well.
> 
> I agree, and then fix up the inkern.c calls to call that as well :)
> 
> thanks,
> 
> greg k-h
Got to love code evolution and the mess it can leave.  Thanks for
picking up on this Greg.  I'd completely forgotten those were there
when I reviewed it..

Agreed that we want a pair of wrappers and assuming Lars-Peter
will add them if I don't hear anything else :)

Jonathan
