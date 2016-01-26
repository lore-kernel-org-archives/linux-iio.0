Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34943 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbcAZW25 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2016 17:28:57 -0500
MIME-Version: 1.0
In-Reply-To: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Tue, 26 Jan 2016 20:28:37 -0200
Message-ID: <CAKi4VA+n63x=HXGpijksCSMC6tb0ppCqxqAiVwSuGnw2TkzS7g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, lkml <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Thu, Jan 14, 2016 at 2:25 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> The driver has sysfs readings with runtime PM support for power saving.
> It also offers buffer support that can be used together with IIO software
> triggers.
>
> Datasheet can be found here:
>         http://www.ti.com.cn/cn/lit/ds/symlink/ads1015.pdf
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---

[ ... ]

> +static const struct i2c_device_id ads1015_id[] = {
> +       {"ads1015", 0},

shouldn't this be ti-ads1015 so not to clash with the hwmon driver?

> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, ads1015_id);
> +
> +static struct i2c_driver ads1015_driver = {
> +       .driver = {
> +               .name = ADS1015_DRV_NAME,

same here, otherwise we will have an i2c:ads1015 alias


Lucas De Marchi
