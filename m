Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37869 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbbHaPAX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 11:00:23 -0400
Subject: Re: [PATCH 0/6] fixes, cleanup and improvements for m62332
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1440459082.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E46C08.80602@kernel.org>
Date: Mon, 31 Aug 2015 16:00:24 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/08/15 22:59, Hartmut Knaack wrote:
> A set of patches to address some issues I spotted during review.
> 
> Hartmut Knaack (6):
>   iio:dac:m62332: share scale and offset
>   iio:dac:m62332: shutdown on remove
>   iio:dac:m62332: use ARRAY_SIZE
>   iio:dac:m62332: drop unrequired variable
>   iio:dac:m62332: address some style issues
>   iio:dac:m62332: use dynamic scale
> 
>  drivers/iio/dac/m62332.c | 63 +++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
> 
Other than letting this series sit on the list a few days longer,
for Dmitry or others to take a look at it, I'm happy with this series.

Thanks,

Jonathan
