Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nm30-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.69]:22991 "HELO
	nm30-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759990Ab0JIBkc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2010 21:40:32 -0400
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260
 driver.
From: David Brownell <david-b@pacbell.net>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, drivers@analog.com,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-iio@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
	matthias <mensch0815@googlemail.com>,
	spi-devel-general@lists.sourceforge.net
In-Reply-To: <20101008182943.GJ3863@angua.secretlab.ca>
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
	 <4C94B4A6.2060001@cam.ac.uk>
	 <AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>
	 <4CA0C7AB.8060905@cam.ac.uk>
	 <AANLkTikXMycs_eaRGA4Va=uaBo_qyx3S3m0Y43Gt+qAz@mail.gmail.com>
	 <4CA344A5.80205@cam.ac.uk> <4CAEFEF4.4040506@cam.ac.uk>
	 <20101008182943.GJ3863@angua.secretlab.ca>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 08 Oct 2010 13:12:00 -0700
Message-ID: <1286568720.1723.4.camel@helium>
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2010-10-08 at 12:29 -0600, Grant Likely wrote:
> On Fri, Oct 08, 2010 at 12:22:28PM +0100, Jonathan Cameron wrote:

> > Is it ever wrong to over specify elements of a transfer?

I wouldn't say that's even possible.

> > We have a driver that (for historical reasons) specifies
> > that a particular transfer is 8 bit.
> > 	.bits_per_word = 8,
> > 
> > This causes issues with the atmel spi driver which sees that
> > the value is specified and hence fails the transfer.


Specifying 8 there means the same as specifying zero.


