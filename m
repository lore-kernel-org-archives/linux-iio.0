Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46978 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbEDQd4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:33:56 -0400
Message-ID: <55479F64.4010802@kernel.org>
Date: Mon, 04 May 2015 17:33:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 08/10] ARM: ux500: fix lsm303dlh magnetometer compat string
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org> <1430399755-26475-8-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-8-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/04/15 14:15, Linus Walleij wrote:
> The magnetometer found on the Ux500 TVK and Snowball boards
> is a LSM303DLH not a LSM303DLM, small differences but still
> different. Put in the right compatible strings and things start
> working smoothly.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Jonathan: This will be merged through the ARM SoC tree if
> found OK. Do not merge to the IIO tree.
Sure.  I'm going to ignore it completely ;)
> ---
>  arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 4 ++--
>  arch/arm/boot/dts/ste-snowball.dts         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
> index 062c6aae3afa..0eeb4d4b5202 100644
> --- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
> +++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
> @@ -100,9 +100,9 @@
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&accel_tvk_mode>;
>  			};
> -			lsm303dlm@1e {
> +			lsm303dlh@1e {
>  				/* Magnetometer */
> -				compatible = "st,lsm303dlm-magn";
> +				compatible = "st,lsm303dlh-magn";
>  				reg = <0x1e>;
>  				vdd-supply = <&ab8500_ldo_aux1_reg>;
>  				vddio-supply = <&db8500_vsmps2_reg>;
> diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> index 1bc84ebdccaa..e2a7417777f9 100644
> --- a/arch/arm/boot/dts/ste-snowball.dts
> +++ b/arch/arm/boot/dts/ste-snowball.dts
> @@ -263,9 +263,9 @@
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&accel_snowball_mode>;
>  			};
> -			lsm303dlm@1e {
> +			lsm303dlh@1e {
>  				/* Magnetometer */
> -				compatible = "st,lsm303dlm-magn";
> +				compatible = "st,lsm303dlh-magn";
>  				reg = <0x1e>;
>  				vdd-supply = <&ab8500_ldo_aux1_reg>;
>  				vddio-supply = <&db8500_vsmps2_reg>;
> 

