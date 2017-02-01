Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from dg.advantech.com ([71.4.62.2]:50578 "EHLO dg.advantech.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754197AbdBAS1n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Feb 2017 13:27:43 -0500
From: "Ken.Lin" <ken.lin@advantech.com>
To: Peter Rosin <peda@axentia.se>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 1 Feb 2017 10:24:30 -0800
Subject: RE: [PATCH 1/2] iio: pressure: mpl3115: do not rely on structure
 field ordering
In-Reply-To: <WM!e12d26e0b57c992627516bbebee1f0ac620aa97ce815547b240a5ff4318cef8602c115af08639804344b7a648bbe4b31!@dg.advantech.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
References: <1485936567-3367-1-git-send-email-peda@axentia.se>
 <1485936567-3367-2-git-send-email-peda@axentia.se>
 <alpine.DEB.2.02.1702010956370.3042@pmeerw.net>
 <ef02efd6-d0da-9310-ba1b-ab3133637f6b@axentia.se>
 <alpine.DEB.2.02.1702011021580.3042@pmeerw.net>
 <8eba97cc-69e5-3698-ddf3-d6eca0bcd3f8@axentia.se>
 <alpine.DEB.2.02.1702011053190.3042@pmeerw.net>
 <2936f505-79d9-340e-4454-ec7ef0bc7236@axentia.se>
 <WM!e12d26e0b57c992627516bbebee1f0ac620aa97ce815547b240a5ff4318cef8602c115af08639804344b7a648bbe4b31!@dg.advantech.com>
 <03B5A3CA1724CE4EAC32B27E39292A677FC7512F94@AUSMAIL1.AUS.ADVANTECH.CORP>
Message-Id: <WM!38a78b30daab0c24fd8c60ed9ccee608d25e37d2d9957594967a683b3de9826e80268c5657ee1f62d3d20947c8ad8230!@dg.advantech.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Wednesday, February 1, 2017 2:18 AM
> To: Peter Meerwald-Stadler
> Cc: linux-kernel@vger.kernel.org; Jonathan Cameron; Hartmut Knaack; Lars-
> Peter Clausen; Alison Schofield; Gregor Boirie; Sanchayan Maity; Ken.Lin; linux-
> iio@vger.kernel.org
> Subject: Re: [PATCH 1/2] iio: pressure: mpl3115: do not rely on structure field
> ordering
> 
> On 2017-02-01 10:57, Peter Meerwald-Stadler wrote:
> >>> -  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >>> 			BIT(IIO_CHAN_INFO_SCALE),
> >>> +  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >>> 			BIT(IIO_CHAN_INFO_SCALE),
> >>> as originally intended
> >>
> >> I considered that option, but the code in mpl3115_read_raw (and
> >> mpl115_read_raw for that matter) return constants fro these values
> >> which to me indicated that they were not "separate" and as that would
> >> also be the change which replicated the exact behavior from before
> >> the regression I went with that. But I don't care either way, so I
> >> can re-spin if you want me to? (But don't blame me if that regresses
> >> in some other interesting way).
> >
> > no, all good; shared_by_type is the way to go I'd rather respin for
> > the not ORed comment in the patch
> 
> Ok, but I think I'll wait a bit so that Ken Lin gets some time to verify that it
> actually solves the original problem. It should, but...
> 


The patch test result looks good to me and functions well as before.

# ls /sys/bus/iio/devices/iio\:device1/
buffer  current_timestamp_clock  dev  in_pressure_raw  in_pressure_scale  in_temp_raw  in_temp_scale  name  of_node  power  scan_elements  subsystem  trigger  uevent
# cat /sys/bus/iio/devices/iio\:device1/in_pressure_raw
403668
# cat /sys/bus/iio/devices/iio\:device1/in_pressure_scale
0.000250
# cat /sys/bus/iio/devices/iio\:device1/in_temp_scale
0.062500
# cat /sys/bus/iio/devices/iio\:device1/in_temp_raw
480

Thanks

> Cheers,
> peda
> 
> 
> --
> This message has been scanned for viruses and dangerous content by
> MailScanner, and is believed to be clean.


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

