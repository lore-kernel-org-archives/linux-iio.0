Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeFJMaH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jun 2018 08:30:07 -0400
Date: Sun, 10 Jun 2018 13:30:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 1/9] MAINTAINERS: add generic resistive touchscreen
 adc
Message-ID: <20180610133000.35bf0344@archlinux>
In-Reply-To: <1526975559-18966-2-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 May 2018 10:52:31 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add MAINTAINERS entry for generic resistive touchscreen adc
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Applied to the togreg branch of iio.git after a rebase brought
in the missing fix that was stalling this.  Note these are
now going to be heading upstream at the next merge window,
not the one currently open.

Pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Changed source file name
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bdc260..ce9720f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5943,6 +5943,12 @@ F:	drivers/base/power/domain*.c
>  F:	include/linux/pm_domain.h
>  F:	Documentation/devicetree/bindings/power/power_domain.txt
>  
> +GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
> +M:	Eugen Hristev <eugen.hristev@microchip.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touchscreen/resistive-adc-touch.c
> +
>  GENERIC UIO DRIVER FOR PCI DEVICES
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
>  L:	kvm@vger.kernel.org

