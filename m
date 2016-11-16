Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34047 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbcKPPPv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2016 10:15:51 -0500
Date: Wed, 16 Nov 2016 09:15:49 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v3 1/6] Documentation: dt-bindings: Document STM32 ADC DT
 bindings
Message-ID: <20161116151549.m6phclc6cqy4lj2y@rob-hp-laptop>
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
 <1479223861-21747-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479223861-21747-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 15, 2016 at 04:30:56PM +0100, Fabrice Gasnier wrote:
> This patch adds documentation of device tree bindings for the STM32 ADC.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt

Acked-by: Rob Herring <robh@kernel.org>
