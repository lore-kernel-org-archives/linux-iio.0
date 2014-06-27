Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61915 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbaF0OQA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 10:16:00 -0400
Message-ID: <53AD7C9B.8040407@roeck-us.net>
Date: Fri, 27 Jun 2014 07:15:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Johannes Pointner <johannes.pointner@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
CC: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Subject: Re: hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
References: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
In-Reply-To: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/27/2014 01:50 AM, Johannes Pointner wrote:
> As I saw in the latest patches for the ntc_thermistor, in which as
> part of the patch the module description changed to :
>
> MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
>
> I wanted to know if it is intended to extend the driver for further
> manufacturers like in my case for an epcos ntc in the future?
>

Sure, why not ? Better than create an entirely new driver which would
be all the same but for the tables. The comment is misleading anyway
(the driver is for Murata thermistors, not from them), so we can
always drop the "from Murata".

Guenter

