Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-193.synserver.de ([212.40.185.193]:1218 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751414AbbJSLRO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Oct 2015 07:17:14 -0400
Message-ID: <5624D136.9030100@metafoo.de>
Date: Mon, 19 Oct 2015 13:17:10 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marc Andre <marc.andre@netline.ch>, jic23@kernel.org
CC: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: iio:ad5064: Add support for LTC2617
References: <CAEnQRZC4sxWXkUgz7316NrzHYa9GkfneG82PcPKgK00S76W=GA@mail.gmail.com> <1444912264-44606-1-git-send-email-marc.andre@netline.ch>
In-Reply-To: <1444912264-44606-1-git-send-email-marc.andre@netline.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/2015 02:31 PM, Marc Andre wrote:
> I've updated the patches according to the feedback of Peter and Daniel.
> - Added datasheet links to the description of patch 1/2.
> - Added 90kohm_to_gnd to ABI documentation sysfs-bus-iio
> 

Looks good to me. You can add

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

I'd prefer though if you change the order of the patches. Patch 1 refactor
the macros so you can specify the ext_info. Patch 2 add support for the LTC
devices, this way we don't end up with a intermediate step where power-down
is broken.

Another thing, if you send a new version of a patch series, don't send it as
a response to the old series. Things tend to get lost that way in nested
threads.

> **** Original intro *****
> 
> Based on the discussion after submitting my patch to add a new driver
> for LTC2617, I've now implemented the support for the LTC2617 (and
> similar) devices into the AD5064 driver.
> 
> I've split the implementation into two patches. The first patch adds
> basic support for LTC2617. The second patch fixes the power down
> functionality because the LTC handle that differently than the AD
> devices.
> 
> [PATCH v2 1/2] iio:ad5064: Add support for ltc2617 and similar devices
> [PATCH v2 2/2] iio:ad5064: Fix power down operation with LTC2617
> 
> Best Regards,
> Marc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

