Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:43826 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbaJ1O4C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Oct 2014 10:56:02 -0400
Received: by mail-wi0-f169.google.com with SMTP id q5so9055313wiv.4
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2014 07:56:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414261101-15590-1-git-send-email-darshanapadmadas@gmail.com>
References: <1414261101-15590-1-git-send-email-darshanapadmadas@gmail.com>
Date: Tue, 28 Oct 2014 16:56:00 +0200
Message-ID: <CAEnQRZDicaPjxx-_VOXAWzgkoD1qTBUOpyapdkR3eKUcz0BKzg@mail.gmail.com>
Subject: Re: [OPW kernel] [PATCH] iio: Add ABI documentation for scaled voltage
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Darshana Padmadas <darshanapadmadas@gmail.com>
Cc: opw-kernel <opw-kernel@googlegroups.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 25, 2014 at 9:18 PM, Darshana Padmadas
<darshanapadmadas@gmail.com> wrote:
> This patch adds an entry in ABI documentation for in_voltage-voltage_scale.
> It has at least one user driver, adis16220, in accel driver.
>
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d760b02..0640118 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -251,6 +251,7 @@ Description:
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_voltage_scale
> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
>  What:          /sys/bus/iio/devices/iio:deviceX/in_accel_scale
> --

Looks good to me. Adding Jonathan and linux-iio for comments.

thanks,
Daniel.
