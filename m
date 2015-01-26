Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58039 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbbAZVBf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jan 2015 16:01:35 -0500
Message-ID: <54C6AB2B.9040709@kernel.org>
Date: Mon, 26 Jan 2015 21:01:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>,
	=?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5rbw==?=
	<kristina.martsenko@gmail.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Juergen Beisert <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 0/4] iio: mxs-lradc: fix interactions between the touchscreen
 and the ADC
References: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com> <201501251947.17832.marex@denx.de>
In-Reply-To: <201501251947.17832.marex@denx.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/01/15 18:47, Marek Vasut wrote:
> On Sunday, January 25, 2015 at 05:28:18 PM, Kristina Martšenko wrote:
>> These patches fix some issues with using the touchscreen and reading
>> other ADC channels at the same time.
> 
> [...]
> 
> Hi!
> 
> Thanks!
> 
> Entire series
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
All 4 applied to the fixes-togreg branch of iio.git and cc'd to
stable.

Thanks

Jonathan
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

