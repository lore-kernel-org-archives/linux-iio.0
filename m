Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58182 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbdDCTpw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 15:45:52 -0400
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
To: Rob Herring <robh@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
 <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
 <20170403164600.siab6ghtoeuxokg5@rob-hp-laptop>
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linus.walleij@linaro.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4251bdd9-48d6-9b44-ed3d-f7ec8bfee875@kernel.org>
Date: Mon, 3 Apr 2017 20:45:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170403164600.siab6ghtoeuxokg5@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/17 17:46, Rob Herring wrote:
> On Fri, Mar 31, 2017 at 02:32:37PM +0200, Fabrice Gasnier wrote:
>> Add documentation for 'assigned-resolution-bits' dt optional property.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Changes in v2:
>> - rename property from 'st,adc-res' to 'assigned-resolution-bits' so it
>>   is more common.
>> ---
>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org> 
Thanks.

Applied to the togreg branch of iio.git.  Will push out as testing for
the autobuilders to have a chance to play with it.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

