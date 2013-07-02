Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47133 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3GBPpH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 11:45:07 -0400
Message-ID: <51D2F580.5070205@free-electrons.com>
Date: Tue, 02 Jul 2013 17:45:04 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hector Palacios <hector.palacios@digi.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Marek Vasut <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: Accessing specific hardware features of mxs-lradc
References: <51D2B057.9090005@digi.com> <51D2CE6A.7040103@metafoo.de> <51D2D591.4040101@free-electrons.com> <51D2E9EF.50303@digi.com> <51D2EFDD.9000403@metafoo.de>
In-Reply-To: <51D2EFDD.9000403@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/07/2013 17:21, Lars-Peter Clausen wrote:
>>>
>>> I was looking at that yesterday as I had to had a scale for the
>>> temperature sensors. You'll have to be careful because the maximum
>>> measured voltage when DIVIDE_BY_TWO is not set is 1.85V and when it is
>>> set, it becomes VDDIO - 50mv.
> 
> I had a quick peak at the datasheet and I think that's a typo. VDDIO is 3.3V.
> This sentence also doesn't make much sense if divide by two would actually
> lower the range. "For input channels (other than BATT, 5V, or VDDIO) with
> signals larger than 1.85 V, the divide-by-two option should be set."
> 

Yeah, what I think they meant is if !DIVIDE_BY_TWO : Vmax = 1.85V else
Vmax = 3.25V. So it may not be as easy as multiplying hte scale by two.
I couldn't test it, so I didn't implement it.

>>>
>>> Also, scaling for quite a lot of channels is fixed. You'll also get
>>> channels with a fixed divider that can take DIVIDE_BY_TWO. That is quite
>>> a mess ;)
>>
>> Thank you, I checked and it's easy to add custom sysfs attributes using
>> IIO_DEVICE_ATTR(). I was thinking whether adding a divide_by_two attribute per
>> channel:
>>
>>     divide_by_two0
>>     divide_by_two1
>>     ...
>>     divide_by_two7
>>
>> or a unique divide_by_two descriptor that admits a mask value for all channels.
>> I think the first approach (one per channel) is cleaner. Opinions?
> 
> Just use the scale attribute for this. That's the standard way to handle this,
> don't invent custom interfaces if there is already a generic one.
> 

Hector, you can have a look at what I did there:

http://marc.info/?l=linux-iio&m=137269905605960&w=2

Add IIO_CHAN_INFO_SCALE to .info_mask_separate in the MXS_ADC_CHAN
macro. Then, implement the scaling in the switch case in
mxs_lradc_read_raw and you'll probably also want to implement a write_raw.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
