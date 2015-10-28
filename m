Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-193.synserver.de ([212.40.185.193]:1122 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754471AbbJ1SqZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2015 14:46:25 -0400
Message-ID: <563117FB.5030506@metafoo.de>
Date: Wed, 28 Oct 2015 19:46:19 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Nicola Corna <nicola@corna.info>, Wolfram Sang <wsa@the-dreams.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
	Jonathan Cameron <jic23@kernel.org>
CC: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: humidity: si7020: added No Hold read mode
References: <5630977D.2020102@metafoo.de> <f113de76b2369d404909cfc5158feca4@rainloop.corna.info> <1446015506-21371-1-git-send-email-nicola@corna.info> <aa9c6c7ffdd5083c110cb35723081dbf@rainloop.corna.info>
In-Reply-To: <aa9c6c7ffdd5083c110cb35723081dbf@rainloop.corna.info>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/28/2015 07:35 PM, Nicola Corna wrote:
> October 28 2015 10:38 AM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:
> 
>> On 10/28/2015 07:58 AM, Nicola Corna wrote:
>> [...]
>>
>>> + holdmode = !((*client)->adapter->quirks &&
>>> + (*client)->adapter->quirks->flags &
>>
>> [...]
>>
>>> + client->adapter->quirks &&
>>> + client->adapter->quirks->flags & I2C_AQ_NO_CLK_STRETCH)
>>
>> This is rather ugly, can we get a helper in the I2C core something along the
>> lines of
>>
>> i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH)
>>
>> - Lars
> 
> Something like this?
> 
> ---
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index a69a9a0..a06ffc0 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -613,6 +613,12 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
> return (func & i2c_get_functionality(adap)) == func;
> }
> 
> +/* Return 1 if adapter has the specified quirks, 0 if not. */
> +static inline int i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
> +{
> + return (quirks & (adap->quirks ? adap->quirks->flags : 0)) == quirks;
> +}

This is not a code obfuscation contest ;)

So maybe more like this:

static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
{
	if (!adap->quirks)
		return false;
	return (adap->quirks->flags & quirks) == quirks;
}

And please use kernel-doc for the documentation.
