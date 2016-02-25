Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0061.outbound.protection.outlook.com ([157.56.110.61]:28960
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760375AbcBYPgk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2016 10:36:40 -0500
From: Ge Gao <GGao@invensense.com>
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <matt.ranostay@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"adriana.reus@intel.com" <adriana.reus@intel.com>
Subject: Re: [PATCH 0/5] mpu6050: code clean and calibration support
Date: Thu, 25 Feb 2016 15:36:36 +0000
Message-ID: <BY2PR1201MB1061AD39CB874A620A7E6513AFA60@BY2PR1201MB1061.namprd12.prod.outlook.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
	<56CE1BCB.40807@kernel.org>
	<DM3PR1201MB1072776083BB71F4F618555CAFA50@DM3PR1201MB1072.namprd12.prod.outlook.com>,<CAEnQRZAS6NAe0R-eLDz66TVA_357RxMtKs2EcHx8YY0VLJvCTQ@mail.gmail.com>
In-Reply-To: <CAEnQRZAS6NAe0R-eLDz66TVA_357RxMtKs2EcHx8YY0VLJvCTQ@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sure. I will do that. 
Thanks.:-)


Ge


________________________________________
From: daniel.baluta@gmail.com <daniel.baluta@gmail.com> on behalf of Daniel Baluta <daniel.baluta@intel.com>
Sent: Thursday, February 25, 2016 12:45 AM
To: Ge Gao
Cc: Jonathan Cameron; Matt Ranostay; linux-iio@vger.kernel.org; daniel.baluta@intel.com; adriana.reus@intel.com
Subject: Re: [PATCH 0/5] mpu6050: code clean and calibration support

On Thu, Feb 25, 2016 at 12:04 AM, Ge Gao <GGao@invensense.com> wrote:
> Dear all,
>         It looks good to me.
>         Thanks.
>

Hi Ge :),

Thanks for having a look at this. For next patches please also add the
kernel formal
Acked-by tag, like this:

Acked-by: Ge Gao <GGao@invensense.com>

so that Jonathan can mark your collaboration into the commit message.

> Best Regards,
>
> Ge Gao
>
>
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Wednesday, February 24, 2016 1:08 PM
> To: Matt Ranostay
> Cc: linux-iio@vger.kernel.org; daniel.baluta@intel.com; adriana.reus@intel.com; Ge Gao
> Subject: Re: [PATCH 0/5] mpu6050: code clean and calibration support
>
> On 22/02/16 21:39, Matt Ranostay wrote:
>> The patchset series cleans up several documentation, return code
>> issues, incorrect timing delays, and adds accl/gyro offset support.
>>
>> Matt Ranostay (5):
>>   iio: imu: mpu6050: use inv_mpu6050_sensor_show return code
>>   iio: imu: mpu6050: fix INV_MPU6050_REG_UP_TIME delay
>>   iio: imu: mpu6050: add missing docstring for int_pin_cfg
>>   iio: imu: mpu6050: add calibration offset support
>>   iio: imu: mpu6050: add mpu6500 register settings
>>
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 88
>> +++++++++++++++++++++++++++---
>> drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 +-
>> drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 20 ++++++-
>> drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  3 +-
>>  4 files changed, 105 insertions(+), 12 deletions(-)
>>
> Whole series looks good to me (the typo fix can follow if you like :)
>
> Ideally I'd like Ge to take a look as well (+ anyone else who fancies doing so!) so will leave it on list for a few days more.
>
> Jonathan
