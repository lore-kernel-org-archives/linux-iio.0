Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:50865 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab1BIXBV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Feb 2011 18:01:21 -0500
Date: Wed, 9 Feb 2011 15:00:58 -0800
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] Staging: IIO: ADC: New driver for
 AD7606/AD7606-6/AD7606-4
Message-ID: <20110209230058.GA32064@kroah.com>
References: <1297253238-1865-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1297253238-1865-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 09, 2011 at 01:07:18PM +0100, michael.hennerich@analog.com =
wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> This patch adds support for the:
> AD7606/AD7606-6/AD7606-4 8/6/4-Channel Data Acquisition
> system (DAS) with 16-Bit, Bipolar, Simultaneous Sampling ADC.
>=20
> Changes since V1:
> IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4: Apply review feedb=
ack
>=20
> Rename sysfs node oversampling to oversampling_ratio.
> Kconfig: Add GPIOLIB dependency.
> Use range in mV to better match HWMON.
> Rename ad7606_check_oversampling.
> Fix various comments and style.
> Reorder is_visible cases.
> Use new gpio_request_one/array and friends.
> Drop check for SPI max_speed_hz.
>=20
> Changes since V2:
> IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4: Apply review feedb=
ack
>=20
> Documentation: specify unit
> Avoid raise condition in ad7606_scan_direct()
> Check return value of bus ops read_block()

This patch fails to build here:

drivers/staging/iio/adc/ad7606_core.c: In function =E2=80=98ad7606_scan=
_direct=E2=80=99:
drivers/staging/iio/adc/ad7606_core.c:47:8: error: =E2=80=98TASK_INTERR=
UPTIBLE=E2=80=99 undeclared (first use in this function)
drivers/staging/iio/adc/ad7606_core.c:47:8: note: each undeclared ident=
ifier is reported only once for each function it appears in
drivers/staging/iio/adc/ad7606_core.c:47:2: error: implicit declaration=
 of function =E2=80=98signal_pending=E2=80=99
drivers/staging/iio/adc/ad7606_core.c:47:2: error: implicit declaration=
 of function =E2=80=98schedule=E2=80=99
drivers/staging/iio/adc/ad7606_core.c: In function =E2=80=98ad7606_inte=
rrupt=E2=80=99:
drivers/staging/iio/adc/ad7606_core.c:400:3: error: =E2=80=98TASK_INTER=
RUPTIBLE=E2=80=99 undeclared (first use in this function)
make[4]: *** [drivers/staging/iio/adc/ad7606_core.o] Error 1


Care to actually test build it next time?  :(

thanks,

greg k-h
