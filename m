Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:33013 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbcGAJxr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2016 05:53:47 -0400
Subject: Re: multi-planar buffers
To: Phil Reid <preid@electromag.com.au>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <595f2eb9-524d-2bb9-6e74-2cacc155a07c@electromag.com.au>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <57763DA7.2010800@metafoo.de>
Date: Fri, 1 Jul 2016 11:53:43 +0200
MIME-Version: 1.0
In-Reply-To: <595f2eb9-524d-2bb9-6e74-2cacc155a07c@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/28/2016 11:04 AM, Phil Reid wrote:
> I'm interested in multi-planar buffers for and ADC that does multiple
> parallel dma transactions.
> Raised the question about 6 months ago and it was something for which Lars
> said support was needed at some point.
> At the time he suggested that it was best implemented with the mmap support
> which still doesn't look to be upstream correct?
> 
> The mmap is also of interest to us due to the potential number of channels
> and high sample rates.
> Is the work stalled on getting this into the kernel?
> 
> Could someone point me to where the latest mmap code is so I can look at
> integrating multi-planar buffers into it for our driver.
> 
> If there something I can do to help get the mmap code into the kernel as
> well I'm happy to have a go with a bit of guidance.

Hi,

No progress on the upstream of the mmap code at the moment, sorry. The
latest code is here:
https://github.com/analogdevicesinc/linux/tree/xcomm_zynq/drivers/iio but
probably needs some serious rework before it is ready for upstream submission.

Among other things to support the multi-planar buffers the structure layout
for the buffer meta data needs to be changed.

- Lars

