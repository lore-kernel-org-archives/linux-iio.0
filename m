Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57978 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1955611AbdDZFZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 01:25:38 -0400
Subject: Re: [PATCH v3 0/2] staging: iio: isl29028: move out of staging
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
References: <20170425013434.1206-1-masneyb@onstation.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a7da92e0-07de-f8ed-99e9-3097cc43e394@kernel.org>
Date: Wed, 26 Apr 2017 06:25:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170425013434.1206-1-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/04/17 02:34, Brian Masney wrote:
> Minor cleanup to the proximity sampling to move this driver out of
> staging.
> 
> Datasheet:
> http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29028.pdf
> 
> Changes since v2:
> - Reject any value that is not in the
>   in_proximity_sampling_frequency_available sysfs attribute.
> - Changed the sampling frequency 83.3 to 80. The data sheet lists 12.5
>   ms, but the original code listed 12 ms, which was the cause of the
>   discrepancy.
> Changes since v1:
> - in_proximity_sampling_frequency_available sysfs attribute now shows
>   decimals.
> 
> Jonathan: Sorry it took me a little over two months to get back to you
> on this driver. I got side tracked with other projects.
*laughs* I have series that I haven't gotten back to reviews on in
years!  What's a few months ;)

Thanks though as this work is good stuff!

Jonathan
> 
> Brian Masney (2):
>   staging: iio: isl29028: correct proximity sleep times
>   staging: iio: isl29028: move out of staging
> 
>  drivers/iio/light/Kconfig            |  10 +
>  drivers/iio/light/Makefile           |   1 +
>  drivers/iio/light/isl29028.c         | 723 +++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/light/Kconfig    |  10 -
>  drivers/staging/iio/light/Makefile   |   1 -
>  drivers/staging/iio/light/isl29028.c | 693 ---------------------------------
>  6 files changed, 734 insertions(+), 704 deletions(-)
>  create mode 100644 drivers/iio/light/isl29028.c
>  delete mode 100644 drivers/staging/iio/light/isl29028.c
> 

