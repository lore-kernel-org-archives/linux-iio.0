Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-090.synserver.de ([212.40.185.90]:1105 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932182AbbIVIQM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2015 04:16:12 -0400
Message-ID: <56010E47.9070007@metafoo.de>
Date: Tue, 22 Sep 2015 10:16:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Rosin <peda@lysator.liu.se>, linux-iio@vger.kernel.org
CC: Peter Rosin <peda@axentia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Subject: Re: Driver for Microchip digital potentiometers, v2
References: <1442870306-26128-1-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1442870306-26128-1-git-send-email-peda@lysator.liu.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/21/2015 11:18 PM, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Hi!
> 
> This is a new attempt for a driver for these chips. It is a
> complete rewrite since the first version which was a dirty
> misc driver (plagiarized from another misc driver) that got
> shredded in review.

Yeah, we need to move the ad_dpot driver over to IIO at some point. The main
issue is that we need to retain the old ABI (at least optionally).

> I don't know if I should have added a new unit "ohms", or if
> it is ok to only provide "steps"? One could also imagine that
> a digital pot can be used to implement a DAC, or something
> else, so maybe the actual unit should be somehow configurable?

Steps are the steps you make with your feet, so that wouldn't be the right
thing here. The right channel type is resistance and the unit is Ohm. You
can use a dpot for a lot of things, e.g. a LED, that doesn't mean we should
have the option to expose this device as a LED device. If something uses the
rdac to implement another function that should be a separate driver being
registered to the rdac.

