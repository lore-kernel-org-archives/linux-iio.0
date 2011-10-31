Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55030 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933999Ab1JaLOL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2011 07:14:11 -0400
Message-ID: <4EAE84F7.5080207@cam.ac.uk>
Date: Mon, 31 Oct 2011 11:22:31 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] Staging: iio/dac/ad5360.c: signedness bug in ad5360_read_raw()
References: <20111029072106.GD17780@elgon.mountain> <4EAD2AB4.1010009@metafoo.de>
In-Reply-To: <4EAD2AB4.1010009@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/30/11 10:45, Lars-Peter Clausen wrote:
> On 10/29/2011 09:21 AM, Dan Carpenter wrote:
>> ad5360_get_channel_vref() returns an int and scale_uv should be the
>> same.  Making it unsigned here breaks the error handling.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23cam.ac.uk>
> 
> Thanks.
> 
>> diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
>> index 72d0f3f..cfeea72 100644
>> --- a/drivers/staging/iio/dac/ad5360.c
>> +++ b/drivers/staging/iio/dac/ad5360.c
>> @@ -371,8 +371,8 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
>>  			   long m)
>>  {
>>  	struct ad5360_state *st = iio_priv(indio_dev);
>> -	unsigned long scale_uv;
>>  	unsigned int ofs_index;
>> +	int scale_uv;
>>  	int ret;
>>  
>>  	switch (m) {
> 
> 

