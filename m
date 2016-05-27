Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDqQNwWrWLQG3ACwG9tTrM6ecQ2xayD9jKGN+pOmxvmqA@mail.gmail.com>
References: <1463522523-25791-1-git-send-email-matt.ranostay@intel.com> <CAEnQRZDqQNwWrWLQG3ACwG9tTrM6ecQ2xayD9jKGN+pOmxvmqA@mail.gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Fri, 27 May 2016 00:50:30 -0700
Message-ID: <CAKzfze-XyK6+kuiOKQgt3fghrKPcF=Gc8QWX-e8hBLBFSa_YcQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: add datasheet names
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Matt Ranostay <matt.ranostay@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 27, 2016 at 12:34 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Wed, May 18, 2016 at 1:02 AM, Matt Ranostay <matt.ranostay@intel.com> wrote:
>> Add datasheet names for ADC channels to allow iio consumers access.
>>
>> Cc: daniel.baluta@intel.com
>
> For next patches use the full convention: name + email.
>
Oops bad habit of mine. Will take note :)

> Daniel Baluta <daniel.baluta@intel.com>
>
>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
>
> Looks good to me.
>
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
>
>> ---
>>  NOTES: Requires previous ADS1115 patchst applied first
>>
>>  drivers/iio/adc/ti-ads1015.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> index a835423..8be192a 100644
>> --- a/drivers/iio/adc/ti-ads1015.c
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -110,6 +110,7 @@ static const struct {
>>                 .shift = 4,                                     \
>>                 .endianness = IIO_CPU,                          \
>>         },                                                      \
>> +       .datasheet_name = "AIN"#_chan,                          \
>>  }
>>
>>  #define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
>> @@ -130,6 +131,7 @@ static const struct {
>>                 .shift = 4,                                     \
>>                 .endianness = IIO_CPU,                          \
>>         },                                                      \
>> +       .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>>  }
>>
>>  #define ADS1115_V_CHAN(_chan, _addr) {                         \
>> @@ -147,6 +149,7 @@ static const struct {
>>                 .storagebits = 16,                              \
>>                 .endianness = IIO_CPU,                          \
>>         },                                                      \
>> +       .datasheet_name = "AIN"#_chan,                          \
>>  }
>>
>>  #define ADS1115_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
>> @@ -166,6 +169,7 @@ static const struct {
>>                 .storagebits = 16,                              \
>>                 .endianness = IIO_CPU,                          \
>>         },                                                      \
>> +       .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>>  }
>>
>>  struct ads1015_data {
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
