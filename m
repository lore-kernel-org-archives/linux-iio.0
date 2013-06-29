Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:41091 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751683Ab3F2N2v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 09:28:51 -0400
Message-ID: <51CEE1E3.6090006@metafoo.de>
Date: Sat, 29 Jun 2013 15:32:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: add DAC 500kohm_to_gnd to possible powerdown_modes
References: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net> <1372023020-18742-3-git-send-email-pmeerw@pmeerw.net> <51CED1BF.8070200@kernel.org>
In-Reply-To: <51CED1BF.8070200@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/29/2013 02:23 PM, Jonathan Cameron wrote:
> On 06/23/2013 10:30 PM, Peter Meerwald wrote:
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> applied to the togreg branch of iio.git
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 2e33dc6..0af1af0 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -351,6 +351,7 @@ Description:
>>  		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
>>  		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
>>  		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
>> +		500kohm_to_gnd: connected to ground via an 100kOhm resistor,

I missed this earlier, there's a typo here, it should obviously be 'via an
500kOhm resistor'
