Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f68.google.com ([74.125.82.68]:34968 "EHLO
	mail-wg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbbERQGx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 12:06:53 -0400
Message-ID: <555A0E19.10807@gmail.com>
Date: Mon, 18 May 2015 18:06:49 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Antoine Tenart <antoine.tenart@free-electrons.com>,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
CC: zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] ARM: berlin: add an ADC node for the BG2Q
References: <1431940760-23896-1-git-send-email-antoine.tenart@free-electrons.com> <1431940760-23896-4-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1431940760-23896-4-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18.05.2015 11:19, Antoine Tenart wrote:
> This patch adds the ADC node for the Berlin BG2Q, using the newly added
> Berlin IIO ADC driver.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 187d056f7ad2..97c7e19e3ec6 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -565,6 +565,13 @@
>   						function = "twsi3";
>   					};
>   				};
> +
> +				adc: adc {
> +					compatible = "marvell,berlin2-adc";
> +					interrupt-parent = <&sic>;

Antoine,

a side note on the interrupt-parent property above:

The parent simple-bus node already contains that property. If you
remove the property here, don't the interrupt routines go up the
hierarchy until they find an interrupt-parent set?

So, is it safe to get rid of the extra interrupt-parent property on
the adc node?

Sebastian

> +					interrupts = <12>, <14>;
> +					interrupt-names = "adc", "tsen";
> +				};
>   			};
>
>   			sic: interrupt-controller@e000 {
>

