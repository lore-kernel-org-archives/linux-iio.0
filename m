Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeHOAHZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Aug 2018 20:07:25 -0400
Date: Tue, 14 Aug 2018 15:18:18 -0600
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: add bindings for ltc166x
Message-ID: <20180814211818.GA19760@rob-hp-laptop>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
 <20180811200226.28776-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180811200226.28776-2-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Aug 2018 22:02:25 +0200, Marcus Folkesson wrote:
> LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
> with eight individual channels.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/iio/dac/ltc166x.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc166x.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
