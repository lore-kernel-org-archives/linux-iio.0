Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35511 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab0JIKSv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Oct 2010 06:18:51 -0400
Message-ID: <4CB042DB.6020500@cam.ac.uk>
Date: Sat, 09 Oct 2010 11:24:27 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Grant Likely <grant.likely@secretlab.ca>, drivers@analog.com,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-iio@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
	matthias <mensch0815@googlemail.com>,
	spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>	 <4C94B4A6.2060001@cam.ac.uk>	 <AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>	 <4CA0C7AB.8060905@cam.ac.uk>	 <AANLkTikXMycs_eaRGA4Va=uaBo_qyx3S3m0Y43Gt+qAz@mail.gmail.com>	 <4CA344A5.80205@cam.ac.uk> <4CAEFEF4.4040506@cam.ac.uk>	 <20101008182943.GJ3863@angua.secretlab.ca> <1286568720.1723.4.camel@helium>
In-Reply-To: <1286568720.1723.4.camel@helium>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/08/10 21:12, David Brownell wrote:
> On Fri, 2010-10-08 at 12:29 -0600, Grant Likely wrote:
>> On Fri, Oct 08, 2010 at 12:22:28PM +0100, Jonathan Cameron wrote:
> 
>>> Is it ever wrong to over specify elements of a transfer?
> 
> I wouldn't say that's even possible.
> 
>>> We have a driver that (for historical reasons) specifies
>>> that a particular transfer is 8 bit.
>>> 	.bits_per_word = 8,
>>>
>>> This causes issues with the atmel spi driver which sees that
>>> the value is specified and hence fails the transfer.
> 
> 
> Specifying 8 there means the same as specifying zero.
Cool,

I'll post a patch (probably Monday now) to at least ensure the
atmel driver lets transfers through if we aren't trying to change
bits_per_word.

Thanks for getting back to us.

Jonathan
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

