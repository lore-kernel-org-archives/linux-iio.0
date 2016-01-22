Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35272 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbcAVQtu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2016 11:49:50 -0500
In-Reply-To: <56A23EAD.1000207@prevas.dk>
References: <1453467296-26356-1-git-send-email-sean.nyekjaer@prevas.dk> <2C284AAE-21FB-4EFE-AD1C-2F010B15C845@jic23.retrosnub.co.uk> <56A23EAD.1000207@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC 1/2] iio: core: added support for a single output that supports both current and voltage
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 22 Jan 2016 16:49:45 +0000
To: =?ISO-8859-1?Q?Sean_Nyekj=E6r?= <sean.nyekjaer@prevas.dk>,
	linux-iio@vger.kernel.org
Message-ID: <1F14D1A1-22FE-4A57-9EA1-2F87E23C6AC9@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 22 January 2016 14:37:33 GMT+00:00, "Sean Nyekjær" <sean.nyekjaer@prevas.dk> wrote:
>Hi
>
>How do you register two channels for one channel?

Register them as two independent channels. One for current and one for
 voltage. In a sense the change of measurement type is just a different type
 of front end mux like you see on many ADCs.


>Please give a quick example
Phone only so will get back to you tomorrow!

>
>/Sean
>
>On 2016-01-22 15:14, Jonathan Cameron wrote:
>> Hi
>>
>> Quick gut feel response. Register two channels.
>>
>> Jonathan
>>
>> On 22 January 2016 12:54:55 GMT+00:00, Sean Nyekjaer 
>> <sean.nyekjaer@prevas.dk> wrote:
>>
>>     Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>>     ---
>>       drivers/iio/industrialio-core.c | 2 ++
>>       include/linux/iio/iio.h         | 1 +
>>       include/uapi/linux/iio/types.h  | 1 +
>>       3 files changed, 4 insertions(+)
>>
>>     diff --git a/drivers/iio/industrialio-core.c
>b/drivers/iio/industrialio-core.c
>>     index fd01f34..5e1beea 100644
>>     --- a/drivers/iio/industrialio-core.c
>>     +++ b/drivers/iio/industrialio-core.c
>>     @@ -77,6 +77,7 @@ static const char * const
>iio_chan_type_name_spec[] = {
>>        [IIO_VELOCITY] = "velocity",
>>        [IIO_CONCENTRATION] = "concentration",
>>        [IIO_RESISTANCE] = "resistance",
>>     + [IIO_DUAL_VOLTCUR] = "voltcur",
>>       };
>>       
>>       static const char * const iio_modifier_names[] = {
>>     @@ -146,6 +147,7 @@ static const char * const
>iio_chan_info_postfix[] = {
>>        [IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
>>        [IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>>       
>>     [IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
>>     + [IIO_CHAN_INFO_MODE] = "mode",
>>       };
>>       
>>       /**
>>     diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>     index b589411..ef4c7cd9 100644
>>     --- a/include/linux/iio/iio.h
>>     +++ b/include/linux/iio/iio.h
>>     @@ -46,6 +46,7 @@ enum iio_chan_info_enum {
>>        IIO_CHAN_INFO_DEBOUNCE_TIME,
>>        IIO_CHAN_INFO_CALIBEMISSIVITY,
>>        IIO_CHAN_INFO_OVERSAMPLING_RATIO,
>>     + IIO_CHAN_INFO_MODE,
>>       };
>>       
>>       enum iio_shared_by {
>>     diff --git a/include/uapi/linux/iio/types.h
>b/include/uapi/linux/iio/types.h
>>     index 7c63bd6..81e6a2a 100644
>>     --- a/include/uapi/linux/iio/types.h
>>     +++ b/include/uapi/linux/iio/types.h
>>     @@ -37,6 +37,7 @@ enum iio_chan_type {
>>        IIO_VELOCITY,
>>        IIO_CONCENTRATION,
>>        IIO_RESISTANCE,
>>     + IIO_DUAL_VOLTCUR,
>>       };
>>       
>>       enum iio_modifier {
>>
>>
>> -- 
>> Sent from my Android device with K-9 Mail. Please excuse my brevity. 
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
