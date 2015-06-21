Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43820 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbbFUNU5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:20:57 -0400
Message-ID: <5586BA37.5020905@kernel.org>
Date: Sun, 21 Jun 2015 14:20:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2 0/7] cm3323 fixes and cleanups
References: <cover.1434578207.git.knaack.h@gmx.de> <5586B9E9.90904@kernel.org>
In-Reply-To: <5586B9E9.90904@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/15 14:19, Jonathan Cameron wrote:
> On 17/06/15 23:31, Hartmut Knaack wrote:
>> Some small fixes and cleanups.
>>
>> Changes in V2:
>>   - apply the integration time bitmask right
>>   - fix order of GENMASK arguments as pointed out by Peter Meerwald
>>
>> Hartmut Knaack (7):
>>   iio:light:cm3323: clear bitmask before set
>>   iio:light:Kconfig: fix typo in description
>>   iio:light:cm3323: pass up error value
>>   iio:light:cm3323: drop barely used variable
>>   iio:light:cm3323: replace unneeded variable
>>   iio:light:cm3323: make use of GENMASK
>>   iio:light:cm3323: add empty lines for code structure
>>
>>  drivers/iio/light/Kconfig  |  2 +-
>>  drivers/iio/light/cm3323.c | 27 +++++++++++++++------------
>>  2 files changed, 16 insertions(+), 13 deletions(-)
>>
> This whole series looks good to me, but I'll let them sit
> for Daniel to have a look as it's his driver.
Or I could just check beyond patch 1 and see that he's already
reviewed them in V1. oops.
> 
> Path 1 is clearly a bug fix, but the others can go the slow
> route.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
