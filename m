Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:54153 "EHLO fe2.pruts.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755852AbcINF73 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Sep 2016 01:59:29 -0400
Content-Type: text/plain; charset=UTF-8
From: Ico Doornekamp <ico@pruts.nl>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ
In-reply-to: <99ce25ac-2330-ad53-151d-f580226906eb@kernel.org>
References: <20160910191946.30105-1-ico@pruts.nl> <99ce25ac-2330-ad53-151d-f580226906eb@kernel.org>
Date: Wed, 14 Sep 2016 07:59:23 +0200
Message-Id: <1473832511-sup-5279@pruts.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* On 2016-09-13 19:35:28 +0200, Jonathan Cameron wrote:
 
> Other than one big issue, the patch looks very good.
> 
> You actually need to add this entry to one of the info_mask bitmaps to
> have the attributes instantiated.

I suspected as much, but I wasn't quite sure about the semantics of the
fields, and when to use info_mask_shared_by_type vs info_mask_shared_by_all.

-- 
:wq
^X^Cy^K^X^C^C^C^C
