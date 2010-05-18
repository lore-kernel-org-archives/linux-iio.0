Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:57750 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab0EROYg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2010 10:24:36 -0400
Message-ID: <4BF2A345.1070506@cam.ac.uk>
Date: Tue, 18 May 2010 15:25:09 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 1/3] staging:iio:max1363 use device_id instead of searching
 on name again
References: <1274132150-29256-1-git-send-email-jic23@cam.ac.uk> <1274132150-29256-2-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712E568FC4C2@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E568FC4C2@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/18/10 14:43, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2010-05-17:
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/adc/max1363.h      |    3 +-
>>  drivers/staging/iio/adc/max1363_core.c |  152
>> +++++++++++++++---------
>> --------
>>  2 files changed, 75 insertions(+), 80 deletions(-)
>> diff --git a/drivers/staging/iio/adc/max1363.h
>> b/drivers/staging/iio/adc/max1363.h index 72cf367..eb20c68 100644 ---
>> a/drivers/staging/iio/adc/max1363.h +++
>> b/drivers/staging/iio/adc/max1363.h @@ -179,7 +179,6 @@ enum
> 
> --[snip]--
> 
>> +     st->chip_info = &max1363_chip_info_tbl[id->driver_data];
>> +     st->name = kstrdup(id->name, GFP_KERNEL);
>> +     if (st->name == NULL) {
>> +             ret = -ENOMEM;
> 
> 
> Isn't id->name == client->name ?
> 
> static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
>                                                 const struct i2c_client *client)
> {
>         while (id->name[0]) {
>                 if (strcmp(client->name, id->name) == 0)
>                         return id;
>                 id++;
>         }
>         return NULL;
> }
> 
> So you don't need an extra copy simply use client->name
> 
Another excellent point.  Thanks!

Will redo this one later.

Jonathan

