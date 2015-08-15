Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47242 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbHONxU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 09:53:20 -0400
Subject: Re: [PATCH 0/2] iio: One more buffer cleanup
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1439564095-7352-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF444F.8070502@kernel.org>
Date: Sat, 15 Aug 2015 14:53:19 +0100
MIME-Version: 1.0
In-Reply-To: <1439564095-7352-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/08/15 15:54, Lars-Peter Clausen wrote:
> Hi,
> 
> One more buffer cleanup moving the generic buffer implementations to a
> common sub-directory before we start adding new generic buffer
> implementations in form of the DMA buffer.
Cool - been looking forward to that for a while :)

J
> 
> - Lars
> 
> Lars-Peter Clausen (2):
>   iio: Move callback buffer to its own module
>   iio: Move generic buffer implementations to sub-directory
> 
>  drivers/iio/Kconfig                                | 22 +-------------------
>  drivers/iio/Makefile                               |  5 +----
>  drivers/iio/buffer/Kconfig                         | 24 ++++++++++++++++++++++
>  drivers/iio/buffer/Makefile                        |  8 ++++++++
>  .../industrialio-buffer-cb.c}                      | 12 +++++++++++
>  .../{ => buffer}/industrialio-triggered-buffer.c   |  0
>  drivers/iio/{ => buffer}/kfifo_buf.c               |  0
>  7 files changed, 46 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/iio/buffer/Kconfig
>  create mode 100644 drivers/iio/buffer/Makefile
>  rename drivers/iio/{buffer_cb.c => buffer/industrialio-buffer-cb.c} (89%)
>  rename drivers/iio/{ => buffer}/industrialio-triggered-buffer.c (100%)
>  rename drivers/iio/{ => buffer}/kfifo_buf.c (100%)
> 

