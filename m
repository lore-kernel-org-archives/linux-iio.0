Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58959 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbcGXMFt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 08:05:49 -0400
Subject: Re: [PATCH 1/3] iio: accel: bma220_spi: set up buffer timestamps for
 non-zero values
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1468203399.git.amsfield22@gmail.com>
 <6097ec724dae1e1fc5a9838b840ba9710a494a6d.1468203399.git.amsfield22@gmail.com>
 <4586F61A4A291F4DA44D32824E7C0F40235BAB3C@IRSMSX109.ger.corp.intel.com>
Cc: "mranostay@gmail.com" <mranostay@gmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0d6a950b-7794-1413-a74b-b73026a006f2@kernel.org>
Date: Sun, 24 Jul 2016 13:05:47 +0100
MIME-Version: 1.0
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F40235BAB3C@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/16 16:53, Breana, Tiberiu A wrote:
>> -----Original Message-----
>> From: Alison Schofield [mailto:amsfield22@gmail.com]
>> Sent: Monday, July 11, 2016 6:25 PM
>> To: jic23@kernel.org
>> Cc: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; mranostay@gmail.com;
>> knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-
>> iio@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH 1/3] iio: accel: bma220_spi: set up buffer timestamps for non-
>> zero values
>>
>> Use the iio_pollfunc_store_time parameter during triggered buffer set-up to get
>> valid timestamps.	
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> 
> +1
> Reviewed-By: Tiberiu Breana <tiberiu.a.breana@intel.com>
> 
Applied to the fixes-togreg-post-rc1 branch of iio.git
(for my convenience) and marked for stable.

Jonathan
>> ---
>>  drivers/iio/accel/bma220_spi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
>> index 1098d10..5099f29 100644
>> --- a/drivers/iio/accel/bma220_spi.c
>> +++ b/drivers/iio/accel/bma220_spi.c
>> @@ -253,7 +253,7 @@ static int bma220_probe(struct spi_device *spi)
>>  	if (ret < 0)
>>  		return ret;
>>
>> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
>>  					 bma220_trigger_handler, NULL);
>>  	if (ret < 0) {
>>  		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
>> --
>> 2.1.4
> 

