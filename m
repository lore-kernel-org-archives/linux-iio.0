Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43783 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeJaEaY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Oct 2018 00:30:24 -0400
Date: Tue, 30 Oct 2018 14:35:34 -0500
From: Rob Herring <robh@kernel.org>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: dac: Add ti,dac7311 device tree
 bindings in documentation
Message-ID: <20181030193534.GA2372@bogus>
References: <20181028162402.16182-1-charles-antoine.couret@essensium.com>
 <20181028162402.16182-2-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181028162402.16182-2-charles-antoine.couret@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 Oct 2018 17:24:02 +0100, Charles-Antoine Couret wrote:
> Description how to invoke ti-dac7311 driver from device tree file.
> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> ---
>  .../bindings/iio/dac/ti,dac7311.txt           | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
