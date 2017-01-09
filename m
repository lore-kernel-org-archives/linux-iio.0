Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33111 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033522AbdAIR7V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 12:59:21 -0500
Date: Mon, 9 Jan 2017 11:58:52 -0600
From: Rob Herring <robh@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: tlc4541: add support for TI tlc4541 adc
Message-ID: <20170109175852.jxemxixx5qpcejov@rob-hp-laptop>
References: <1483606546-13629-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483606546-13629-1-git-send-email-preid@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 05, 2017 at 04:55:46PM +0800, Phil Reid wrote:
> This adds TI's tlc4541 16-bit ADC driver. Which is a single channel
> ADC. Supports raw and trigger buffer access.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  .../devicetree/bindings/iio/adc/ti-tlc4541.txt     |  16 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ti-tlc4541.c                       | 266 +++++++++++++++++++++
>  4 files changed, 294 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
>  create mode 100644 drivers/iio/adc/ti-tlc4541.c

