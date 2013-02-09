Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43654 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab3BIK7L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2013 05:59:11 -0500
Message-ID: <51162BF7.1040107@kernel.org>
Date: Sat, 09 Feb 2013 10:59:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: Add helper functions for setting up transfers
References: <1357752671-30222-1-git-send-email-lars@metafoo.de> <20130127033358.GA20672@sirena.org.uk> <20130205140755.33FCD3E1265@localhost>
In-Reply-To: <20130205140755.33FCD3E1265@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/2013 02:07 PM, Grant Likely wrote:
> On Sun, 27 Jan 2013 03:33:59 +0000, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>> On Wed, Jan 09, 2013 at 06:31:09PM +0100, Lars-Peter Clausen wrote:
>>
>>> The second function spi_sync_transfer() takes a SPI device and an array of
>>> spi_transfers. It will allocate a new spi_message (on the stack) and add all
>>> transfers in the array to the message. Finally it will call spi_sync() on the
>>> message.
>>
>> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Looks good to me also. Go ahead and merge this series through the iio
> tree since it is the first user.
Grant, can I take that as an Acked-by?  Its going to touch your tree so
that would probably reduce questions as this goes up stream.


> 
> g.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
