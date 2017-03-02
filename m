Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46295 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdCBUUU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Mar 2017 15:20:20 -0500
Subject: Re: [PATCH v14 3/5] input: touchscreen: mxs-lradc: Add support for
 touchscreen
To: Harald Geyer <harald@ccbib.org>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
References: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
 <cover.1488380468.git.ksenija.stanojevic@gmail.com>
 <80f16ceab50848e0fbdafda4057186c561bf519b.1488380468.git.ksenija.stanojevic@gmail.com>
 <E1cjDd3-0000KO-Ao@stardust.g4.wien.funkfeuer.at>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
        linux-iio@vger.kernel.org, stefan.wahren@i2se.com,
        fabio.estevam@freescale.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8b803696-6161-f606-9183-f1a9e169de42@kernel.org>
Date: Thu, 2 Mar 2017 19:55:02 +0000
MIME-Version: 1.0
In-Reply-To: <E1cjDd3-0000KO-Ao@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/17 23:25, Harald Geyer wrote:
> Hi Ksenija!
> 
> Ksenija Stanojevic writes:
>> +static int mxs_lradc_ts_register(struct mxs_lradc_ts *ts)
>> +{
>> +	struct input_dev *input = ts->ts_input;
>> +	struct device *dev = ts->dev;
>> +
>> +	input = devm_input_allocate_device(dev);
>> +	if (!input)
>> +		return -ENOMEM;
>> +
>> +	input->name = "mxs-lradc-ts";
>> +	input->id.bustype = BUS_HOST;
>> +	input->open = mxs_lradc_ts_open;
>> +	input->close = mxs_lradc_ts_close;
>> +
>> +	__set_bit(EV_ABS, input->evbit);
>> +	__set_bit(EV_KEY, input->evbit);
>> +	__set_bit(BTN_TOUCH, input->keybit);
>> +	__set_bit(INPUT_PROP_DIRECT, input->propbit);
>> +	input_set_abs_params(input, ABS_X, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
>> +	input_set_abs_params(input, ABS_Y, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
>> +	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_SINGLE_SAMPLE_MASK,
>> +			     0, 0);
>> +
>> +	ts->ts_input = input;
>> +	input_set_drvdata(input, ts);
>> +
>> +	return input_register_device(input);
>> +}
>> +
>> +static int mxs_lradc_ts_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = dev->parent->of_node;
>> +	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
>> +	struct mxs_lradc_ts *ts;
>> +	struct resource *iores;
>> +	int ret, irq, virq, i;
>> +	u32 ts_wires = 0, adapt;
>> +
>> +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>> +	if (!ts)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, ts);
>> +
>> +	ts->lradc = lradc;
>> +	ts->dev = dev;
>> +	spin_lock_init(&ts->lock);
>> +
>> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
>> +	if (IS_ERR(ts->base))
>> +		return PTR_ERR(ts->base);
>> +
>> +	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>> +				   &ts_wires);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (of_property_read_u32(node, "fsl,ave-ctrl", &adapt)) {
>> +		ts->over_sample_cnt = 4;
>> +	} else {
>> +		if (adapt >= 1 || adapt <= 32) {
>> +			ts->over_sample_cnt = adapt;
>> +		} else {
>> +			dev_err(ts->dev, "Invalid sample count (%u)\n",
>> +				adapt);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	if (of_property_read_u32(node, "fsl,ave-delay", &adapt)) {
>> +		ts->over_sample_delay = 2;
>> +	} else {
>> +		if (adapt >= 2 || adapt <= LRADC_DELAY_DELAY_MASK + 1) {
>> +			ts->over_sample_delay = adapt;
>> +		} else {
>> +			dev_err(ts->dev, "Invalid sample delay (%u)\n",
>> +				adapt);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	if (of_property_read_u32(node, "fsl,settling", &adapt)) {
>> +		ts->settling_delay = 10;
>> +	} else {
>> +		if (adapt >= 1 || adapt <= LRADC_DELAY_DELAY_MASK) {
>> +			ts->settling_delay = adapt;
>> +		} else {
>> +			dev_err(ts->dev, "Invalid settling delay (%u)\n",
>> +				adapt);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	ret = stmp_reset_block(ts->base);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mxs_lradc_ts_hw_init(ts);
>> +
>> +	for (i = 0; i < 3; i++) {
>> +		irq = platform_get_irq_byname(pdev, mxs_lradc_ts_irq_names[i]);
>> +		if (irq < 0)
>> +			return irq;
>> +
>> +		virq = irq_of_parse_and_map(node, irq);
>> +
>> +		mxs_lradc_ts_stop(ts);
>> +
>> +		ret = devm_request_irq(dev, virq,
>> +				       mxs_lradc_ts_handle_irq,
>> +				       0, mxs_lradc_ts_irq_names[i], ts);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	mxs_lradc_ts_register(ts);
>> +
>> +	return 0;
> 
> In case you end up creating v15, please check if the above can be:
> return mxs_lradc_ts_register(ts);
> 
> Offtopic: This patch series has got the most contradictory review
> comments I have seen so far at kernel work. Thanks for your tireless
> effort to satisfy everybody. I'm looking forward to this getting merged.
> 
> Harald
> 
Seconded!  It's been one of those 'interesting' series but hopefully we
are getting to a conclusion.

Jonathan
