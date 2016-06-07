Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:47885 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161158AbcFGPTv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2016 11:19:51 -0400
Subject: Re: [PATCH] HC-SR04 ultrasonic ranger IIO driver
To: johannes@johannesthoma.com, linux-iio@vger.kernel.org
References: <1465238418-26095-1-git-send-email-johannes@johannesthoma.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5756E614.5010508@metafoo.de>
Date: Tue, 7 Jun 2016 17:19:48 +0200
MIME-Version: 1.0
In-Reply-To: <1465238418-26095-1-git-send-email-johannes@johannesthoma.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Thanks for the patch.

On 06/06/2016 08:40 PM, johannes@johannesthoma.com wrote:
[...]
> + * To configure a device do a
> + *
> + *    mkdir /sys/kernel/config/iio/triggers/hc-sr04/sensor0
> + *
> + * (you need to mount configfs to /sys/kernel/config first unless it isn't
> + * mounted already)
> + *
> + * Then configure the ECHO and TRIG pins (this also accepts symbolic names
> + * configured in the device tree)
> + *
> + *    echo 23 > /config/iio/triggers/hc-sr04/sensor0/trig_pin
> + *    echo 24 > /config/iio/triggers/hc-sr04/sensor0/echo_pin
> + *
> + * Then you can measure distance with:
> + *
> + *    cat /sys/devices/trigger0/measure
> + *
> + * (trigger0 is the device name as reported by
> + *  /config/iio/triggers/hc-sr04/sensor0/dev_name

Any new ABI needs to be documented in Documentation/ABI/...

But to take one thing ahead passing the GPIO number (or a label) from
userspace is not really a good ABI in my opinion. The GPIO numbers should
come from the hardware description (DTS, ACPI, board file, ...)

> +	do_gettimeofday(&now);

gettimeofday is not a good function if you want to measure elapsed time
since the returned value jumps around when the system time is changed. Try
to use one of the monotonic time sources, those are guaranteed not to jump
around.
