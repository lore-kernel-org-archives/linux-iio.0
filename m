Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:45298 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbcGNQGV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2016 12:06:21 -0400
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
To: Lee Jones <lee.jones@linaro.org>, Harald Geyer <harald@ccbib.org>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell>
 <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
 <20160713124935.GC11154@dell>
Cc: =?UTF-8?Q?Ksenija_Stanojevi=c4=87?= <ksenija.stanojevic@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de>
Date: Thu, 14 Jul 2016 17:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <20160713124935.GC11154@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/13/2016 02:49 PM, Lee Jones wrote:
> On Fri, 01 Jul 2016, Harald Geyer wrote:
>
>> Hi Ksenija!
>>
>> Ksenija Stanojević writes:
>>> On Tue, Jun 28, 2016 at 6:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>>>> +static int mxs_lradc_add_device(struct platform_device *pdev,
>>>>> +                             struct mxs_lradc *lradc, char *name, int i)
>>>>> +{
>>>>> +     struct mfd_cell *cell;
>>>>> +
>>>>> +     cell = &lradc->cells[i];
>>>>> +     cell->name = name;
>>>>> +     cell->platform_data = lradc;
>>>>> +     cell->pdata_size = sizeof(*lradc);
>>>>> +
>>>>> +     return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
>>>>> +}
>>>>
>>>> Please don't roll your own API.
>>>>
>>>> Use 'struct mfd_cell' like everyone else does.
>>>
>>> It has been suggested in previous reviews to use separate function to
>>> register mfd device, and to make mfd_cell allocate dynamically because
>>> struc mxs-lradc is allocated dynamically.
>>> But I can revrse changes and make mfd_cells allocate staticaly
>>> wthout separate function.
>>
>> I think making mfd_cells members of struct mxs-lradc will address all
>> review comments.
>
> No, please don't do that either.
>
It'd be nice if you explained in detail why not. Otherwise this is just 
empty splat.

-- 
Best regards,
Marek Vasut
