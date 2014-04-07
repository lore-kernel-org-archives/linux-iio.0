Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55684 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752AbaDGSF6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Apr 2014 14:05:58 -0400
Message-ID: <5342E952.4040407@kernel.org>
Date: Mon, 07 Apr 2014 19:07:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: sr@denx.de
Subject: Re: [PATCH 4/6] staging:iio:adc:spear rename device specific state
 structure to _state
References: <1396716315-2465-1-git-send-email-jic23@kernel.org> <1396716315-2465-5-git-send-email-jic23@kernel.org> <5341283F.6010106@gmx.de>
In-Reply-To: <5341283F.6010106@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/14 11:11, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> Also rename instances of it to st.  This brings the driver inline with
>> the conventions of IIO and avoids some naming confusion with some IIO
>> structures which also use the _info postfix.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git

Thanks
>> ---
>>   drivers/staging/iio/adc/spear_adc.c | 126 ++++++++++++++++++------------------
>>   1 file changed, 63 insertions(+), 63 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

