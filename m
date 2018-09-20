Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:58658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731492AbeITOYP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Sep 2018 10:24:15 -0400
Date: Thu, 20 Sep 2018 09:41:39 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
CC: Song Qiang <songqiang1304521@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180920094139.000065fe@huawei.com>
In-Reply-To: <CY4PR21MB07761FEA1CDDC87FBE5568B4FB1C0@CY4PR21MB0776.namprd21.prod.outlook.com>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <CY4PR21MB07761FEA1CDDC87FBE5568B4FB1C0@CY4PR21MB0776.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 19 Sep 2018 18:58:37 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v4.18.8, v4.14.70, v4.9.127, v4.4.156, v3.18.122, 
> 
> v4.18.8: Build OK!
> v4.14.70: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
> 
> v4.9.127: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
> 
> v4.4.156: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
> 
> v3.18.122: Failed to apply! Possible dependencies:
>     22aac3eb0c46 ("MAINTAINERS: add entry for STM32 I2C driver")
>     4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
>     78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
> 
> 
> Please let us know how to resolve this.
> 
> --
> Thanks,
> Sasha
Hi Sasha,

This is a false detection.  The stable tag is in the context of the
additions to MAINTAINERS.   I guess that is a rare enough case it's not
worth fixing in your scripts, but thought I'd point it out incase you
want to do so!

Jonathan
