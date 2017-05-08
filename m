Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32969 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdEHQZm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 12:25:42 -0400
Date: Mon, 8 May 2017 11:25:40 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add driver for the
 ti-adc084s021 chip
Message-ID: <20170508162540.yusrkvcjcdyvjriu@rob-hp-laptop>
References: <1493812905-28904-1-git-send-email-marten.lindahl@axis.com>
 <1493812905-28904-2-git-send-email-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1493812905-28904-2-git-send-email-marten.lindahl@axis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 03, 2017 at 02:01:44PM +0200, Mårten Lindahl wrote:
> From: Mårten Lindahl <martenli@axis.com>
> 
> This adds support for the Texas Instruments ADC084S021 ADC chip.
> 
> Signed-off-by: Mårten Lindahl <martenli@axis.com>
> ---
> Changes in v3:
> - No updates since v2
> 
> Changes in v2:
> - Updated the 'Required properties' section
> - Removed the 'Optional properties' section
> 
>  .../devicetree/bindings/iio/adc/ti-adc084s021.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt

Acked-by: Rob Herring <robh@kernel.org>
