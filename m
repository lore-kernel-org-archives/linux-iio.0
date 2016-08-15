Return-Path: <wxt@rock-chips.com>
Message-ID: <57B20584.3090502@rock-chips.com>
Date: Tue, 16 Aug 2016 02:10:12 +0800
From: Caesar Wang <wxt@rock-chips.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, heiko@sntech.de
CC: Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dianders@chromium.org, linux-rockchip@lists.infradead.org,
 robh+dt@kernel.org, john@metanate.com,
 linux-arm-kernel@lists.infradead.org, linux@roeck-us.net
Subject: Re: [PATCH v3 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com> <5b6602f2-23f9-e5e5-8479-cddd365f7e71@kernel.org>
In-Reply-To: <5b6602f2-23f9-e5e5-8479-cddd365f7e71@kernel.org>
Content-Type: multipart/alternative;
 boundary="------------050008070903070007060500"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050008070903070007060500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


On 2016?08?16? 01:41, Jonathan Cameron wrote:
> On 27/07/16 15:24, Caesar Wang wrote:
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: linux-iio@vger.kernel.org
>> Cc: linux-rockchip@lists.infradead.org
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
> Hi
>
> Patch is fine (I'll fix up the wording issue) however...
>
> I'm not clear on the severity of the issue. Is this something
> we should be pushing for stable?

I think that should be pushing for stable, since the common isssue for 
the ADC is initially enabled on loader,
and only disabled after the first read.

cat /sys/class/hwmon/hwmon1/device/temp1_input
cat: /sys/class/hwmon/hwmon1/device/temp1_input: Connection timed out

The kernel log shows:

[ 32.209451] read channel() error: -110
..

Also, for my experience. Some other reasons caused the adc (controller) 
glitch for the kernel side.

-
Caesar

> Jonathan
>> ---
>>
>> Changes in v3:
>> - %s/devm_reset_control_get_optional()/devm_reset_control_get()
>> - add Guente's test tag.
>>
>> Changes in v2:
>> - Make the reset as an optional property, since it should work
>> with old devicetrees as well.
>>
>>   .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++
>>   drivers/iio/adc/Kconfig                            |  1 +
>>   drivers/iio/adc/rockchip_saradc.c                  | 30 ++++++++++++++++++++++
>>   3 files changed, 38 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> index bf99e2f..205593f 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> @@ -16,6 +16,11 @@ Required properties:
>>   - vref-supply: The regulator supply ADC reference voltage.
>>   - #io-channel-cells: Should be 1, see ../iio-bindings.txt
>>   
>> +Optional properties:
>> +- resets: Must contain an entry for each entry in reset-names if need support
>> +	  this option. See ../reset/reset.txt for details.
>> +- reset-names: Must include the name "saradc-apb".
>> +
>>   Example:
>>   	saradc: saradc@2006c000 {
>>   		compatible = "rockchip,saradc";
>> @@ -23,6 +28,8 @@ Example:
>>   		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>>   		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>>   		clock-names = "saradc", "apb_pclk";
>> +		resets = <&cru SRST_SARADC>;
>> +		reset-names = "saradc-apb";
>>   		#io-channel-cells = <1>;
>>   		vref-supply = <&vcc18>;
>>   	};
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 1de31bd..7675772 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -389,6 +389,7 @@ config QCOM_SPMI_VADC
>>   config ROCKCHIP_SARADC
>>   	tristate "Rockchip SARADC driver"
>>   	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>> +	depends on RESET_CONTROLLER
>>   	help
>>   	  Say yes here to build support for the SARADC found in SoCs from
>>   	  Rockchip.
>> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
>> index f9ad6c2..85d7012 100644
>> --- a/drivers/iio/adc/rockchip_saradc.c
>> +++ b/drivers/iio/adc/rockchip_saradc.c
>> @@ -21,6 +21,8 @@
>>   #include <linux/of_device.h>
>>   #include <linux/clk.h>
>>   #include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/reset.h>
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/iio/iio.h>
>>   
>> @@ -53,6 +55,7 @@ struct rockchip_saradc {
>>   	struct clk		*clk;
>>   	struct completion	completion;
>>   	struct regulator	*vref;
>> +	struct reset_control	*reset;
>>   	const struct rockchip_saradc_data *data;
>>   	u16			last_val;
>>   };
>> @@ -190,6 +193,16 @@ static const struct of_device_id rockchip_saradc_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
>>   
>> +/**
>> + * Reset SARADC Controller.
>> + */
>> +static void rockchip_saradc_reset_controller(struct reset_control *reset)
>> +{
>> +	reset_control_assert(reset);
>> +	usleep_range(10, 20);
>> +	reset_control_deassert(reset);
>> +}
>> +
>>   static int rockchip_saradc_probe(struct platform_device *pdev)
>>   {
>>   	struct rockchip_saradc *info = NULL;
>> @@ -218,6 +231,20 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>   	if (IS_ERR(info->regs))
>>   		return PTR_ERR(info->regs);
>>   
>> +	/*
>> +	 * The reset should be an optional property, as it should work
>> +	 * with old devicetrees as well
>> +	 */
>> +	info->reset = devm_reset_control_get(&pdev->dev, "saradc-apb");
>> +	if (IS_ERR(info->reset)) {
>> +		ret = PTR_ERR(info->reset);
>> +		if (ret != -ENOENT)
>> +			return ret;
>> +
>> +		dev_dbg(&pdev->dev, "no reset control found\n");
>> +		info->reset = NULL;
>> +	}
>> +
>>   	init_completion(&info->completion);
>>   
>>   	irq = platform_get_irq(pdev, 0);
>> @@ -252,6 +279,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>>   		return PTR_ERR(info->vref);
>>   	}
>>   
>> +	if (info->reset)
>> +		rockchip_saradc_reset_controller(info->reset);
>> +
>>   	/*
>>   	 * Use a default value for the converter clock.
>>   	 * This may become user-configurable in the future.
>>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
caesar wang | software engineer | wxt@rock-chip.com


--------------050008070903070007060500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 2016&#24180;08&#26376;16&#26085; 01:41, Jonathan Cameron
      wrote:<br>
    </div>
    <blockquote
      cite="mid:5b6602f2-23f9-e5e5-8479-cddd365f7e71@kernel.org"
      type="cite">
      <pre wrap="">On 27/07/16 15:24, Caesar Wang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">SARADC controller needs to be reset before programming it, otherwise
it will not function properly.

Signed-off-by: Caesar Wang <a class="moz-txt-link-rfc2396E" href="mailto:wxt@rock-chips.com">&lt;wxt@rock-chips.com&gt;</a>
Cc: Jonathan Cameron <a class="moz-txt-link-rfc2396E" href="mailto:jic23@kernel.org">&lt;jic23@kernel.org&gt;</a>
Cc: Heiko Stuebner <a class="moz-txt-link-rfc2396E" href="mailto:heiko@sntech.de">&lt;heiko@sntech.de&gt;</a>
Cc: Rob Herring <a class="moz-txt-link-rfc2396E" href="mailto:robh+dt@kernel.org">&lt;robh+dt@kernel.org&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:linux-iio@vger.kernel.org">linux-iio@vger.kernel.org</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:linux-rockchip@lists.infradead.org">linux-rockchip@lists.infradead.org</a>
Tested-by: Guenter Roeck <a class="moz-txt-link-rfc2396E" href="mailto:linux@roeck-us.net">&lt;linux@roeck-us.net&gt;</a>

</pre>
      </blockquote>
      <pre wrap="">Hi

Patch is fine (I'll fix up the wording issue) however...

I'm not clear on the severity of the issue. Is this something
we should be pushing for stable?
</pre>
    </blockquote>
    <small><br>
      I think that should be pushing for stable, since the common isssue
      for the ADC is initially enabled on loader,<br>
      and only disabled after the first read.<br>
      <br>
      cat /sys/class/hwmon/hwmon1/device/temp1_input<br>
      cat: /sys/class/hwmon/hwmon1/device/temp1_input: Connection timed
      out<br>
      <br>
      The kernel log shows:<br>
      <br>
      [ 32.209451] read channel() error: -110<br>
      ..<br>
      <br>
      Also, for my experience. Some other reasons caused the adc
      (controller) glitch for the kernel side.</small><br>
    <br>
    -<br>
    <small>Caesar</small><br>
    <br>
    <blockquote
      cite="mid:5b6602f2-23f9-e5e5-8479-cddd365f7e71@kernel.org"
      type="cite">
      <pre wrap="">
Jonathan
</pre>
      <blockquote type="cite">
        <pre wrap="">---

Changes in v3:
- %s/devm_reset_control_get_optional()/devm_reset_control_get()
- add Guente's test tag.

Changes in v2:
- Make the reset as an optional property, since it should work
with old devicetrees as well.

 .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++
 drivers/iio/adc/Kconfig                            |  1 +
 drivers/iio/adc/rockchip_saradc.c                  | 30 ++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
index bf99e2f..205593f 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
@@ -16,6 +16,11 @@ Required properties:
 - vref-supply: The regulator supply ADC reference voltage.
 - #io-channel-cells: Should be 1, see ../iio-bindings.txt
 
+Optional properties:
+- resets: Must contain an entry for each entry in reset-names if need support
+	  this option. See ../reset/reset.txt for details.
+- reset-names: Must include the name "saradc-apb".
+
 Example:
 	saradc: saradc@2006c000 {
 		compatible = "rockchip,saradc";
@@ -23,6 +28,8 @@ Example:
 		interrupts = &lt;GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH&gt;;
 		clocks = &lt;&amp;cru SCLK_SARADC&gt;, &lt;&amp;cru PCLK_SARADC&gt;;
 		clock-names = "saradc", "apb_pclk";
+		resets = &lt;&amp;cru SRST_SARADC&gt;;
+		reset-names = "saradc-apb";
 		#io-channel-cells = &lt;1&gt;;
 		vref-supply = &lt;&amp;vcc18&gt;;
 	};
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1de31bd..7675772 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -389,6 +389,7 @@ config QCOM_SPMI_VADC
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM &amp;&amp; COMPILE_TEST)
+	depends on RESET_CONTROLLER
 	help
 	  Say yes here to build support for the SARADC found in SoCs from
 	  Rockchip.
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index f9ad6c2..85d7012 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -21,6 +21,8 @@
 #include &lt;linux/of_device.h&gt;
 #include &lt;linux/clk.h&gt;
 #include &lt;linux/completion.h&gt;
+#include &lt;linux/delay.h&gt;
+#include &lt;linux/reset.h&gt;
 #include &lt;linux/regulator/consumer.h&gt;
 #include &lt;linux/iio/iio.h&gt;
 
@@ -53,6 +55,7 @@ struct rockchip_saradc {
 	struct clk		*clk;
 	struct completion	completion;
 	struct regulator	*vref;
+	struct reset_control	*reset;
 	const struct rockchip_saradc_data *data;
 	u16			last_val;
 };
@@ -190,6 +193,16 @@ static const struct of_device_id rockchip_saradc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
 
+/**
+ * Reset SARADC Controller.
+ */
+static void rockchip_saradc_reset_controller(struct reset_control *reset)
+{
+	reset_control_assert(reset);
+	usleep_range(10, 20);
+	reset_control_deassert(reset);
+}
+
 static int rockchip_saradc_probe(struct platform_device *pdev)
 {
 	struct rockchip_saradc *info = NULL;
@@ -218,6 +231,20 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (IS_ERR(info-&gt;regs))
 		return PTR_ERR(info-&gt;regs);
 
+	/*
+	 * The reset should be an optional property, as it should work
+	 * with old devicetrees as well
+	 */
+	info-&gt;reset = devm_reset_control_get(&amp;pdev-&gt;dev, "saradc-apb");
+	if (IS_ERR(info-&gt;reset)) {
+		ret = PTR_ERR(info-&gt;reset);
+		if (ret != -ENOENT)
+			return ret;
+
+		dev_dbg(&amp;pdev-&gt;dev, "no reset control found\n");
+		info-&gt;reset = NULL;
+	}
+
 	init_completion(&amp;info-&gt;completion);
 
 	irq = platform_get_irq(pdev, 0);
@@ -252,6 +279,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		return PTR_ERR(info-&gt;vref);
 	}
 
+	if (info-&gt;reset)
+		rockchip_saradc_reset_controller(info-&gt;reset);
+
 	/*
 	 * Use a default value for the converter clock.
 	 * This may become user-configurable in the future.

</pre>
      </blockquote>
      <pre wrap="">

_______________________________________________
Linux-rockchip mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linux-rockchip@lists.infradead.org">Linux-rockchip@lists.infradead.org</a>
<a class="moz-txt-link-freetext" href="http://lists.infradead.org/mailman/listinfo/linux-rockchip">http://lists.infradead.org/mailman/listinfo/linux-rockchip</a>
</pre>
    </blockquote>
    <br>
    <br>
    <pre class="moz-signature" cols="72">-- 
caesar wang | software engineer | <a class="moz-txt-link-abbreviated" href="mailto:wxt@rock-chip.com">wxt@rock-chip.com</a> </pre>
  </body>
</html>

--------------050008070903070007060500--
