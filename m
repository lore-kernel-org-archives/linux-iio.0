Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44045 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbcDJN72 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 09:59:28 -0400
Subject: Re: [PATCH v2] staging: iio: ad7606: use
 iio_device_{claim|release}_direct_mode()
To: Lars-Peter Clausen <lars@metafoo.de>,
	Alison Schofield <amsfield22@gmail.com>,
	linux-iio@vger.kernel.org
References: <20160401165349.GA2678@d830.WORKGROUP>
 <1459915891-2586-1-git-send-email-amsfield22@gmail.com>
 <57057A4E.208@metafoo.de>
Cc: knaack.h@gmx.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A5C3D.2020102@kernel.org>
Date: Sun, 10 Apr 2016 14:59:25 +0100
MIME-Version: 1.0
In-Reply-To: <57057A4E.208@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/16 22:06, Lars-Peter Clausen wrote:
> On 04/06/2016 06:11 AM, Alison Schofield wrote:
>> Replace the code that guarantees the device stays in direct mode with
>> iio_device_{claim|release}_direct_mode() which does same.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Applied to the togreg branch of iio.git - thanks.

Jonathan
>> ---
>> Changed in v2:
>>  - removed improper application of claim/release from intr handler
>>  - updated changelog
>>
>>  drivers/staging/iio/adc/ad7606_core.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
>> index 6dbc811..f79ee61 100644
>> --- a/drivers/staging/iio/adc/ad7606_core.c
>> +++ b/drivers/staging/iio/adc/ad7606_core.c
>> @@ -88,12 +88,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>>  
>>  	switch (m) {
>>  	case IIO_CHAN_INFO_RAW:
>> -		mutex_lock(&indio_dev->mlock);
>> -		if (iio_buffer_enabled(indio_dev))
>> -			ret = -EBUSY;
>> -		else
>> -			ret = ad7606_scan_direct(indio_dev, chan->address);
>> -		mutex_unlock(&indio_dev->mlock);
>> +		ret = iio_device_claim_direct_mode(indio_dev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = ad7606_scan_direct(indio_dev, chan->address);
>> +		iio_device_release_direct_mode(indio_dev);
>>  
>>  		if (ret < 0)
>>  			return ret;
>>
> 

