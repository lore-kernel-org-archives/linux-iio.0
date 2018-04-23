Return-Path: <SRS0=xslx=HM=xevo.com=mkelly@kernel.org>
Subject: Re: [PATCH v7 2/2] dt-bindings: iio:imu:mpu6050: support more
 interrupt types
To: Jonathan Cameron <jic23@kernel.org>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20180420165401.13076-1-mkelly@xevo.com>
 <20180420165401.13076-2-mkelly@xevo.com>
 <e4b895f2-8730-598c-5716-3dee151de26d@invensense.com>
 <20180421162801.4b8ddc25@archlinux>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <cf9a541f-d266-8ae5-9c59-b4a2661ffb54@xevo.com>
Date: Mon, 23 Apr 2018 09:53:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180421162801.4b8ddc25@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 04/21/2018 08:28 AM, Jonathan Cameron wrote:
> On Fri, 20 Apr 2018 19:05:12 +0200
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
> 
>> On 20/04/2018 18:54, Martin Kelly wrote:
>>> Document that the hardware supports falling edge, rising edge, level
>>> low, and level high interrupt types, rather than just rising edge.
>>>
>>> The language used is the same as that in st_lsm6dsx.txt.
>>>
>>> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> Hi Martin,
> 
> Please pick up an acks / reviewed-by's from earlier versions.
> The chances are I'll miss them some of the time otherwise.
> Rob acked this one.
> 
> Applied with the two acks I know of to the togreg branch of iio.git
> and pushed out as testing for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> 

OK, I'll try to remember to do that in the future.
