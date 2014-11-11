Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63045 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbaKKWjm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 11 Nov 2014 17:39:42 -0500
Message-ID: <54629026.3080002@gmx.de>
Date: Tue, 11 Nov 2014 23:39:34 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: vadc: Qualcomm SPMI PMIC voltage ADC driver
References: <1415028270-25860-1-git-send-email-iivanov@mm-sol.com>	 <1415028270-25860-3-git-send-email-iivanov@mm-sol.com>	 <54612A0D.7020308@gmx.de> <1415694109.22935.13.camel@mm-sol.com>
In-Reply-To: <1415694109.22935.13.camel@mm-sol.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ivan T. Ivanov schrieb am 11.11.2014 09:21:
> Hi Hartmut,
> 
> On Mon, 2014-11-10 at 22:11 +0100, Hartmut Knaack wrote:
>> Ivan T. Ivanov schrieb am 03.11.2014 16:24:
>>> From: Stanimir Varbanov <svarbanov@mm-sol.com>
>>>
>>> The voltage ADC is peripheral of Qualcomm SPMI PMIC chips. It has
>>> 15 bits resolution and register space inside PMIC accessible across
>>> SPMI bus.
>>>
>>> The vadc driver registers itself through IIO interface.
>> Reviewing again, I got the feeling that due to the complexity of adc reads (writing to register 
>> to start conversion, waiting a decent time for the conversion to complete, reading the result), 
>> it would be beneficial to use a mutex in vadc_read_raw or its depending functions.
> 
> Hm, yes, but there is such a nice info_exist_lock :-) in core functions,
> which in practice serve the same purpose.
I seem to miss that. Please point me in the right direction.
> 
>> Also, I would want to double-check that the CPU in this type of chips is little endian.
> 
> Yes, it is.
> 
>> Besides that, a few minor issues inline.
> 
>>> +static int vadc_probe(struct platform_device *pdev)
>>> +{
>>> +       struct device_node *node = pdev->dev.of_node;
>>> +       struct device *dev = &pdev->dev;
>>> +       struct iio_dev *indio_dev;
>>> +       struct vadc_priv *vadc;
>>> +       struct regmap *regmap;
>>> +       int ret, irq_eoc;
>>> +       u32 res;
>> Since vadc->base is u16, shouldn't res be u16 as well? Also think about naming it reg, as this is 
>> the property name in DT.
> 
> Yes, but #address-cells for the node is 1, so I would like to keep it 32 bits.
> 
>>> +
>>> +       regmap = dev_get_regmap(dev->parent, NULL);
>>> +       if (!regmap)
>>> +       return -ENODEV;
>>> +
>>> +       ret = of_property_read_u32(node, "reg", &res);
>> For u16, there would be of_property_read_u16().
>>> +       if (ret < 0)
>>> +       return -ENODEV;
>> Just return ret here?
> 
> I am usually trying to follow these recommendations[1]. In practice driver
> core cares only for EPROBE_DEFER, ENODEV and ENXIO, while of_property_read_u32()
> can return ENODATA and EOVERFLOW, which did't not make sense for the core.
Please point me in the right direction on this one, too. It is pretty common to pass error codes up, as it is also mentioned in [1].
Yet, this thread in [1] seems more like a draft to me, as Greg K-H wrote in the end: "Fair enough, care to respin this and send it out to me for review?"
> 
> Thank you,
> Ivan
> 
> [1] http://www.gossamer-threads.com/lists/linux/kernel/1010603
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

