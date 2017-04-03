Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34306 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdDCQqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 12:46:03 -0400
Date: Mon, 3 Apr 2017 11:46:00 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com, linus.walleij@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
Message-ID: <20170403164600.siab6ghtoeuxokg5@rob-hp-laptop>
References: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
 <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 31, 2017 at 02:32:37PM +0200, Fabrice Gasnier wrote:
> Add documentation for 'assigned-resolution-bits' dt optional property.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - rename property from 'st,adc-res' to 'assigned-resolution-bits' so it
>   is more common.
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org> 
