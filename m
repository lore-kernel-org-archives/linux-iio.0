Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44564 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab3INTSp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 15:18:45 -0400
Message-ID: <5234C4B2.5040704@kernel.org>
Date: Sat, 14 Sep 2013 21:18:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jon Brenner <jon.brenner@ams.com>
Subject: Re: [PATCH 3/4] iio: Add tsl4531 ambient light sensor driver
References: <1378653659-15665-1-git-send-email-pmeerw@pmeerw.net> <1378653659-15665-4-git-send-email-pmeerw@pmeerw.net> <523446C4.7030808@kernel.org> <alpine.DEB.2.01.1309142106520.22469@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1309142106520.22469@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/14/13 20:13, Peter Meerwald wrote:
> 
>>> driver for the TSL4531 family of 16-bit I2C ambient light
>>> sensors; information is here:
>>> http://www.ams.com/eng/Products/Light-Sensors/Ambient-Light-Sensor-ALS/TSL45315
> 
>> Applied to the togreg branch of iio.git.
> 
> there may be your Signed-off-by: missing
Gah!  Fixed and thanks for pointing that out.
> 
>> One little question, what is 'single cycle measurement' referring to in the TODO note?
> 
> the chip can run in continuous measurement mode and one-shot measurement 
> mode; the driver implements continuous measurement mode (aka normal mode) 
> thus wasting energy
> 
> it is not clear how to know when the measurement is complete in one-shot 
> mode, hence I'm sticking with continuous mode
>
Thanks, perhaps Jon can dig out some details on that when he has a few mins.

Jonathan
> p.
> 
