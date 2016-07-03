Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57049 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcGCJZ1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 05:25:27 -0400
Subject: Re: [PATCH v2 3/4] iio: potentiometer: mcp4531: Add device tree
 binding
To: Florian Vaussard <florian.vaussard@heig-vd.ch>,
	Peter Rosin <peda@axentia.se>,
	Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466972567-9580-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466972567-9580-4-git-send-email-florian.vaussard@heig-vd.ch>
 <68f532da-766d-d1f6-5528-f69b80fb41b6@axentia.se>
 <f05299bb-6404-fb3a-badc-4668a6600e08@heig-vd.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8d501966-d2f3-7b0b-2d70-3f0a60802d99@kernel.org>
Date: Sun, 3 Jul 2016 10:25:23 +0100
MIME-Version: 1.0
In-Reply-To: <f05299bb-6404-fb3a-badc-4668a6600e08@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 06:30, Florian Vaussard wrote:
> Hi Peter,
> 
> Le 27. 06. 16 à 00:12, Peter Rosin a écrit :
>> Hi Florian,
>>
>> On 2016-06-26 22:22, Florian Vaussard wrote:
>>> This patch adds the necessary device tree binding to allow DT probing of
>>> currently supported parts.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
>>> ---
>>>  drivers/iio/potentiometer/mcp4531.c | 273 +++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 272 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
>>> index 2251173..bf7b853 100644
>>> --- a/drivers/iio/potentiometer/mcp4531.c
>>> +++ b/drivers/iio/potentiometer/mcp4531.c
>>> @@ -31,6 +31,8 @@
>>>  #include <linux/module.h>
>>>  #include <linux/i2c.h>
>>>  #include <linux/err.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>>  
>>>  #include <linux/iio/iio.h>
>>>  
>>> @@ -188,12 +190,275 @@ static const struct iio_info mcp4531_info = {
>>>  	.driver_module = THIS_MODULE,
>>>  };
>>>  
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id mcp4531_of_match[] = {
>>> +	{
>>> +		.compatible = "microchip,mcp4531-502",
>>> +		.data = &mcp4531_cfg[MCP453x_502]
>>> +	},
>>
>> All this vertical whitespace makes this unreadable. I'd be
>> happier with either ignoring the 80 char rule, or skipping
>> the leading tab. I.e.
>>
>> 	{ .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
>> 	{ .compatible = "microchip,mcp4531-103", .data = &mcp4531_cfg[MCP453x_103] },
>> 	{ .compatible = "microchip,mcp4531-503", .data = &mcp4531_cfg[MCP453x_503] },
>> 	...
>>
>> or
>>
>> { .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
>> { .compatible = "microchip,mcp4531-103", .data = &mcp4531_cfg[MCP453x_103] },
>> { .compatible = "microchip,mcp4531-503", .data = &mcp4531_cfg[MCP453x_503] },
>> ...
>>
>> Or perhaps using a macro?
>>
>> #define MCP4531_COMPATIBLE(of_compatible, cfg) {	\
>> 		.compatible = of_compatible,		\
>> 		.data = &mcp4531_cfg[cfg],		\
>> }
>>
>> and then
>>
>> 	MCP4531_COMPATIBLE("microchip,mcp4531-502", MCP453x_502),
>> 	MCP4531_COMPATIBLE("microchip,mcp4531-103", MCP453x_103),
>> 	MCP4531_COMPATIBLE("microchip,mcp4531-503", MCP453x_503),
>> 	...
>>
>> Pick any of those, and you have my ack. Maybe Jonathan has an opinion
>> on which is best?
>>
> 
> The macro is my preferred one, as it makes things easier to read. Jonathan?
I'm fine with any of the options (or indeed the original line break heavy
approach). Take your pick!

Jonathan
> 
> Thanks for the suggestion!
> 
> Best,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

