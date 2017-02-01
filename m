Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:45606 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751284AbdBAJ5e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Feb 2017 04:57:34 -0500
Date: Wed, 1 Feb 2017 10:57:32 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Peter Rosin <peda@axentia.se>
cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Ken Lin <ken.lin@advantech.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: pressure: mpl3115: do not rely on structure
 field ordering
In-Reply-To: <8eba97cc-69e5-3698-ddf3-d6eca0bcd3f8@axentia.se>
Message-ID: <alpine.DEB.2.02.1702011053190.3042@pmeerw.net>
References: <1485936567-3367-1-git-send-email-peda@axentia.se> <1485936567-3367-2-git-send-email-peda@axentia.se> <alpine.DEB.2.02.1702010956370.3042@pmeerw.net> <ef02efd6-d0da-9310-ba1b-ab3133637f6b@axentia.se> <alpine.DEB.2.02.1702011021580.3042@pmeerw.net>
 <8eba97cc-69e5-3698-ddf3-d6eca0bcd3f8@axentia.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > -  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > 			BIT(IIO_CHAN_INFO_SCALE),
> > +  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > 			BIT(IIO_CHAN_INFO_SCALE),
> > as originally intended
> 
> I considered that option, but the code in mpl3115_read_raw (and
> mpl115_read_raw for that matter) return constants fro these values which
> to me indicated that they were not "separate" and as that would also be
> the change which replicated the exact behavior from before the regression
> I went with that. But I don't care either way, so I can re-spin if you
> want me to? (But don't blame me if that regresses in some other
> interesting way).

no, all good; shared_by_type is the way to go
I'd rather respin for the not ORed comment in the patch

> >> Cheers,
> >> peda
> >>
> >>> thanks, p.
> >>>
> >>>> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> >>>> index cc3f84139157..525644a7442d 100644
> >>>> --- a/drivers/iio/pressure/mpl3115.c
> >>>> +++ b/drivers/iio/pressure/mpl3115.c
> >>>> @@ -190,7 +190,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
> >>>>  	{
> >>>>  		.type = IIO_PRESSURE,
> >>>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >>>> -			BIT(IIO_CHAN_INFO_SCALE),
> >>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> >>>>  		.scan_index = 0,
> >>>>  		.scan_type = {
> >>>>  			.sign = 'u',
> >>>> @@ -203,7 +203,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
> >>>>  	{
> >>>>  		.type = IIO_TEMP,
> >>>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >>>> -			BIT(IIO_CHAN_INFO_SCALE),
> >>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> >>>>  		.scan_index = 1,
> >>>>  		.scan_type = {
> >>>>  			.sign = 's',
> >>>>
> >>>
> >>
> > 
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
