Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [212.40.180.161] ([212.40.180.161]:49655 "EHLO
	smtp-out-039.synserver.de" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754173AbcBIUbG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 15:31:06 -0500
Subject: Re: [PATCH v2 3/4] iio: ad5755: added full support for devicetree
To: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>,
	linux-iio@vger.kernel.org
References: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-3-git-send-email-sean.nyekjaer@prevas.dk>
 <56B9A1B2.6030007@prevas.dk>
Cc: devicetree@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56BA4C74.9030503@metafoo.de>
Date: Tue, 9 Feb 2016 21:30:44 +0100
MIME-Version: 1.0
In-Reply-To: <56B9A1B2.6030007@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/2016 09:22 AM, Sean Nyekjær wrote:
> 
> On 2016-02-03 15:31, Sean Nyekjaer wrote:
>> Devicetree can provide platform data
>>
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Lars do you have time to look at this before i'm fixing the comments from
> Jonathan and Rob :-)

The obvious thing is to use '-' instead of '_' since that is the DT convention.

Other than that this non-trivial. This is the first binding for such a
device and it is always hard to come up with a good ABI without knowing what
other similar devices might need to be supported by the same bindings. And
it is also not always clear what is hardware description and what is driver
policy.

The external resistor configuration should be clear, that's a description of
the hardware whether the resistor exists or not.

For the others it's not so clear. E.g. the DC-to-DC converter configuration,
this is most certainly not a description of the hardware. But we could get
away with it by saying this is a system level design decision and is made by
the system designer based on the operating parameters of the hardware and
hence is policy that belongs in the DT. It might make sense to follow what
the regulator bindings do here, even though the regulator is not exposed
externally.

The configuration of the output pin (voltage level, current level, etc) is
certainly influenced by the restrictions of the hardware itself. You don't
want to allow a configuration that can damage the hardware. But on the other
hand it is still a valid usecase for some applications to switch between two
setups at runtime, which is something you said you need to be able to do.
Here we might want to use something similar to pinctrl where the devicetree
can offer a selection of valid configurations and the driver can switch
between those configurations.

- Lars

[...]
>> +static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
>> +{
>> +    struct device_node *np = dev->of_node;
>> +    struct device_node *pp;
>> +    struct ad5755_platform_data *pdata;
>> +    unsigned int tmp;
>> +    unsigned int tmparray[3];
>> +    int devnr;
>> +
>> +    pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +    if (!pdata)
>> +        return NULL;
>> +
>> +    pdata->ext_dc_dc_compenstation_resistor =
>> +           of_property_read_bool(np,
>> "adi,ext_dc_dc_compenstation_resistor");
>> +
>> +    if (!of_property_read_u32(np, "adi,dc_dc_phase", &tmp))
>> +        pdata->dc_dc_phase = tmp;
>> +    else
>> +        pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
>> +
>> +    if (!of_property_read_u32(np, "adi,dc_dc_freq", &tmp))
>> +        pdata->dc_dc_freq = tmp;
>> +    else
>> +        pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
>> +
>> +    if (!of_property_read_u32(np, "adi,dc_dc_maxv", &tmp))
>> +        pdata->dc_dc_maxv = tmp;
>> +    else
>> +        pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
>> +
>> +    devnr = 0;
>> +    for_each_child_of_node(np, pp) {
>> +        if (devnr > AD5755_NUM_CHANNELS) {
>> +            dev_err(dev, "There is to many channels defined in DT\n");
>> +            goto error_out;
>> +        }
>> +
>> +        if (!of_property_read_u32(pp, "adi,mode", &tmp))
>> +            pdata->dac[devnr].mode = tmp;
>> +        else
>> +            pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
>> +
>> +        pdata->dac[devnr].ext_current_sense_resistor =
>> +               of_property_read_bool(pp, "adi,ext_current_sense_resistor");
>> +
>> +        pdata->dac[devnr].enable_voltage_overrange =
>> +            of_property_read_bool(pp, "adi,enable_voltage_overrange");
>> +        if (!of_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
>> +            pdata->dac[devnr].slew.enable = tmparray[0];
>> +            pdata->dac[devnr].slew.rate = tmparray[1];
>> +            pdata->dac[devnr].slew.step_size = tmparray[2];
>> +        } else {
>> +            pdata->dac[devnr].slew.enable = false;
>> +            pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
>> +            pdata->dac[devnr].slew.step_size = AD5755_SLEW_STEP_SIZE_1;
>> +        }
>> +
>> +        devnr++;
>> +    }
>> +
>> +    return pdata;

[...]
