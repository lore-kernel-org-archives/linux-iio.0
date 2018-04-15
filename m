Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:46434
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752470AbeDOTFU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 15:05:20 -0400
Subject: Re: [PATCH v5 1/2] iio:imu: inv_mpu6050: support more interrupt types
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20180409202128.5031-1-mkelly@xevo.com>
 <64b0a5c7-ee8d-d1ca-b3aa-a1801f19787c@invensense.com>
 <6e3f08f8-ec16-e67b-c68c-7020eb660b14@xevo.com>
 <2ab59fc6-49c9-7426-fe95-824a165cfefa@invensense.com>
 <ef871439-f42f-cb7d-6dc3-4e0c47ff8986@xevo.com>
 <20180415184351.544f4bfa@archlinux>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <b282fe90-a16c-1dd5-f88f-84b73af3f989@xevo.com>
Date: Sun, 15 Apr 2018 12:05:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180415184351.544f4bfa@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/15/2018 10:43 AM, Jonathan Cameron wrote:
> On Wed, 11 Apr 2018 09:42:14 -0700
> Martin Kelly <mkelly@xevo.com> wrote:
> 
>> On 04/11/2018 12:01 AM, Jean-Baptiste Maneyrol wrote:
>>> This is OK for me.
>>>
>>> Jonathan will tell us about EBUSY error code for sure if it is not correct.
>>>
>>> JB
>>>    
>>
>> Sounds good; once we hear from Jonathan, I will submit the next revision.
> Optimists.  I can never make my mind up on some of the error codes.
> 
> It's not totally silly so I'm happy with EBUSY or ENODEV as you wish.
> 
> Jonathan
> 

OK, then I will defer to Jean-Baptiste on this. Shall we go with ENODEV?
