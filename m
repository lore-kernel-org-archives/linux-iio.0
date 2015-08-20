Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:55445 "EHLO
	5.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbHUA1M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 20:27:12 -0400
Received: from mail21.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id A1DC1FFB095
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2015 23:58:03 +0200 (CEST)
Mime-Version: 1.0
Date: Thu, 20 Aug 2015 21:57:55 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <bab6a87a8de5af06403a6f593e91ce02@rainloop.corna.info>
From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [PATCH 1/3] iio:humidity:si7020: replaced bitmask on humidity
 values with range check
To: "Hartmut Knaack" <knaack.h@gmx.de>,
	"Jonathan Cameron" <jic23@kernel.org>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	"Peter Meerwald" <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
In-Reply-To: <55D63D5E.8050000@gmx.de>
References: <55D63D5E.8050000@gmx.de>
 <1440079909-1337-1-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

August 20 2015 10:49 PM, "Hartmut Knaack" <knaack.h@gmx.de> wrote:
> Nicola Corna schrieb am 20.08.2015 um 16:11:
> 
>> The maximum possible value for the relative humidity is 55575 (100%RH).
>> This value, if shifted right by 2 bits, uses 14 bits and masking it with
>> a 12 bit mask removes 2 meaningful bits.
>> The masking has been replaced with a range check that sets the minimum
>> value at 3194 (0%RH) and the maximum at 55575 (100%RH).
> 
> Hmm, I guess the mask should have been applied for bits 13:2, but your
> solution confirms better to the data sheet. Just one essential detail:
> The raw sensor data has already been divided by 4 when you do the boundary
> check. So, you need to divide the boundaries, as well.
> Btw, you can make this a one-liner using clamp_val, check it out: [1]
> 
> [1]http://lxr.free-electrons.com/source/include/linux/kernel.h#L795
> 

Yes, you're right. Thanks.
Forgive me for my ignorance, but do I have now to upload the [PATCH v2] for
all the three patches?

>> Signed-off-by: Nicola Corna <nicola@corna.info>
>> ---
>> drivers/iio/humidity/si7020.c | 12 ++++++++++--
>> 1 file changed, 10 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
>> index fa3b809..62fdbcf 100644
>> --- a/drivers/iio/humidity/si7020.c
>> +++ b/drivers/iio/humidity/si7020.c
>> @@ -57,8 +57,16 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>> if (ret < 0)
>> return ret;
>> *val = ret >> 2;
>> - if (chan->type == IIO_HUMIDITYRELATIVE)
>> - *val &= GENMASK(11, 0);
>> + /*
>> + * Humidity values can sligthly exceed the 0-100%RH
>> + * range and should be corrected by software
>> + */
>> + if (chan->type == IIO_HUMIDITYRELATIVE) {
>> + if (*val < 3194) /* 0%RH */
>> + *val = 3194;
>> + else if (*val > 55575) /* 100%RH */
>> + *val = 55575;
>> + }
>> return IIO_VAL_INT;
>> case IIO_CHAN_INFO_SCALE:
>> if (chan->type == IIO_TEMP)
