Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36770 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbGFIjQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2015 04:39:16 -0400
Received: by wguu7 with SMTP id u7so133702199wgu.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2015 01:39:15 -0700 (PDT)
Message-ID: <559A3EB0.2060200@parkeon.com>
Date: Mon, 06 Jul 2015 10:39:12 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, roberta.dobrescu@gmail.com,
	christoph.muellner@theobroma-systems.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 7/9] iio: mma8452: change iio event type to IIO_EV_TYPE_MAG
References: <1436018110-3903-1-git-send-email-martink@posteo.de> <1436018110-3903-8-git-send-email-martink@posteo.de> <559919F5.8070107@kernel.org>
In-Reply-To: <559919F5.8070107@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/15 13:50, Jonathan Cameron wrote:
> On 04/07/15 14:55, Martin Kepplinger wrote:
>> IIO_EV_TYPE_THRESH in rising direction describes an event where the
>> threshold is crossed in rising direction, positive or negative values
>> being possible. This is not the case here.
>>
>> Since the threshold is no signed value and only the magnitude is compared,
>> IIO_EV_TYPE_MAG is what describes the behaviour of these devices, see the
>> sysfs-bus-iio ABI Documentation.

Fwiw there was some discussion of this before the initial submission:

http://www.spinics.net/lists/linux-iio/msg14039.html

Initially I used a magnitude too but Jonathan convinced me it should be 
a threshold.

"

The  moment you know the sign of the magnitude it stops being a magnitude
and becomes a generic threshold.  Report it as such and control it as such.

"

Thing is that the hardware indeed only compares the absolute value for 
the threshold *but* indicates with the event the sign.
However it is true that the driver doesn't currently do anything with 
the sign information.


>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> This is a fix and so should have been the first patch in the series.  It will
> want to go via a different tree (iio-fixes) and probably be marked for stable.
>
> I would however like Peter's ack on this as well before taking it.
>> ---
>>   drivers/iio/accel/mma8452.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 7f6e3b4..e23ebd0 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -598,21 +598,21 @@ static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
>>   	if (src & data->chip_info->ev_src_xe)
>>   		iio_push_event(indio_dev,
>>   			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
>> -						  IIO_EV_TYPE_THRESH,
>> +						  IIO_EV_TYPE_MAG,
>>   						  IIO_EV_DIR_RISING),
>>   			       ts);
>>   
>>   	if (src & data->chip_info->ev_src_ye)
>>   		iio_push_event(indio_dev,
>>   			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
>> -						  IIO_EV_TYPE_THRESH,
>> +						  IIO_EV_TYPE_MAG,
>>   						  IIO_EV_DIR_RISING),
>>   			       ts);
>>   
>>   	if (src & data->chip_info->ev_src_ze)
>>   		iio_push_event(indio_dev,
>>   			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
>> -						  IIO_EV_TYPE_THRESH,
>> +						  IIO_EV_TYPE_MAG,
>>   						  IIO_EV_DIR_RISING),
>>   			       ts);
>>   }
>> @@ -689,7 +689,7 @@ static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
>>   
>>   static const struct iio_event_spec mma8452_transient_event[] = {
>>   	{
>> -		.type = IIO_EV_TYPE_THRESH,
>> +		.type = IIO_EV_TYPE_MAG,
>>   		.dir = IIO_EV_DIR_RISING,
>>   		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>   		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>> @@ -700,7 +700,7 @@ static const struct iio_event_spec mma8452_transient_event[] = {
>>   
>>   static const struct iio_event_spec mma8452_motion_event[] = {
>>   	{
>> -		.type = IIO_EV_TYPE_THRESH,
>> +		.type = IIO_EV_TYPE_MAG,
>>   		.dir = IIO_EV_DIR_RISING,
>>   		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>   		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>>

