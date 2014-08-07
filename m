Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39205 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbaHGQ15 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 12:27:57 -0400
Message-ID: <53E3A90C.6080006@kernel.org>
Date: Thu, 07 Aug 2014 17:27:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: balbi@ti.com
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
References: <1407341409-30284-1-git-send-email-balbi@ti.com> <alpine.DEB.2.01.1408061815140.29646@pmeerw.net> <20140806214222.GB3556@saruman.home> <53E35018.1000900@kernel.org> <20140807143943.GB24581@saruman.home>
In-Reply-To: <20140807143943.GB24581@saruman.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/08/14 15:39, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Aug 07, 2014 at 11:08:24AM +0100, Jonathan Cameron wrote:
>>>>> +				OPT3001_CONFIGURATION); +		return ret; +	} + +	/* wait for conversion and give it an extra 5ms */ + 
>>>>> usleep_range(opt->int_time + 5000, opt->int_time + 10000); + +	ret = opt3001_read(opt,
>>>>> OPT3001_CONFIGURATION); +	if (ret < 0) { +		dev_err(opt->dev, "failed to read register %02x\n", +
>>>>> OPT3001_CONFIGURATION); +		return ret; +	} + +	reg = ret; +	if (!(reg & OPT3001_CONFIGURATION_CRF)) +
>>>>> return -EPIPE; + +	ret = opt3001_read(opt, OPT3001_RESULT); +	if (ret < 0) { +		dev_err(opt->dev, "failed
>>>>> to read register %02x\n", +				OPT3001_RESULT); +		return ret; +	} + +	exponent =
>>>>> OPT3001_REG_EXPONENT(ret); +	mantissa = OPT3001_REG_MANTISSA(ret); + + opt3001_to_iio_ret(opt, exponent,
>>>>> mantissa, val, val2); + +	return IIO_VAL_INT_PLUS_MICRO; +} + +static int opt3001_get_scale(struct opt3001
>>>>> *opt, int *val, int *val2) +{ +	int ret; +	u8 exponent; +
>>>> 
>>>> I guess OPT3001_RESULT is only valid AFTER performing opt3001_get_lux()
>>> 
>>> right. I'm only interested in the exponent part. It'll latch the exponent from last conversion, 0 being
>>> default.
>> Given you unwind the scale anyway in your read raw, I'd not bother having a scale interface at all (assuming I'm
>> right in thinking your read raw is returning the value in lux?)  Also as you are in lux, it should be the
>> processed form not the raw one to indicate the scale does not need to be applied to the value to convert to lux.
> 
> alright, I'll switch to processed and remove scale.
> 
>> For a light sensor, the conversion here is actually fairly straight forward. Almost all of them have to use the
>> processed interface as they are horribly non linear.
> 
> :)
> 
>>> 
>>>>> + +	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS) +		return -EBUSY; + +	if (chan->type != IIO_LIGHT)
>>>>> + return -EINVAL; + +	mutex_lock(&opt->lock); + +	switch (mask) {
>>>> 
>>>> is there no way to control the scale?
>>> 
>>> yeah, but the HW does auto-scaling which works pretty well. Why would you want to control the scale manually ?
>> On a slow device like this you probably wouldn't but for quicker devices the overhead of converting into a
>> standard form in kernel might be excessive.
> 
> hehe, even when you _do_ set the scale, you still have the top 4 bits as exponent, the difference is that you know
> what they are before the conversion is done :-)
Then you can junk them and let userspace use the known value to deal with the raw data.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJT46kMAAoJEFSFNJnE9BaICmQP/iY3mtojtzobsU1BTFiyd6ah
xp/5vsyCM4pdqMOm8xUDwp6aBlvBvAQfVDGcQetR/KawJt7SMtKJdDxhR/hkFodE
E/3thrUXjCYw0VW9Xkg5doBucqbaWOjNsjnZDFH8HBZupFTWHv3I/QQq3acbdAbJ
DC0DRtfrTBF2JEOSLRssY11pAbxkDdeuZvIqQLpwZ80+Ptpi9MkeWoHlwOq9v67P
s0KODDTep2n7Z2w9KaY4V5L5YgLjW5YsDW+qv3zpQyq54+LB+CnCFMK2DZ4RqQlt
zPDuz7Cw8ujiqoHJlrs+bc/AbTk6gV/+puOyzb9zp6/HbSF/Q72Drw/1yF+2dIz4
rZtNaxsg0I+mH0e8xiKRYIeYHEKnHvwhO2e+6CJdLWabYvS8tSiYrU7qHKwkZVja
P04RGZNdqWrdmEOmxidd9CO+K7lvMqv/pSzVmVpQWq7Zw9EDx77h1SxyIHWtnD+3
CsiZluC++2JqCdvU01Cen+x95DPZPfK3hp6u7Y8SGgKwGluxxRMlN3QyYQXC5g5s
o9G4Jw/0wV0hshuTmwR9SifwkS2XMp/FbCJC2/c6A8PUx9O9H5IVIqk+ChSaWXkP
3NPl2O1hQIdjLgoDF5Xn4SD+F/CC3WPczMV+zcW8GrmZKjb30X0x5BNIv2UxKN0H
zJyy8hv/NLTUBaoXd5BG
=QBgz
-----END PGP SIGNATURE-----
