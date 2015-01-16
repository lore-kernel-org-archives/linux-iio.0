Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33196 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbAQNvd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jan 2015 08:51:33 -0500
Message-ID: <54B9951B.6000409@kernel.org>
Date: Fri, 16 Jan 2015 22:47:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: industrialio-event: Fix typo 's/dynically/dynamically/'
References: <1421360654-1390-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZC4Xa1ArYPYKQZ1VV2qoen+V8t94T4oxrKs5vr2R6bNdg@mail.gmail.com>
In-Reply-To: <CAEnQRZC4Xa1ArYPYKQZ1VV2qoen+V8t94T4oxrKs5vr2R6bNdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/15 09:37, Daniel Baluta wrote:
> On Fri, Jan 16, 2015 at 12:24 AM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> 
Applied.  Thanks.
>> ---
>>  drivers/iio/industrialio-event.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
>> index 0c1e37e..db0cc4f 100644
>> --- a/drivers/iio/industrialio-event.c
>> +++ b/drivers/iio/industrialio-event.c
>> @@ -404,7 +404,7 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
>>  {
>>         int j, ret, attrcount = 0;
>>
>> -       /* Dynically created from the channels array */
>> +       /* Dynamically created from the channels array */
>>         for (j = 0; j < indio_dev->num_channels; j++) {
>>                 ret = iio_device_add_event_sysfs(indio_dev,
>>                                                  &indio_dev->channels[j]);
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

