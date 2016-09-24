Return-Path: <elfring@users.sourceforge.net>
Subject: Re: [PATCH 1/7] iio: Use kmalloc_array() in iio_scan_mask_set()
To: Jonathan Cameron <jic23@kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <d0db8c45-5999-6000-212a-3e8957766afb@users.sourceforge.net>
 <7d1ed0ab-f3ce-3112-a004-1540c54638fd@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <6d97d9b3-27f5-bd9b-93d1-65bd65959d74@users.sourceforge.net>
Date: Sat, 24 Sep 2016 18:18:14 +0200
MIME-Version: 1.0
In-Reply-To: <7d1ed0ab-f3ce-3112-a004-1540c54638fd@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

> Applied to the togreg branch of iio.git - initially pushed out
> as testing for the autobuilders to play with it.

Thanks for your positive response.


Do you see any need to improve the software situation around
the macro "BITS_TO_LONGS" further?

Do you fiddle with a programming interface like "bitmap_alloc" occasionally?

Regards,
Markus
