Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:56638 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbFGQdi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 12:33:38 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] iio: adc: twl4030_madc: Fix calculation of the temperature sense current
From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5574707F.6000109@kernel.org>
Date: Sun, 7 Jun 2015 18:33:28 +0200
Cc: Marek Belisko <marek@goldelico.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <206BDE24-37FF-496B-861E-5356132EDB4C@goldelico.com>
References: <1432842619-7251-1-git-send-email-marek@goldelico.com> <5574707F.6000109@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Am 07.06.2015 um 18:25 schrieb Jonathan Cameron <jic23@kernel.org>:

> On 28/05/15 20:50, Marek Belisko wrote:
>> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>> 
>> The bit mask to read the setting of the constant current source
>> for measuring the NTC voltage was the wrong one. Since default
>> value is initialized to the lowest level (000 = 10uA) the difference
>> was probably never noticed in practice.
> I'm going to take that literally and apply it via the slow route on
> the basis that a bug no one noticed doesn’t need fixing fast!

Yes, that is fine.

>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan

Thanks,
Nikolaus

>> ---
>> drivers/iio/adc/twl4030-madc.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
>> index 94c5f05..6d2d429 100644
>> --- a/drivers/iio/adc/twl4030-madc.c
>> +++ b/drivers/iio/adc/twl4030-madc.c
>> @@ -235,7 +235,7 @@ static int twl4030battery_temperature(int raw_volt)
>> 	if (ret < 0)
>> 		return ret;
>> 
>> -	curr = ((val & TWL4030_BCI_ITHEN) + 1) * 10;
>> +	curr = ((val & TWL4030_BCI_ITHSENS) + 1) * 10;
>> 	/* Getting and calculating the thermistor resistance in ohms */
>> 	res = volt * 1000 / curr;
>> 	/* calculating temperature */
>> 
> 

