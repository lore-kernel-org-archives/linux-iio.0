Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0070.outbound.protection.outlook.com ([104.47.32.70]:7680
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752322AbeC1QlA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Mar 2018 12:41:00 -0400
Subject: Re: How to handle missing timestamps? (was Re: [PATCH] iio: imu:
 inv_mpu6050: improve missing timestamp handling)
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20180324000240.19519-1-mkelly@xevo.com>
 <20180324123519.0acba88e@archlinux>
 <7c1718f2fc324eb6b959257a80e136cdCY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
 <cc66bed2-ef59-ea75-d26d-f5ed55b55a65@xevo.com>
 <CY4PR1201MB0184826F66D8C1439D2FA6D1C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
 <d18234ce-f311-17df-1281-26ea3f035e13@xevo.com>
 <CY4PR1201MB0184E34B46C1C56A7C38CFC9C4A30@CY4PR1201MB0184.namprd12.prod.outlook.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <815051a3-ef5d-4a3a-49b8-324f806425cf@xevo.com>
Date: Wed, 28 Mar 2018 09:40:50 -0700
MIME-Version: 1.0
In-Reply-To: <CY4PR1201MB0184E34B46C1C56A7C38CFC9C4A30@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/28/2018 08:13 AM, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> loosing data at 50Hz is really strange. I am currently running an old MPU-6500 at 200Hz on I2C @400KHz without any issue (using HiKey board).
> 

It is really strange, I agree. I am even losing data at 10 Hz, at about 
the same rate (6 interrupts for every 10 samples). The interrupt handler 
(both top and bottom half) are taking about 8 ms, so I don't think they 
are causing the issue (since the budget is 100 ms at 10 Hz). AFAICT, the 
interrupts either are not being generated at 10 Hz or are not being 
delivered at 10 Hz due to other latency in the system. I have not 
investigated enough yet to know exactly what's happening.

> Can you tell me what is the chip you are using, the board (CPU+freq) and the I2C bus speed?
> 

I'm using a nanopi neo air: 
http://www.friendlyarm.com/index.php?route=product/product&product_id=151. 
This is an ARM Cortex A7. This is an Allwinner H3 SoC running up to 1.2 
GHz, and the system load is near 0, so the system should be more than 
capable of handling 10 Hz data. The I2C bus is set at 400 KHz, and I 
have pasted the relevant device-tree fragment below.

Note that I'm also seeing the I2C bus lockup regularly at higher 
frequencies (500 Hz will reliably trigger it within a few seconds). I 
suspect these issues are related. Watching the output of 
iio_generic_buffer and similar tools shows the samples come in at a 
regular rate (say, 10 Hz) and then have periodic brief stalls before 
going back to the regular rate. This supports the theory of bus lockups 
causing the issue.

Device-tree fragment:

#include "sun8i-h3-nanopi-neo-air.dts"

[...]

&i2c0 {
         pinctrl-names = "default";
         pinctrl-0 = <&i2c0_pins>;
         status = "okay";
         bus_freq = <400000>;

         mpu9250@68 {
                 model = "Invensense MPU9250";
                 compatible = "invensense,mpu9250";
                 reg = <0x68>;
                 interrupt-parent = <&pio>;
                 interrupts = <6 11 IRQ_TYPE_EDGE_RISING>; /* PG11 / 
EINT11 */
         };
};

> Anyway, your solution seems to be good, better then putting 0 for timestamps.
> 
> Best regards,
> JB
>    
