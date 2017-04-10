Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:53096 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbdDJNkP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2017 09:40:15 -0400
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] iio: light: rpr0521 whitespace fixes
Date: Mon, 10 Apr 2017 13:25:04 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC43E5@WILL-MAIL002.REu.RohmEu.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491566839-3925-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <dd2e1ad8-bb61-f93e-41ed-8595d733e979@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8.4.2017 17:49, Jonathan Cameron wrote:
> On 07/04/17 13:07, Mikko Koivunen wrote:
>> Just whitespace changes, no functional changes.
>>
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
>> ---
>>  drivers/iio/light/rpr0521.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>> index c15529b..30c2592 100644
>> --- a/drivers/iio/light/rpr0521.c
>> +++ b/drivers/iio/light/rpr0521.c
>> @@ -357,8 +357,8 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>  			return ret;
>>  
>>  		*val = le16_to_cpu(raw_data);
>> -
> I'd argue that there are good readability reasons to leave this blank line.
> If the original driver hadn't had it I wouldn't have felt strongly enough
> to comment on it, but adding noise to remove it seems rather pointless..

Ack.
Patchset was chopped for mailing list from one big commit and from your
comments on next patches I see some other whitespace changes should also
be in this commit. Let's see in v3 if I get it better.

>>  		return IIO_VAL_INT;
>> +
> Adding this one is definitely worthwhile though!
>>  	case IIO_CHAN_INFO_SCALE:
>>  		mutex_lock(&data->lock);
>>  		ret = rpr0521_get_gain(data, chan->address, val, val2);
>>
>

