Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35432 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbbHaPi2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 11:38:28 -0400
MIME-Version: 1.0
In-Reply-To: <55DF71A5.1010705@kernel.org>
References: <1440065534-8601-1-git-send-email-adriana.reus@intel.com>
 <1440065534-8601-3-git-send-email-adriana.reus@intel.com> <55DF71A5.1010705@kernel.org>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 31 Aug 2015 10:38:08 -0500
Message-ID: <CAL_Jsq+uvhaE77yXqKGXF_p6gAV5F+rPwnT547ym-o23=3fR+w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] devicetree: Add documentation for UPISEMI us5182d
 ALS and Proximity sensor
To: Jonathan Cameron <jic23@kernel.org>,
	Adriana Reus <adriana.reus@intel.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, daniel.baluta@intel.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 27, 2015 at 3:23 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 20/08/15 11:12, Adriana Reus wrote:
>> Added entries in i2c/vendor-prefixes for the us5182d als and proximity sensor.
>> Also added a documentation file for this sensor's properties.
>>
>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> This isn't that trivial so I'd like some device tree maintainer
> input if possible.

It seems fairly reasonable to me. Would other ALS or proximity sensors
need similar properties?

> For now I've backed out the driver from my tree (given timing we have
> loads of time to sort this out!)
>
> Anyhow, anyone device tree related able to take a look at this.
>
> Adriana, btw these should be cc'd to the device tree maintainers in
> the first place (now added).
>
> Jonathan
>> ---
>>  .../devicetree/bindings/iio/light/us5182d.txt      | 23 ++++++++++++++++++++++
>>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>  2 files changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>> new file mode 100644
>> index 0000000..7785c56
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>> @@ -0,0 +1,23 @@
>> +* UPISEMI us5182d I2C ALS and Proximity sensor
>> +
>> +Required properties:
>> +- compatible: must be "upisemi,usd5182"
>> +- reg: the I2C address of the device
>> +
>> +Optional properties:

Do you expect certain defaults if not present? Some description of how
all these values are determined would be useful.


>> +- upisemi,glass-coef: glass attenuation factor
>> +- upisemi,dark-ths: array of thresholds (adc counts) corresponding to every scale

What is the size of the array and valid range of values?

Be specific this is 16-bit property.

>> +- upisemi,upper-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light > threshold
>> +- upisemi,lower-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light < threshold

Be specific this is an 8-bit property.

>> +
>> +Example:
>> +
>> +    usd5182@39 {
>> +                compatible = "upisemi,usd5182";
>> +                reg = <0x39>;
>> +                upisemi,glass-coef = < 1000 >;
>> +                upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
>> +                upisemi,upper-dark-gain = /bits/ 8 <0x00>;
>> +                upisemi,lower-dark-gain = /bits/ 8 <0x16>;
>> +    };
>> +
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index d444757..5b40bab 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -211,6 +211,7 @@ toshiba   Toshiba Corporation
>>  toumaz       Toumaz
>>  tplink       TP-LINK Technologies Co., Ltd.
>>  truly        Truly Semiconductors Limited
>> +upisemi      uPI Semiconductor Corp.
>>  usi  Universal Scientific Industrial Co., Ltd.
>>  v3   V3 Semiconductor
>>  variscite    Variscite Ltd.
>>
>
