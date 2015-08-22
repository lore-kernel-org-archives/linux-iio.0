Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38094 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbHVRov (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 13:44:51 -0400
Subject: Re: RFC: humidity sensor heaters
To: Matt Ranostay <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <CAKzfze9RxmqD1KgewziH=-xWkfr31P7WNUyM707swMx1RCWgfA@mail.gmail.com>
Cc: =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8B511.3060000@kernel.org>
Date: Sat, 22 Aug 2015 18:44:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze9RxmqD1KgewziH=-xWkfr31P7WNUyM707swMx1RCWgfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/08/15 04:56, Matt Ranostay wrote:
> Jonathan et all,
> 
> So I am currently working on a driver for the TI HDC100x series of
> temp + humidity sensors, and have a question on how we should handler
> the heater functionality.
> 
> This seems quite common in high accuracy relative humidity sensors to
> have a resistive element within the sensor to heat up the device and
> get rid of any condensation that happens in a high humidity
> environment.
> 
> Now it could be a one off sysfs entry within the driver like
> "heater_status" but it seems something we want to more generic since
> this will be an issue in the future (aka si7005 driver for instance).
There are a few humidity sensors in hwmon (predate IIO and at least
one is my fault :)   sht15 for example has heater_enable

Hmm. I wonder if we need something generic enough to account for
heaters that will run at various levels?  Or current output or similar?
Perhaps we even treat it as an output channel.

out_current_heater_raw and
out_current_heater_raw_available with 0 and 1 for example
If we have info on the actual current then provide scale as well.
For the hdc1000 it would be 7.6
Does that work whilst remaining as generic as possible?

It does seem a little over the top, but does fit within standard interfaces
be it making good use of an extended name.

Jonathan
> 
> Thoughts? Comments?
> 
> Thanks,
> 
> Matt
> 

