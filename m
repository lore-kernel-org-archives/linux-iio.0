Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36628 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbcLSWBV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2016 17:01:21 -0500
Date: Mon, 19 Dec 2016 16:01:18 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v3 1/2] iio: adc: hx711: Add DT binding for avia,hx711
Message-ID: <20161219220118.izqizukofldr6nlz@rob-hp-laptop>
References: <20161214161640.GA13885@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161214161640.GA13885@andreas>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Dec 14, 2016 at 05:16:40PM +0100, Andreas Klinger wrote:
> Add DT bindings for avia,hx711
> Add vendor avia to vendor list
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 16 ++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt    |  1 +
>  2 files changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt

Acked-by: Rob Herring <robh@kernel.org>
