Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43657 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbcJ3StD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 14:49:03 -0400
Subject: Re: [PATCH v3] staging: iio: cdc: ad7746: add additional config
 defines
To: Lars-Peter Clausen <lars@metafoo.de>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <1477643212-7200-1-git-send-email-eraretuya@gmail.com>
 <f59b10dc-e273-d147-611c-0fca52ee8bc0@kernel.org>
 <48d88156-88a9-dcc9-48d8-809d992c56e1@metafoo.de>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5ef0f1e1-236c-0698-cdfc-533125b2d2c7@kernel.org>
Date: Sun, 30 Oct 2016 18:49:00 +0000
MIME-Version: 1.0
In-Reply-To: <48d88156-88a9-dcc9-48d8-809d992c56e1@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/10/16 17:46, Lars-Peter Clausen wrote:
> On 10/30/2016 06:41 PM, Jonathan Cameron wrote:
>> On 28/10/16 09:26, Eva Rachel Retuya wrote:
>>> Introduce defines for shifting and mask under the config register for
>>> better readability. Also, introduce helper variables for index
>>> calculation.
>>>
>>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
>> Looks good to me.
>>
>> Lars could you sanity check this one as well?
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
There was a bit of fun applying this.  Eva, can you check I didn't mess it
up?

Applied to the togreg branch of iio.git.  Initially pushed out as testing
for the autobuilders to play with it. (and this time I remembered to actually
do the push!)

thanks,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

