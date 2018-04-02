Return-Path: <tomlebreux@cock.li>
Subject: Re: Moving ad2s90 out of staging
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
References: <63f2588d-0edd-9115-74a4-d0743fb358c1@cock.li>
 <20180317222001.5846a58f@archlinux>
From: Tom Lebreux <tomlebreux@cock.li>
Message-ID: <6d00d7b9-dbae-b542-f670-473d326fa01b@cock.li>
Date: Mon, 2 Apr 2018 14:57:53 -0400
MIME-Version: 1.0
In-Reply-To: <20180317222001.5846a58f@archlinux>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>



On 03/17/2018 06:20 PM, Jonathan Cameron wrote:
> On Wed, 14 Mar 2018 21:29:48 -0400
> Tom Lebreux <tomlebreux@cock.li> wrote:
> 
>> Dear IIO community,
>>
>> I plan on working on the ad2s90 resolver driver. I understand that we do not
>> have hardware to test the drivers, so I will not be adding new features. The
>> work will be mostly about cleaning up the driver.
>>
>> 1. Clean up CHECK (mutex not commented)
>>
>> 2. Sort include alphabetically
>>
>> 3. Reverse christmas tree ordering 
>> I saw this in David's plan for the ad2s1200 driver as well as a patch for an
>> accel driver. However, I did not see this mentionned in
>> Documentation/process/coding-style.rst. Is this necessary, or even wanted ?
> It is one of those things that I wouldn't say is necessary but is moderately
> common.
Alright.

>>
>> 4. Return -EINVAL on spi_read error
>> Currently, on spi_read error, read_raw still returns IIO_VAL_INT. I believe this
>> should be returning -EINVAL, as does, for example, the adxrs450 gyro driver.
> Sounds reasonable.
>>
>> 5. Remove indexed property as there is only 1 channel
> Leave it there.  The ABI allows this and actually if we hadn't originally
> specified it to be fine to not be indexed, I think we would actually make
> it a requirement.  It makes life ever so slightly easier for userspace
> parsing.
> 
I will leave it there.

>>
>> 6. Use a #define for magic number 830000
>> This sets the maximum clock speed of the spi driver. I am struggling to find
>> where this number comes from. Is this number coming from the fact that there
>> needs 600ns between the CS and the first galling edge (mentionned in the 
>> comment right above the assigment)? The data sheet specifies the max SCLK input
>> rate as being 2MHz.
> I'm not sure there is that much to be gained, it's not a magic number
> in the sense that its value really is the frequency.
> Given the comment I'd imagine that we have half a wavelength between the CS and
> falling edge. If that indeed needs to be at least 600ns then this is the maximum
> frequency. as 1/830000 = 1.2microseconds.
> 
> 
> 
I will keep it as is, with the comments. 
>>
>> Is this a good plan ? Am I missing anything important ?
>>
>> This was my first time reading a specification document, learning about
>> resolvers and resolver-to-digital converters.
>>
>> From what I understand, the ad2s90 uses the spi interface to output (only) its
>> absolute position angle. However, it supports many other outputs, such as A, B
>> encoding, direction of rotation of input (DIR) and angular velocity of input
>> signals (VEL). What is used to received these numbers ? Or are they only used
>> to connect directly to other devices ?
> A / B would be signals to an encoder input.  There are quite a few devices
> that have hardware that would interpret that.  The am335x found on a beaglebone
> black for example.  Right now there is an out of tree driver for that, but nothing
> in tree.  See the recent proposal for a counters subsystem.
> 
This hardware stuff is still new to me, thanks for giving me an example. I will take 
a look.

> The velocity input could be connected to any normal ADC.  At that point we
> could support it by using the consumer interfaces for IIO reasonably well.
> However, for now just stick to the absolute position that we can get digitally!
> 
> As for other things.
> IIO_CHAN_INFO_RAW only seems a bit odd given the nature of resolvers
> means we know the 'units' and hence can provide the scale.
> 
Are you saying we should provide the scale in addition to the RAW info? I'm
not sure what the value of the scale should be in this case.

> Otherwise, there is so little to this driver that there can't be much else that
> needs doing!
> 
> Jonathan
Indeed the driver is quite small and simple. Thanks for the plan review.

>>
>> Best regards,
>>
>> Tom Lebreux
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
