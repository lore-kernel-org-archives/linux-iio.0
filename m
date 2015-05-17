Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59685 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbEQLkZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 07:40:25 -0400
Message-ID: <55587E28.7070504@kernel.org>
Date: Sun, 17 May 2015 12:40:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Antoine Tenart <antoine.tenart@free-electrons.com>,
	sebastian.hesselbarth@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
CC: zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ARM: berlin: add an ADC node for the BG2Q
References: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com> <1431339531-11938-4-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1431339531-11938-4-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/15 11:18, Antoine Tenart wrote:
> This patch adds the ADC node for the Berlin BG2Q, using the newly added
> Berlin IIO ADC driver.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

The driver support will be working it's way through to mainline in the
next merge window.  Obviously I 'could' take this through IIO, but not
without an appropriate Ack.

Hence I'll assume it's going through the arm-soc tree.

Thanks,

Jonathan
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 187d056f7ad2..97c7e19e3ec6 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -565,6 +565,13 @@
>  						function = "twsi3";
>  					};
>  				};
> +
> +				adc: adc {
> +					compatible = "marvell,berlin2-adc";
> +					interrupt-parent = <&sic>;
> +					interrupts = <12>, <14>;
> +					interrupt-names = "adc", "tsen";
> +				};
>  			};
>  
>  			sic: interrupt-controller@e000 {
> 

