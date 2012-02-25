Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38598 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab2BYLSN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2012 06:18:13 -0500
Message-ID: <4F48C3AA.9060304@cam.ac.uk>
Date: Sat, 25 Feb 2012 11:19:06 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com
Subject: Re: [PATCH 6/6] stargate2: example of map configuration for iio to
 hwmon example.
References: <1329335285-31006-1-git-send-email-jic23@kernel.org> <1329335285-31006-7-git-send-email-jic23@kernel.org> <4F3C1EAC.9090809@kernel.org> <20120224200712.GA24588@kroah.com>
In-Reply-To: <20120224200712.GA24588@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/24/2012 08:07 PM, Greg KH wrote:
> On Wed, Feb 15, 2012 at 09:07:56PM +0000, Jonathan Cameron wrote:
>> On 02/15/2012 07:48 PM, Jonathan Cameron wrote:
>>> From: Jonathan Cameron <jic23@cam.ac.uk>
>>>
>>> Do not commit.
>> Whilst this example was never meant to be committed, the obvious flaw
>> is that max1363 doesn't actually support these interfaces because
>> I left one patch out. Lets call it 5.5 and stick it before this one.
> 
> Huh?  I don't understand what you mean here, should I not apply this
> one?
Sorry, the confusion here comes from the fact that this set was not
yet meant to be a merge request but rather had been sent out for review.
You were explicitly cc'd because of the issues you had raised with the
previous version (that were hopefully fixed to your satisfaction here).
This final patch was there to show how things worked, but should
obvously not merge as it uses headers in staging from outside (under
arch).  The board isn't actually wired like this anyway!

Having said that, the only reason I hadn't sent a new version was a
nasty cold so thanks for merging the first 5.  The 5.5 one was only
really required to support this example, so whilst harmless it wasn't
important and I'll tack it on the next set I send out.

Thanks again for pulling these.  I guess that means you are happy
with the new version!

Jonathan
> 
> confused,
> 
> greg k-h

