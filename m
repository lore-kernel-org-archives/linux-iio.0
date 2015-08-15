Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49067 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbbHOT5Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 15:57:24 -0400
Subject: Re: [PATCH 05/19] staging: iio: Remove unnecessary externs
To: Lars-Peter Clausen <lars@metafoo.de>,
	Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <cover.1439241825.git.joe@perches.com>
 <fba2902597293652f4d8561730c0cf16cd4369a0.1439241825.git.joe@perches.com>
 <55CA424F.1030704@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF99A1.1000701@kernel.org>
Date: Sat, 15 Aug 2015 20:57:21 +0100
MIME-Version: 1.0
In-Reply-To: <55CA424F.1030704@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/15 19:43, Lars-Peter Clausen wrote:
> On 08/10/2015 11:51 PM, Joe Perches wrote:
>> Using 'extern' is not necessary for function prototypes.
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Applied to the togreg branch of iio.git.  4.4 material now
probably.

Thanks,

Jonathan
> Thanks.
> 
>> ---
>>  drivers/staging/iio/meter/ade7854.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
>> index 52ca541..52f4195 100644
>> --- a/drivers/staging/iio/meter/ade7854.h
>> +++ b/drivers/staging/iio/meter/ade7854.h
>> @@ -168,7 +168,7 @@ struct ade7854_state {
>>  
>>  };
>>  
>> -extern int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
>> -extern int ade7854_remove(struct iio_dev *indio_dev);
>> +int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
>> +int ade7854_remove(struct iio_dev *indio_dev);
>>  
>>  #endif
>>
> 

