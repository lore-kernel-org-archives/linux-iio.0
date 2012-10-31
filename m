Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33044 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935637Ab2JaOKJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 31 Oct 2012 10:10:09 -0400
Date: Wed, 31 Oct 2012 15:10:06 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] staging:iio: add a callback buffer for in kernel
 push interface
In-Reply-To: <1351679431-7963-4-git-send-email-jic23@kernel.org>
Message-ID: <alpine.DEB.2.01.1210311505340.10186@pmeerw.net>
References: <1351679431-7963-1-git-send-email-jic23@kernel.org> <1351679431-7963-4-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm sure you missed my spellchecking :)

> +config IIO_BUFFER_CB
> +       boolean "IIO callback buffer used for push in kernel interfaces"
> +       help
> +         Should be selected by any drivers that do inkernel push
> +	 usage.  That is, those where the data is pushed to the consumer.
> +

is it 'in kernel' or 'inkernel'? I'd prefer in-kernel :)
indentation seems inconsistent

> +/**
> + * iio_channel_cb_get_channels() - get access to the underlying channels.
> + * @cb_buff:		The callback buffers from whom we want the channel
> + *			information.

buffers from which?

-- 

Peter Meerwald
+43-664-2444418 (mobile)
