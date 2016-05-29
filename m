Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33466 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbcE2QXk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 12:23:40 -0400
Subject: Re: [PATCH 1/1] iio: light: Added CM36672 Proximity Sensor Driver.
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Kevin Tsai <capellamicro@gmail.com>
References: <1464482526-862-1-git-send-email-capellamicro@gmail.com>
 <alpine.DEB.2.02.1605291021570.25960@pmeerw.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <68f15180-cba4-8afe-1237-be47ae3a7955@kernel.org>
Date: Sun, 29 May 2016 17:23:37 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1605291021570.25960@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/05/16 09:55, Peter Meerwald-Stadler wrote:
> On Sat, 28 May 2016, Kevin Tsai wrote:
> 
>> Added Vishay Capella CM36672 Proximity Sensor IIO driver.  Support both
>> ACPI and Device Tree.
> 
> comments below
>  
>> Signed-off-by: Kevin Tsai <capellamicro@gmail.com>
>> ---
<snip>
>> +#ifdef CONFIG_ACPI
>> +/**
>> + * cm36672_acpi_get_cpm_info() - Get CPM object from ACPI
>> + * @client:	pointer of struct i2c_client.
>> + * @obj_name:	pointer of ACPI object name.
>> + * @count:	maximum size of return array.
>> + * @vals:	pointer of array for return elements.
>> + *
>> + * Convert ACPI CPM table to array. Special thanks Srinivas Pandruvada's
> 
> thanks for
thanks to (if we are getting picky ;)
> 
>> + * help to implement this routine.
>> + *
>> + * Return: -ENODEV for fail. Otherwise is number of elements.
> 
> Otherwise the number of elements
> 
