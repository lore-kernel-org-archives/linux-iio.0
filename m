Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36012 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbcLVBC0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2016 20:02:26 -0500
Received: by mail-oi0-f66.google.com with SMTP id u15so30530508oie.3
        for <linux-iio@vger.kernel.org>; Wed, 21 Dec 2016 17:02:24 -0800 (PST)
Subject: Re: [PATCH] indention and space fixes to align with linux style
To: Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
References: <1482289187-7276-1-git-send-email-scott@matheina.com>
 <1482290625.1984.33.camel@perches.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Scott Matheina <scott@matheina.com>
Message-ID: <518f5c19-26f3-9896-64c8-ec2a2b592c5c@matheina.com>
Date: Wed, 21 Dec 2016 19:02:22 -0600
MIME-Version: 1.0
In-Reply-To: <1482290625.1984.33.camel@perches.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12/20/2016 09:23 PM, Joe Perches wrote:
> On Tue, 2016-12-20 at 20:58 -0600, Scott Matheina wrote:
>> Fixed indention and space issues to align the code with the linux style guide.
> []
>> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> []
>> @@ -176,16 +176,16 @@
>>    */
>>
>>   struct adt7316_chip_info {
>> -	struct adt7316_bus	bus;
>> -	u16			ldac_pin;
>> -	u16			int_mask;	/* 0x2f */
>> -	u8			config1;
>> -	u8			config2;
>> -	u8			config3;
>> -	u8			dac_config;	/* DAC config */
>> -	u8			ldac_config;	/* LDAC config */
>> -	u8			dac_bits;	/* 8, 10, 12 */
>> -	u8			id;		/* chip id */
>> +	struct adt7316_bus bus;
>> +	u16 ldac_pin;
>> +	u16 int_mask;		/* 0x2f */
>> +	u8 config1;
>> +	u8 config2;
>> +	u8 config3;
>> +	u8 dac_config;		/* DAC config */
>> +	u8 ldac_config;		/* LDAC config */
>> +	u8 dac_bits;		/* 8, 10, 12 */
>> +	u8 id;			/* chip id */
>>   };
> Hello Scott.
>
> I believe you're relatively new at this
> patch submission stuff.
>
> The style above is fine and doesn't need
> to be changed.  It is not in CodingStyle
> as preferred one way or the other.
>
>>   /*
>> @@ -212,13 +212,12 @@ struct adt7316_chip_info {
>>    */
>>
>>   struct adt7316_limit_regs {
>> -	u16	data_high;
>> -	u16	data_low;
>> +	u16 data_high;
>> +	u16 data_low;
>>   };
>>
>>   static ssize_t adt7316_show_enabled(struct device *dev,
>> -		struct device_attribute *attr,
>> -		char *buf)
>> +				    struct device_attribute *attr, char *buf)
> This one isn't either but it is a very common
> style in net/, drivers/net, and drivers/staging
> though.
>
The problem I'm running into is when I use Lindent, it automatically 
makes the
change above, so I can't use that tool for the file. Even when I correct 
the changes
in the file git diff still shows the non-change, so I'm just trying to 
figure out how
to use the given tools without having these issues. I'm going to just go 
manual with
my future changes is suppose.

