Return-Path: <SRS0=egdf=ZG=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Tue, 24 Jan 2017 18:25:59 +0000
In-Reply-To: <48f9023e-9799-669e-94bd-782a2880a1e7@st.com>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com> <1484832854-6314-6-git-send-email-fabrice.gasnier@st.com> <8e1e4672-2259-bd84-b646-f24026dcff64@kernel.org> <48f9023e-9799-669e-94bd-782a2880a1e7@st.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 5/7] iio: adc: stm32: add optional dma support
To: Fabrice Gasnier <fabrice.gasnier@st.com>,Jonathan Cameron <jic23@kernel.org>,linux@armlinux.org.uk,robh+dt@kernel.org,linux-arm-kernel@lists.infradead.org,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org
CC: linux-iio@vger.kernel.org,mark.rutland@arm.com,mcoquelin.stm32@gmail.com,alexandre.torgue@st.com,lars@metafoo.de,knaack.h@gmx.de,pmeerw@pmeerw.net,benjamin.gaignard@linaro.org,benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <1325A4A4-C87B-4B47-A23A-5DEFE6DE5F7E@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 24 January 2017 14:43:56 GMT+00:00, Fabrice Gasnier <fabrice=2Egasnier@=
st=2Ecom> wrote:
>On 01/22/2017 02:14 PM, Jonathan Cameron wrote:
>> On 19/01/17 13:34, Fabrice Gasnier wrote:
>>> Add optional DMA support to STM32 ADC=2E
>>> Use dma cyclic mode with at least two periods=2E
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice=2Egasnier@st=2Ecom>
>> What is the point going forward in supporting non dma buffered reads
>at all?
>> Is there hardware that doesn't have DMA support?
>
>Hi Jonathan,
>
>Basically no, but there is a limited number of DMA request lines=2E
>DMA request lines mapping is documented in STM32F4 reference manual
>(DMA1/2 request mapping)=2E
>There may be a situation where user (in dt) assign all DMA channels to
>other IPs=2E Then only choice would be to fall back using interrupt mode=
=20
>for ADC=2E
>This is why I'd like to keep support for both interrupt and DMA modes=2E
Ah=2E Fair enough=2E  Thanks for the explanation=2E Perhaps a note in the =
patch description
would give us something to point at in future or even something in the bon=
ding docs?
>
>> Just strikes me that the driver would be slight simpler if we dropped
>that
>> support=2E
>>
>> Various comments inline=2E  Mostly around crossing the boundary to
>fetch
>> from the IIO specific buffer (indio_dev->buffer)=2E  That should never
>be
>> used directly as we can have multiple consumers of the datastream so
>> the numbers you get from that may represent only part of what is
>going on=2E
>>
>>
>>> ---
>>>  drivers/iio/adc/Kconfig          |   2 +
>>>  drivers/iio/adc/stm32-adc-core=2Ec |   1 +
>>>  drivers/iio/adc/stm32-adc-core=2Eh |   2 +
>>>  drivers/iio/adc/stm32-adc=2Ec      | 209
>++++++++++++++++++++++++++++++++++++---
>>>  4 files changed, 202 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 9a7b090=2E=2E2a2ef78 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -444,12 +444,14 @@ config ROCKCHIP_SARADC
>>>  config STM32_ADC_CORE
>>>  	tristate "STMicroelectronics STM32 adc core"
>>>  	depends on ARCH_STM32 || COMPILE_TEST
>>> +	depends on HAS_DMA
>>>  	depends on OF
>>>  	depends on REGULATOR
>>>  	select IIO_BUFFER
>>>  	select MFD_STM32_TIMERS
>>>  	select IIO_STM32_TIMER_TRIGGER
>>>  	select IIO_TRIGGERED_BUFFER
>>> +	select IRQ_WORK
>>>  	help
>>>  	  Select this option to enable the core driver for
>STMicroelectronics
>>>  	  STM32 analog-to-digital converter (ADC)=2E
>>> diff --git a/drivers/iio/adc/stm32-adc-core=2Ec
>b/drivers/iio/adc/stm32-adc-core=2Ec
>>> index 4214b0c=2E=2E22b7c93 100644
>>> --- a/drivers/iio/adc/stm32-adc-core=2Ec
>>> +++ b/drivers/iio/adc/stm32-adc-core=2Ec
>>> @@ -201,6 +201,7 @@ static int stm32_adc_probe(struct
>platform_device *pdev)
>>>  	priv->common=2Ebase =3D devm_ioremap_resource(&pdev->dev, res);
>>>  	if (IS_ERR(priv->common=2Ebase))
>>>  		return PTR_ERR(priv->common=2Ebase);
>>> +	priv->common=2Ephys_base =3D res->start;
>>>
>>>  	priv->vref =3D devm_regulator_get(&pdev->dev, "vref");
>>>  	if (IS_ERR(priv->vref)) {
>>> diff --git a/drivers/iio/adc/stm32-adc-core=2Eh
>b/drivers/iio/adc/stm32-adc-core=2Eh
>>> index 081fa5f=2E=2E2ec7abb 100644
>>> --- a/drivers/iio/adc/stm32-adc-core=2Eh
>>> +++ b/drivers/iio/adc/stm32-adc-core=2Eh
>>> @@ -42,10 +42,12 @@
>>>  /**
>>>   * struct stm32_adc_common - stm32 ADC driver common data (for all
>instances)
>>>   * @base:		control registers base cpu addr
>>> + * @phys_base:		control registers base physical addr
>>>   * @vref_mv:		vref voltage (mv)
>>>   */
>>>  struct stm32_adc_common {
>>>  	void __iomem			*base;
>>> +	phys_addr_t			phys_base;
>>>  	int				vref_mv;
>>>  };
>>>
>>> diff --git a/drivers/iio/adc/stm32-adc=2Ec
>b/drivers/iio/adc/stm32-adc=2Ec
>>> index 9753c39=2E=2E3439f4c 100644
>>> --- a/drivers/iio/adc/stm32-adc=2Ec
>>> +++ b/drivers/iio/adc/stm32-adc=2Ec
>>> @@ -21,6 +21,8 @@
>>>
>>>  #include <linux/clk=2Eh>
>>>  #include <linux/delay=2Eh>
>>> +#include <linux/dma-mapping=2Eh>
>>> +#include <linux/dmaengine=2Eh>
>>>  #include <linux/iio/iio=2Eh>
>>>  #include <linux/iio/buffer=2Eh>
>>>  #include <linux/iio/timer/stm32-timer-trigger=2Eh>
>>> @@ -29,6 +31,7 @@
>>>  #include <linux/iio/triggered_buffer=2Eh>
>>>  #include <linux/interrupt=2Eh>
>>>  #include <linux/io=2Eh>
>>> +#include <linux/irq_work=2Eh>
>>>  #include <linux/module=2Eh>
>>>  #include <linux/platform_device=2Eh>
>>>  #include <linux/of=2Eh>
>>> @@ -69,6 +72,8 @@
>>>  #define STM32F4_EXTSEL_SHIFT		24
>>>  #define STM32F4_EXTSEL_MASK		GENMASK(27, 24)
>>>  #define STM32F4_EOCS			BIT(10)
>>> +#define STM32F4_DDS			BIT(9)
>>> +#define STM32F4_DMA			BIT(8)
>>>  #define STM32F4_ADON			BIT(0)
>>>
>>>  /* STM32F4_ADC_SQR1 - bit fields */
>>> @@ -165,6 +170,11 @@ struct stm32_adc_trig_info {
>>>   * @bufi:		data buffer index
>>>   * @num_conv:		expected number of scan conversions
>>>   * @exten:		external trigger config (enable/polarity)
>>> + * @work:		irq work used to call trigger poll routine
>>> + * @dma_chan:		dma channel
>>> + * @rx_buf:		dma rx buffer cpu address
>>> + * @rx_dma_buf:		dma rx buffer bus address
>>> + * @rx_buf_sz:		dma rx buffer size
>>>   */
>>>  struct stm32_adc {
>>>  	struct stm32_adc_common	*common;
>>> @@ -177,6 +187,11 @@ struct stm32_adc {
>>>  	int			bufi;
>>>  	int			num_conv;
>>>  	enum stm32_adc_exten	exten;
>>> +	struct irq_work		work;
>>> +	struct dma_chan		*dma_chan;
>>> +	u8			*rx_buf;
>>> +	dma_addr_t		rx_dma_buf;
>>> +	int			rx_buf_sz;
>>>  };
>>>
>>>  /**
>>> @@ -332,10 +347,20 @@ static void stm32_adc_conv_irq_disable(struct
>stm32_adc *adc)
>>>  /**
>>>   * stm32_adc_start_conv() - Start conversions for regular channels=2E
>>>   * @adc: stm32 adc instance
>>> + *
>>> + * Start conversions for regular channels=2E
>>> + * Also take care of normal or DMA mode=2E DMA is used in circular
>mode for
>>> + * regular conversions, in IIO buffer modes=2E Rely on rx_buf as raw
>>> + * read doesn't use dma, but direct DR read=2E
>>>   */
>>>  static void stm32_adc_start_conv(struct stm32_adc *adc)
>>>  {
>>>  	stm32_adc_set_bits(adc, STM32F4_ADC_CR1, STM32F4_SCAN);
>>> +
>>> +	if (adc->rx_buf)
>>> +		stm32_adc_set_bits(adc, STM32F4_ADC_CR2,
>>> +				   STM32F4_DMA | STM32F4_DDS);
>>> +
>>>  	stm32_adc_set_bits(adc, STM32F4_ADC_CR2, STM32F4_EOCS |
>STM32F4_ADON);
>>>
>>>  	/* Wait for Power-up time (tSTAB from datasheet) */
>>> @@ -353,6 +378,10 @@ static void stm32_adc_stop_conv(struct
>stm32_adc *adc)
>>>
>>>  	stm32_adc_clr_bits(adc, STM32F4_ADC_CR1, STM32F4_SCAN);
>>>  	stm32_adc_clr_bits(adc, STM32F4_ADC_CR2, STM32F4_ADON);
>>> +
>>> +	if (adc->rx_buf)
>>> +		stm32_adc_clr_bits(adc, STM32F4_ADC_CR2,
>>> +				   STM32F4_DMA | STM32F4_DDS);
>>>  }
>>>
>>>  /**
>>> @@ -689,19 +718,138 @@ static int
>stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
>>>  	=2Edriver_module =3D THIS_MODULE,
>>>  };
>>>
>>> +static int stm32_adc_dma_residue(struct stm32_adc *adc)
>>> +{
>>> +	struct dma_tx_state state;
>>> +	enum dma_status status;
>>> +
>>> +	if (!adc->rx_buf)
>>> +		return 0;
>>> +
>>> +	status =3D dmaengine_tx_status(adc->dma_chan,
>>> +				     adc->dma_chan->cookie,
>>> +				     &state);
>>> +	if (status =3D=3D DMA_IN_PROGRESS) {
>>> +		/* Residue is size in bytes from end of buffer */
>>> +		int i =3D adc->rx_buf_sz - state=2Eresidue;
>>> +		int size;
>>> +
>>> +		/* Return available bytes */
>>> +		if (i >=3D adc->bufi)
>>> +			size =3D i - adc->bufi;
>>> +		else
>>> +			size =3D adc->rx_buf_sz - adc->bufi + i;
>>> +
>>> +		return size;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void stm32_adc_dma_irq_work(struct irq_work *work)
>>> +{
>>> +	struct stm32_adc *adc =3D container_of(work, struct stm32_adc,
>work);
>>> +	struct iio_dev *indio_dev =3D iio_priv_to_dev(adc);
>>> +
>>> +	/**
>>> +	 * iio_trigger_poll calls generic_handle_irq()=2E So, it requires
>hard
>>> +	 * irq context, and cannot be called directly from dma callback,
>>> +	 * dma cb has to schedule this work instead=2E
>>> +	 */
>>> +	iio_trigger_poll(indio_dev->trig);
>> This is nasty ;)  iio_trigger_poll_chained is your friend=2E It is
>missnamed=2E
>> If you only need to call the threaded part of the pollfunc (and I
>think you
>> can construct it so you do) then it will call it without needing to
>bounce
>> back into interrupt context=2E
>
>I'll look into it :-)
>
>>
>>> +}
>>> +
>>> +static void stm32_adc_dma_buffer_done(void *data)
>>> +{
>>> +	struct stm32_adc *adc =3D data;
>>> +
>>> +	/* invoques iio_trigger_poll() from hard irq context */
>>> +	irq_work_queue(&adc->work);
>>> +}
>>> +
>>>  static int stm32_adc_buffer_preenable(struct iio_dev *indio_dev)
>>>  {
>>>  	struct stm32_adc *adc =3D iio_priv(indio_dev);
>>> +	struct dma_async_tx_descriptor *desc;
>>> +	struct dma_slave_config config;
>>> +	dma_cookie_t cookie;
>>> +	int ret, size, watermark;
>>>
>>>  	/* Reset adc buffer index */
>>>  	adc->bufi =3D 0;
>>>
>>> -	/* Allocate adc buffer */
>>> -	adc->buffer =3D kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
>>> -	if (!adc->buffer)
>>> +	if (!adc->dma_chan) {
>>> +		/* Allocate adc buffer */
>>> +		adc->buffer =3D kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
>>> +		if (!adc->buffer)
>>> +			return -ENOMEM;
>>> +
>>> +		return 0;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Allocate at least twice the buffer size for dma cyclic
>transfers, so
>>> +	 * we can work with at least two dma periods=2E There should be :
>>> +	 * - always one buffer (period) dma is working on
>>> +	 * - one buffer (period) driver can push with iio_trigger_poll()=2E
>>> +	 */
>>> +	size =3D indio_dev->buffer->bytes_per_datum *
>indio_dev->buffer->length;
>>> +	size =3D max(indio_dev->scan_bytes * 2, size);
>> Hmm=2E There is a bit of a weird mix going on here=2E Firstly, you may
>have more
>> than one consumer buffer, the one you are checking is only the one
>directly
>> associated with the IIO userspace interface=2E
>>
>> So scan_bytes is the right value to use for both of these statements=2E
>> The buffer length is typically not knowable either or relevant here=2E
>> If you are ultimately going to deal with watermarks there is an
>interface
>> to guide read sizes based on that but this isn't it=2E
>>
>> So basically device should never know anything at all about the
>software
>> buffer=2E All info should pass through the core which knows about all
>the
>> consumers hanging off this interface (and the demux that is going on
>to
>> feed them all)=2E
>>
>> Some drivers provide additional info to allow the modifying of the
>> precise hardware watermark being used=2E  That's an acceptable form of
>> 'tweak'=2E
>
>I'll follow your guidelines and rework this part=2E I also had some
>doubts=20
>on this=2E This is more clear!
>
>Thanks,
>Regards,
>Fabrice
>
>>
>>> +
>>> +	adc->rx_buf =3D dma_alloc_coherent(adc->dma_chan->device->dev,
>>> +					 PAGE_ALIGN(size), &adc->rx_dma_buf,
>>> +					 GFP_KERNEL);
>>> +	if (!adc->rx_buf)
>>>  		return -ENOMEM;
>>> +	adc->rx_buf_sz =3D size;
>>> +	watermark =3D indio_dev->buffer->bytes_per_datum
>>> +		* indio_dev->buffer->watermark;
>>> +	watermark =3D max(indio_dev->scan_bytes, watermark);
>>> +	watermark =3D rounddown(watermark, indio_dev->scan_bytes);
>>> +
>>> +	dev_dbg(&indio_dev->dev, "%s size=3D%d watermark=3D%d\n", __func__,
>size,
>>> +		watermark);
>>> +
>>> +	/* Configure DMA channel to read data register */
>>> +	memset(&config, 0, sizeof(config));
>>> +	config=2Esrc_addr =3D (dma_addr_t)adc->common->phys_base;
>>> +	config=2Esrc_addr +=3D adc->offset + STM32F4_ADC_DR;
>>> +	config=2Esrc_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
>>> +
>>> +	ret =3D dmaengine_slave_config(adc->dma_chan, &config);
>>> +	if (ret)
>>> +		goto config_err;
>>> +
>>> +	/* Prepare a DMA cyclic transaction */
>>> +	desc =3D dmaengine_prep_dma_cyclic(adc->dma_chan,
>>> +					 adc->rx_dma_buf,
>>> +					 size, watermark,
>>> +					 DMA_DEV_TO_MEM,
>>> +					 DMA_PREP_INTERRUPT);
>>> +	if (!desc) {
>>> +		ret =3D -ENODEV;
>>> +		goto config_err;
>>> +	}
>>> +
>>> +	desc->callback =3D stm32_adc_dma_buffer_done;
>>> +	desc->callback_param =3D adc;
>>> +
>>> +	cookie =3D dmaengine_submit(desc);
>>> +	if (dma_submit_error(cookie)) {
>>> +		ret =3D dma_submit_error(cookie);
>>> +		goto config_err;
>>> +	}
>>> +
>>> +	/* Issue pending DMA requests */
>>> +	dma_async_issue_pending(adc->dma_chan);
>>>
>>>  	return 0;
>>> +
>>> +config_err:
>>> +	dma_free_coherent(adc->dma_chan->device->dev, PAGE_ALIGN(size),
>>> +			  adc->rx_buf, adc->rx_dma_buf);
>>> +
>>> +	return ret;
>>>  }
>>>
>>>  static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>>> @@ -719,7 +867,8 @@ static int stm32_adc_buffer_postenable(struct
>iio_dev *indio_dev)
>>>  	if (ret < 0)
>>>  		return ret;
>>>
>>> -	stm32_adc_conv_irq_enable(adc);
>>> +	if (!adc->dma_chan)
>>> +		stm32_adc_conv_irq_enable(adc);
>>>  	stm32_adc_start_conv(adc);
>>>
>>>  	return 0;
>>> @@ -731,7 +880,8 @@ static int stm32_adc_buffer_predisable(struct
>iio_dev *indio_dev)
>>>  	int ret;
>>>
>>>  	stm32_adc_stop_conv(adc);
>>> -	stm32_adc_conv_irq_disable(adc);
>>> +	if (!adc->dma_chan)
>>> +		stm32_adc_conv_irq_disable(adc);
>>>
>>>  	ret =3D iio_triggered_buffer_predisable(indio_dev);
>>>  	if (ret < 0)
>>> @@ -748,7 +898,16 @@ static int stm32_adc_buffer_postdisable(struct
>iio_dev *indio_dev)
>>>  {
>>>  	struct stm32_adc *adc =3D iio_priv(indio_dev);
>>>
>>> -	kfree(adc->buffer);
>>> +	if (!adc->dma_chan) {
>>> +		kfree(adc->buffer);
>>> +	} else {
>>> +		dmaengine_terminate_all(adc->dma_chan);
>>> +		irq_work_sync(&adc->work);
>>> +		dma_free_coherent(adc->dma_chan->device->dev,
>>> +				  PAGE_ALIGN(adc->rx_buf_sz),
>>> +				  adc->rx_buf, adc->rx_dma_buf);
>>> +		adc->rx_buf =3D NULL;
>>> +	}
>>>  	adc->buffer =3D NULL;
>>>
>>>  	return 0;
>>> @@ -769,15 +928,31 @@ static irqreturn_t
>stm32_adc_trigger_handler(int irq, void *p)
>>>
>>>  	dev_dbg(&indio_dev->dev, "%s bufi=3D%d\n", __func__, adc->bufi);
>>>
>>> -	/* reset buffer index */
>>> -	adc->bufi =3D 0;
>>> -	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
>>> -					   pf->timestamp);
>>> +	if (!adc->dma_chan) {
>>> +		/* reset buffer index */
>>> +		adc->bufi =3D 0;
>>> +		iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
>>> +						   pf->timestamp);
>>> +	} else {
>>> +		int residue =3D stm32_adc_dma_residue(adc);
>>> +
>>> +		while (residue >=3D indio_dev->scan_bytes) {
>>> +			adc->buffer =3D (u16 *)&adc->rx_buf[adc->bufi];
>>> +			iio_push_to_buffers_with_timestamp(indio_dev,
>>> +							   adc->buffer,
>>> +							   pf->timestamp);
>>> +			residue -=3D indio_dev->scan_bytes;
>>> +			adc->bufi +=3D indio_dev->scan_bytes;
>>> +			if (adc->bufi >=3D adc->rx_buf_sz)
>>> +				adc->bufi =3D 0;
>>> +		}
>>> +	}
>>>
>>>  	iio_trigger_notify_done(indio_dev->trig);
>>>
>>>  	/* re-enable eoc irq */
>>> -	stm32_adc_conv_irq_enable(adc);
>>> +	if (!adc->dma_chan)
>>> +		stm32_adc_conv_irq_enable(adc);
>>>
>>>  	return IRQ_HANDLED;
>>>  }
>>> @@ -910,13 +1085,17 @@ static int stm32_adc_probe(struct
>platform_device *pdev)
>>>  	if (ret < 0)
>>>  		goto err_clk_disable;
>>>
>>> +	adc->dma_chan =3D dma_request_slave_channel(&indio_dev->dev, "rx");
>>> +	if (adc->dma_chan)
>>> +		init_irq_work(&adc->work, stm32_adc_dma_irq_work);
>>> +
>>>  	ret =3D iio_triggered_buffer_setup(indio_dev,
>>>  					 &iio_pollfunc_store_time,
>>>  					 &stm32_adc_trigger_handler,
>>>  					 &stm32_adc_buffer_setup_ops);
>>>  	if (ret) {
>>>  		dev_err(&pdev->dev, "buffer setup failed\n");
>>> -		goto err_clk_disable;
>>> +		goto err_dma_disable;
>>>  	}
>>>
>>>  	ret =3D iio_device_register(indio_dev);
>>> @@ -930,6 +1109,10 @@ static int stm32_adc_probe(struct
>platform_device *pdev)
>>>  err_buffer_cleanup:
>>>  	iio_triggered_buffer_cleanup(indio_dev);
>>>
>>> +err_dma_disable:
>>> +	if (adc->dma_chan)
>>> +		dma_release_channel(adc->dma_chan);
>>> +
>>>  err_clk_disable:
>>>  	clk_disable_unprepare(adc->clk);
>>>
>>> @@ -943,6 +1126,8 @@ static int stm32_adc_remove(struct
>platform_device *pdev)
>>>
>>>  	iio_device_unregister(indio_dev);
>>>  	iio_triggered_buffer_cleanup(indio_dev);
>>> +	if (adc->dma_chan)
>>> +		dma_release_channel(adc->dma_chan);
>>>  	clk_disable_unprepare(adc->clk);
>>>
>>>  	return 0;
>>>
>>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
