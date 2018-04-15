Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752457AbeDOPkT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:40:19 -0400
Date: Sun, 15 Apr 2018 16:40:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] staging: iio: ad7746: Add ABI documentation
Message-ID: <20180415164012.3e848d51@archlinux>
In-Reply-To: <1523637411-8531-13-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-13-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:49 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> The use cases for this driver don't comply with the current ABI. The
> ad7746 and ad7152 need an external capacitance or voltage reference to
> automatically calibrate themselves which is not the normal use case of
> the calibscale and calibbias ABIs, a new ABI was needed.

I agree with the general aim here.  Would appreciate input from Michael
in particular on these + ideally others!

One comment inline,

Thanks,

Jonathan

> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-ad7746 | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad7746
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad7746 b/Documentation/ABI/testing/sysfs-bus-iio-ad7746
> new file mode 100644
> index 0000000..96a41b7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad7746
> @@ -0,0 +1,17 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibscale_calibration
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_calibscale_calibration

Hmm. I wonder if indicating that it causes calibration would be better done by
in_voltage0_calibscale_calibrate

> +KernelVersion:	4.17.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enter gain calibration mode, in which a full-scale
> +		{capacitance, voltage reference} must be connected to the
> +		{capacitance, voltage} input beforehand to automatically
> +		calibrate the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibbias_calibration
> +KernelVersion:	4.17.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enter offset calibration mode, in which a zero-scale
> +		capacitance must be connected to the capacitance input
> +		beforehand to automatically calibrate the device.

