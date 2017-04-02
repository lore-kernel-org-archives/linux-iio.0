Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47434 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdDBJJx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:09:53 -0400
Subject: Re: [PATCH 1/2] iio:imu:mpu6050 update i2c bindings to reflect
 i2c-gate and supported parts
To: Rob Herring <robh@kernel.org>
References: <20170326111100.2571-1-jic23@kernel.org>
 <20170326111100.2571-2-jic23@kernel.org>
 <20170330230252.cxbdh3g744qwdtfh@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Mark.Rutland@arm.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ab168948-10f9-025b-6775-a7158e081481@kernel.org>
Date: Sun, 2 Apr 2017 10:09:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170330230252.cxbdh3g744qwdtfh@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 00:02, Rob Herring wrote:
> On Sun, Mar 26, 2017 at 12:10:59PM +0100, Jonathan Cameron wrote:
>> These bindings are somewhat lagging the state of the driver.  The i2c-gate
>> bindings are documented elsewhere, but it seems sensible to at least have
>> an example and cross reference in here.  SPI bindings will need to be the
>> subject of a future patch.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 23 ++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>> index a9fc11e43b45..e18e04f3c6f4 100644
>> --- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>> +++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
>> @@ -3,14 +3,17 @@ InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
>>  http://www.invensense.com/mems/gyro/mpu6050.html
>>  
>>  Required properties:
>> - - compatible : should be "invensense,mpu6050"
>> + - compatible : should be "invensense,mpu6050", "invensense,mpu6500",
>> +   "invensense,mpu9150" or "invensense,icm20608"
> 
> One per line please. With that,
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Fixed and applied.

