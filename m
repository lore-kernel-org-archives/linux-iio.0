Return-Path: <SRS0=SU3E=HG=xevo.com=mkelly@kernel.org>
Subject: Re: [PATCH v5 1/2] iio:imu: inv_mpu6050: support more interrupt types
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20180409202128.5031-1-mkelly@xevo.com>
 <64b0a5c7-ee8d-d1ca-b3aa-a1801f19787c@invensense.com>
 <6e3f08f8-ec16-e67b-c68c-7020eb660b14@xevo.com>
 <2ab59fc6-49c9-7426-fe95-824a165cfefa@invensense.com>
 <ef871439-f42f-cb7d-6dc3-4e0c47ff8986@xevo.com>
 <20180415184351.544f4bfa@archlinux>
 <b282fe90-a16c-1dd5-f88f-84b73af3f989@xevo.com>
 <f4c27917-80e7-340d-6f51-42a44f161777@invensense.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <ca4ac214-d85f-bf9a-07db-31f72afbb95b@xevo.com>
Date: Tue, 17 Apr 2018 11:14:22 -0700
MIME-Version: 1.0
In-Reply-To: <f4c27917-80e7-340d-6f51-42a44f161777@invensense.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/17/2018 07:10 AM, Jean-Baptiste Maneyrol wrote:
> 
> 
> On 15/04/2018 21:05, Martin Kelly wrote:
>> On 04/15/2018 10:43 AM, Jonathan Cameron wrote:
>>> On Wed, 11 Apr 2018 09:42:14 -0700
>>> Martin Kelly <mkelly@xevo.com> wrote:
>>>
>>>> On 04/11/2018 12:01 AM, Jean-Baptiste Maneyrol wrote:
>>>>> This is OK for me.
>>>>>
>>>>> Jonathan will tell us about EBUSY error code for sure if it is not 
>>>>> correct.
>>>>>
>>>>> JB
>>>>
>>>> Sounds good; once we hear from Jonathan, I will submit the next 
>>>> revision.
>>> Optimists.  I can never make my mind up on some of the error codes.
>>>
>>> It's not totally silly so I'm happy with EBUSY or ENODEV as you wish.
>>>
>>> Jonathan
>>>
>>
>> OK, then I will defer to Jean-Baptiste on this. Shall we go with ENODEV?
> 
> After looking into the irq kernel code, I think perhaps the best value 
> should be EINVAL. What it really means, is that configuration is missing 
> in the dts file where it shouldn't. Incorrect value seams more 
> meaningful in this case.
> 
> Do you agree?
> 
> JB

Yes, EINVAL is fine with me. I didn't use it because there was a note in 
the aforementioned document saying that it's best to use a more specific 
error code. However, none of these error codes have a clear case for 
their use, and it's all a bit muddled, as Jonathan mentioned. I'll send 
a revision with EINVAL later this week when I'm back to my desk with 
hardware to test.
