Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo2.mail-out.ovh.net ([178.32.228.2]:39633 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbJ1UTa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2015 16:19:30 -0400
Received: from mail435.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 633D2FFC91F
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2015 21:19:29 +0100 (CET)
Mime-Version: 1.0
Date: Wed, 28 Oct 2015 20:19:07 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <ba63445a2f9af32bcbad698039041cbf@rainloop.corna.info>
From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [PATCH v4 4/4] iio: humidity: si7020: added No Hold read mode
To: "Lars-Peter Clausen" <lars@metafoo.de>,
	"Wolfram Sang" <wsa@the-dreams.de>,
	"Stephen Warren" <swarren@wwwdotorg.org>,
	"Lee Jones" <lee@kernel.org>, "Eric Anholt" <eric@anholt.net>,
	"Jonathan Cameron" <jic23@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"Hartmut Knaack" <knaack.h@gmx.de>,
	"Peter Meerwald" <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
In-Reply-To: <563117FB.5030506@metafoo.de>
References: <563117FB.5030506@metafoo.de> <5630977D.2020102@metafoo.de>
 <f113de76b2369d404909cfc5158feca4@rainloop.corna.info>
 <1446015506-21371-1-git-send-email-nicola@corna.info>
 <aa9c6c7ffdd5083c110cb35723081dbf@rainloop.corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

October 28 2015 7:46 PM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:

> On 10/28/2015 07:35 PM, Nicola Corna wrote:
> 
>> October 28 2015 10:38 AM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:
>> 
>>> On 10/28/2015 07:58 AM, Nicola Corna wrote:
>>> [...]
>>> 
>>>> + holdmode = !((*client)->adapter->quirks &&
>>>> + (*client)->adapter->quirks->flags &
>>> 
>>> [...]
>>> 
>>>> + client->adapter->quirks &&
>>>> + client->adapter->quirks->flags & I2C_AQ_NO_CLK_STRETCH)
>>> 
>>> This is rather ugly, can we get a helper in the I2C core something along the
>>> lines of
>>> 
>>> i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH)
>>> 
>>> - Lars
>> 
>> Something like this?
>> 
>> ---
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index a69a9a0..a06ffc0 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -613,6 +613,12 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
>> return (func & i2c_get_functionality(adap)) == func;
>> }
>> 
>> +/* Return 1 if adapter has the specified quirks, 0 if not. */
>> +static inline int i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
>> +{
>> + return (quirks & (adap->quirks ? adap->quirks->flags : 0)) == quirks;
>> +}
> 
> This is not a code obfuscation contest ;)

I love one-liners ;)

> So maybe more like this:
> 
> static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
> {
> if (!adap->quirks)
> return false;
> return (adap->quirks->flags & quirks) == quirks;
> }

Should I use bool (like in your snippet) or int (like i2c_check_functionality) as return type?

> And please use kernel-doc for the documentation.
