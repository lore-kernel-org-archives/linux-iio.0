Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38035 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbFMSVV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 14:21:21 -0400
Message-ID: <557C749E.2090005@kernel.org>
Date: Sat, 13 Jun 2015 19:21:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: pmeerw@pmeerw.net, tiberiu.a.breana@intel.com, knaack.h@gmx.de,
	lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] iio: proximity: sx9500: Fix proximity value
References: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com> <1434037774-22081-3-git-send-email-daniel.baluta@intel.com> <20150612074046.GB14044@vdogaru>
In-Reply-To: <20150612074046.GB14044@vdogaru>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/15 08:40, Vlad Dogaru wrote:
> On Thu, Jun 11, 2015 at 06:49:34PM +0300, Daniel Baluta wrote:
>> Because of the ABI confusion proximity value exposed by SX9500
>> was inverted.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> 
> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
> 
> Sorry for causing the confusion, it was the only proximity sensor I had
> encountered to date.
Greg,

I've cc'd you to let you know that this fix causes an ABI change for
one driver.  Technically that driver actually matched with the current documentation,
just the documentation was misleading and lots of drivers have ended up with
the reverse interpretation (question was whether proximity values get larger
or smaller as you get nearer). 

Anyhow, given timing I doubt the pull request will reach you until after the
merge window.  I am also going to mark this for stable to cover the 4.0 and 4.1
kernels that have this driver in them.

Hope that's fine!

Applied to the fixes-togreg branch of iio.git

Daniel, thanks for clearing this mess up and checking through all the drivers
and datasheets to figure out it was only this one!

Jonathan

> 
>> ---
>>  drivers/iio/proximity/sx9500.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
>> index 2042e37..01494cd 100644
>> --- a/drivers/iio/proximity/sx9500.c
>> +++ b/drivers/iio/proximity/sx9500.c
>> @@ -281,7 +281,7 @@ static int sx9500_read_prox_data(struct sx9500_data *data,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	*val = 32767 - (s16)be16_to_cpu(regval);
>> +	*val = be16_to_cpu(regval);
>>  
>>  	return IIO_VAL_INT;
>>  }
>> -- 
>> 1.9.1
>>

