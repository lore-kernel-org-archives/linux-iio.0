Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailcl1.heig-vd.ch ([193.134.216.182]:50203 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751625AbcFUHQ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jun 2016 03:16:58 -0400
Subject: Re: [PATCH 1/3] iio: potentiometer: mcp4531: Add support for MCP454x,
 MCP456x, MCP464x and MCP466x
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-2-git-send-email-florian.vaussard@heig-vd.ch>
 <alpine.DEB.2.02.1606210859150.20893@pmeerw.net>
CC: Florian Vaussard <florian.vaussard@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>
From: Florian Vaussard <florian.vaussard@heig-vd.ch>
Message-ID: <5768E894.7050309@heig-vd.ch>
Date: Tue, 21 Jun 2016 09:11:16 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1606210859150.20893@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On 06/21/2016 09:04 AM, Peter Meerwald-Stadler wrote:
> 
>> @@ -49,8 +49,10 @@ config MCP4531
>>  	depends on I2C
>>  	help
>>  	  Say yes here to build support for the Microchip
>> -	  MCP4531, MCP4532, MCP4551, MCP4552,
>> -	  MCP4631, MCP4632, MCP4651, MCP4652
>> +	  MCP4531, MCP4532, MCP4541, MCP4542,
>> +	  MCP4551, MCP4552, MCP4561, MCP4562,
>> +	  MCP4631, MCP4632, MCP4641, MCP4642,
>> +	  MCP4651, MCP4652, MCP4661, MCP4662
>>  	  digital potentiomenter chips.
> 
> unrelated typo: potentiometer
> could you please fix it up as a separate patch in you series?
> 

Sure, I will do this patch in v2.

> some whitespace around /*sentinel*/ in patch 3/3 would be nice, looks good 
> otherwise

I will wait for some more feedback and fix in v2.

Thanks for your review,
Florian
