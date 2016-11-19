Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46465 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbcKSLmO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 06:42:14 -0500
Subject: Re: [PATCH v3 1/6] Documentation: dt-bindings: Document STM32 ADC DT
 bindings
To: Rob Herring <robh@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
 <1479223861-21747-2-git-send-email-fabrice.gasnier@st.com>
 <20161116151549.m6phclc6cqy4lj2y@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <31b94d46-7786-8a3b-3b41-b4ce2b4ae945@kernel.org>
Date: Sat, 19 Nov 2016 11:42:09 +0000
MIME-Version: 1.0
In-Reply-To: <20161116151549.m6phclc6cqy4lj2y@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/11/16 15:15, Rob Herring wrote:
> On Tue, Nov 15, 2016 at 04:30:56PM +0100, Fabrice Gasnier wrote:
>> This patch adds documentation of device tree bindings for the STM32 ADC.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 83 ++++++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

