Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32877 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbcFCMCA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:02:00 -0400
Subject: Re: [PATCH v2 3/7] iio: adc: ad7793: claim direct mode when writing
 frequency
To: Lars-Peter Clausen <lars@metafoo.de>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160602042802.GA2910@d830.WORKGROUP>
 <574FF039.9040909@metafoo.de>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <797b141b-a1f5-9540-0bd0-bed17ef583d9@kernel.org>
Date: Fri, 3 Jun 2016 13:01:57 +0100
MIME-Version: 1.0
In-Reply-To: <574FF039.9040909@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/16 09:37, Lars-Peter Clausen wrote:
> On 06/02/2016 06:28 AM, Alison Schofield wrote:
>> Driver was checking for direct mode and trying to lock it, but
>> left a gap where mode could change before the desired operation.
>> Use iio_device_claim_direct_mode() to guarantee device stays in
>> direct mode.
>>
>> Refactor function to clarify look-up followed by lock sequence.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

