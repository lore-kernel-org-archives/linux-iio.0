Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44602 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbcC1KCS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 06:02:18 -0400
Subject: Re: [PATCH 1/1] iio: fix config watermark initial value
To: Lars-Peter Clausen <lars@metafoo.de>,
	Irina Tirdea <irina.tirdea@intel.com>,
	linux-iio@vger.kernel.org
References: <1458810585-24555-1-git-send-email-irina.tirdea@intel.com>
 <56F3B217.8040206@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F90127.4000807@kernel.org>
Date: Mon, 28 Mar 2016 11:02:15 +0100
MIME-Version: 1.0
In-Reply-To: <56F3B217.8040206@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 09:23, Lars-Peter Clausen wrote:
> On 03/24/2016 10:09 AM, Irina Tirdea wrote:
>> config structure is set to 0 when updating the buffers, so by
>> default config->watermark will be 0. When computing the minimum
>> between config->watermark and the buffer->watermark or
>> insert_buffer-watermark, this will always be 0 regardless of the
>> value set by the user for the buffer.
>>
>> Set as initial value for config->watermark the maximum allowed
>> value so that the minimum value will always be set from one of the
>> buffers.
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> 
> Looks good. This bug was my fault, sorry.
> 
> Fixes: f0566c0c405d ("iio: Set device watermark based on watermark of all
> attached buffers")
Applied to the fixes-togreg-post-rc1 branch of iio.git and marked for stable.

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/industrialio-buffer.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index b976332..90462fc 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -653,6 +653,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>>  	unsigned int modes;
>>  
>>  	memset(config, 0, sizeof(*config));
>> +	config->watermark = ~0;
>>  
>>  	/*
>>  	 * If there is just one buffer and we are removing it there is nothing
>>
> 

