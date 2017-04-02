Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47461 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdDBJMW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:12:22 -0400
Subject: Re: [PATCH 2/2] iio:imu:mpu6050 add explicit mpu9250 support
To: Rob Herring <robh@kernel.org>
References: <20170326111100.2571-1-jic23@kernel.org>
 <20170326111100.2571-3-jic23@kernel.org>
 <20170330231846.j45psrzast3pjc5b@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Mark.Rutland@arm.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <636acb36-58d3-e54a-8536-3702f9e1cae3@kernel.org>
Date: Sun, 2 Apr 2017 10:12:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170330231846.j45psrzast3pjc5b@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 00:18, Rob Herring wrote:
> On Sun, Mar 26, 2017 at 12:11:00PM +0100, Jonathan Cameron wrote:
>> The mpu9250 is a SIP containing an mpu6500 and an ak8975.  If this was all
>> there was too it there would be no need for explicit handling in the driver.
>> Arguably the bindings would also only reflect the presence of an mpu6500 with
>> the ak8975 hanging off it, as the kernel doesn't care that they are in one
>> package.
>>
>> However, the WHOAMI value changes as well so best to add explicit support.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 2 +-
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c                | 6 ++++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c                 | 5 +++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                 | 2 ++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c                 | 1 +
>>  5 files changed, 15 insertions(+), 1 deletion(-)
> 
> Same one per line comment, but
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Fixed up and applied.  Thanks Rob.

Jonathan
