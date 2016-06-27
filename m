Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailcl0.heig-vd.ch ([193.134.216.181]:58264 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751728AbcF0FwH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jun 2016 01:52:07 -0400
Subject: Re: [PATCH v2 3/4] iio: potentiometer: mcp4531: Add device tree
 binding
To: Peter Rosin <peda@axentia.se>,
	Florian Vaussard <florian.vaussard@gmail.com>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466972567-9580-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466972567-9580-4-git-send-email-florian.vaussard@heig-vd.ch>
 <68f532da-766d-d1f6-5528-f69b80fb41b6@axentia.se>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Vaussard Florian <florian.vaussard@heig-vd.ch>
From: Florian Vaussard <florian.vaussard@heig-vd.ch>
Message-ID: <f05299bb-6404-fb3a-badc-4668a6600e08@heig-vd.ch>
Date: Mon, 27 Jun 2016 07:30:30 +0200
MIME-Version: 1.0
In-Reply-To: <68f532da-766d-d1f6-5528-f69b80fb41b6@axentia.se>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

Le 27. 06. 16 à 00:12, Peter Rosin a écrit :
> Hi Florian,
> 
> On 2016-06-26 22:22, Florian Vaussard wrote:
>> This patch adds the necessary device tree binding to allow DT probing of
>> currently supported parts.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
>> ---
>>  drivers/iio/potentiometer/mcp4531.c | 273 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 272 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
>> index 2251173..bf7b853 100644
>> --- a/drivers/iio/potentiometer/mcp4531.c
>> +++ b/drivers/iio/potentiometer/mcp4531.c
>> @@ -31,6 +31,8 @@
>>  #include <linux/module.h>
>>  #include <linux/i2c.h>
>>  #include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>>  
>>  #include <linux/iio/iio.h>
>>  
>> @@ -188,12 +190,275 @@ static const struct iio_info mcp4531_info = {
>>  	.driver_module = THIS_MODULE,
>>  };
>>  
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id mcp4531_of_match[] = {
>> +	{
>> +		.compatible = "microchip,mcp4531-502",
>> +		.data = &mcp4531_cfg[MCP453x_502]
>> +	},
> 
> All this vertical whitespace makes this unreadable. I'd be
> happier with either ignoring the 80 char rule, or skipping
> the leading tab. I.e.
> 
> 	{ .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
> 	{ .compatible = "microchip,mcp4531-103", .data = &mcp4531_cfg[MCP453x_103] },
> 	{ .compatible = "microchip,mcp4531-503", .data = &mcp4531_cfg[MCP453x_503] },
> 	...
> 
> or
> 
> { .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
> { .compatible = "microchip,mcp4531-103", .data = &mcp4531_cfg[MCP453x_103] },
> { .compatible = "microchip,mcp4531-503", .data = &mcp4531_cfg[MCP453x_503] },
> ...
> 
> Or perhaps using a macro?
> 
> #define MCP4531_COMPATIBLE(of_compatible, cfg) {	\
> 		.compatible = of_compatible,		\
> 		.data = &mcp4531_cfg[cfg],		\
> }
> 
> and then
> 
> 	MCP4531_COMPATIBLE("microchip,mcp4531-502", MCP453x_502),
> 	MCP4531_COMPATIBLE("microchip,mcp4531-103", MCP453x_103),
> 	MCP4531_COMPATIBLE("microchip,mcp4531-503", MCP453x_503),
> 	...
> 
> Pick any of those, and you have my ack. Maybe Jonathan has an opinion
> on which is best?
> 

The macro is my preferred one, as it makes things easier to read. Jonathan?

Thanks for the suggestion!

Best,
Florian
