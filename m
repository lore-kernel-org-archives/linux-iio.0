Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35886 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753956AbcLUDly (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 22:41:54 -0500
Received: by mail-oi0-f68.google.com with SMTP id u15so26665828oie.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2016 19:41:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] indention and space fixes to align with linux style
From: Scott Matheina <scott@matheina.com>
In-Reply-To: <1482290625.1984.33.camel@perches.com>
Date: Tue, 20 Dec 2016 21:41:52 -0600
Cc: gregkh@linuxfoundation.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-Id: <6BFFEC3B-AFD4-4391-8C42-AD4864012F03@matheina.com>
References: <1482289187-7276-1-git-send-email-scott@matheina.com> <1482290625.1984.33.camel@perches.com>
To: Joe Perches <joe@perches.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> On Dec 20, 2016, at 9:23 PM, Joe Perches <joe@perches.com> wrote:
>=20
>> On Tue, 2016-12-20 at 20:58 -0600, Scott Matheina wrote:
>> Fixed indention and space issues to align the code with the linux style g=
uide.
> []
>> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/ad=
dac/adt7316.c
> []
>> @@ -176,16 +176,16 @@
>>  */
>>=20
>> struct adt7316_chip_info {
>> -    struct adt7316_bus    bus;
>> -    u16            ldac_pin;
>> -    u16            int_mask;    /* 0x2f */
>> -    u8            config1;
>> -    u8            config2;
>> -    u8            config3;
>> -    u8            dac_config;    /* DAC config */
>> -    u8            ldac_config;    /* LDAC config */
>> -    u8            dac_bits;    /* 8, 10, 12 */
>> -    u8            id;        /* chip id */
>> +    struct adt7316_bus bus;
>> +    u16 ldac_pin;
>> +    u16 int_mask;        /* 0x2f */
>> +    u8 config1;
>> +    u8 config2;
>> +    u8 config3;
>> +    u8 dac_config;        /* DAC config */
>> +    u8 ldac_config;        /* LDAC config */
>> +    u8 dac_bits;        /* 8, 10, 12 */
>> +    u8 id;            /* chip id */
>> };
>=20
> Hello Scott.
>=20
> I believe you're relatively new at this
> patch submission stuff.
>=20
> The style above is fine and doesn't need
> to be changed.  It is not in CodingStyle
> as preferred one way or the other.

I would say very very new just a couple submissions so any advice would be g=
reat, drivers/staging is, so I'm told a good place to make mistakes

>> /*
>> @@ -212,13 +212,12 @@ struct adt7316_chip_info {
>>  */
>>=20
>> struct adt7316_limit_regs {
>> -    u16    data_high;
>> -    u16    data_low;
>> +    u16 data_high;
>> +    u16 data_low;
>> };
>>=20
>> static ssize_t adt7316_show_enabled(struct device *dev,
>> -        struct device_attribute *attr,
>> -        char *buf)
>> +                    struct device_attribute *attr, char *buf)
>=20
> This one isn't either but it is a very common
> style in net/, drivers/net, and drivers/staging
> though.
>=20
