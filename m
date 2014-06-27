Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:63468 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbaF0Iuk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 04:50:40 -0400
Received: by mail-qg0-f54.google.com with SMTP id q107so4135266qgd.13
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2014 01:50:39 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 27 Jun 2014 10:50:39 +0200
Message-ID: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
Subject: hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
From: Johannes Pointner <johannes.pointner@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As I saw in the latest patches for the ntc_thermistor, in which as
part of the patch the module description changed to :

MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");

I wanted to know if it is intended to extend the driver for further
manufacturers like in my case for an epcos ntc in the future?

Of course I would create the necessary patch.

Thanks,
Hannes
