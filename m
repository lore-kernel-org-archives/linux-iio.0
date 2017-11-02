Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:37754 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933398AbdKBOpG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Nov 2017 10:45:06 -0400
Date: Thu, 2 Nov 2017 14:44:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Matt Ranostay" <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2 00/13] iio: health: Add MAX30105 support to max30102
 driver
Message-ID: <20171102144424.00004629@huawei.com>
In-Reply-To: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 27 Oct 2017 21:45:30 +0200
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> This patch series reworks the max30102 driver to add support for the
> MAX30105 part (which add a third LED)
> 
> v2:
> * send correct patches, sorry for the mess
> * fix Matt Ranostay's email address
> 
Series looks good to me.

Ideally I'd like Matt to have a look and given where we are in the cycle
(i.e. this one is over for IIO) we have plenty of time.

Thanks,

Jonathan
> 
> patches 1 to 3 are bugfix
> 
> patches 4 to 6 add minor features and cleanup
> 
> patch 8 allows to read the temperature without currently measuring
> other channels
> 
> patches 9 to 11 prepare for adding another LED, more flexibility
> 
> patch 12 adds support for the MAX30105 part
> 
> patch 13 updates devicetree documentation for the MAX30105 part
> 
> Peter Meerwald-Stadler (13):
>   iio: health: max30102: Temperature should be in milli Celsius
>   iio: health: max30102: Fix missing newline in dev_err
>   iio: health: max30102: Remove inconsistent full stop in error
> message iio: health: max30102: Fix mode config values
>   iio: health: max30102: Check retval of powermode function
>   iio: health: max30102: Add check for part ID
>   iio: health: max30102: Introduce intensity channel macro
>   iio: health: max30102: Add power enable parameter to get_temp
> function iio: health: max30102: Introduce indices for LED channels
>   iio: health: max30102: Move mode setting to buffer_postenable
>   iio: health: max30102: Prepare for copying varying number of
>     measurements
>   iio: health: max30102: Add MAX30105 support
>   dt-bindings: iio: health: Add MAX30105 support to max30102.txt
> 
>  .../devicetree/bindings/iio/health/max30102.txt    |   8 +-
>  drivers/iio/health/max30102.c                      | 310
> ++++++++++++++++----- 2 files changed, 241 insertions(+), 77
> deletions(-)
> 

