Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35530 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759594AbcBYIpV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2016 03:45:21 -0500
Received: by mail-wm0-f52.google.com with SMTP id c200so17617581wme.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Feb 2016 00:45:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DM3PR1201MB1072776083BB71F4F618555CAFA50@DM3PR1201MB1072.namprd12.prod.outlook.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
	<56CE1BCB.40807@kernel.org>
	<DM3PR1201MB1072776083BB71F4F618555CAFA50@DM3PR1201MB1072.namprd12.prod.outlook.com>
Date: Thu, 25 Feb 2016 10:45:20 +0200
Message-ID: <CAEnQRZAS6NAe0R-eLDz66TVA_357RxMtKs2EcHx8YY0VLJvCTQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] mpu6050: code clean and calibration support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Ge Gao <GGao@invensense.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <matt.ranostay@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"adriana.reus@intel.com" <adriana.reus@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
