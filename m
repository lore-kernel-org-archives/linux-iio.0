Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <558E6E1A.2060204@gmx.de>
References: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com>
	<1429212059-13010-4-git-send-email-roberta.dobrescu@gmail.com>
	<558E6E1A.2060204@gmx.de>
Date: Mon, 29 Jun 2015 10:24:50 +0300
Message-ID: <CAEnQRZCwGLJR_etKBA4YyO7cD10XL_PuLMfHZP+arUmALA7aoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging: iio: light: isl29018: Use standard sysfs
 attributes for scale and integration time
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 27, 2015 at 12:34 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Roberta Dobrescu schrieb am 16.04.2015 um 21:20:
>> This patch refactors the isl29018 driver code in order to use standard
>> sysfs attributes for scale and integration time.
>>
>> ISL29018 light sensor uses four ranges and four ADC's resolutions
>> which influence the calculated lux. Adc resolution is strongly
>> connected to integration time and range should be controlled by scale.
>>
>> This patch introduces the usage of integration time and scale instead
>> of adc resolution and range.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>> ---
>>  drivers/staging/iio/light/isl29018.c | 224 +++++++++++++++++++++++++++--------
>>  1 file changed, 175 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
>> index ffc3d1b..435d417 100644
>> --- a/drivers/staging/iio/light/isl29018.c
>> +++ b/drivers/staging/iio/light/isl29018.c
>> @@ -66,6 +66,39 @@
>>  #define ISL29035_BOUT_SHIFT          0x07
>>  #define ISL29035_BOUT_MASK           (0x01 << ISL29035_BOUT_SHIFT)
>>
>> +#define ISL29018_INT_TIME_AVAIL              "0.090000 0.005630 0.000351 0.000021"
>> +#define ISL29023_INT_TIME_AVAIL              "0.090000 0.005600 0.000352 0.000022"
>> +#define ISL29035_INT_TIME_AVAIL              "0.105000 0.006500 0.000410 0.000025"
>> +
>> +static const char * const int_time_avail[] = {
>> +     ISL29018_INT_TIME_AVAIL,
>> +     ISL29023_INT_TIME_AVAIL,
>> +     ISL29035_INT_TIME_AVAIL,
>> +};
>> +
>
> Hi Roberta,
> are you still working to get this one out of staging? You introduced here the
> int_time_avail array (missing prefix), although you don't make use of it down
> in show_int_time_available() (also missing prefix), where I would expect it to
> be used. So, what's the status? Do you intend to use this array later on, or
> can it be dropped?
> Just for completeness: show_scale_available also misses a prefix.

Hi Hartmut,

Yes are still working to get this out of staging, but it wasn't a top priority.
I hope to have it finished by the end of July.

thanks,
Daniel.
