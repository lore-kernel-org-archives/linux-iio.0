Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40171 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab2GBOuE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2012 10:50:04 -0400
Message-ID: <4FF1B518.5080209@kernel.org>
Date: Mon, 02 Jul 2012 15:50:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio:kfifo_buf  Take advantage of the fixed record
 size used in IIO
References: <1341060763-9602-1-git-send-email-jic23@kernel.org> <1341060763-9602-2-git-send-email-jic23@kernel.org> <4FF18C68.5000904@metafoo.de>
In-Reply-To: <4FF18C68.5000904@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 7/2/2012 12:56 PM, Lars-Peter Clausen wrote:
> On 06/30/2012 02:52 PM, Jonathan Cameron wrote:
>> @@ -106,11 +108,12 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>>   	int ret, copied;
>>   	struct iio_kfifo *kf = iio_to_kfifo(r);
>>   
>> -	if (n < r->bytes_per_datum)
>> +	if (n < r->bytes_per_datum || r->bytes_per_datum == 0)
>>   		return -EINVAL;
> Strictly speaking this is a unrelated change, but well...
Fair point. Naughty me ;(  Will split out as a separate patch on next 
version.
>
> I'll apply the kfifo patches to my IIO working tree and see if I'll get any
> issues.
Thanks
