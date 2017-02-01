Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr10103.outbound.protection.outlook.com ([40.107.1.103]:10160
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751243AbdBAKS3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Feb 2017 05:18:29 -0500
Subject: Re: [PATCH 1/2] iio: pressure: mpl3115: do not rely on structure
 field ordering
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1485936567-3367-1-git-send-email-peda@axentia.se>
 <1485936567-3367-2-git-send-email-peda@axentia.se>
 <alpine.DEB.2.02.1702010956370.3042@pmeerw.net>
 <ef02efd6-d0da-9310-ba1b-ab3133637f6b@axentia.se>
 <alpine.DEB.2.02.1702011021580.3042@pmeerw.net>
 <8eba97cc-69e5-3698-ddf3-d6eca0bcd3f8@axentia.se>
 <alpine.DEB.2.02.1702011053190.3042@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Ken Lin <ken.lin@advantech.com>, <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <2936f505-79d9-340e-4454-ec7ef0bc7236@axentia.se>
Date: Wed, 1 Feb 2017 11:18:20 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1702011053190.3042@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-02-01 10:57, Peter Meerwald-Stadler wrote:
>>> -  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>>> 			BIT(IIO_CHAN_INFO_SCALE),
>>> +  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> 			BIT(IIO_CHAN_INFO_SCALE),
>>> as originally intended
>>
>> I considered that option, but the code in mpl3115_read_raw (and
>> mpl115_read_raw for that matter) return constants fro these values which
>> to me indicated that they were not "separate" and as that would also be
>> the change which replicated the exact behavior from before the regression
>> I went with that. But I don't care either way, so I can re-spin if you
>> want me to? (But don't blame me if that regresses in some other
>> interesting way).
> 
> no, all good; shared_by_type is the way to go
> I'd rather respin for the not ORed comment in the patch

Ok, but I think I'll wait a bit so that Ken Lin gets some time to verify
that it actually solves the original problem. It should, but...

Cheers,
peda

