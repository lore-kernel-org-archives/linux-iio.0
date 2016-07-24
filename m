Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58982 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbcGXMH5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 08:07:57 -0400
Subject: Re: [PATCH 2/3] iio: humidity: am2315: set up buffer timestamps for
 non-zero values
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1468203399.git.amsfield22@gmail.com>
 <b246c9e7acf284069789cce4228b8d0e1733bbc8.1468203399.git.amsfield22@gmail.com>
 <4586F61A4A291F4DA44D32824E7C0F40235BAB4C@IRSMSX109.ger.corp.intel.com>
Cc: "mranostay@gmail.com" <mranostay@gmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <78950a64-3471-df78-d4e2-1e07c8f4bc07@kernel.org>
Date: Sun, 24 Jul 2016 13:07:55 +0100
MIME-Version: 1.0
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F40235BAB4C@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/16 16:54, Breana, Tiberiu A wrote:
>> -----Original Message-----
>> From: Alison Schofield [mailto:amsfield22@gmail.com]
>> Sent: Monday, July 11, 2016 6:26 PM
>> To: jic23@kernel.org
>> Cc: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; mranostay@gmail.com;
>> knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-
>> iio@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH 2/3] iio: humidity: am2315: set up buffer timestamps for non-
>> zero values
>>
>> Use the iio_pollfunc_store_time parameter during triggered buffer set-up to get
>> valid timestamps.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> ---
> 
> +1
> Reviewed-By: Tiberiu Breana <tiberiu.a.breana@intel.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git and marked for stable.

Thanks,
Jonathan
> 
>>  drivers/iio/humidity/am2315.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
>> index 3e200f6..ff96b6d 100644
>> --- a/drivers/iio/humidity/am2315.c
>> +++ b/drivers/iio/humidity/am2315.c
>> @@ -244,7 +244,7 @@ static int am2315_probe(struct i2c_client *client,
>>  	indio_dev->channels = am2315_channels;
>>  	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
>>
>> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
>>  					 am2315_trigger_handler, NULL);
>>  	if (ret < 0) {
>>  		dev_err(&client->dev, "iio triggered buffer setup failed\n");
>> --
>> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

