Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46934 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab2E2Kee (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 May 2012 06:34:34 -0400
Message-ID: <4FC4A636.3000609@cam.ac.uk>
Date: Tue, 29 May 2012 11:34:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH v3] iio: frequency: New driver for AD9523 SPI Low Jitter
 Clock Generator
References: <1338285197-15439-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1338285197-15439-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/29/2012 10:53 AM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
>
> Changes since V1:
>
> Apply Jonathan's review feedback:
> Revise device status attribute names, and split documentation into two sections.
> Add additional comments, and fix indention issues.
> Remove pointless zero initializations.
> Revise return value handling.
> Simplify some code sections.
> Split store_eeprom and sync handling into separate functions.
> Use strtobool where applicable.
> Document platform data structures using kernel-doc style.
>
> Use dev_to_iio_dev
> write_raw IIO_CHAN_INFO_FREQUENCY: Reject values<= 0
> Make patch target drivers/iio
>
> Changes since V2:
>
> Use for_each_clear_bit() and __set_bit() where applicable.
> Add descriptive comment.
> Avoid temporary for struct regulator.
> spi_device_id name use ad9523-1, ad9523 will be added later.
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   .../ABI/testing/sysfs-bus-iio-frequency-ad9523     |   37 +
>   drivers/iio/Kconfig                                |    1 +
>   drivers/iio/Makefile                               |    1 +
>   drivers/iio/frequency/Kconfig                      |   23 +
>   drivers/iio/frequency/Makefile                     |    5 +
>   drivers/iio/frequency/ad9523.c                     | 1057 ++++++++++++++++++++
>   include/linux/iio/frequency/ad9523.h               |  195 ++++
>   7 files changed, 1319 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>   create mode 100644 drivers/iio/frequency/Kconfig
>   create mode 100644 drivers/iio/frequency/Makefile
>   create mode 100644 drivers/iio/frequency/ad9523.c
>   create mode 100644 include/linux/iio/frequency/ad9523.h
>
