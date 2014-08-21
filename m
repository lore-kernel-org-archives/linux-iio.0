Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42100 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbaHUN0A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Aug 2014 09:26:00 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so14601760pac.17
        for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2014 06:26:00 -0700 (PDT)
Date: Thu, 21 Aug 2014 06:25:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Johannes Pointner <johannes.pointner@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	lm-sensors@lm-sensors.org
Subject: Re: iio: iio_channel_get: ntc_thermistor isn't working since patch
 for of_iio_channel_get_by_name()
Message-ID: <20140821132556.GA24224@roeck-us.net>
References: <CAJKbBDBCEVfB-f6W1NbpPhuyduYB4KQMoT=9=wF4yny3a6weKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJKbBDBCEVfB-f6W1NbpPhuyduYB4KQMoT=9=wF4yny3a6weKA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 21, 2014 at 09:29:56AM +0200, Johannes Pointner wrote:
> Hello,
> 
> I found out that since this patch https://lkml.org/lkml/2014/6/11/201,
> which fixes the return values in this function, the ntc_thermistor
> driver isn't working anymore for me.
> The problem is that before the driver asked for probe deferral because
> the adc driver isn't loaded at this point and now the probe fails in
> the function iio_channel_get_sys and returns -ENODEV.
> My question is: Who is in this case responsible to request a deferral?
> The driver or the subsystem?
> 
Unless I am missing something, iio_get_channel() should request probe deferral.
There is no other way for the driver to know that the adc driver is not loaded
yet.

The problem here may be that the devicetree entry for the ntc_thermistor driver
may not be correct. The above referenced patch fixes a bug in that area, and
devicetree data is now better validated.

Guenter
