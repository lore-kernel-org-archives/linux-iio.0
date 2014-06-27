Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53268 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbaF0KvD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 27 Jun 2014 06:51:03 -0400
Date: Fri, 27 Jun 2014 12:50:58 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Johannes Pointner <johannes.pointner@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Subject: Re: hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
Message-ID: <20140627125058.0d4b79a0@endymion.delvare>
In-Reply-To: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
References: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 27 Jun 2014 10:50:39 +0200, Johannes Pointner wrote:
> As I saw in the latest patches for the ntc_thermistor, in which as
> part of the patch the module description changed to :
> 
> MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
> 
> I wanted to know if it is intended to extend the driver for further
> manufacturers like in my case for an epcos ntc in the future?

If there is enough compatibility, then yes, of course.

> Of course I would create the necessary patch.

-- 
Jean Delvare
SUSE L3 Support
