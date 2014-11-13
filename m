Return-Path: <Ezequiel.Garcia@imgtec.com>
Message-ID: <5464F5EE.70602@imgtec.com>
Date: Thu, 13 Nov 2014 15:18:22 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
CC: Andrew Bresticker <abrestic@chromium.org>, James Hartley
	<james.hartley@imgtec.com>, Lars-Peter Clausen <lars@metafoo.de>, "Jonathan
 Cameron" <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	<Naidu.Tellapati@imgtec.com>, Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH v3 2/3] DT: iio: adc: Add CC_10001 binding documentation
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com> <1415888044-16635-3-git-send-email-ezequiel.garcia@imgtec.com> <CAL_JsqK=F36EweJyWKemYn=5TbzKWv3xLFfhbfQ1bvQKR6tQLQ@mail.gmail.com>
In-Reply-To: <CAL_JsqK=F36EweJyWKemYn=5TbzKWv3xLFfhbfQ1bvQKR6tQLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>



On 11/13/2014 11:37 AM, Rob Herring wrote:
> On Thu, Nov 13, 2014 at 8:13 AM, Ezequiel Garcia
> <ezequiel.garcia@imgtec.com> wrote:
>> From: Phani Movva <Phani.Movva@imgtec.com>
>>
>> Add the devicetree binding document for Cosmic Circuits 10001 ADC device.
>>
>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> [Ezequiel: minor style cleaning]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> ---
>>  .../devicetree/bindings/iio/adc/cc10001_adc.txt    | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
>> new file mode 100644
>> index 0000000..1533c19
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
>> @@ -0,0 +1,22 @@
>> +* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
>> +
>> +Required properties:
>> +  - compatible: Should be "cosmic,10001-adc"
>> +  - reg: Should contain adc registers location and length.
>> +  - clock-names: Should contain "adc".
>> +  - clocks: phandles to input clocks.
> 
> You need to be explicit about how many clocks and their order. From
> the names, I'm guessing it is only 1.
> 

Will fix.

Thanks!
-- 
Ezequiel
