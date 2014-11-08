Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <545E0E92.4080503@kernel.org>
References: <1415276952-19712-1-git-send-email-daniel.baluta@intel.com>
	<545E0E92.4080503@kernel.org>
Date: Sat, 8 Nov 2014 16:16:44 +0200
Message-ID: <CAEnQRZBwPUWZnu6xBGxfu2sSSbZJG+5VciC1W80=yFoHeTtZvw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: Add support for Kionix KMX61 sensor
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 8, 2014 at 2:37 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 06/11/14 12:29, Daniel Baluta wrote:
>> Minimal implementation for KMX61 6-axis accelerometer/magnetometer. It exports
>> raw accel/magn readings together with scale and sampling frequency.
>>
>> Datasheet will be available at:
>> http://www.kionix.com/6-axis-accelerometer-magnetometer/kmx61
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> Very nice.  Only one comment inline.
>
> There are some possible race conditions (I think) based on functions
> doing read, modify, write.  Ideally they may want protecting with
> a mutex.

You are right. I will analyze all possible race conditions and send v2.

Thanks.
