Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:55252 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbeGTPbz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jul 2018 11:31:55 -0400
Date: Fri, 20 Jul 2018 08:43:16 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: iio: accel: Add docs for ADXL372
Message-ID: <20180720144316.GA25713@rob-hp-laptop>
References: <1531409697-19957-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531409697-19957-1-git-send-email-stefan.popa@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 12, 2018 at 06:34:57PM +0300, Stefan Popa wrote:
> Add the device tree binding documentation for the ADXL372 3-axis digital
> accelerometer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/adxl372.txt | 16 ++++++++++++++++
>  MAINTAINERS                                             |  1 +
>  2 files changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

Reviewed-by: Rob Herring <robh@kernel.org>
