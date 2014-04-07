Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55704 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbaDGSKa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Apr 2014 14:10:30 -0400
Message-ID: <5342EA62.1070009@kernel.org>
Date: Mon, 07 Apr 2014 19:11:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 6/6] staging:iio:adc:spear rename spear_read_raw to spear_adc_read_raw
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-7-git-send-email-jic23@kernel.org> <53412847.3030700@gmx.de>
In-Reply-To: <53412847.3030700@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/14 11:11, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> This brings it inline with all the other prefix usage in the driver.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>

Hmm, I think something went wrong with the original patch.
The users of this function weren't updated. I've fixed that
as it was trivial and taken the view that the ack assumed
I wasn't an idiot ;)

Applied with fix to the togreg branch of iio.git

Thanks,

Jonathan


>> ---
>>   drivers/staging/iio/adc/spear_adc.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

