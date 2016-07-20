Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37779 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbcGTO6E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 10:58:04 -0400
Subject: Re: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <e24c8b63-7774-66d2-3317-43fd5598ecc9@kernel.org>
 <578DE5C9.8070502@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e763fba8-391f-f353-9ffe-354c08305dc5@kernel.org>
Date: Wed, 20 Jul 2016 15:57:59 +0100
MIME-Version: 1.0
In-Reply-To: <578DE5C9.8070502@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 09:33, Quentin Schulz wrote:
> On 18/07/2016 15:18, Jonathan Cameron wrote:
>> On 15/07/16 10:59, Quentin Schulz wrote:
>>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>>> controller and a thermal sensor. This patch adds the ADC driver which is
>>> based on the MFD for the same SoCs ADC.
>>>
>>> This also registers the thermal adc channel in the iio map array so
>>> iio_hwmon could use it without modifying the Device Tree.
>>>
>>> This driver probes on three different platform_device_id to take into
>>> account slight differences between Allwinner SoCs ADCs.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>
>> Hi Quentin,
>>
>> Various bits inline.  In particular the irq handling looks flakey / racey
>> to me.  Definitely need some explanatory comments.
>>
>> Also another note on the craziness that using extended_name to provide
>> the hwmon labels will cause :)
>>
>> Jonathan
> [...]
>>> +struct sunxi_gpadc_dev {
>>> +	void __iomem			*regs;
>>> +	struct completion		completion;
>>> +	int				temp_data;
>>> +	u32				adc_data;
>>> +	struct regmap			*regmap;
>>> +	unsigned int			fifo_data_irq;
>>> +	unsigned int			temp_data_irq;
>>> +	unsigned int			flags;
>> I'd prefer something more explicit than this.  Right now only one
>> bit can ever be set - indicating a particular chip family.  Why not
>> just have an enum instead?
> 
> ACK.
> 
> [...]
>>> +static const struct iio_chan_spec sunxi_gpadc_channels[] = {
>>> +	SUNXI_GPADC_ADC_CHANNEL(0, "adc_chan0"),
>>> +	SUNXI_GPADC_ADC_CHANNEL(1, "adc_chan1"),
>>> +	SUNXI_GPADC_ADC_CHANNEL(2, "adc_chan2"),
>>> +	SUNXI_GPADC_ADC_CHANNEL(3, "adc_chan3"),
>>> +	{
>>> +		.type = IIO_TEMP,
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>> +		.datasheet_name = "temp_adc",
>>> +		.extend_name = "SoC temperature",
>> Just curious, did you look at the resultling sysfs entries?
>> Going to be something like
>> in_temp_SoC\ Temperature_input... Not good.
> 
> Just encountered this after further testing, not good as you said.
> 
>> If there is a strong enough reason (and there may be) to add a 'help string'
>> type label to struct iio_chan_spec then my only real worries would be that
>> we would be adding a whole pile of ABI that would be in the, near impossible
>> to change in future, category...
> 
> I don't understand your "adding a whole pile of ABI" thing. 
Adding a 'free form' description field to the sysfs ABI of IIO is
nasty in that such things tend not to be as reviewed as they should
be and the moment an unclear / wrong statement is there, it's in
the kernel ABI and chances are someone will go and write a script
using it.  Userspace breakage ensues so we get stuck with garbage. 
>Same as
> datasheet_name variable: const char* in struct iio_chan_spec and used
> whenever needed with some NULL checks. This is the easiest way to do it.
> Or maybe you're thinking of adding an item to iio_chan_info_enum and all
> its underlying modifications? This could allow us to expose a _label
> sysfs file in the iio_device per type/channel.
As you suggest - new field in iio_chan_spec.
> 
> I understand the "near impossible to change in future" concern though.
> 
> [...]
>>> +	enable_irq(info->temp_data_irq);
>> Is this hardware spitting out extra irqs?  If not, much better to just
>> leave it enabled all the time and control whether it can occur or not
>> by controlling the device state..
> 
> The temp_data_irq occurs every SUNXI_GPADC_TEMP_PERIOD(x) periods (in
> the current state of the driver: 2s). What do you mean by controlling
> the device state? Enabling or disabling the hardware part of the IP
> responsible of getting the temperature
> (SUNXI_GPADC_TP_TPR_TEMP_ENABLE(x) here)?
Yes, or something along those lines if it wakes up fast enough.
> Once the interrupt is activated, the IP periodically performs
> conversions. We don't really want interrupts to be activated when not
> needed.
> 
> [...]
>>> +
>>> +	if (info->flags & SUNXI_GPADC_ARCH_SUN4I)
>>> +		*val = info->temp_data * 133 - 257000;
>> Why report as processed?  I'd just report them as raw with the scale
>> and offset provided.  It's not a big thing, but if we can leave it so
>> that the conversion only occurs when desired, why not?
>>
>> For in kernel users, this all happen 'automagically' anyway ;)
>>
> 
> ACK.
> 
> [...]
>>> +	mutex_unlock(&indio_dev->mlock);
>> mlock has a very specific purpose - locking the state changes of
>> between 'buffered' (push) and poll modes. Don't use it for anything else.
>> In fact it's almost always a bug to access it directly at all.  We have
>> nice wrappers now for checking and locking the access mode.
>> Just have a local lock in your iio_priv structure.
> 
> ACK. There is still a lot of drivers using iio_dev mlock though.
> 
> [...]
>>> +static irqreturn_t sunxi_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
>>> +{
>>> +	struct sunxi_gpadc_dev *info = dev_id;
>>> +	int ret;
>>> +
>>> +	ret = regmap_read(info->regmap, SUNXI_GPADC_TP_DATA, &info->adc_data);
>>> +	if (ret == 0)
>>> +		complete(&info->completion);
>> if (!regmap_read(...))?
>>
> 
> ACK.
> 
> [...]
>>> +
>>> +	info->temp_data_irq = irq;
>>> +	disable_irq(irq);
>> As below, I want a comment explaining why you are disabling the irq here.
>> This is clearly racey..
> 
> Once the interrupt is activated, the IP performs continuous conversions
> (temp_data_irq only periodically). I want these interrupts to be enabled
> only when I read the sysfs file or we get useless interrupts.
> In the current state of this driver's irq handlers, I only set values in
> structures and all the needed structures are already initialized before
> requesting irqs. So it does not look like a race. I can prevent races in
> future versions by adding an atomic flag if wanted.
> 
>>> +
>>> +	irq = platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
>>> +	if (irq < 0) {
>>> +		dev_err(&pdev->dev,
>>> +			"no FIFO_DATA_PENDING interrupt registered\n");
>>> +		ret = irq;
>>> +		goto err;
>>> +	}
>>> +
>>> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>>> +					   sunxi_gpadc_fifo_data_irq_handler,
>>> +					   0, "fifo_data", info);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev,
>>> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
>>> +			ret);
>>> +		goto err;
>>> +	}
>>> +
>>> +	info->fifo_data_irq = irq;
>> There's a race here - this may be the only way of doing it though.
>>
>> However, I want a comment explaining why here... Are we looking at a hardware
>> bug?
>>> +	disable_irq(irq);
>>> +
>>> +	ret = iio_map_array_register(indio_dev, sunxi_gpadc_hwmon_maps);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "failed to register iio map array\n");
>>> +		goto err;
>>> +	}
>>> +
>>> +	platform_set_drvdata(pdev, indio_dev);
>>> +
>>> +	ret = iio_device_register(indio_dev);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "could not register the device\n");
>>> +		iio_map_array_unregister(indio_dev);
>> Once you have an unwinding path (which is sensible here) put everything in
>> that block - it makes it easier to review (initially I compared that block
>> with the remove and thought you'd missed this error path).
>>
> 
> ACK. As suggested by Maxime, I will put that in a different goto label.
> 
>>> +		goto err;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +err:
>>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
>>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int sunxi_gpadc_remove(struct platform_device *pdev)
>>> +{
>>> +	struct sunxi_gpadc_dev *info;
>>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +
>>> +	info = iio_priv(indio_dev);
>>> +	iio_device_unregister(indio_dev);
>>> +	iio_map_array_unregister(indio_dev);
>> Slight disrepancy here between the cleanup in the error path in
>> probe vs what we have in remove (next line doesn't exist in probe cleanup)
>> Perhaps a comment here would make it clear why...
>>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
> 
> SUNXI_GPADC_TP_INT_FIFO is the register in charge of activating hardware
> interrupts. I disable all interrupts. In the probe, the interrupts are
> already disabled (with disable_irq(irq)). This is actually just a
> shortcut compared to "disable_irq(info->fifo_data_irq);
> disable_irq(inf->temp_data_irq);".
That disables reception of interrupts, I'd suggest it would be cleaner
to ensure you also disable their generation if an error occurs.
Basically it looks nicer that way ;)
> 
> [...]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

