Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42630 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbcH2Stp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 14:49:45 -0400
Subject: Re: [PATCH -next] iio: temperature: fix non static symbol warnings
To: Matt Ranostay <mranostay@gmail.com>,
        Wei Yongjun <weiyj.lk@gmail.com>
References: <1472222000-1163-1-git-send-email-weiyj.lk@gmail.com>
 <F9B1372A-28A3-4B3B-98CA-09BDA439A97D@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <396702fd-dbd0-a9dc-ec23-c59b8dd1a68a@kernel.org>
Date: Mon, 29 Aug 2016 19:49:43 +0100
MIME-Version: 1.0
In-Reply-To: <F9B1372A-28A3-4B3B-98CA-09BDA439A97D@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/08/16 09:51, Matt Ranostay wrote:
> Reviewed-By: Matt Ranostay <mranostay@gmail.com>
Applied to the togreg branch of iio.git.
This will be initially pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
> 
>> On Aug 26, 2016, at 07:33, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>>
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> Fixes the following sparse warnings:
>>
>> drivers/iio/temperature/maxim_thermocouple.c:35:28: warning:
>> symbol 'max6675_channels' was not declared. Should it be static?
>> drivers/iio/temperature/maxim_thermocouple.c:52:28: warning:
>> symbol 'max31855_channels' was not declared. Should it be static?
>> drivers/iio/temperature/maxim_thermocouple.c:98:38: warning:
>> symbol 'maxim_thermocouple_chips' was not declared. Should it be static?
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>> drivers/iio/temperature/maxim_thermocouple.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
>> index 030827e..39dd202 100644
>> --- a/drivers/iio/temperature/maxim_thermocouple.c
>> +++ b/drivers/iio/temperature/maxim_thermocouple.c
>> @@ -32,7 +32,7 @@ enum {
>>    MAX31855,
>> };
>>
>> -const struct iio_chan_spec max6675_channels[] = {
>> +static const struct iio_chan_spec max6675_channels[] = {
>>    {    /* thermocouple temperature */
>>        .type = IIO_TEMP,
>>        .info_mask_separate =
>> @@ -49,7 +49,7 @@ const struct iio_chan_spec max6675_channels[] = {
>>    IIO_CHAN_SOFT_TIMESTAMP(1),
>> };
>>
>> -const struct iio_chan_spec max31855_channels[] = {
>> +static const struct iio_chan_spec max31855_channels[] = {
>>    {    /* thermocouple temperature */
>>        .type = IIO_TEMP,
>>        .address = 2,
>> @@ -95,7 +95,7 @@ struct maxim_thermocouple_chip {
>>    u32 status_bit;
>> };
>>
>> -const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
>> +static const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
>>    [MAX6675] = {
>>            .channels = max6675_channels,
>>            .num_channels = ARRAY_SIZE(max6675_channels),
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

