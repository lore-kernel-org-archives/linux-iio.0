Return-Path: <jcsistemas2001@gmail.com>
MIME-Version: 1.0
In-Reply-To: <566C1493.7090002@jic23.retrosnub.co.uk>
References: <CAAn_ec90t=N1e1m8aUcBZRb5wsRwiz56WUzFCWqTrVHHhcAuBA@mail.gmail.com>
	<566C0A32.3030104@kernel.org>
	<CAAn_ec_=9syP4j+g5GRMCB-+7vCWE1XqryE6KWUm=auUBZE=uQ@mail.gmail.com>
	<566C1493.7090002@jic23.retrosnub.co.uk>
Date: Sat, 12 Dec 2015 20:41:55 +0800
Message-ID: <CAAn_ec_5UcQ5GVFx=byU6sKJ9u33LmUzFvoRvVgTko4GfDHnOA@mail.gmail.com>
Subject: Re: read /dev/iio:device0 return -1 (Invalid argument)
From: Julio Cruz <jcsistemas2001@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

OK, I understood! Thanks

I will use 32 bits for storage in all the channels

On Sat, Dec 12, 2015 at 8:35 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On 12/12/15 12:24, Julio Cruz wrote:
>> HI Jonathan,
> Hi Julio
>
> I've kept the list cc'd as this sort of conversation acts as
> 'free' documentation solving other people's problems in future.
>
>>
>> Thanks for your quick reply.
>>
>> When you mention the alignment, I remember some things that I did
>> about it, as below.
>>
>> When I started testing the _trigger_handler, I found that the driver
>> calculate indio_dev->scan_bytes. This value is not clear to me
>> because, for example, 1 channel is 3 bytes,
> It shouldn't be. Padding is to the nearest power of 2 bytes so should
> be 4.  The non power of two realbits may have resulted in an unexpected
> path in which case we should add a sanity check to catch this.
>> and for 2 channels is 8
>> bytes (1 byte padding). The channel spec are realbits = 24 and
>> storagebits = 24.
> Storage bits should be a power of 2.  So in this case 32 bytes.
> Might seem wasteful but processors handle aligned data a lot
> more easily so to keep rates up it is usually better to burn a small
> amount of memory and keep everything aligned.
>
>  At that point, I fixed the frame buffer size to 27
>> (used at iio_push_to_buffers) assuming that the same buffer could be
>> read at user space.
>>
>> Please, may I know if this approach is correct?
> Sorry nope, the buffer structure assumes power of 2 alignment everywhere.
>>
>> The SPI device send 9 channels, 3 bytes each one (for a total of 27
>> bytes) and each channels is 24 bits width.
> Unfortunately you'll have to do unpacking of this before pushing to the buffer.
> It'll have to happen somewhere anyway (as userspace code would need to unpack
> it otherwise).
>
> It's actually relatively unusual to find a device that does this sort of
> packing.  We have talked in the past about allowing this sort of packing and
> modifying the buffer infrastructure to accept it, but I'm unconvinced that
> it is worth the added complexity + cost in userspace complexity.
>
> Jonathan
>>
>> Thanks
>>
>> Julio
>>
>>
>> On Sat, Dec 12, 2015 at 7:51 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 12/12/15 08:36, Julio Cruz wrote:
>>>> Hi,
>>>>
>>>> I get an error trying to read /dev/iio:device0 in a custom application
>>>> (C/C++), however in a terminal the command "cat /dev/iio_device0"
>>>> return data.
>>>>
>>>> Below the procedure:
>>>>
>>>> - enable channels
>>>> - setup trigger
>>>> - setup buffer lenght
>>>> - enable buffer (the SPI interrupt is setup properly and all the
>>>> trigger handler are done)
>>>> - read /dev/iio_device0
>>>>
>>>> It's a SPI device acquiring 27 bytes @ 1KHz.
>>> Reading this again after point 4 below this makes me ask the question
>>> what are you pushing into the buffer? 27 bytes seems unlikely given
>>> the alignment requirements.
>>>
>>>>
>>>> Results:
>>>>
>>>> 1. Custom application (based on generic_buffer.c): function 'read'
>>>> return -1 and strerror(errno) return "Invalid argument"
>>>> 2. iio_readdev (libiio): show the message "Unable to refill buffer:
>>>> Input/output error"
>>>> 3. In terminal, the command "cat /dev/iio_device0" show values (no
>>>> readable) while the buffer is enable.
>>>>
>>>> Any suggestion?
>>>>
>>>> Thanks for your help!
>>> Sounds like you are ultimately getting that error from a call to
>>>  iio_buffer_read_first_n_outer
>>> so what can return -EINVAL (which is -1)?
>>>
>>> 1) Buffer not being allocated (seems unlikely - that's really just to
>>> pick up on bugs in side the driver)
>>> 2) read_first_n from the buffer not supplied - again not likely.
>>> 3) wait_event_interruptible returns it - unlikely.
>>> 4) read_first_n which comes from the buffer implementation is returning -EINVAL
>>> This last one seems most likely.
>>>
>>> So I am guessing you are using the kfifo buffer (most common option).
>>> Reasons this can return -EINVAL are
>>> 1) kfifo not initialized (unlikely)
>>> 2) Read length is less than the buffer element size (which is the full scan storage
>>> size)
>>> 3) an error from kfifo_to_user (unlikely)
>>>
>>> So I'm guessing you are reading too small an amount of data. (tricky to chase
>>> down without adding further printk's etc to the relevant bits of kernel code)
>>> If I've 'guessed' right, interesting question is how this came about.
>>> How many bytes is it trying to read?
>>>
>>> Note that IIO has strict alignment requirements - any element must be aligned
>>> to it's own size and this will in some case add lots of padding.  The full buffer
>>> element will be a multiple of the largest element in the scan.  If you have a timestamp
>>> for example at 64bits the whole buffer element will be a multiple of 8bytes.
>>>
>>> Jonathan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>
