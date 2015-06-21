Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43985 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbFUNpE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:45:04 -0400
Message-ID: <5586BFDD.2000907@kernel.org>
Date: Sun, 21 Jun 2015 14:45:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH 2/3] iio:accel:bmc150-accel: make use of mask definition
References: <cover.1434404216.git.knaack.h@gmx.de>	<a9a11f217224e458d8ffb2741b27f1ad92db1870.1434404216.git.knaack.h@gmx.de> <CAE1zotKLuJxTYzJZ84Gzi-dY1HqgGzmh3BheszWeka6Wi9XqtQ@mail.gmail.com>
In-Reply-To: <CAE1zotKLuJxTYzJZ84Gzi-dY1HqgGzmh3BheszWeka6Wi9XqtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/15 11:34, Octavian Purdila wrote:
> On Tue, Jun 16, 2015 at 12:48 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> BMC150_ACCEL_SLOPE_THRES_MASK was defined some time ago, but its 'magic'
>> value got used instead in bmc150_accel_write_event(). Make use of it for
>> improved readability.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Reviewed-by: Octavian Purdila <octavian.purdila@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
etc etc.
> 
>> ---
>>  drivers/iio/accel/bmc150-accel.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
>> index cc5a357..36a9cd5 100644
>> --- a/drivers/iio/accel/bmc150-accel.c
>> +++ b/drivers/iio/accel/bmc150-accel.c
>> @@ -776,7 +776,7 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
>>
>>         switch (info) {
>>         case IIO_EV_INFO_VALUE:
>> -               data->slope_thres = val & 0xFF;
>> +               data->slope_thres = val & BMC150_ACCEL_SLOPE_THRES_MASK;
>>                 break;
>>         case IIO_EV_INFO_PERIOD:
>>                 data->slope_dur = val & BMC150_ACCEL_SLOPE_DUR_MASK;
>> --
>> 2.3.6
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
