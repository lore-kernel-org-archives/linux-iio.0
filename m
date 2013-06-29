Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44259 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3F2PNL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 11:13:11 -0400
Message-ID: <51CEF97F.4050209@kernel.org>
Date: Sat, 29 Jun 2013 16:13:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: add DAC 500kohm_to_gnd to possible powerdown_modes
References: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net> <1372023020-18742-3-git-send-email-pmeerw@pmeerw.net> <51CED1BF.8070200@kernel.org> <51CEE1E3.6090006@metafoo.de>
In-Reply-To: <51CEE1E3.6090006@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/29/2013 02:32 PM, Lars-Peter Clausen wrote:
> On 06/29/2013 02:23 PM, Jonathan Cameron wrote:
>> On 06/23/2013 10:30 PM, Peter Meerwald wrote:
>>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> applied to the togreg branch of iio.git
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 2e33dc6..0af1af0 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -351,6 +351,7 @@ Description:
>>>  		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
>>>  		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
>>>  		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
>>> +		500kohm_to_gnd: connected to ground via an 100kOhm resistor,
> 
> I missed this earlier, there's a typo here, it should obviously be 'via an
> 500kOhm resistor'
> 
doh, I'll fix that and force a push to the tree.
