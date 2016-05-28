Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56667 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcE1RVx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 May 2016 13:21:53 -0400
Subject: Re: [PATCH] iio: adc: ti-ads1015: add datasheet names
To: Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>
References: <1463522523-25791-1-git-send-email-matt.ranostay@intel.com>
 <CAEnQRZDqQNwWrWLQG3ACwG9tTrM6ecQ2xayD9jKGN+pOmxvmqA@mail.gmail.com>
 <CAKzfze-XyK6+kuiOKQgt3fghrKPcF=Gc8QWX-e8hBLBFSa_YcQ@mail.gmail.com>
Cc: Matt Ranostay <matt.ranostay@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <71535376-55d2-7a27-fdcd-e2d6f805b89f@kernel.org>
Date: Sat, 28 May 2016 18:21:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze-XyK6+kuiOKQgt3fghrKPcF=Gc8QWX-e8hBLBFSa_YcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/05/16 08:50, Matt Ranostay wrote:
> On Fri, May 27, 2016 at 12:34 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>> On Wed, May 18, 2016 at 1:02 AM, Matt Ranostay <matt.ranostay@intel.com> wrote:
>>> Add datasheet names for ADC channels to allow iio consumers access.
>>>
>>> Cc: daniel.baluta@intel.com
>>
>> For next patches use the full convention: name + email.
>>
> Oops bad habit of mine. Will take note :)
> 
>> Daniel Baluta <daniel.baluta@intel.com>
>>
>>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
>>
>> Looks good to me.
>>
>> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing etc..

Thanks,

Jonathan
>>
>>> ---
>>>  NOTES: Requires previous ADS1115 patchst applied first
>>>
>>>  drivers/iio/adc/ti-ads1015.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>>> index a835423..8be192a 100644
>>> --- a/drivers/iio/adc/ti-ads1015.c
>>> +++ b/drivers/iio/adc/ti-ads1015.c
>>> @@ -110,6 +110,7 @@ static const struct {
>>>                 .shift = 4,                                     \
>>>                 .endianness = IIO_CPU,                          \
>>>         },                                                      \
>>> +       .datasheet_name = "AIN"#_chan,                          \
>>>  }
>>>
>>>  #define ADS1015_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
>>> @@ -130,6 +131,7 @@ static const struct {
>>>                 .shift = 4,                                     \
>>>                 .endianness = IIO_CPU,                          \
>>>         },                                                      \
>>> +       .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>>>  }
>>>
>>>  #define ADS1115_V_CHAN(_chan, _addr) {                         \
>>> @@ -147,6 +149,7 @@ static const struct {
>>>                 .storagebits = 16,                              \
>>>                 .endianness = IIO_CPU,                          \
>>>         },                                                      \
>>> +       .datasheet_name = "AIN"#_chan,                          \
>>>  }
>>>
>>>  #define ADS1115_V_DIFF_CHAN(_chan, _chan2, _addr) {            \
>>> @@ -166,6 +169,7 @@ static const struct {
>>>                 .storagebits = 16,                              \
>>>                 .endianness = IIO_CPU,                          \
>>>         },                                                      \
>>> +       .datasheet_name = "AIN"#_chan"-AIN"#_chan2,             \
>>>  }
>>>
>>>  struct ads1015_data {
>>> --
>>> 2.7.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

