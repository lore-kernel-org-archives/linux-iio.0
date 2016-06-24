Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35666 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbcFXK0L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 06:26:11 -0400
Received: by mail-oi0-f47.google.com with SMTP id r2so109434916oih.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2016 03:26:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <272E4CB3-460C-4FC2-9164-6304B550E80D@goldelico.com>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-3-git-send-email-linus.walleij@linaro.org> <272E4CB3-460C-4FC2-9164-6304B550E80D@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Jun 2016 12:26:10 +0200
Message-ID: <CACRpkdaLMZ_iQnebK1M_D2heFuTCjaBh2hqZrqizKczbfGruAg@mail.gmail.com>
Subject: Re: [PATCH 2/9 v2] iio: pressure: bmp280: support device tree initialization
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Discussions about the Letux Kernel
	<letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 23, 2016 at 10:18 AM, H. Nikolaus Schaller
<hns@goldelico.com> wrote:
>> Am 22.06.2016 um 22:53 schrieb Linus Walleij <linus.walleij@linaro.org>:

>> +#ifdef CONFIG_OF
>> +static const struct of_device_id bmp280_of_match[] = {
>> +     { .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
>> +     { .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
>> +     { .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
>> +     { .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
>
> Here I get:
>
> FATAL: drivers/iio/pressure/bmp280-i2c: struct of_device_id is not terminated with a NULL entry!

I got this from the build robot too, fixed locally and resending in v3.
Thanks!

Yours,
Linus Walleij
