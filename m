Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr720073.outbound.protection.outlook.com ([40.107.72.73]:3904
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbeHTTMF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Aug 2018 15:12:05 -0400
Subject: Re: IIO driver for the Invensense ICM-20948 IMU
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <07126db2-bb47-2be8-b43e-42171d60ff57@xevo.com>
 <20180820142856.00003804@huawei.com>
 <SN1PR12MB252592EBB4686A3BFB8D4E6EC4320@SN1PR12MB2525.namprd12.prod.outlook.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <599e17a6-c4da-2d06-d61a-4a0521104773@xevo.com>
Date: Mon, 20 Aug 2018 08:55:41 -0700
MIME-Version: 1.0
In-Reply-To: <SN1PR12MB252592EBB4686A3BFB8D4E6EC4320@SN1PR12MB2525.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/20/2018 07:05 AM, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> I'm currently working in background on adding our old 9-axis MPU-9250 (MPU-6500 + AK8963 in 1 package) to the existing driver.
> 
> Currently this kind of setup is supported by driving the mag from the ak8975 driver in the kernel. My goal is to drive the mag from the MPU using the MPU I2C master IP for achieving better performance (no jitter compared to kernel timers) and provide a true 9-axis device.

Thanks, that sounds like very useful work!

> 
> ICM-20948 is ICM-20648 + AK9916 in 1 package. I think It should be possible to support it inside the existing driver. We need first to add ICM-20648 support inside the driver. For the basic functions, this chip should be quite similar to the already supported ones.
> 
> I am sorry there is no current plan or deadline for this kind of work. It really depends on my available bandwidth.
> 

No problem, thanks for the information.

> Feel free to work on it by adding first 6-axis (ICM-20648) support to the driver.
> 
> Best regards,
> JB
> 
> 
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Monday, August 20, 2018 15:28
> To: Martin Kelly
> Cc: linux-iio@vger.kernel.org; Jean-Baptiste Maneyrol
> Subject: Re: IIO driver for the Invensense ICM-20948 IMU
>    
> 
> On Thu, 16 Aug 2018 14:36:32 -0700
> Martin Kelly <mkelly@xevo.com> wrote:
> 
>> Hi,
>>
>> Unless I missed something, I noticed the ICM-20948 IMU from Invensense
>> appears not to have an IIO driver yet. I'm wondering if there are plans
>> to add one and if so, the expected timeline for it.
>>
>> Thanks,
>> Martin
> 
> Hi Martin,
> 
> I'm not aware of anyone looking at this part.  A quick glance a the datasheet
> suggested this has an entirely different address map to the existing parts, so
> won't be trivial to support either.
> 
> Hopefully Jean-Baptiste will have more information for us!
> 
> Jonathan
> 
>      
> 
