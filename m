Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdGQUyB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jul 2017 16:54:01 -0400
Date: Mon, 17 Jul 2017 21:53:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: Documentation: Add ina2xx shunt_resistor
 attribute documentation
Message-ID: <20170717215357.6452f0f5@kernel.org>
In-Reply-To: <2351a045a0564f5bb2af6c652d1fa5e3@rwthex-w2-b.rwth-ad.de>
References: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
        <2351a045a0564f5bb2af6c652d1fa5e3@rwthex-w2-b.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 01:34:10 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> The ina2xx driver appeared in the Linux kernel version 4.5, but provided
> no documentation. Contrary to other uses of resistance in IIO, ina2xx uses
> microohms instead of ohms in the sysfs attribute.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
This has me confused.  The documentation is already
there and lists it as being in ohms.

Ah, subtle filename difference.  Docs in are
Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc

This attribute effectively exists for other parts
as well now.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> new file mode 100644
> index 000000000000..9525098f6822
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
> +Date:		December 2015
> +KernelVersion:	4.5
> +Contact:	linux-iio@vger.kernel.org
> +Description: 	The value of the shunt resistor connected to the V_IN+ and V_IN-
> +		inputs, used to compute the current flowing through the shunt and
> +		the corresponding power. In microohms.

