Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <54D269B7.3070202@kernel.org>
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
	<1422662408-8149-3-git-send-email-octavian.purdila@intel.com>
	<54D269B7.3070202@kernel.org>
Date: Wed, 4 Feb 2015 21:29:22 +0200
Message-ID: <CAE1zotJEUxMwHcnjiJwGq_R6N9DSEDY=5dO9MEYOynU6-UtA=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] iio: add watermark logic to iio read and poll
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 4, 2015 at 8:49 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 31/01/15 00:00, Octavian Purdila wrote:
>> From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
>>
>> Currently the IIO buffer blocking read only wait until at least one
>> data element is available.
>> This patch makes the reader sleep until enough data is collected before
>> returning to userspace. This should limit the read() calls count when
>> trying to get data in batches.
>>
>> Co-author: Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>
>> Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
>> [rebased and remove buffer timeout]
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> One question on the ABI below... Otherwise looks good to me.
>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio  |  10 +++
>>  drivers/iio/industrialio-buffer.c        | 124 ++++++++++++++++++++++++++-----
>>  drivers/iio/kfifo_buf.c                  |  11 +--
>>  drivers/staging/iio/accel/sca3000_ring.c |   4 +-
>>  include/linux/iio/buffer.h               |   8 +-
>>  5 files changed, 127 insertions(+), 30 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index c03a140..2a3dc12 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1193,3 +1193,13 @@ Description:
>>               This attribute is used to read the current speed value of the
>>               user (which is the norm or magnitude of the velocity vector).
>>               Units after application of scale are m/s.
>> +
>> +What:                /sys/bus/iio/devices/iio:deviceX/buffer/low_watermark
> Just thinking about this again.  Why low?

I just kept the original name. A simple watermark sounds better to me,
I will change it in the next version.
