Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35609 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbHWH3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Aug 2015 03:29:43 -0400
Received: by pacdd16 with SMTP id dd16so73418674pac.2
        for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2015 00:29:43 -0700 (PDT)
References: <CAKzfze9RxmqD1KgewziH=-xWkfr31P7WNUyM707swMx1RCWgfA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAKzfze9RxmqD1KgewziH=-xWkfr31P7WNUyM707swMx1RCWgfA@mail.gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <84D8A360-F891-42D6-98A4-7BE289C8B236@gmail.com>
Cc: =?utf-8?Q?Marek_Va=C5=A1ut?= <marex@denx.de>
From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: RFC: humidity sensor heaters
Date: Sun, 23 Aug 2015 00:29:39 -0700
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

That all seems perfectly logical just wanted to be sure what would be the best way.

Would it make sense to block temp reads to raw with the heater on? Like what a lot of drivers do on buffered triggered reads for some channels 

Sent from my iPhone

> On Aug 20, 2015, at 20:56, Matt Ranostay <mranostay@gmail.com> wrote:
> 
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
> 
> Thoughts? Comments?
> 
> Thanks,
> 
> Matt
