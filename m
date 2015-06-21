Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43939 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbFUNhi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:37:38 -0400
Message-ID: <5586BE20.3010000@kernel.org>
Date: Sun, 21 Jun 2015 14:37:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ABI: Fix typo in in_proximity_raw description
References: <1434487003-7248-1-git-send-email-pmeerw@pmeerw.net> <CAEnQRZAwOBfLXuNG3qU8WbXrEfyhWAOvhZ6TxDLWnB_+4cEaBQ@mail.gmail.com>
In-Reply-To: <CAEnQRZAwOBfLXuNG3qU8WbXrEfyhWAOvhZ6TxDLWnB_+4cEaBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/15 21:57, Daniel Baluta wrote:
> On Tue, Jun 16, 2015 at 11:36 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> 
> Oh, didn't see that :)
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Now that's awkward.  The original patch is working its
way to stable, but this one definitely isn't worth sending
that way.  Ah well, remind me to pick it up if I look like
I've forgotten by the time the original change turns up in 
my togreg branch.

Thanks,

Jonathan
> 
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 3befcb1..7d909a4 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1162,7 +1162,7 @@ KernelVersion:    3.4
>>  Contact:       linux-iio@vger.kernel.org
>>  Description:
>>                 Proximity measurement indicating that some
>> -               object is near the sensor, usually be observing
>> +               object is near the sensor, usually by observing
>>                 reflectivity of infrared or ultrasound emitted.
>>                 Often these sensors are unit less and as such conversion
>>                 to SI units is not possible.  Where it is, the units should
>> --

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
