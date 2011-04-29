Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DBAB240.80108@cam.ac.uk>
Date: Fri, 29 Apr 2011 13:42:40 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
 Michael.Hennerich@analog.com
Subject: Re: [RFC PATCH] IIO: break out const elements of iio_dev configuration
References: <1303898975-26215-1-git-send-email-jic23@cam.ac.uk> <201104271558.37971.arnd@arndb.de> <4DB830CB.8060905@cam.ac.uk>
In-Reply-To: <4DB830CB.8060905@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Bump.  All: Yes or no to this?  It'll have to be one mass change patch.
Arnd is in favour. I can see the long term advantages.

We could push this in before chan_spec introduction then add the new
stuff to it as we go.  Or I can leave it at the top of my tree after
all the changes that are queued up as one mass change patch.

Either is fine with me - perhaps even push this on to Greg very late
indeed so any new drivers for the next merge window are moved over as well?


On 04/27/11 16:05, Jonathan Cameron wrote:
> On 04/27/11 14:58, Arnd Bergmann wrote:
>> On Wednesday 27 April 2011, Jonathan Cameron wrote:
>>> In conclusion max1363 gets bigger in all ways if we break this
>>> stuff out.  That is just down to the large number of devices supported.
>>> lis3l02dq which supports only one part gets smaller.
>>>
>>> So not a clear descision either way as far as I am concerned, but
>>> putting the channel_spec into this structure is pretty costly for
>>> typical multipart drivers.
>>>
>>> So the upshot of this RFC to my mind is: Is the clarity gained
>>> a good idea?
>>>
>>> What do people think?
>>
>> I suggested this initially, so it shouldn't surprise that I like
>> the patch.
>>
>> For the increase in size, that seems to be purely because of the
>> change in one data structure from bool to pointer, right?
>> If you reorder the members of max1363_chip_info to remove the
>> padding, I think you can make up for that.
> Changes in there were a bit more than that, but I take your point.
> The difference is pretty minor.  The size argument was more one
> for avoiding putting chan_spec structures in the iio_info struct.
> That meant a lot more variants of the iio_info structs were needed
> in that driver.  It was kind of obvious from the lines of code that
> would need to be added as well, but I had the size numbers too hand.
> 
> For reference, reordering max1363_chip_info gets us:
> 
> 26571   drivers/staging/iio/adc/max1363.ko
> and
> max1363                15884  0
> 
> So not a great saving - but the difference are pretty trivial anyway
> and there are sure to be numerous other ways of making minor savings
> in that driver! (can get to 15748 merely by making num_modes a u8)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
