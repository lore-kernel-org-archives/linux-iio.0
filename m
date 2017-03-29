Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33164 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932760AbdC2Ad3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2017 20:33:29 -0400
Date: Tue, 28 Mar 2017 19:33:26 -0500
From: Rob Herring <robh@kernel.org>
To: Rick Altherr <raltherr@google.com>
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] Documentation: dt-bindings: Document bindings for
 Aspeed AST2400/AST2500 ADC
Message-ID: <20170329003326.hhz6qz4o5vorugnh@rob-hp-laptop>
References: <20170321204828.31303-1-raltherr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321204828.31303-1-raltherr@google.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 01:48:27PM -0700, Rick Altherr wrote:
> Signed-off-by: Rick Altherr <raltherr@google.com>
> ---
> 
> Changes in v2:
> - Rewritten as an IIO ADC device
> 
>  .../devicetree/bindings/iio/adc/aspeed_adc.txt       | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt

Acked-by: Rob Herring <robh@kernel.org>
