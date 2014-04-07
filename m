Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55678 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaDGSFa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Apr 2014 14:05:30 -0400
Message-ID: <5342E936.3080508@kernel.org>
Date: Mon, 07 Apr 2014 19:06:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 3/6] staging:iio:adc:spear_adc use info_mask_shared_by_all
 for samp freq
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-4-git-send-email-jic23@kernel.org> <5341283A.5030202@gmx.de>
In-Reply-To: <5341283A.5030202@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/14 11:11, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> Using the core support makes this element available to in kernel users as
>> well as to userspace under exactly the same interface as before.  The
>> intent is to move all sampling frequency control to this approach
>> throughout IIO.
>>
>> Drop unused clk_high and clk_low whilst we are at it.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Stefan Roese <sr@denx.de>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git

Thanks,


>> ---
>>   drivers/staging/iio/adc/spear_adc.c | 92 +++++++++++++------------------------
>>   1 file changed, 33 insertions(+), 59 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

