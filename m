Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59673 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758267AbcIXQgd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:36:33 -0400
Subject: Re: [PATCH 1/7] iio: Use kmalloc_array() in iio_scan_mask_set()
To: SF Markus Elfring <elfring@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <d0db8c45-5999-6000-212a-3e8957766afb@users.sourceforge.net>
 <7d1ed0ab-f3ce-3112-a004-1540c54638fd@kernel.org>
 <6d97d9b3-27f5-bd9b-93d1-65bd65959d74@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <82e19d9b-ecbd-6252-a6fe-f96afadc3be4@kernel.org>
Date: Sat, 24 Sep 2016 17:36:30 +0100
MIME-Version: 1.0
In-Reply-To: <6d97d9b3-27f5-bd9b-93d1-65bd65959d74@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 17:18, SF Markus Elfring wrote:
>> Applied to the togreg branch of iio.git - initially pushed out
>> as testing for the autobuilders to play with it.
> 
> Thanks for your positive response.
> 
> 
> Do you see any need to improve the software situation around
> the macro "BITS_TO_LONGS" further?
> 
> Do you fiddle with a programming interface like "bitmap_alloc" occasionally?
It might be clearer than having an array allocation as we do after this
patch. Obviously the representation is an array, but it is a little ugly
as it stands!
> 
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

