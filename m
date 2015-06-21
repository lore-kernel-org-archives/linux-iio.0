Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43977 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbbFUNnP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:43:15 -0400
Message-ID: <5586BF72.4050601@kernel.org>
Date: Sun, 21 Jun 2015 14:43:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH 1/3] iio:accel:bmc150-accel: fix counting direction
References: <cover.1434404216.git.knaack.h@gmx.de>	<905a190eec730a8e31863e079a55029612784d93.1434404216.git.knaack.h@gmx.de> <CAE1zot+y7izi2vJDg7q+VT+GMPdbNymuUmsAOQP0MBVAmzNETw@mail.gmail.com>
In-Reply-To: <CAE1zot+y7izi2vJDg7q+VT+GMPdbNymuUmsAOQP0MBVAmzNETw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/15 11:31, Octavian Purdila wrote:
> On Tue, Jun 16, 2015 at 12:48 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>
>> In bmc150_accel_unregister_triggers() triggers should be unregistered in
>> reverse order of registration. Trigger registration starts with number 0,
>> counting up. In consequence, trigger number needs to be count down here.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Reviewed-by: Octavian Purdila <octavian.purdila@intel.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> 
> 
>> ---
>>  drivers/iio/accel/bmc150-accel.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index 4e70f51..cc5a357 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -1464,7 +1464,7 @@ static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
>>  {
>>         int i;
>>
>> -       for (i = from; i >= 0; i++) {
>> +       for (i = from; i >= 0; i--) {
>>                 if (data->triggers[i].indio_trig) {
>>                         iio_trigger_unregister(data->triggers[i].indio_trig);
>>                         data->triggers[i].indio_trig = NULL;
>> --
>> 2.3.6
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
