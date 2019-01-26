Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F240BC282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CAD21872
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 20:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548535707;
	bh=NIdk0ZbBs+uVkvkK8D7eaDqeNRjSIT7kWZW3IYLTezE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cTKct370wbyBHrOJDcELVeCY7GYZJqueNa1WvSVD3l20bgOlwUfzOrB2VPkwNd5vd
	 gtE/rua9bAyXLLbvBfzRcE+ETcRXuHY2qpFOy3UX4Ve3qR0kmo6GrRKBQDgpfYkVk0
	 Hi94nSwLq96RuY7exw3uOss3drZOUyXVrq6ro21E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAZUs1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfAZUs1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Jan 2019 15:48:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1396B2184C;
        Sat, 26 Jan 2019 20:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548535705;
        bh=NIdk0ZbBs+uVkvkK8D7eaDqeNRjSIT7kWZW3IYLTezE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vlFEhCH+FSMsNrpZ6OFym0YOTSBGtwg3qNXiRQRz5X8uX9VZ3qrQiFskN/Rgz/Kad
         DcTIX3wihKLfUUcbIAirbYJEcVDbx2v6h8MKSl8zZ/cSg8Rptib4VDVkUV5JPBzQvA
         z7n7Hjr3HML8CR/hFzMZRvz9j2en37n9gycj2KZg=
Date:   Sat, 26 Jan 2019 20:48:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Felipe Cardoso Resende <felipecardoso.fcr@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: iio: adc: Include SPDX Identifier
Message-ID: <20190126204820.5998bf29@archlinux>
In-Reply-To: <20190126173746.GA7100@archfcr.localdomain>
References: <20190126173746.GA7100@archfcr.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Jan 2019 15:37:53 -0200
Felipe Cardoso Resende <felipecardoso.fcr@gmail.com> wrote:

> Remove warning found by checkpatch.pl by including SPDX Identifier
> 
> Signed-off-by: Felipe Cardoso Resende <felipecardoso.fcr@gmail.com>

However much checkpatch moans about this they all need careful individual
checking and I always prefer to get input from someone who either wrote
the code or works for the company with the copyright.

It's particularly fun as one of these is currently inconsistent
within the file. I've raised it with Analog and they have promised to clean
these up.  There is also one that has been done already (and indeed moved
out of staging). If we apply this I'll just drop that one.

Obviously if they are happy with your change that is great but I will need
an Ack from one of the current Analog team.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c     | 3 +--
>  drivers/staging/iio/adc/ad7192.h     | 5 ++---
>  drivers/staging/iio/adc/ad7280a.c    | 3 +--
>  drivers/staging/iio/adc/ad7280a.h    | 5 ++---
>  drivers/staging/iio/adc/ad7606.c     | 3 +--
>  drivers/staging/iio/adc/ad7606.h     | 5 ++---
>  drivers/staging/iio/adc/ad7606_par.c | 3 +--
>  drivers/staging/iio/adc/ad7606_spi.c | 3 +--
>  drivers/staging/iio/adc/ad7780.c     | 3 +--
>  drivers/staging/iio/adc/ad7816.c     | 3 +--
>  10 files changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..b01d4cd6bb82 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
>   *
>   * Copyright 2011-2015 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/interrupt.h>
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> index 7433a43c2611..2a5a55fdd825 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -1,9 +1,8 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
>   * AD7190 AD7192 AD7195 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  #ifndef IIO_ADC_AD7192_H_
>  #define IIO_ADC_AD7192_H_
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 14f6a3ced060..c10fdce511a6 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * AD7280A Lithium Ion Battery Monitoring System
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/crc8.h>
> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> index ccfb90d20e71..400d47ab3744 100644
> --- a/drivers/staging/iio/adc/ad7280a.h
> +++ b/drivers/staging/iio/adc/ad7280a.h
> @@ -1,9 +1,8 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
>   * AD7280A Lithium Ion Battery Monitoring System
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #ifndef IIO_ADC_AD7280_H_
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 7308fa8fbb4c..b4a28cddfc91 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c

This one isn't even there any more.  Please be careful to check you have
the right tree to work against, particularly when doing mass changes
like this.  In this particular case it's iio.git and right now the
only near up to date version is the testing branch (coincidence of where
we are in the cycle).

> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * AD7606 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/interrupt.h>
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index 86188054b60b..3a57bc5539b6 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -1,9 +1,8 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
>   * AD7606 ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #ifndef IIO_ADC_AD7606_H_
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 8bd86e727b02..ec2280f07b78 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * AD7606 Parallel Interface ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/module.h>
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index b76ca5a8c059..0b848da3ac08 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * AD7606 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/module.h>
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index c4a85789c2db..88caa6617c74 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/interrupt.h>
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 5209651a1b25..0ac6b3f32d13 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * AD7816 digital temperature sensor driver supporting AD7816/7/8
>   *
>   * Copyright 2010 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.

This one is inconsistent as the module driver marking is GPL V2 only.
Hence we should confirm this with Analog.

>   */
>  
>  #include <linux/interrupt.h>

