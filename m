Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <CAEnQRZBv4=UXVAzBn9rui2nyJ_UQdbqyUxDNchtZ9=mJ71Ympw@mail.gmail.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
	<1456177151-15881-2-git-send-email-matt.ranostay@intel.com>
	<CAEnQRZBv4=UXVAzBn9rui2nyJ_UQdbqyUxDNchtZ9=mJ71Ympw@mail.gmail.com>
Date: Mon, 22 Feb 2016 23:50:03 +0200
Message-ID: <CAEnQRZA4o65VH=UbW9qwmEFcbWdioUnT3DMKah_m7DrVZbL32w@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: imu: mpu6050: use inv_mpu6050_sensor_show return code
From: Daniel Baluta <daniel.baluta@intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Matt Ranostay <matt.ranostay@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Adriana Reus <adriana.reus@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 22, 2016 at 11:49 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Mon, Feb 22, 2016 at 11:39 PM, Matt Ranostay <matt.ranostay@intel.com> wrote:
>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
>> ---
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> index 225860016fed..4324328fd304 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -275,7 +275,7 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>>                 case IIO_TEMP:
>>                         /* wait for stablization */
>
> While at it please also fix this type :D.

s/type/typo :)))
