Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59123 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbJYMhq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 08:37:46 -0400
Subject: Re: [PATCH 2/2] iio: adc: mcp320x: Add compatible with vendor prefix
 to OF table
To: Michael Welling <mwelling@ieee.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>
References: <1444827279-23163-1-git-send-email-javier@osg.samsung.com>
 <1444827279-23163-3-git-send-email-javier@osg.samsung.com>
 <20151014152753.GB29846@deathstar>
Cc: linux-kernel@vger.kernel.org, Andrea Galbusera <gizero@gmail.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CCD19.5090004@kernel.org>
Date: Sun, 25 Oct 2015 12:37:45 +0000
MIME-Version: 1.0
In-Reply-To: <20151014152753.GB29846@deathstar>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/10/15 16:27, Michael Welling wrote:
> On Wed, Oct 14, 2015 at 02:54:39PM +0200, Javier Martinez Canillas wrote:
>> The driver Device Tree binding now documents compatible strings that have
>> a vendor prefix, so add these to the OF device ID table to match and mark
>> the old ones as deprecated explaining that should not be used anymore.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>>  drivers/iio/adc/mcp320x.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>> index 41a21e986c1a..9fcb8b61e300 100644
>> --- a/drivers/iio/adc/mcp320x.c
>> +++ b/drivers/iio/adc/mcp320x.c
>> @@ -354,6 +354,7 @@ static int mcp320x_remove(struct spi_device *spi)
>>  
>>  #if defined(CONFIG_OF)
>>  static const struct of_device_id mcp320x_dt_ids[] = {
>> +	/* NOTE: The use of compatibles with no vendor prefix is deprecated. */
>>  	{
>>  		.compatible = "mcp3001",
>>  		.data = &mcp320x_chip_infos[mcp3001],
>> @@ -382,6 +383,33 @@ static const struct of_device_id mcp320x_dt_ids[] = {
>>  		.compatible = "mcp3301",
>>  		.data = &mcp320x_chip_infos[mcp3301],
>>  	}, {
>> +		.compatible = "microchip,mcp3001",
>> +		.data = &mcp320x_chip_infos[mcp3001],
>> +	}, {
>> +		.compatible = "microchip,mcp3002",
>> +		.data = &mcp320x_chip_infos[mcp3002],
>> +	}, {
>> +		.compatible = "microchip,mcp3004",
>> +		.data = &mcp320x_chip_infos[mcp3004],
>> +	}, {
>> +		.compatible = "microchip,mcp3008",
>> +		.data = &mcp320x_chip_infos[mcp3008],
>> +	}, {
>> +		.compatible = "microchip,mcp3201",
>> +		.data = &mcp320x_chip_infos[mcp3201],
>> +	}, {
>> +		.compatible = "microchip,mcp3202",
>> +		.data = &mcp320x_chip_infos[mcp3202],
>> +	}, {
>> +		.compatible = "microchip,mcp3204",
>> +		.data = &mcp320x_chip_infos[mcp3204],
>> +	}, {
>> +		.compatible = "microchip,mcp3208",
>> +		.data = &mcp320x_chip_infos[mcp3208],
>> +	}, {
>> +		.compatible = "microchip,mcp3301",
>> +		.data = &mcp320x_chip_infos[mcp3301],
>> +	}, {
> 
> Acked-by: Michael Welling <mwelling@ieee.org>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
>>  	}
>>  };
>>  MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
>> -- 
>> 2.4.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

