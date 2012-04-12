Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:12098 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934170Ab2DLNUn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Apr 2012 09:20:43 -0400
Message-ID: <4F86D3ED.4020301@nvidia.com>
Date: Thu, 12 Apr 2012 18:39:01 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	"jbrenner@taosinc.com" <jbrenner@taosinc.com>,
	Rhyland Klein <rklein@nvidia.com>, "max@stro.at" <max@stro.at>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>
Subject: Re: [PATCH V3 1/2] staging: iio: add channel info for sampling frequency
References: <1334234288-25037-1-git-send-email-ldewangan@nvidia.com> <1334234288-25037-2-git-send-email-ldewangan@nvidia.com> <4F86D55F.2030808@cam.ac.uk>
In-Reply-To: <4F86D55F.2030808@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thursday 12 April 2012 06:45 PM, Jonathan Cameron wrote:
> On 4/12/2012 1:38 PM, Laxman Dewangan wrote:
>> Adding channel info IIO_CHAN_INFO_SAMP_FREQ to select
>> different sampling frequency per channel wise.
>>
>> Signed-off-by: Laxman Dewangan<ldewangan@nvidia.com>
>> ---
>> As per discussion on previous patch, adding channel info
>> for selecting sampling freqeuncy.
> To match with the existing devices can we not use the abrieviation
> for the attribute naming.
>

Sorry..I did not get it completely.
Is it like we should have IIO_CHAN_INFO_SAMPLING_FREQUENCY in place of  
IIO_CHAN_INFO_SAMP_FREQ?


>> @@ -90,6 +90,7 @@ static const char * const iio_chan_info_postfix[] = {
>>    	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
>>    	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
>>    	= "filter_low_pass_3db_frequency",
>> +	[IIO_CHAN_INFO_SAMP_FREQ] = "samp_freq",
> "sampling_frequency"

and then change here as "sampling_frequency"?



