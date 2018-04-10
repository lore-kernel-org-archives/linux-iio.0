Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:35616
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751803AbeDJSLP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Apr 2018 14:11:15 -0400
Subject: Re: [PATCH v4 2/2] dt-bindings: iio:imu:mpu6050: support more
 interrupt types
To: Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
References: <20180406220048.29498-1-mkelly@xevo.com>
 <20180406220048.29498-2-mkelly@xevo.com>
 <20180410141237.4jozljz6d5okwo2r@rob-hp-laptop>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <b90d4517-3eee-546d-db6c-2f7a7416a943@xevo.com>
Date: Tue, 10 Apr 2018 11:11:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180410141237.4jozljz6d5okwo2r@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2018 07:12 AM, Rob Herring wrote:
> On Fri, Apr 06, 2018 at 03:00:48PM -0700, Martin Kelly wrote:
>> Document that the inv_mpu6050 driver now supports falling edge, rising
> 
> It's really about what the h/w supports for bindings.
> 

I understand that about devicetree in general, though in this case the 
device supports all these types but the driver did not and would 
silently fail if you gave the wrong type. I wanted to document that it's 
now safe to use the other interrupt types, while before the 
documentation told you (correctly) to use only rising edge.

If you think it's a good idea, I will change the description to 
"Document that the MPU9250 supports ..." to clarify.

>> edge, level low, and level high interrupt types, rather than just rising
>> edge.
>>
>> The language used is the same as that in st_lsm6dsx.txt.
>>
>> Signed-off-by: Martin Kelly <mkelly@xevo.com>
>> ---
>>   Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
