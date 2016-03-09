Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56006 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbcCIVE0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 16:04:26 -0500
Subject: Re: [PATCH v2 1/2] iio: core: introduce IIO_CHAN_INFO_SIGNED
To: Lars-Peter Clausen <lars@metafoo.de>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
References: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
 <1457360997-29179-2-git-send-email-ludovic.desroches@atmel.com>
 <56DDDFFC.5010100@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E08FD5.4060701@kernel.org>
Date: Wed, 9 Mar 2016 21:04:21 +0000
MIME-Version: 1.0
In-Reply-To: <56DDDFFC.5010100@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/16 20:09, Lars-Peter Clausen wrote:
> On 03/07/2016 03:29 PM, Ludovic Desroches wrote:
>> The same channel can be used to perform a signed or an unsigned
>> conversion. Add a new infomask element to be able to select the type of
>> conversion wanted: a raw one or a signed raw one.
> 
> If this is the difference between offset binary and two's complement then it
> makes no sense to expose this at this level. Both are the same number just
> in a different representation and converting between them is cheap. A few
> magnitudes cheaper than reading the result over sysfs. So, if your device
> supports both, just pick one.
> 
> For the buffered interface it may make sense to expose this, since the per
> sample overhead is a lot lower. But still doing the conversion should be
> cheap enough that it does not really matter. Before this is implemented I'd
> like to see hard performance numbers that this actually makes a difference.
> 
> - Lars
> 
Definitely looking for more detail on this.  I'd missed we were talking simply
about representation (which is also how I read 62.6.6 Conversion Results Format
in the datasheet). Not entirely sure what I imagined the difference between
signed and unsigned output would be!

Jonathan
