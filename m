Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58261 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949566AbdDZGD3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 02:03:29 -0400
Subject: Re: [PATCH v3 2/2] staging: iio: isl29028: move out of staging
To: Joe Perches <joe@perches.com>,
        Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
References: <20170425013434.1206-1-masneyb@onstation.org>
 <20170425013434.1206-3-masneyb@onstation.org>
 <6c005fd8-7fad-4887-601e-2f8756df2c89@kernel.org>
 <1493185750.18659.24.camel@perches.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c3e1c235-15b3-ebf6-d4f0-25a4a6dc6c9f@kernel.org>
Date: Wed, 26 Apr 2017 07:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <1493185750.18659.24.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/04/17 06:49, Joe Perches wrote:
> On Wed, 2017-04-26 at 06:30 +0100, Jonathan Cameron wrote:
>> On 25/04/17 02:34, Brian Masney wrote:
>>> Move ISL29028 ALS / Proximity Sensor out of staging and into mainline.
>>>
>>> Signed-off-by: Brian Masney <masneyb@onstation.org>
> 
> Hey Brian.
> 
> Next time it's better to use git format-patch -M
> to reduce the patch size and show renames.
My fault :)  For patches doing a move of an IIO driver
out of staging I've asked that people don't
use -M to encourage people to do a 'big picture' review
before we move them out of staging. 

This particular one went pretty smoothly, but in some other
staging move patches it's been a different story!

As Brian has done quite a few of these he is getting pretty
good at it ;)

Jonathan
> 
>> Applied to the togreg branch of iio.git
>>
>> Thanks,
>>
>> Jonathan
>>> ---
>>>  drivers/iio/light/Kconfig            |  10 +
>>>  drivers/iio/light/Makefile           |   1 +
>>>  drivers/iio/light/isl29028.c         | 723 +++++++++++++++++++++++++++++++++++
>>>  drivers/staging/iio/light/Kconfig    |  10 -
>>>  drivers/staging/iio/light/Makefile   |   1 -
>>>  drivers/staging/iio/light/isl29028.c | 723 -----------------------------------
>>>  6 files changed, 734 insertions(+), 734 deletions(-)
>>>  create mode 100644 drivers/iio/light/isl29028.c
>>>  delete mode 100644 drivers/staging/iio/light/isl29028.c
> 
> [quoted the entire patch]
> 
> And Jonathan, please trim your replies a bit more.
> 
> Thanks.
> 

