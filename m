Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E2EB64DA
	for <linux-iio@archiver.kernel.org>; Mon, 19 Jun 2023 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFSUCo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjFSUCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jun 2023 16:02:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24472E6F
        for <linux-iio@vger.kernel.org>; Mon, 19 Jun 2023 13:02:40 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id BL5BqWzxKmdEOBL5BqHfBw; Mon, 19 Jun 2023 22:02:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687204958;
        bh=PzDgVMn+LmcGBIIXFua1hVukKNuDSYIsbjDAaxt9dhc=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=I1k8bpOtDwz716MkF0tblqY0cSymhT3qR5dKWd7cinRXpYRRPcqfp36B9KTjr6D/1
         BsLjLlsUV2oys7LQlAV2Y1BAU1faBNdMqhZGL6PJqMwYNE2fmzJeXCbI3p0pvMxKGq
         +dK138ZhXz1p/JNiVbSQbksEprTvHs9nsxjZLDI5x9dkNmPxKjgiDnsTLvndINYTB1
         44B7a03/cgr8GqwH1vV4pYZQRARwIGPNHdgwHYridTpU2vnTzhIDWW4uXiAijjlZJ3
         QlfoL35dHUta1HDhVmAEhUpyuCcLTawePoZIE7v9936SAvd3ICSFtnCzHBOruUqDmu
         93gAWjf5fH90A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Jun 2023 22:02:38 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1d367f33-3ed2-63d0-093a-7d1f561cca10@wanadoo.fr>
Date:   Mon, 19 Jun 2023 22:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 2/2] iio: st_sensors: Remove some redundant includes in
 st_sensors.h
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
References: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
 <bd7fa0b07c85172ecba384e239cb0ecf0780766a.1686600780.git.christophe.jaillet@wanadoo.fr>
 <20230617194911.7963bd6d@jic23-huawei>
X-Mozilla-News-Host: news://news.gmane.io
Content-Language: fr, en-US
In-Reply-To: <20230617194911.7963bd6d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 17/06/2023 à 20:49, Jonathan Cameron a écrit :
> On Mon, 12 Jun 2023 22:13:37 +0200
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>> There is no need to include i2c.h and spi/spi.h in st_sensors.h.
>> Should it be needed, st_sensors_(i2c|spi).h should be used.
> Agreed these should be dropped from here.
> 
> But I don't agree with statement that i2c.h and spi/spi.h should
> be gotten implicitly from st_sensors_i2c.h / st_sensors_spi.h
> If they are needed the should be included directly in the files
> where they are needed.
> 
> Jonathan

Another option I thought about was to:
    - keep the includes in st_sensors.h

    - move function declaration in st_sensors.h
int st_sensors_spi_configure(struct iio_dev *indio_dev,
			     struct spi_device *spi);
and
int st_sensors_i2c_configure(struct iio_dev *indio_dev,
			     struct i2c_client *client);

    - remove st_sensors_spi.h and st_sensors_i2c.h

At least, it would simplify things a remove 2 mostly useless .h file.

It would not give the benefit of removing some include for files that do 
not require spi.h or i2c.h, but as these includes are already there, it 
wouldn't make things worst :)

What do you think of this approach?

CJ

> 
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Based on one of my script, this reduces the number of included files from
>> 573 files to 515 files when compiling drivers/iio/accel/st_accel_buffer.c
>> ---
>>   include/linux/iio/common/st_sensors.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
>> index 607c3a89a647..a1d3d57d6d6e 100644
>> --- a/include/linux/iio/common/st_sensors.h
>> +++ b/include/linux/iio/common/st_sensors.h
>> @@ -10,8 +10,6 @@
>>   #ifndef ST_SENSORS_H
>>   #define ST_SENSORS_H
>>   
>> -#include <linux/i2c.h>
>> -#include <linux/spi/spi.h>
>>   #include <linux/irqreturn.h>
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/trigger.h>
> 
> 

