Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60780 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbcDRTpC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 15:45:02 -0400
Subject: Re: [PATCH 1/2] iio: magn: Split bmc150 driver in common/i2c parts
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	"Baluta, Daniel" <daniel.baluta@intel.com>
References: <1460729590-18886-1-git-send-email-daniel.baluta@intel.com>
 <1460729590-18886-2-git-send-email-daniel.baluta@intel.com>
 <57135F32.3030202@kernel.org>
 <1F3AC3675D538145B1661F571FE1805F2F260CC5@irsmsx105.ger.corp.intel.com>
Cc: "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>,
	"Purdila, Octavian" <octavian.purdila@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5715393B.4080401@kernel.org>
Date: Mon, 18 Apr 2016 20:44:59 +0100
MIME-Version: 1.0
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F260CC5@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/04/16 12:24, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: 17 April, 2016 13:02
>> To: Baluta, Daniel; Tirdea, Irina
>> Cc: knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; geert@linux-m68k.org; Dogaru, Vlad; Purdila, Octavian; linux-
>> kernel@vger.kernel.org; linux-iio@vger.kernel.org
>> Subject: Re: [PATCH 1/2] iio: magn: Split bmc150 driver in common/i2c parts
>>
>> On 15/04/16 15:13, Daniel Baluta wrote:
>>> This is useful for easily adding SPI support in later patches.
>>>
>>> Now bmc150_magn exports core functions to be used by I2C/SPI drivers
>>> instances. For the moment only I2C driver is supported.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>
>> This looks good to me - all mechanistic stuff so I doubt anything nasty
>> has snuck in. Ideally I'd like an Ack from Irina on this but it'll probably
>> be in my testing tree for a few days so I can add one if it comes in.
>>
> 
> Looks good to me.
> 
> Acked-by: Irina Tirdea <irina.tirdea@intel.com>
Thanks,

Added the Ack.

Jonathan
> 
>> Applied to the togreg branch of iio.git - pushed out as testing for the
>> autobuilders to mess with it.
>>
>> Thanks,
>>
>> Jonathan
> 

