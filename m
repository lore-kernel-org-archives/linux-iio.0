Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailcl0.heig-vd.ch ([193.134.216.181]:36039 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751198AbcFVGW5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 22 Jun 2016 02:22:57 -0400
Subject: Re: [PATCH 3/3] iio: potentiometer: mcp4531: Add device tree binding
To: Peter Rosin <peda@axentia.se>, <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-4-git-send-email-florian.vaussard@heig-vd.ch>
 <bf4dbd64-aac8-aba3-ec5c-4cd4d0e848f6@axentia.se>
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
Message-ID: <829a4507-39d7-e04a-9672-6309def89ee2@heig-vd.ch>
Date: Wed, 22 Jun 2016 08:22:46 +0200
MIME-Version: 1.0
In-Reply-To: <bf4dbd64-aac8-aba3-ec5c-4cd4d0e848f6@axentia.se>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Peter,

Le 21. 06. 16 à 09:51, Peter Rosin a écrit :
> On 2016-06-21 08:55, Florian Vaussard wrote:
>> This patch adds the necessary device tree binding to allow DT probing of
>> currently supported parts.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
>> ---
>>  drivers/iio/potentiometer/mcp4531.c | 83 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 82 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
>> index 2251173..41a1e46 100644
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
>> @@ -188,12 +190,84 @@ static const struct iio_info mcp4531_info = {
>>  	.driver_module = THIS_MODULE,
>>  };
>>  
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id mcp45xx_of_match[] = {
> 
> Should be named mcp4531_of_match, also the casting to void and
> then back to an integer type is ugly. Would it work to store a
> pointer directly into the mcp4531_cfg array instead? I.e.
> 
> 	{ .compatible = "microchip,mcp4531-502", .data = &mcp4531_cfg[MCP453x_502] },
> etc
> 
> and then adjust accordingly in mcp4531_probe()?
> 

Yes the casting is pretty ugly. And kbuild agrees with you :) I took this from
another driver (lame excuse). Your suggestion is sensible, I will give it a try.

> That is, if you need this patch at all, see my reply to 2/3...
> 

This seems necessary in order to have the vendor ID in the compatible string.

Thanks for your review.

Florian
