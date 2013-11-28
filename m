Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:36340
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753959Ab3K1B0o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Nov 2013 20:26:44 -0500
From: Fugang Duan <fugang.duan@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	Frank Li <Frank.Li@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc
 driver
Date: Thu, 28 Nov 2013 01:25:55 +0000
Message-ID: <9848F2DB572E5649BA045B288BE08FBE0189C154@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1385463394-11157-1-git-send-email-B38611@freescale.com>
 <1385463394-11157-3-git-send-email-B38611@freescale.com>
 <20131126142534.GB5402@e106331-lin.cambridge.arm.com>
 <9848F2DB572E5649BA045B288BE08FBE01898D02@039-SN2MPN1-023.039d.mgd.msft.net>
 <20131127141803.GA27879@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131127141803.GA27879@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Mark Rutland [mailto:mark.rutland@arm.com]
Data: Wednesday, November 27, 2013 10:18 PM

>To: Duan Fugang-B38611
>Cc: jic23@kernel.org; sachin.kamat@linaro.org; devicetree@vger.kernel.org;
>shawn.guo@linaro.org; Li Frank-B20596; linux-iio@vger.kernel.org
>Subject: Re: [PATCH v3 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
>
>On Wed, Nov 27, 2013 at 05:37:24AM +0000, Fugang Duan wrote:
>> From: Mark Rutland <mark.rutland@arm.com>
>> Data: Tuesday, November 26, 2013 10:26 PM
>>
>> >To: Duan Fugang-B38611
>> >Cc: jic23@kernel.org; sachin.kamat@linaro.org;
>> >devicetree@vger.kernel.org; shawn.guo@linaro.org; Li Frank-B20596;
>> >linux-iio@vger.kernel.org
>> >Subject: Re: [PATCH v3 2/3] iio:adc:imx: add Freescale Vybrid vf610
>> >adc driver
>> >
>> >On Tue, Nov 26, 2013 at 10:56:33AM +0000, Fugang Duan wrote:
>> >> Add Freescale Vybrid vf610 adc driver. The driver only support ADC
>> >> software trigger.
>> >>
>> >> Signed-off-by: Fugang Duan <B38611@freescale.com>
>> >> ---
>> >>  drivers/iio/adc/Kconfig     |   11 +
>> >>  drivers/iio/adc/Makefile    |    1 +
>> >>  drivers/iio/adc/vf610_adc.c |  744
>> >> +++++++++++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 756 insertions(+), 0 deletions(-)
>> >
>> >[...]
>> >
>> >> +static void vf610_adc_cfg_of_init(struct vf610_adc *info) {
>> >> +       struct device_node *np = info->dev->of_node;
>> >> +
>> >> +       /*
>> >> +        * set default Configuration for ADC controller
>> >> +        * This config may upgrade to require from DT
>> >> +        */
>> >> +       info->adc_feature.clk_sel = ADCIOC_BUSCLK_SET;
>> >> +       info->adc_feature.vol_ref = VF610_ADCIOC_VR_VREF_SET;
>> >> +       info->adc_feature.calibration = true;
>> >> +       info->adc_feature.tri_hw = false;
>> >> +       info->adc_feature.dataov_en = true;
>> >> +       info->adc_feature.ac_clk_en = false;
>> >> +       info->adc_feature.dma_en = false;
>> >> +       info->adc_feature.cc_en = false;
>> >> +       info->adc_feature.cmp_func_en = false;
>> >> +       info->adc_feature.cmp_range_en = false;
>> >> +       info->adc_feature.cmp_greater_en = false;
>> >> +
>> >> +       if (of_property_read_u32(np, "fsl,adc-io-pinctl",
>> >> +                       &info->adc_feature.pctl)) {
>> >> +               info->adc_feature.pctl = VF610_ADC_IOPCTL5;
>> >> +               dev_info(info->dev,
>> >> +                       "Miss adc-io-pinctl in dt, enable pin SE5.\n");
>> >> +       }
>> >
>> >Could you elaborate on what this means? What is this doing when
>> >pinctrl is not specified in the DT?
>> >
>>
>> As vf610 reference manually describe ADC pin control:
>>
>> 37.8.2 Input Select and Pin Control
>> The pin control registers (ADC_PC) disable the I/O port control of the
>> pins used as analog inputs. When a pin control register bit is set,
>> the following conditions are forced for the associated MCU pin:
>> * The output buffer is forced to its high impedance state.
>> * The input buffer is disabled. A read of the I/O port returns a zero
>> for any pin with its input buffer disabled.
>> * The pullup is disabled.
>>
>> So, when the relative ADC pin is used as Sliding rheostat test, disable the
>pin control.
>>
>>
>> >> +
>> >> +       if (info->vref)
>> >> +               info->vref_uv = regulator_get_voltage(info->vref);
>> >> +       else if (of_property_read_u32(np, "fsl,adc-vref", &info->vref_uv))
>> >> +               dev_err(info->dev,
>> >> +                       "Miss adc-vref property or vref regulator
>> >> + in the DT.\n");
>> >
>> >Query the regulator instead.
>>
>> When the ADC reference voltage is not controlled by regulator, just by
>> fixed voltage from MCU digital power, We get the reference voltage
>> from DT.
>
>You could use a fixed-regulator in that case in the DT, and query the voltage
>through the regulator framework. There is no need for this property.
>
>>
>> >
>> >> +
>> >> +       if (of_property_read_u32(np, "fsl,adc-clk-div",
>> >> +                       &info->adc_feature.clk_div_num)) {
>> >> +               info->adc_feature.clk_div_num = 2;
>> >> +               dev_info(info->dev,
>> >> +                       "Miss adc-clk-div in dt, set divider to 2.\n");
>> >> +       }
>> >
>> >Why do you need this?
>> >
>> >I'd expect the use to request a frequency they wanted to sample at,
>> >and the driver would try its best by fiddling with this and the clock input.
>> >
>> >> +
>> >> +       if (of_property_read_u32(np, "fsl,adc-res",
>> >> +                       &info->adc_feature.res_mode)) {
>> >> +               info->adc_feature.res_mode = 12;
>> >> +               dev_info(info->dev,
>> >> +                       "Miss adc-res property in dt, use 8bit
>> >> + mode.\n");
>> >
>> >This message does not seem to match the code above it.
>> >
>> >Is this a hardware limitation in some instances? Or is it always
>> >possible to select any of the resolutions?
>>
>> No limitation, just mistake for it. I have tested 8-bit, 10-bit, 12-bit mode,
>all pass.
>
>Ok. So this is not necessary?
>
>> >
>> >> +
>> >> +       if (of_property_read_u32(np, "fsl,adc-sam-time",
>> >> +                       &info->adc_feature.sam_time)) {
>> >> +               info->adc_feature.sam_time = 4;
>> >> +               dev_info(info->dev,
>> >> +                       "Miss adc-sam-time property in dt, set to 4.\n");
>> >> +       }
>> >
>> >This looks like it should be handled at runtime.
>>
>> Driver can get the ADC sample time duration fro DT.
>> fsl,adc-sam-time: ADC sample time duration, number of ADC clocks, such
>> as 2, 4, 6, 8, 12, 16, 20, 24
>
>If this is not a fixed property of the hardware, and there isn't some
>limitation such that one of these values _must_ be used, I do not believe it
>should be in the device tree.
>
>Just because it is easier to put it there doesn't make putting it there correct.
>
>>
>> How to handled at runtime ?
>> Use ioctl ?
>
>Something of that sort. Hopefully someone more familiar with the subsystem can
>describe what's preferred.
>
>> For the ADC, there have many setting, some of setting are defined
>> statically,  some of them get from DT.  If let the setting handled at
>> runtime, it need to introduce ioctl interface for the driver.
>
>If it's a static property of the HW that cannot be probed, it should be in the
>DT. If it's a limitation of the HW, that should be in the DT.
>
>If it's an arbitrary value that does not have a significant effect on
>performance or correctness, I do not see why it should be in the DT.
>
>As far as I can see, this does not belong in the DT. The fact that you'd need
>an ioctl to configure it dynamically is an orthogonal issue.
>
>>
>> >
>> >> +
>> >> +       info->adc_feature.hw_average = of_property_read_bool(np,
>> >> +                                       "fsl,adc-hw-aver-en");
>> >
>> >Is hw average support not always present?
>>
>> Vf610 RM describe:
>> 37.8.5.7 Hardware Average Function
>> After the selected input is sampled and converted, the result is
>> placed in an accumulator from which an average is calculated once the
>> selected number of conversions has been completed. When hardware
>> averaging is selected the completion of a single conversion will not set the
>COCOn bit.
>>
>> In general, hw average function is useful to reduce cpu loading.
>> The function is optional for user.
>
>Ok. If this is always possible to use, as your description implies, then I do
>not see why this needs to be in the DT. Whether you choose to enable or disable
>it in the driver by default, or whether you expose an interface to userspace to
>configure this is an orthogonal issue.
>
>>
>> >
>> >> +       if (info->adc_feature.hw_average &&
>> >> +                of_property_read_u32(np, "fsl,adc-aver-sam-sel",
>> >> +                               &info->adc_feature.hw_sam)) {
>> >> +               info->adc_feature.hw_sam = 4;
>> >> +               dev_info(info->dev,
>> >> +                       "Miss adc-aver-sam-sel property in dt, set to
>4.\n");
>> >> +       }
>> >
>> >Why not configure this at runtime instead?
>> >
>> As above said, if let the configuration set at runtime, we need to
>> introduce ioctl interface for user.
>> How do you think ?
>
>An ioctl or sysfs interface sounds like the correct solution. I don't have any
>strong opinion on the particular interface used, but DT is not the right place
>to expose this configuration option.
>
>>
>>
>> >> +
>> >> +       info->adc_feature.lpm = of_property_read_bool(np,
>> >> + "fsl,adc-low-power-
>> >mode");
>> >> +       info->adc_feature.hs_oper = of_property_read_bool(np,
>> >> + "fsl,adc-high-speed-conv");
>> >
>> >Please elaborate on what these mean, and why they need to be in the DT.
>> >
>> Yes, there have some configuration have been set in default,  some of them
>from DT.
>> I think the hw function/feature enable/disable are judged from DT.
>> Some general configurations are set in default.
>
>Sorry, but that does not answer my questions:
>
>* What do these two properties mean?
>* Why must they be in the DT?
>
>As far as I can tell, they do not need to be in the DT.
>
>>
>> Of course, let all of them are set at runtime is better. But need to
>> introduce ioctl interface for user.
>
>I don't see this as an argument for placing these in the DT. Describe the
>hardware in the DT. Anything that is expected to be changed by the user is
>clearly not a property of the hardware and should not be in the DT.
>
>There are grey areas with some devices where a specific configuration is far
>more optimal for a given platform (e.g. reserving specific portions of memory
>for frame buffers). As far as I can see, none of the properties proposed in
>this patch fall into that area, and sane defaults can be selected for all of
>them which could later be overridden with a userspace interface of some sort.
>
>Thanks,
>Mark.

Thanks, Mark.

Anyway, I need to re-architect the ADC configuration, as you suggestion, move some setting from DT, add it for runtime.
For iio subsystem, there have some sysfs interface for related ADC setting, but other runtime setting need ioctl interface.

Thanks very much!
Andy

