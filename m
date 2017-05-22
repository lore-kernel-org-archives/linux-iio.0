Return-Path: <SRS0=iYD7=44=cogentembedded.com=vladimir.barinov@kernel.org>
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeff White <Jeff.White@zii.aero>, Chris Healy <Chris.Healy@zii.aero>
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Message-ID: <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
Date: Mon, 22 May 2017 21:27:31 +0300
MIME-Version: 1.0
In-Reply-To: <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
Content-Type: multipart/alternative;
 boundary="------------17FCFFE487971508E71A0F02"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------17FCFFE487971508E71A0F02
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nikita,

On 19.05.2017 17:48, Nikita Yushchenko wrote:
> Reset GPIO is active low.
>
> Currently driver uses gpiod_set_value(1) to clean reset, which depends
> on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.
>
> This fixes driver to use _raw version of gpiod_set_value() to enforce
> active-low semantics despite of what's written in device tree. Allowing
> device tree to override that only opens possibility for errors and does
> not add any value.
>
> Additionally, use _cansleep version to make things work with i2c-gpio
> and other sleeping gpio drivers.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>   drivers/iio/adc/hi8435.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index d09cb6ff8044..ab59969b7c49 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -476,13 +476,15 @@ static int hi8435_probe(struct spi_device *spi)
>   	priv->spi = spi;
>   
>   	reset_gpio = devm_gpiod_get(&spi->dev, NULL, GPIOD_OUT_LOW);
> -	if (IS_ERR(reset_gpio)) {
> -		/* chip s/w reset if h/w reset failed */
> +	if (!IS_ERR(reset_gpio)) {
> +		/* need >=100ns low pulse to reset chip */
> +		gpiod_set_raw_value_cansleep(reset_gpio, 0);
> +		udelay(1);
> +		gpiod_set_raw_value_cansleep(reset_gpio, 1);
> +	} else {
> +		/* s/w reset chip if h/w reset is not available */
>   		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
>   		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
> -	} else {
> -		udelay(5);
> -		gpiod_set_value(reset_gpio, 1);
>   	}
>   
>   	spi_set_drvdata(spi, idev);

The reset gpio comes from platform hence it should be handled by DTS.

In driver the gpio should not be raw.

Even the hi8435 is active low but platform may invert signal (f.e. by 
adding trigger on the circuit path).


I'd suggest to update documentation 
Documentation/devicetree/bindings/iio/adc/hi8435.txt:

"

Optional properties:
  - gpios: GPIO used for controlling the reset pin (*active low*)

Example:
sensor@0 {
         compatible = "holt,hi8435";
         reg = <0>;
         gpios = <&gpio6 1 *GPIO_ACTIVE_LOW*>;
"

Regards,

Vladimir




--------------17FCFFE487971508E71A0F02
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Nikita,<br>
      <br>
      On 19.05.2017 17:48, Nikita Yushchenko wrote:<br>
    </div>
    <blockquote
      cite="mid:20170519144802.14427-4-nikita.yoush@cogentembedded.com"
      type="cite">
      <pre wrap="">Reset GPIO is active low.

Currently driver uses gpiod_set_value(1) to clean reset, which depends
on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.

This fixes driver to use _raw version of gpiod_set_value() to enforce
active-low semantics despite of what's written in device tree. Allowing
device tree to override that only opens possibility for errors and does
not add any value.

Additionally, use _cansleep version to make things work with i2c-gpio
and other sleeping gpio drivers.

Signed-off-by: Nikita Yushchenko <a class="moz-txt-link-rfc2396E" href="mailto:nikita.yoush@cogentembedded.com">&lt;nikita.yoush@cogentembedded.com&gt;</a>
---
 drivers/iio/adc/hi8435.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index d09cb6ff8044..ab59969b7c49 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -476,13 +476,15 @@ static int hi8435_probe(struct spi_device *spi)
 	priv-&gt;spi = spi;
 
 	reset_gpio = devm_gpiod_get(&amp;spi-&gt;dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio)) {
-		/* chip s/w reset if h/w reset failed */
+	if (!IS_ERR(reset_gpio)) {
+		/* need &gt;=100ns low pulse to reset chip */
+		gpiod_set_raw_value_cansleep(reset_gpio, 0);
+		udelay(1);
+		gpiod_set_raw_value_cansleep(reset_gpio, 1);
+	} else {
+		/* s/w reset chip if h/w reset is not available */
 		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
 		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
-	} else {
-		udelay(5);
-		gpiod_set_value(reset_gpio, 1);
 	}
 
 	spi_set_drvdata(spi, idev);
</pre>
    </blockquote>
    <p>The reset gpio comes from platform hence it should be handled by
      DTS.</p>
    <p>In driver the gpio should not be raw.<br>
    </p>
    <p>Even the hi8435 is active low but platform may invert signal
      (f.e. by adding trigger on the circuit path).</p>
    <p><br>
    </p>
    <p>I'd suggest to update documentation
      Documentation/devicetree/bindings/iio/adc/hi8435.txt:</p>
    <p>"<br>
    </p>
    <p>Optional properties:<br>
       - gpios: GPIO used for controlling the reset pin (<b>active low</b>)<br>
      <br>
      Example:<br>
      sensor@0 {<br>
              compatible = "holt,hi8435";<br>
              reg = &lt;0&gt;;<br>
              gpios = &lt;&amp;gpio6 1 <b>GPIO_ACTIVE_LOW</b>&gt;;<br>
      "</p>
    <p>Regards,</p>
    <p>Vladimir<br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------17FCFFE487971508E71A0F02--
