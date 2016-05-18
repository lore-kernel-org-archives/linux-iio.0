Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34057 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbcERPY4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2016 11:24:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id m101so3454447lfi.1
        for <linux-iio@vger.kernel.org>; Wed, 18 May 2016 08:24:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1463584578-16772-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1463584578-16772-1-git-send-email-quentin.schulz@free-electrons.com>
Date: Wed, 18 May 2016 18:24:54 +0300
Message-ID: <CAEnQRZCf+_wppwNznDupddOh9aO6+eqB3ZXg7F7oO7bT+ta5mg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: nau7802: Expose possible gains in sysfs
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	maxime.ripard@free-electrons.com,
	alexandre.belloni@free-electrons.com,
	antoine.tenart@free-electrons.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 18, 2016 at 6:16 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The Nuvoton NAU7802 ADC is able to adjust its gain but prior knowledge of
> its possible values was required to adjust it. Users had to guess the
> possible gain values based on the ADC datasheet or on this driver's code.
>
> This exposes the possible values in the in_voltage_scale_available file of
> each nau7802 ADC device. The gain is set for the whole ADC and is therefore
> not configurable by channel. Thus, there exists only one
> in_voltage_scale_available file for each nau7802 ADC device even if it has
> two separate channels.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>
> There exists two files to set the gain: in_voltageX_scale_available and
> in_voltage-voltage_scale_available. What are the differences between those
> two? What are the use cases for each? Which one should I have used?

First is for single channels while the latter is for differential channels.
In this case it's correct to use in in_voltageX_scale_available as you did.

thanks,
Daniel.
