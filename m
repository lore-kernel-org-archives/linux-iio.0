Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1200 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752175Ab2GBNJ2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2012 09:09:28 -0400
Message-ID: <4FF19E69.9040009@metafoo.de>
Date: Mon, 02 Jul 2012 15:13:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: Introduce iio_validate_scan_mask_onehot
References: <1341233083-8765-1-git-send-email-lars@metafoo.de> <1341233083-8765-2-git-send-email-lars@metafoo.de> <alpine.DEB.2.01.1207021451180.26435@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1207021451180.26435@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2012 02:52 PM, Peter Meerwald wrote:
> 
>> Add a helper function for validating a scan mask for devices where at most one
>> channel may be selected at a time. This is a common case among devices which
>> have scan mask restrictions so it makes sense to provide this function in the
>> core.
> 
> personally, would find iio_validate_scan_mask_atmost_one clearer than
> iio_validate_scan_mask_onehot, but it is a bit longer also

I think the code can even be changed to be more strict and just check if
bitmap_weight == 1. A mask is only validating after enabling a channel and
not after disabling it, so there will always be at least one bit set when
the validate function is called.

- Lars
