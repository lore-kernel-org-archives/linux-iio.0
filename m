Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52659 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbbEHSnX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:43:23 -0400
Message-ID: <554D03C2.8030106@kernel.org>
Date: Fri, 08 May 2015 14:43:14 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Xander Huff <xander.huff@ni.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, ben.shelton@ni.com, joshc@ni.com,
	joe.hershberger@ni.com
Subject: Re: [PATCH 1/2] devicetree: xilinx-xadc: Add optional xlnx,extend-name
 property
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
In-Reply-To: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/15 18:44, Xander Huff wrote:
> To better facilitate user-mode access to optional aux channels, allow
> device trees to specify a custom extended name for defined channels.
> 
> Signed-off-by: Xander Huff <xander.huff@ni.com>
> Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
> Reviewed-by: Josh Cartwright <joshc@ni.com>
> --
> Natinst-ReviewBoard-ID: 97119
Interesting idea. I'd like to let this sit for a fair while to see what
comments it gets.  If it makes sense for this driver, it probably makes
sense for a lot of others.  As such we may well want to have a general
binding for this, rather than one for just this part.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> index d71258e..4c5a60b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> @@ -68,6 +68,8 @@ Optional properties:
>  			  Note each channel number should only be used at most
>  			  once.
>  		Optional properties:
> +			* xlnx,extend-name: Custom extended name for the
> +			  channel.
>  			* xlnx,bipolar: If set the channel is used in bipolar
>  			  mode.
>  
> @@ -107,6 +109,7 @@ Examples:
>  			#size-cells = <0>;
>  			channel@0 {
>  				reg = <0>;
> +				xlnx,extend-name = "vin_v";
>  				xlnx,bipolar;
>  			};
>  		};
> 

