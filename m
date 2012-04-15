Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54021 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab2DOQ3p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2012 12:29:45 -0400
Message-ID: <4F8AF777.7070500@cam.ac.uk>
Date: Sun, 15 Apr 2012 17:29:43 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] staging:iio:isl29028 Add IIO_CHAN_INFO_RAW/PROCESSED
 entries
References: <1334490117-28009-1-git-send-email-jic23@kernel.org> <4F8AD058.6030705@kernel.org> <4F8AE9C6.9010901@nvidia.com>
In-Reply-To: <4F8AE9C6.9010901@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/15/2012 04:31 PM, Laxman Dewangan wrote:
> On Sunday 15 April 2012 07:12 PM, Jonathan Cameron wrote:
>> On 04/15/2012 12:41 PM, Jonathan Cameron wrote:
>>> Precursor to making value read / write attribute optional.
>>> This one stands along as it merged just before the series
>>> doing all the other drivers.
>>>
>> Note there is also a one line change to remove the processed_val line
>> in the obvious patch later in the series...
>>
>>> Signed-off-by: Jonathan Cameron<jic23@kernel.org>
>>>
> 
> Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
Thanks for the fast response.  Now I can get this out before any other
drivers sneak past ;)
> 
> changes make more sense now.  I was thinking that what is mask 0 when I
> started this driver and after reading  other driver came to know about
> this.
Yup, it all got a bit ilogical in there. The wonders of code evolution.
>>>           switch (chan->type) {
>>>           case IIO_LIGHT:
>>>               ret = isl29028_als_get(chip, val);
>>> @@ -391,12 +392,15 @@ static const struct iio_chan_spec
>>> isl29028_channels[] = {
>>>       {
>>>           .type = IIO_LIGHT,
>>>           .processed_val = 1,
> 
> processed_val should be removed here and already you have taken care.
yup, that occurs 2 patches later to keep things working all the way
through the series.
> 
> 
> -----------------------------------------------------------------------------------
> 
> This email message is for the sole use of the intended recipient(s) and
> may contain
> confidential information.  Any unauthorized review, use, disclosure or
> distribution
> is prohibited.  If you are not the intended recipient, please contact
> the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

