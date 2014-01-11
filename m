Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46988 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbaAKLVu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 06:21:50 -0500
Message-ID: <52D12956.1080208@kernel.org>
Date: Sat, 11 Jan 2014 11:21:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: Add si7005 relative humidity and temperature
 sensor driver
References: <1389355432-26695-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389355432-26695-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10/01/14 12:03, Peter Meerwald wrote:
> sensor provides 12-bit relative humidity and 14-bit temperature
> via I2C interface; temperature and linearity compensation is not
> implemented (yet)
>
> driver also supports the Si7015, but not the 2nd generation
> sensors Si7013/Si7020/Si7021
>
> datasheet is here
> http://www.silabs.com/Support%20Documents/TechnicalDocs/Si7005.pdf
>
> v2: (thanks to Lars-Peter Clausen)
> * fix coding style
> * use devm_iio_device_register()
> * change copyright year to 2014
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git (pushed out as testing initially)
