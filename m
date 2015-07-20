Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57329 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbbGTRsg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2015 13:48:36 -0400
Message-ID: <55AD3471.3030606@kernel.org>
Date: Mon, 20 Jul 2015 18:48:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: Re: [PATCH 0/8] bmc150_magn fix and cleanup
References: <cover.1437090791.git.knaack.h@gmx.de> <1F3AC3675D538145B1661F571FE1805F2F06BB5B@irsmsx105.ger.corp.intel.com>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F06BB5B@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/15 18:30, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
>> Sent: 17 July, 2015 11:52
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; Dogaru, Vlad
>> Subject: [PATCH 0/8] bmc150_magn fix and cleanup
>>
>> Some issues I spotted during review of this driver. First three are quite
>> obvious problems, the rest may be matter of taste or intended to stay
>> in the original form. Opinions welcome.
>>
> 
> Hi Hartmut,
> 
> Thanks for taking the time to cleanup these issues. I know you did not get
> to review this code before merge, so I was expecting your feedback :)
> 
> I see Jonathan has already merged some of the changes, so I'm just going
> to reply to the rest.
> I am fine with the first 4 changes which already got merged anyway.
Feel free to offer comments on the rest as well.  I was on a bit of a roll
and not giving sufficient time to others to review these.  The
'obviously' correct are not always so obvious given patch 5!

Sorry about that

Jonathan
> 
> Thanks,
> Irina
> 
>> Hartmut Knaack (8):
>>   iio:magnetometer:bmc150_magn: add regmap dependency
>>   iio:magnetometer:bmc150_magn: sort entry alphabetically
>>   iio:magnetometer:bmc150_magn: output intended variable
>>   iio:magnetometer:bmc150_magn: replace magic value
>>   iio:magnetometer:bmc150_magn: add error handling on gpio probe
>>   iio:magnetometer:bmc150_magn: protect runtime_resume with mutex
>>   iio:magnetometer:bmc150_magn: expand mutex in trigger_handler
>>   iio:magnetometer:bmc150_magn: use descriptive name for mask
>>
>>  drivers/iio/magnetometer/Kconfig       | 32 ++++++++++++++++++--------------
>>  drivers/iio/magnetometer/Makefile      |  3 +--
>>  drivers/iio/magnetometer/bmc150_magn.c | 31 ++++++++++++++++++++++---------
>>  3 files changed, 41 insertions(+), 25 deletions(-)
>>
>> --
>> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

