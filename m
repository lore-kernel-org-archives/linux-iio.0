Return-Path: <manuel.stahl@iis.fraunhofer.de>
Message-ID: <5326A29B.6020307@iis.fraunhofer.de>
Date: Mon, 17 Mar 2014 08:22:03 +0100
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: inv_mpu6050: Enable default bypass mode
References: <1394571854-6737-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1394571854-6737-2-git-send-email-srinivas.pandruvada@linux.intel.com> <5324795B.50509@kernel.org>
In-Reply-To: <5324795B.50509@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Am 15.03.2014 17:01, schrieb Jonathan Cameron:
> On 11/03/14 21:04, Srinivas Pandruvada wrote:
>> This chip has two modes to control secondary sensor attached to it.
>> One is master mode and another is bypass mode. In master mode
>> MPU6500 will directly communicates to the secondary sensor device
>> attached to it. This can support very few secondary devices in this
>> mode.
>> But when configured in bypass mode the i2c lines are directly connected
>> to host i2c bus controller.
>> Since in master mode it can only support few devices and they are not
>> implemented in this driver, set the default mode to bypass mode.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> This has been proposed before by Manuel Stahl,
>
> Please read the thread from
>
> http://www.spinics.net/lists/linux-iio/msg11985.html
>
> In short, the best way we have come up with for handling this cleanly
> (avoiding issues with the device in between going into sleep etc) was
> to implement an i2c bus multiplexer with 1 input and 1 output as part of
> the driver.
>
> Manuel, any progress on your patches?

No, I was waiting for the outcome of this discussion. Probably I will 
not be available for the next three weeks, so if someone else wants to 
start off coding, feel free to do so.

-- 
Regards,
Manuel Stahl
