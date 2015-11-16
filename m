Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbKPGzP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Nov 2015 01:55:15 -0500
In-Reply-To: <1447629111-6400-1-git-send-email-nizamhaider786@gmail.com>
References: <1447629111-6400-1-git-send-email-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] IIO: adc: xilinx-xadc-core.c: constify iio_buffer_setup_ops structure
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 16 Nov 2015 06:54:43 +0000
To: Nizam Haider <nizamhaider786@gmail.com>, jic23@kernel.org
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	thomas.betker@rohde-schwarz.com, xander.huff@ni.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Nizam Haider <nijamh@cdac.in>
Message-ID: <E5B479B9-0B4F-4183-A850-3E7DBC260D09@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 15 November 2015 23:11:51 GMT+00:00, Nizam Haider <nizamhaider786@gmail.com> wrote:
>structure iio_buffer_setup_ops is never modified, so declare it as
>const.
>
>Signed-off-by: Nizam Haider <nijamh@cdac.in>
Sometimes it feels like there is something in the air...

Julia Lawal posted a patch for this yesterday.

Thanks

Jonathan
>---
> drivers/iio/adc/xilinx-xadc-core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iio/adc/xilinx-xadc-core.c
>b/drivers/iio/adc/xilinx-xadc-core.c
>index 0370624..c2b5f10 100644
>--- a/drivers/iio/adc/xilinx-xadc-core.c
>+++ b/drivers/iio/adc/xilinx-xadc-core.c
>@@ -803,7 +803,7 @@ err:
> 	return ret;
> }
> 
>-static struct iio_buffer_setup_ops xadc_buffer_ops = {
>+static const struct iio_buffer_setup_ops xadc_buffer_ops = {
> 	.preenable = &xadc_preenable,
> 	.postenable = &iio_triggered_buffer_postenable,
> 	.predisable = &iio_triggered_buffer_predisable,

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
