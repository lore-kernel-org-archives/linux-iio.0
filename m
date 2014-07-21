Return-Path: <cw00.choi@samsung.com>
Message-id: <53CCCB20.50802@samsung.com>
Date: Mon, 21 Jul 2014 17:11:12 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, jic23@kernel.org,
 ch.naveen@samsung.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
 kgene.kim@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 linux-iio@vger.kernel.org, t.figa@samsung.com, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com,
 robh+dt@kernel.org, galak@codeaurora.org
Subject: Re: [PATCHv7 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and
 code clean
References: <1405909068-22539-1-git-send-email-cw00.choi@samsung.com>
 <14522743.f6oFhEQVv4@wuerfel>
In-reply-to: <14522743.f6oFhEQVv4@wuerfel>
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/21/2014 04:38 PM, Arnd Bergmann wrote:
> On Monday 21 July 2014 11:17:44 Chanwoo Choi wrote:
>>
>> This patchset support Exynos3250 ADC (Analog Digital Converter) because
>> Exynos3250 has additional special clock for ADC IP.
>>
>> Changes from v6:
>> - Use "exynos3250-adc" compatible string instead of "exynos3250-adc-v2"
>> - Use "sclk" clock name instead of "sclk_adc"
>> - Remove un-necessary macro for exyno-adc-data-v2 structure.
>> - Remove '(void *)' cast and mark the exynos-adc-data structure as 'const'
>> - Change the number of ADC channels (Exynos3250 has only two channels for ADC)
>>
> 
> Looks good to me. Two small requests:
> 
> a) if you don't mind, can you add my patch (1/2) to add support for s3c64xx to
>    your series, adding your Signed-off-by line in addition to mine? I think
>    that one was noncontroversial, while the second patch (2/2) need some more
>    work to address the comments and do testing.

OK, I'll add this patch.
But, I have a question.

Your patch add following compatible string.
"s3c64100-adc" is right?

 static const struct of_device_id exynos_adc_match[] = {
 	{
+		.compatible = "samsung,s3c64100-adc",
+		.data = &exynos_adc_s3c64xx_data,
+	}, {

> 
> b) For the "compatible" string, I think it makes sense to set a fallback to
>    "samsung,exynos-adc-v2" in the case for exynos3250, making the DT
>    representation
> 
> 	compatible = "samsung,exynos3250-adc", "samsung,exynos-adc-v2";
> 
>    It's not entirely compatible because of the addition of the clock, but
>    since the register layout is the same, I think it still make sense.

OK, I'll add it in exynos3250.dtsi as following:

                adc: adc@126C0000 {
-                       compatible = "samsung,exynos-adc-v3";
+                       compatible = "samsung,exynos3250-adc",
+                                    "samsung,exynos-adc-v2";
                        reg = <0x126C0000 0x100>, <0x10020718 0x4>;
                        interrupts = <0 137 0>;
-                       clock-names = "adc", "sclk_tsadc";
+                       clock-names = "adc", "sclk";
                        clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
                        #io-channel-cells = <1>;
                        io-channel-ranges;

Thanks,
Chanwoo Choi

> 
> Thanks.
> 
> For the entire series,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
