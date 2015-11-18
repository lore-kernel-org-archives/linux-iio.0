Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44102 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbbKRTEY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 14:04:24 -0500
Subject: Re: [PATCH] iio: adc: xilinx: constify iio_buffer_setup_ops structure
To: Lars-Peter Clausen <lars@metafoo.de>,
	Julia Lawall <Julia.Lawall@lip6.fr>
References: <1447617602-12922-1-git-send-email-Julia.Lawall@lip6.fr>
 <5648E8DA.3070509@metafoo.de>
Cc: kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <564CCBB5.6000607@kernel.org>
Date: Wed, 18 Nov 2015 19:04:21 +0000
MIME-Version: 1.0
In-Reply-To: <5648E8DA.3070509@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/11/15 20:19, Lars-Peter Clausen wrote:
> On 11/15/2015 09:00 PM, Julia Lawall wrote:
>> The iio_buffer_setup_ops structures are never modified, so declare this one
>> as const, like the others.
>>
>> Done with the help of Coccinelle.
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.

Thanks,

Jonathan
> 
> Thanks.
> 
>>
>> ---
>>  drivers/iio/adc/xilinx-xadc-core.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>> index 0370624..c2b5f10 100644
>> --- a/drivers/iio/adc/xilinx-xadc-core.c
>> +++ b/drivers/iio/adc/xilinx-xadc-core.c
>> @@ -803,7 +803,7 @@ err:
>>  	return ret;
>>  }
>>  
>> -static struct iio_buffer_setup_ops xadc_buffer_ops = {
>> +static const struct iio_buffer_setup_ops xadc_buffer_ops = {
>>  	.preenable = &xadc_preenable,
>>  	.postenable = &iio_triggered_buffer_postenable,
>>  	.predisable = &iio_triggered_buffer_predisable,
>>
> 

