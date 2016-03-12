Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43726 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbcCLLQj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 06:16:39 -0500
Subject: Re: [RFC PATCH v2 0/2] iio: introduce
 iio_device_{claim|release}_direct_mode()
To: Alison Schofield <amsfield22@gmail.com>,
	outreachy-kernel@googlegroups.com
References: <cover.1456794364.git.amsfield22@gmail.com>
 <cover.1457549841.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E3FA94.7000204@kernel.org>
Date: Sat, 12 Mar 2016 11:16:36 +0000
MIME-Version: 1.0
In-Reply-To: <cover.1457549841.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/16 19:25, Alison Schofield wrote:
> This patchset introduces two helper functions to simplify driver code
> requiring the device to be locked in direct mode during execution of a
> code path. The staging driver ad7192 is updated to demonstrate usage.
> 
> This could be applied to approximately 18 known cases where the driver
> is holding the lock in direct mode.  Unknown cases might be those that
> should, but don't, hold the lock.
> 
> Alternate implementation: Generalize to support a claim on any mode.
> Do iio_claim_mode(device,mode) where if the device is in *mode*, it
> is guaranteed to stay that way until release is called. I considered
> and rejected this option because a) not sure other modes would ever
> need to be locked, and b) the semantic improvement is less when it
> is generalized.
I agree with your chosen approach.

One general process comment.  After the positive emails you received for
v1, dropping the Request For Comment would have made sense marking the
series as in your opinion ready to be applied.

Jonathan
>  
> This patchset was inspired by a discussion on linux-iio:
> http://www.spinics.net/lists/linux-iio/msg18540.html
> 
> Changes in v2:
> o use iio_device prefix for new functions
> o replace EINVAL with EBUSY on failure to claim direct mode
> o update commit msg & changelog to reflect new prefix
> 
> Alison Schofield (2):
>   iio: core: implement iio_device_{claim|release}_direct_mode()
>   staging: iio: ad7192: use iio_device_{claim|release}_direct_mode()
> 
>  drivers/iio/industrialio-core.c  | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/ad7192.c | 24 +++++++++---------------
>  include/linux/iio/iio.h          |  2 ++
>  3 files changed, 50 insertions(+), 15 deletions(-)
> 

