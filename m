Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43934 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbHWPzj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Aug 2015 11:55:39 -0400
Subject: Re: RFC: humidity sensor heaters
To: Matt Ranostay <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <CAKzfze9RxmqD1KgewziH=-xWkfr31P7WNUyM707swMx1RCWgfA@mail.gmail.com>
 <84D8A360-F891-42D6-98A4-7BE289C8B236@gmail.com>
Cc: =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D9ECF9.1010303@kernel.org>
Date: Sun, 23 Aug 2015 16:55:37 +0100
MIME-Version: 1.0
In-Reply-To: <84D8A360-F891-42D6-98A4-7BE289C8B236@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/15 08:29, Matt Ranostay wrote:
> That all seems perfectly logical just wanted to be sure what would be the best way.
> 
> Would it make sense to block temp reads to raw with the heater on?
> Like what a lot of drivers do on buffered triggered reads for some
> channels
Probably chip dependent (might be well isolated as some of these parts are
quite large).  However, if it definitely has a pronounced effect (guessing
it does) then sure. Return -EBUSY if it is enabled and the temperature is
read.

J
> 
> Sent from my iPhone
> 
>> On Aug 20, 2015, at 20:56, Matt Ranostay <mranostay@gmail.com> wrote:
>>
>> Jonathan et all,
>>
>> So I am currently working on a driver for the TI HDC100x series of
>> temp + humidity sensors, and have a question on how we should handler
>> the heater functionality.
>>
>> This seems quite common in high accuracy relative humidity sensors to
>> have a resistive element within the sensor to heat up the device and
>> get rid of any condensation that happens in a high humidity
>> environment.
>>
>> Now it could be a one off sysfs entry within the driver like
>> "heater_status" but it seems something we want to more generic since
>> this will be an issue in the future (aka si7005 driver for instance).
>>
>> Thoughts? Comments?
>>
>> Thanks,
>>
>> Matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

