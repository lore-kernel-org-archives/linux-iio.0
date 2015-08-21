Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
Date: Thu, 20 Aug 2015 20:56:01 -0700
Message-ID: <CAKzfze9RxmqD1KgewziH=-xWkfr31P7WNUyM707swMx1RCWgfA@mail.gmail.com>
Subject: RFC: humidity sensor heaters
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan et all,

So I am currently working on a driver for the TI HDC100x series of
temp + humidity sensors, and have a question on how we should handler
the heater functionality.

This seems quite common in high accuracy relative humidity sensors to
have a resistive element within the sensor to heat up the device and
get rid of any condensation that happens in a high humidity
environment.

Now it could be a one off sysfs entry within the driver like
"heater_status" but it seems something we want to more generic since
this will be an issue in the future (aka si7005 driver for instance).

Thoughts? Comments?

Thanks,

Matt
