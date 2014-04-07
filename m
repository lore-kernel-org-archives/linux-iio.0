Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55623 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbaDGRyq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Apr 2014 13:54:46 -0400
Message-ID: <5342E6B1.6010100@kernel.org>
Date: Mon, 07 Apr 2014 18:56:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 1/6] staging:iio:adc:spear adc - prefix defines to avoid
 namespace clashes.
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-2-git-send-email-jic23@kernel.org> <53412831.1080406@gmx.de>
In-Reply-To: <53412831.1080406@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/14 11:10, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> Acked-by: Stefan Roese <sr@denx.de>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Thanks, applied to the togreg branch of iio.git - initially
pushed out as testing for the autobuilders to play.
>> ---
>>   drivers/staging/iio/adc/spear_adc.c | 73 ++++++++++++++++++-------------------
>>   1 file changed, 36 insertions(+), 37 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

