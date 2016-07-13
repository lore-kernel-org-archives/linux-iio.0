Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34822 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcGMMsm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2016 08:48:42 -0400
Received: by mail-wm0-f45.google.com with SMTP id f65so27464564wmi.0
        for <linux-iio@vger.kernel.org>; Wed, 13 Jul 2016 05:48:41 -0700 (PDT)
Date: Wed, 13 Jul 2016 13:49:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Ksenija =?utf-8?Q?Stanojevi=C4=87?=
	<ksenija.stanojevic@gmail.com>, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>,
	linux-iio@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Message-ID: <20160713124935.GC11154@dell>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell>
 <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 01 Jul 2016, Harald Geyer wrote:

> Hi Ksenija!
> 
> Ksenija Stanojević writes:
> > On Tue, Jun 28, 2016 at 6:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > >> +static int mxs_lradc_add_device(struct platform_device *pdev,
> > >> +                             struct mxs_lradc *lradc, char *name, int i)
> > >> +{
> > >> +     struct mfd_cell *cell;
> > >> +
> > >> +     cell = &lradc->cells[i];
> > >> +     cell->name = name;
> > >> +     cell->platform_data = lradc;
> > >> +     cell->pdata_size = sizeof(*lradc);
> > >> +
> > >> +     return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
> > >> +}
> > >
> > > Please don't roll your own API.
> > >
> > > Use 'struct mfd_cell' like everyone else does.
> > 
> > It has been suggested in previous reviews to use separate function to
> > register mfd device, and to make mfd_cell allocate dynamically because
> > struc mxs-lradc is allocated dynamically.
> > But I can revrse changes and make mfd_cells allocate staticaly
> > wthout separate function.
> 
> I think making mfd_cells members of struct mxs-lradc will address all
> review comments.

No, please don't do that either.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
