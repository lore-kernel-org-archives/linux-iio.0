Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:47519 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbcLHXDd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2016 18:03:33 -0500
Subject: Re: [PATCH v11 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
 <7122f136e4735fe18c8b431006e6d6314b3c7e41.1481234322.git.ksenija.stanojevic@gmail.com>
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        harald@ccbib.org, stefan.wahren@i2se.com,
        fabio.estevam@freescale.com
From: Marek Vasut <marex@denx.de>
Message-ID: <8b5ad884-ed94-c776-043d-1dbdd64182d2@denx.de>
Date: Thu, 8 Dec 2016 23:56:28 +0100
MIME-Version: 1.0
In-Reply-To: <7122f136e4735fe18c8b431006e6d6314b3c7e41.1481234322.git.ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/2016 11:27 PM, Ksenija Stanojevic wrote:
> Add core files for low resolution analog-to-digital converter (mxs-lradc)
> MFD driver.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

Just a nit below.

> +++ b/include/linux/mfd/mxs-lradc.h
> @@ -0,0 +1,187 @@
> +/*

[...]

> +#define LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
> +#define LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
> +#define LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
> +#define LRADC_CTRL1_TOUCH_DETECT_IRQ		BIT(8)
> +#define LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))

This would turn into BIT(n) , no ?

> +#define LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
> +#define LRADC_CTRL1_MX23_LRADC_IRQ_MASK		0x01ff
> +#define LRADC_CTRL1_LRADC_IRQ_OFFSET		0

[...]

-- 
Best regards,
Marek Vasut
