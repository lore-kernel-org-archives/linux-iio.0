Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2686 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751414AbdB0OIu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 09:08:50 -0500
Subject: Re: [RFC v2 6/7] IIO: add bindings for stm32 DFSDM filter
To: Rob Herring <robh@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-7-git-send-email-arnaud.pouliquen@st.com>
 <20170222164209.62lk5igeymckhimv@rob-hp-laptop>
CC: Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <9a4541e2-03a8-f8ef-d708-ec28e9f5fed0@st.com>
Date: Mon, 27 Feb 2017 15:07:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170222164209.62lk5igeymckhimv@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 02/22/2017 05:42 PM, Rob Herring wrote:
> On Mon, Feb 13, 2017 at 05:38:28PM +0100, Arnaud Pouliquen wrote:
>> Add bindings that describe Digital Filter for Sigma Delta
>> Modulators. DFSDM allows to connect sigma delta
>> modulators and/or PDM microphones.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 125 +++++++++++++++++++++
>>  1 file changed, 125 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
>> new file mode 100644
>> index 0000000..83937cb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
>> @@ -0,0 +1,125 @@
>> +STMicroelectronics STM32 DFSDM ADC device driver
>> +
>> +
>> +STM32 DFSDM ADC is a sigma delta analog-to-digital converter dedicted to
>> +interface external sigma delta modulators to stm32 micro controlers.
>> +it is mainly targeted for:
>> +- Sigma delta modulators ( motor control, metering...)
>> +- PDM microphones ( audio digital microphone)
>> +
>> +It featured with up to 8 serial digital interface (SPI or Manchester) and
>> +up to 4 filters.
>> +
>> +Each instance of the sub-drivers uses one filter instance.
>> +
>> +Contents of a stm32 dfsdmc root node:
>> +-------------------------------------
>> +Required properties:
>> +- compatible: Should be "st,stm32-dfsdm-adc".
>> +- reg: Offset and length of the DFSDM block register set.
>> +- clocks: IP and serial interfaces clocking. Should be set according
>> +		to rcc clock ID and "clock-names".
>> +- clock-names: Input clock name "dfsdm" must be defined,
>> +		"audio" is optional. If defined CLKOUT is based on the audio
>> +		clock, else "dfsdm" is used.
>> +- clocks: Clock for the analog circuitry (common to all ADCs).
>> +- clock-names: Must be "adc".
>> +
>> +Optional properties:
>> +- st,clkout-freq: needed for SPI master mode
>> +		  SPI clock OUT frequency (Hz).This clock must be set according
>> +		  to "clock" property. Frequency must be a multiple of the rcc
>> +		  clock frequency. If not, clkout frequency will not be
>> +		  accurate.
> 
> We already have a standard property to specify the SPI freq.
I found spi-max-frequency. In this case it is a fixed frequency, not a
max... anyway if preferred i will use it.

> 
>> +
>> +Contents of a stm32 DFSDM child nodes:
>> +----------------------------------------
>> +
>> +Required properties:
>> +- compatible: Must be:
>> +	"st,stm32-dfsdm-adc" for sigma delta ADCs
>> +	"st,stm32-dfsdm-pdm" for audio digital microphone.
>> +- reg: Specifies the DFSDM filter instance.
>> +- interrupts: IRQ lines connected to each DFSDM filter instance.
>> +- st,adc-channels:	List of single-ended channels muxed for this ADC.
>> +- st,adc-channel-names:	List of single-ended channels Name.
> 
> Why do you need names?
Name is used to expose an explicit IIO interface to userland (sysfs). So
this field allows to expose an explicit name corresponding to hardware
connected to the DFSDM (pdm microphone, adc for motor control,internal
ADC, ...).
if you prefer I can clean it and use a non explicit hard-coded name (as
stm32-adc.c)

> 
>> +- st,dai-filter-order:  SinC filter order from 0 to 5.
>> +			0: FastSinC
>> +			[1-5]: order 1 to 5.
>> +			For audio purpose it is recommended to use order 3 to 5.
>> +
>> +Required properties for "st,stm32-dfsdm-adc" compatibility:
>> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
>> +- io-channels: from common iio binding. use to pipe external sigma delta
>> +		modulator or internal ADC output to dfsdm channel.
>> +
>> +Required properties for "st,stm32-dfsdm-pdm" compatibility:
>> +- #sound-dai-cells: must be set to 0.
>> +- dma: DMA controller phandle and DMA request line associated to the
>> +		filter instance ( specified by the field "reg")
>> +- dma-names: must be "rx"
>> +
>> +Optional properties:
>> +- st,adc-channel-types:	Single-ended channel input type. Default value is 0.
> 
> How is the default 0 when the values are strings?
oops, miss cleaning from first version...
> 
>> +			- "SPI_R": SPI with data on rising edge (default)
>> +			- "SPI_F": SPI with data on falling edge
>> +			- "MANCH_R": manchester codec, rising edge = logic 0
>> +			- "MANCH_F": manchester codec, falling edge = logic 1
>> +- st,adc-channel-clk-src: Conversion clock source. default value is 1.
> 
> Ditto.
> 
> Perhaps you should be using the clock binding and assigned-clocks 
> property.
This corresponds to bus clocks, is it compatible with clock binding?
or perhaps the issue is that my naming is not very pertinent...
> 
>> +			  - "CLKIN": External SPI clock (CLKIN x)
>> +			  - "CLKOUT": internal SPI clock (CLKOUT) (default)
>> +			  - "CLKOUT_F": internal SPI clock divided by 2 (falling edge).
>> +			  - "CLKOUT_R": internal SPI clock divided by 2 (rising edge).
>> +
>> +- st,adc-alt-channel: Must be defined if Two sigma delta modulator are
>> +			  connected on same SPI input.
>> +			  If not set channel n is connected to SPI input n.
>> +			  If set channel n is connected to SPI input n + 1.
>> +
>> +- st,filter0-sync: Set to 1 to synchronize with DFSDM filter instance 0.
>> +		   to used for multi microphone synchronization.
> 
> Is there an instance 1?  If not, drop the 0. If you need to expand to 
> multiple instances, you can have multiple values.
Yes there is an instance 0. We can synchronize all the filter output on
filter instance 0. This is possible only for instance 0. , As example
this could be useful for audio stereo recording.
> 
>> +
>> +Example of a sigma delta adc purpose:
>> +	ads1202: simple_sd_adc@0 {
>> +		compatible = "sd-modulator";
>> +		#io-channel-cells = <1>;
>> +		status = "okay";
>> +	};
>> +	dfsdm: dfsdm@40017000 {
>> +		compatible = "st,stm32h7-dfsdm";
>> +		reg = <0x40017000 0x400>;
>> +		clocks = <&timer_clk>;
>> +		clock-names = "dfsdm";
>> +
>> +		dfsdm_adc0: dfsdm-adc0@0 {
>> +			compatible = "st,stm32-dfsdm-adc";
>> +			#io-channel-cells = <1>;
>> +			reg = <0>;
>> +			interrupts = <110>;
>> +			st,adc-channels = <0>;
> 
> Does reg provide the same thing?
reg represents the instance of the filter ( 4 instances)
Channels ( 8 instances) are linked to the input interface.
we can connect one or several channels to one filter.
> 
>> +			st,adc-channel-names = "in0";
>> +			st,adc-channel-types = "SPI_R";
>> +			st,adc-channel-clk-src = "CLKOUT";
>> +			io-channels = <&ads1202 0>;
>> +	};
>> +
>> +Example of a pdm microphone purpose:
>> +	dfsdm: dfsdm@40017000 {
>> +		compatible = "st,stm32h7-dfsdm";
>> +		reg = <0x40017000 0x400>;
>> +		clocks = <&timer_clk>;
>> +		clock-names = "dfsdm";
>> +
>> +		dfsdm_pdm0: dfsdm-pdm@0 {
>> +			compatible = "st,stm32-dfsdm-pdm";
>> +			#sound-dai-cells = <0>;
>> +			reg = <0>;
>> +			interrupts = <110>;
>> +			dmas = <&dmamux1 102 0x400 0x00>;
>> +			dma-names = "rx";
>> +			st,adc-channels = <0>;
>> +			st,adc-channel-names = "pdm1";
>> +			st,adc-channel-types = "SPI_R";
>> +			st,adc-channel-clk-src = "CLKOUT";
>> +		};
>> +	}
>> -- 
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
