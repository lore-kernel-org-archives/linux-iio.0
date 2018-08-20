Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:50396 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbeHTRgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Aug 2018 13:36:10 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Martin Kelly <mkelly@xevo.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO driver for the Invensense ICM-20948 IMU
Date: Mon, 20 Aug 2018 14:05:40 +0000
Message-ID: <SN1PR12MB252592EBB4686A3BFB8D4E6EC4320@SN1PR12MB2525.namprd12.prod.outlook.com>
References: <07126db2-bb47-2be8-b43e-42171d60ff57@xevo.com>,<20180820142856.00003804@huawei.com>
In-Reply-To: <20180820142856.00003804@huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I'm currently working in background on adding our old 9-axis MPU-9250 (MPU-=
6500 + AK8963 in 1 package) to the existing driver.=20

Currently this kind of setup is supported by driving the mag from the ak897=
5 driver in the kernel. My goal is to drive the mag from the MPU using the =
MPU I2C master IP for achieving better performance (no jitter compared to k=
ernel timers) and provide a true 9-axis device.

ICM-20948 is ICM-20648 + AK9916 in 1 package. I think It should be possible=
 to support it inside the existing driver. We need first to add ICM-20648 s=
upport inside the driver. For the basic functions, this chip should be quit=
e similar to the already supported ones.

I am sorry there is no current plan or deadline for this kind of work. It r=
eally depends on my available bandwidth.

Feel free to work on it by adding first 6-axis (ICM-20648) support to the d=
river.

Best regards,
JB


From: Jonathan Cameron <jonathan.cameron@huawei.com>
Sent: Monday, August 20, 2018 15:28
To: Martin Kelly
Cc: linux-iio@vger.kernel.org; Jean-Baptiste Maneyrol
Subject: Re: IIO driver for the Invensense ICM-20948 IMU
=A0=20

On Thu, 16 Aug 2018 14:36:32 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Hi,
>=20
> Unless I missed something, I noticed the ICM-20948 IMU from Invensense=20
> appears not to have an IIO driver yet. I'm wondering if there are plans=20
> to add one and if so, the expected timeline for it.
>=20
> Thanks,
> Martin

Hi Martin,

I'm not aware of anyone looking at this part.=A0 A quick glance a the datas=
heet
suggested this has an entirely different address map to the existing parts,=
 so
won't be trivial to support either.

Hopefully Jean-Baptiste will have more information for us!

Jonathan

    =
