Return-Path: <naveenkrishna.ch@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1364298777-8178-1-git-send-email-sachin.kamat@linaro.org>
References: <1364298777-8178-1-git-send-email-sachin.kamat@linaro.org>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Tue, 26 Mar 2013 16:55:13 -0700
Message-ID: <CAHfPSqCyn=Q_zH11=pRjP3rY69xbHDnRSwBmiA4fGmz62hV-Vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: exynos-adc: Fix typo in DT documentation
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, jic23@kernel.org,
	rob.herring@calxeda.com, grant.likely@secretlab.ca, linux-iio@vger.kernel.org,
	patches@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 26 March 2013 04:52, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Fixes some typos in the documentation of exynos-adc.txt.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> index 05e9d95..1fc744b 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> @@ -1,6 +1,6 @@
>  Samsung Exynos Analog to Digital Converter bindings
>
> -This devicetree binding are for the new adc driver written fori
> +The devicetree bindings are for the new ADC driver written for
Thanks for the correction
>  Exynos4 and upward SoCs from Samsung.
>
>  New driver handles the following
> @@ -49,4 +49,4 @@ adc@12D10000 {
>  };
>
>  Note: Does not apply to ADC driver under arch/arm/plat-samsung/
> -Note: The child node can be added under the adc node or seperately.
> +Note: The child node can be added under the adc node or separately.
Sorry, but i cant see whats the difference here.
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Shine bright,
(: Nav :)
