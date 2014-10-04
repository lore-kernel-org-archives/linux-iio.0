Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57428 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaJDKaf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 06:30:35 -0400
Message-ID: <542FCC46.1050700@kernel.org>
Date: Sat, 04 Oct 2014 11:30:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Vlad Dogaru <vlad.dogaru@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add bmp280 pressure and temperature driver
References: <1412278823-10870-1-git-send-email-vlad.dogaru@intel.com> <alpine.DEB.2.01.1410022146100.8592@pmeerw.net> <20141003101619.GA17511@vdogaru> <alpine.DEB.2.01.1410031641190.17977@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1410031641190.17977@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 15:44, Peter Meerwald wrote:
> 
>>>> +static int bmp280_read_raw(struct iio_dev *indio_dev,
>>>> +			   struct iio_chan_spec const *chan,
>>>> +			   int *val, int *val2, long mask)
>>>> +{
>>>> +	int ret;
>>>> +	struct bmp280_data *data = iio_priv(indio_dev);
>>>> +
>>>> +	mutex_lock(&data->lock);
>>>
>>> locking is only needed for _RAW
>>>
>>>> +
>>>> +	switch (mask) {
>>>> +	case IIO_CHAN_INFO_RAW:
>>>
>>> I think this should be _PROCESSED, not _RAW;
>>> there is calibration and all kind of scaling done internally
>>
>> Just to make sure here:  If I use _PROCESSED, I need to apply scale in
>> kernel space and remove _SCALE, correct?
> 
> yes
> 
> since pressure is using a temperature read and calibration data, it hardly 
> qualifies as 'raw'
I'd typically be happy with this if there was a significant advantage in
leaving the application of the final scale to userspace.  This would either
be in terms of time, accuracy or simplicity (as floating point math would
be available in userspace).  Hence the channel doesn't have to be completely
'raw'.  Having said that, looks like here it makes sense to just do the *10 in
kernel space ;)
> 
>> I will address the rest of your observations in v2, once I get a chance
>> to test using the device on Monday.
>>
>> Thank you for the review.
> 
> p.
> 
