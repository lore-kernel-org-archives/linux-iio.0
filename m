Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <73CF94B0-47DF-493D-8F2A-0BC26EB4DEBB@kernel.org>
References: <1436754043-6232-1-git-send-email-mranostay@gmail.com>
	<1436754043-6232-2-git-send-email-mranostay@gmail.com>
	<73CF94B0-47DF-493D-8F2A-0BC26EB4DEBB@kernel.org>
Date: Thu, 16 Jul 2015 19:55:52 -0700
Message-ID: <CAKzfze8w6PDT9oWGCSbSK70K+e3ciijdJv+AwKxwbc=uQ-iHvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: light: DT binding docs for APDS9960 driver
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Ok will fix in v4. Please review the 2/2 patch when you get a chance :)

On Mon, Jul 13, 2015 at 2:42 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> On 13 July 2015 03:20:42 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>>Document compatible string, and required DT properties for APDS9960
>>chipset driver.
>>
>>Reviewed-by: Marek Vasut <marex@denx.de>
>>Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>---
>>.../devicetree/bindings/iio/light/apds9960.txt        | 19
>>+++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>create mode 100644
>>Documentation/devicetree/bindings/iio/light/apds9960.txt
>>
>>diff --git a/Documentation/devicetree/bindings/iio/light/apds9960.txt
>>b/Documentation/devicetree/bindings/iio/light/apds9960.txt
>>new file mode 100644
>>index 0000000..7a47d28
>>--- /dev/null
>>+++ b/Documentation/devicetree/bindings/iio/light/apds9960.txt
>>@@ -0,0 +1,19 @@
>>+* Avago APDS9960 gesture/RGB/ALS/proximity sensor
>>+
>>+http://www.avagotech.com/docs/AV02-4191EN
>>+
>>+Required properties:
>>+
>>+  - compatible: must be "avago,apds9960"
>>+  - reg: the I2c address of the sensor
>>+  - interrupt-parent: should be the phandle for the interrupt
>>controller
>>+  - interrupts: interrupt mapping for GPIO IRQ
> Usual trick here is to cross reference the interrupt bindings doc to allow all the
>  complexity without duplicating docs too much.
>>+
>>+Example:
>>+
>>+apds9960@39 {
>>+      compatible = "avago,apds9960";
>>+      reg = <0x39>;
>>+      interrupt-parent = <&gpio1>;
>>+      interrupts = <16 1>;
>>+};
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
