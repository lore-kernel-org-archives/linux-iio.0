Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:41180 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754312Ab2LLToe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2012 14:44:34 -0500
Message-ID: <50C8DECC.7010706@metafoo.de>
Date: Wed, 12 Dec 2012 20:45:16 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: jic23@kernel.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: question about driver for different sensors in the same ASIC
References: <3BE6D37A-6EDA-4E4C-808F-1DEAEDE86DA3@gmail.com>
In-Reply-To: <3BE6D37A-6EDA-4E4C-808F-1DEAEDE86DA3@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/12/2012 08:19 PM, Denis Ciocca wrote:
> Ho guys,
> 
> I have a 	question for you!
> If I have two sensors (accelerometer and gyroscope for example) in the same ASIC with the same I2C address, I have to do only one driver (only probe I think) for the devices or it is possible execute two different probes (one for accelerometer and the other one for gyroscope) keeping separate the drivers?
> Thanks,
> 
> Denis

Usually you'd want to be able to sample both the accelerometer and gyro sensors
at the same time, so just one driver should be fine.

Or have the gyro and accelerometer sensors completely separated register maps
and don't share any functionality?

- Lars
