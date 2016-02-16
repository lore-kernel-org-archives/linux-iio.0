Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35788 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbcBPIS0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2016 03:18:26 -0500
Received: by mail-io0-f175.google.com with SMTP id g203so157689496iof.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Feb 2016 00:18:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160216075658.GA4553@mwanda>
References: <20160216075658.GA4553@mwanda>
Date: Tue, 16 Feb 2016 09:18:25 +0100
Message-ID: <CAL7P5j+QSygH5PFk=jH2=4kBgPAK21B5c00OcrrfYWtmHrLiSg@mail.gmail.com>
Subject: Re: iio: adc: Move mxs-lradc out of staging
From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dan,

On Tue, Feb 16, 2016 at 8:56 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Ksenija Stanojevic,
>
> The patch f836c4592244: "iio: adc: Move mxs-lradc out of staging"
> from Feb 6, 2016, leads to the following static checker warning:
>
>         drivers/iio/adc/mxs-lradc.c:1503 mxs_lradc_hw_init()
>         warn: inconsistent indenting
>
> drivers/iio/adc/mxs-lradc.c
>   1496          mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
>   1497
>   1498          /* Configure the touchscreen type */
>   1499          if (lradc->soc == IMX28_LRADC) {
>   1500                  mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
>   1501                                      LRADC_CTRL0);
>   1502
>   1503          if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
>   1504                  mxs_lradc_reg_set(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
>   1505                                    LRADC_CTRL0);
>
> Should these lines be indented more or are the curly braces misplaced?

Lines should be indented more, I will send a patch.

>   1506          }
>   1507
>   1508          /* Start internal temperature sensing. */
>   1509          mxs_lradc_reg_wrt(lradc, 0, LRADC_CTRL2);
>   1510
>   1511          return 0;
>
>

Thanks,
Ksenija
