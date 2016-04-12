Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37944 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933322AbcDLNnI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2016 09:43:08 -0400
Received: by mail-wm0-f41.google.com with SMTP id u206so28796842wme.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2016 06:43:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <570CF267.4020804@intel.com>
References: <570CDFD0.7060702@intel.com>
	<alpine.DEB.2.02.1604121404050.4383@pmeerw.net>
	<570CF267.4020804@intel.com>
Date: Tue, 12 Apr 2016 16:43:07 +0300
Message-ID: <CAEnQRZDFF4WrWz_XGqaxqizvF4pTTD+NunnFDxmkiey6-K65cw@mail.gmail.com>
Subject: Re: IIO driver for si114x
From: Daniel Baluta <daniel.baluta@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Matt Ranostaj <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 12, 2016 at 4:04 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> On 04/12/2016 03:06 PM, Peter Meerwald-Stadler wrote:
>>>
>>> I want to add support for a si1145 light sensor. Some brief googling
>>> finds a
>>> bunch of old (2012) patches for an si114x driver in drivers/iio/light.
>>> Here's
>>> the link to the old thread:
>>>
>>> http://comments.gmane.org/gmane.linux.kernel.iio/5478
>>
>>
>> I have updated sources, not yet posted
>> Matt Ranostay also indicated that he'd be willing to work on the device
>
> I found some reasonably recent sources in the chromeos kernel:
>
> https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/chromeos-4.4/drivers/iio/light/si114x.c
>
> This driver seems to be only for si1141/42/43 models and will explicitly
> fail on probe with the part_id values reported by si1145. Some hacking made
> the driver probe and report some sort of values.
>
> I'm not sure how well that driver is tested, it failed for me at register
> time because SI114X_CURRENT_CHANNEL has the default scan_index 0 and this is
> detected as a duplicate despite the fact that scan_type is not otherwise
> filled. This check has been in the IIO core since 3.18.

Pretty sure the tests where done without this patch:

http://www.spinics.net/lists/linux-iio/msg15851.html
