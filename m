Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49968 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbcKEMxD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 08:53:03 -0400
Subject: Re: regmap and i2c_smbus_write_byte question
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20161105113831.GA6053@basecamp.onstation.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6a764449-63a3-e7a3-8bd4-d20c436bed3f@kernel.org>
Date: Sat, 5 Nov 2016 12:53:02 +0000
MIME-Version: 1.0
In-Reply-To: <20161105113831.GA6053@basecamp.onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/11/16 11:38, Brian Masney wrote:
> I am investigating converting the tsl2583 staging driver over to use
> the regmap API. I ran into an issue converting the following call to
> i2c_smbus_write_byte() over to the regmap API:
> 
> struct tsl2583_chip {
>         struct i2c_client *client;
>         ...
> }
> 
> /*
>  * clear status, really interrupt status (interrupts are off), but
>  * we use the bit anyway - don't forget 0x80 - this is a command
>  */      
> ret = i2c_smbus_write_byte(chip->client,
>                            (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |
>                             TSL258X_CMD_ALS_INT_CLR));
> 
> I don't see a way to do this in the regmap API.  
> drivers/input/touchscreen/tsc2004.c has this same issue and that code
> directly calls i2c_smbus_write_byte() along with the regmap API. Am I
> missing something? This doesn't feel right to me to bypass the regmap
> API and directly access the i2c client.
> 
> The data sheet for the tsl2583 sensor is available here:
> http://media.digikey.com/PDF/Data%20Sheets/Austriamicrosystems%20PDFs/TSL2581,83.pdf
> Page 10 has the table that describes clearing the interrupt bit. The
> sensor will not take additional readings until that bit is cleared
> (even though interrupts are off).
Bit of a tangential question but why do a regmap conversion for this device?
It's i2c only so we don't gain from easy support for multiple bus types.
There aren't all that many registers and we don't have reason to
often read/write the ones that aren't volatile.

Hence I'd argue there is little point in doing a regmap conversion in
the first place.

If there is a good reason to do it then there isn't an easy way around
these 'odd' diversions from what is otherwise a nice register
based interface.

Hence another reason to not do a regmap conversion.

J

> 
> Thanks,
> 
> Brian
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

