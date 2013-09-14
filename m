Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40049 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab3INKV1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 06:21:27 -0400
Message-ID: <523446C4.7030808@kernel.org>
Date: Sat, 14 Sep 2013 12:21:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jon Brenner <jon.brenner@ams.com>
Subject: Re: [PATCH 3/4] iio: Add tsl4531 ambient light sensor driver
References: <1378653659-15665-1-git-send-email-pmeerw@pmeerw.net> <1378653659-15665-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378653659-15665-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/13 16:20, Peter Meerwald wrote:
> driver for the TSL4531 family of 16-bit I2C ambient light
> sensors; information is here:
> http://www.ams.com/eng/Products/Light-Sensors/Ambient-Light-Sensor-ALS/TSL45315
>
> the chip offers simple lux output
>
> v3 (thanks Lars-Peter Clausen):
> * add mutex to when updating integration time
> * fix chip ID checking
> * code cleanups
> v2:
> * rename to tsl4351
> * use INT_TIME
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Jon Brenner <jon.brenner@ams.com>
Clean, concise and easy to review.  This is the sort of driver
I like!  To be fair you were assisted here by the hardware designers
making a device that fits remarkably well with our interfaces ;)

Applied to the togreg branch of iio.git.

One little question, what is 'single cycle measurement' referring to in the TODO note?

Thanks,

Jonathan

