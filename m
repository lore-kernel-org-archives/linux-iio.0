Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0A3BCD2E
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716785; cv=none; b=FhZ26gc1tJp1qHVO1d6BhhHedRfViGYMG8Rp35pIUihOPzEDncz6bZcF2frRbaf3dEW69BU9KUdN4XabfsPRY2ZY61KSQ14R4y7QdxyZRs392nyYqXOEjZrl81WFfj9oJBhtXRlN8UvZtS2SoJzCWmEdwetdoZlgKRP+vp0654U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716785; c=relaxed/simple;
	bh=EMYGVE6IQWuScE6M+xqy53gN2E9nBRjXujLElAOAmog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8HhkcqCMsySIjiUa6dJor33BDFJLGzTHSdwumM3fWqeNDgCzHuP1PP33To04gzIwPWrg4ZP/tNjSLoNBAbjc8DxzyqrCZn2mOMG6+AZ9/jgR/HvOVDDei0l/LGh7HSJQZowRJ87FsmQ9iVaLKNtn78cj+Lfhe9fDyXgR329qkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk+aBdia; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk+aBdia"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c82538b6b0so18553375ad.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782716783; x=1783321583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OQSOqKJq6xwV0BouSXRJQided8S7YeCM64Nxu1hkxrw=;
        b=Gk+aBdiaUye8cR2TmWSD6x5LRTohwF6K9zveyxOET7hGuFy2c+Wj4lNj0uaX2yvmOG
         g1gUHKiDztxGAD/du5BSd+hzz638FbfkL2QLHaUe9RAISW528g+UelFzHNF+lM533EaO
         /WceMfIyl7lFVZB9tbhVe7aYfl8FDsaT6yTQi//3UvaMYDJdFKtyoJB1r/K6QwtJmDmZ
         blUZk12M8soLYQ8xDkEOiUj+qhH3uVBEhUFn4KyS1psacb1TmAr0WuyIxQq4h300CtaA
         95c8QKgFuzVPc8vvk2r1PJdYelei0KISM8pPCD1VFtehYCNvXmoQPLv6VxrJfKazxe00
         WxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716783; x=1783321583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQSOqKJq6xwV0BouSXRJQided8S7YeCM64Nxu1hkxrw=;
        b=bXKb5s1Z1dEizOaxQbN/cvv96TN6C7drQG2mqnKgUIn2FyoTNdquGtWUiHUSq7ETHF
         0SVhwEXCiv8W5qxY9K2yEwJaRe1jSU94LtpSoCJOKMSG7623RYYAop+HlgUO+1LCMDff
         9yM+W3VL6ivWNFsXgBUUmUOeRmacChi5Mv7iAmlsunf8yoeCOgiQ8Xlzk4PxXzx3zjK0
         ZpyTEbJmH4yEnkvCFxu5gOSe0Sn9bcINoIXpn5HKuejnPq/jbWTQst0nEzu8AnGDWWS9
         eHQPmGfTCLJfPSaCJMIXemCDCvcxcOLAIViMUsalsiIe2gWCYPP9vFN0swQklIoT2uKd
         AbQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr28IXa1UAQ21yn6SiaIMq29b33BrDuTOuDyHLUmEI2Fr9JWSL1o2c7R2+aqGeAGuLjK8O4CIqlYcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9E6RXZls47dM+SyFtRq7tOx/MpOqT2u9ZI62G9HqaaSZpQhE
	dtFfOdONINebKU13gAGnP22PTus/aKW3NIxVE4PtUYeJz8xcaCYDaEdK
X-Gm-Gg: AfdE7ckGzai3ov+c/EQsS18dEeBDRtsTlkKeECiQ9BuJ7FjmzjnBRfALGremr5w6JdZ
	JTw5HlYUcNUtCbbAG20gDrJMquLHGslafpnyu8beYa3Lu5NilW58mXSNWgO/DdgzSeaIOM30bSD
	3aDLRCuAURpl0pqjq0y4s2og687cXglUs5nFjtHRMtnoq2Sv5hQoReD0JkdgmYrR6pmt4+QVtI+
	jVdI9HQlQIqIalZr5nEbCRE1WxgRGPCtbesdvZqUsFAk0+OOfncsDQ6MmEp/p9Daxb+ez+kanK1
	yOldks0+ZpeyPu01BKccv4yPVMnxCtnF4qgQ1nzVN3MPkWSNSyzodD5iOm2dekvih6ZILjZUizV
	RJ93Crz2b65ZE3Tj9VJ8HFr4DaMtOp6y3OfFZ4i9aMBTyIF1CCnBMmHpWnQh5lyPNUnPHCC5T2G
	KKDmvrrfZbc5eOQmQ6vQ+OYAQjnl2ptQhPIDrv7YlKnNErJC3jA0seGyXZJrDH9mhn
X-Received: by 2002:a17:903:41d1:b0:2c9:97a7:b1ed with SMTP id d9443c01a7336-2c997a7b334mr73382705ad.44.1782716782497;
        Mon, 29 Jun 2026 00:06:22 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9e28d8129sm24451255ad.80.2026.06.29.00.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:06:22 -0700 (PDT)
Message-ID: <1f8bc01d-e330-4d4a-910c-514e002b256b@gmail.com>
Date: Mon, 29 Jun 2026 15:06:18 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-3-cwweng.linux@gmail.com>
 <aj52jaJK3qwvQu2k@ashevche-desk.local>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <aj52jaJK3qwvQu2k@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andy,

Thanks for the review and the kind words.

I will address the cleanup comments in v2:
- trim the include list and add the missing specific headers such as
   linux/types.h and linux/jiffies.h,
- rename the RMW helper to ma35d1_adc_update(),
- mask the update value in the helper,
- add set/clear bits helpers,
- use loop-local unsigned int indices where applicable,
- use devm_kasprintf() or drop the channel name handling if it is no
   longer needed,
- switch to device_for_each_child_node_scoped(),
- simplify the IRQ and triggered-buffer error paths.

 > > +     if (have_single && have_diff)
 > > +             return -EINVAL;
 >
 > Is it possible IRL?

The EADC differential enable bit is global, so the check was intended to
reject buffered scans containing both single-ended and differential
channels.

However, after looking at the hardware constraints and the other review
comments, I plan to simplify v2 and reduce the initial upstream driver
scope. The v2 driver will focus on direct raw reads for the external
single-ended ADC channels only.

Triggered buffered capture, the device trigger and differential channel
support will be dropped from the initial submission. They can be added
later as follow-up patches once the scan sequencing, trigger model and
differential pair constraints are handled properly.

Thanks,
Chi-Wen

Andy Shevchenko 於 2026/6/26 下午 08:54 寫道:
> On Thu, Jun 25, 2026 at 07:06:38PM +0800, Chi-Wen Weng wrote:
>
>> Add an IIO driver for the Nuvoton MA35D1 Enhanced ADC controller.
>>
>> The driver supports direct raw reads and triggered buffered capture. The
>> controller end-of-conversion interrupt is exposed as the device trigger
>> and is used to push samples into the IIO buffer.
>>
>> Channels are described by firmware child nodes and can be configured as
>> single-ended or differential inputs. Since the differential enable bit is
>> global, mixed single-ended and differential buffered scans are rejected.
>>
>> DMA support is intentionally not included in this initial upstream driver;
>> conversions are handled through the interrupt-driven path.
> Nice written driver, some small issues here and there, and I think in a couple
> of versions it will stabilize and can be accepted.
>
> ...
>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
> No need, bitmap.h covers this.
>
>> +#include <linux/bitmap.h>
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/device.h>
> No need, covered by platform_device.h.
>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
> No way this header should be in the mere drivers.
>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/property.h>
> Also missing some headers, such as types.h.
>
> ...
>
>> +#define MA35D1_EADC_TIMEOUT		msecs_to_jiffies(1000)
> + jiffies.h
>
> ...
>
>> +static inline u32 ma35d1_adc_read(struct ma35d1_adc *adc, u32 reg)
>> +{
>> +	return readl(adc->regs + reg);
>> +}
>> +
>> +static inline void ma35d1_adc_write(struct ma35d1_adc *adc, u32 reg, u32 val)
>> +{
>> +	writel(val, adc->regs + reg);
>> +}
>> +
>> +static void ma35d1_adc_rmw(struct ma35d1_adc *adc, u32 reg, u32 mask, u32 val)
> Name it _update() to be aligned with the _read() and _write() above.
>
>> +{
>> +	u32 tmp;
>> +
>> +	tmp = ma35d1_adc_read(adc, reg);
>> +	tmp &= ~mask;
>> +	tmp |= val;
> Correct pattern is to use
>
> 	tmp = (tmp & ~mask) | (val & mask);
>
>> +	ma35d1_adc_write(adc, reg, tmp);
>> +}
> ...
>
>> +static void ma35d1_adc_config_sample(struct ma35d1_adc *adc,
>> +				     unsigned int sample, unsigned int channel)
>> +{
>> +	u32 reg = MA35D1_EADC_SCTL(sample);
> I don't see the need of this variable, use the value directly.
>
>> +	ma35d1_adc_rmw(adc, reg,
>> +		       MA35D1_EADC_SCTL_CHSEL_MASK |
>> +		       MA35D1_EADC_SCTL_TRGSEL_MASK,
>> +		       FIELD_PREP(MA35D1_EADC_SCTL_CHSEL_MASK, channel) |
>> +		       MA35D1_EADC_SCTL_TRGSEL_ADINT0);
>> +}
> ...
>
>> +static irqreturn_t ma35d1_adc_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	int i;
>> +
>> +	for (i = 0; i < adc->scan_chancnt; i++)
> 	for (unsigned int i = 0; i < adc->scan_chancnt; i++)
>
>> +		adc->scan.channels[i] =
>> +			ma35d1_adc_read(adc, MA35D1_EADC_DAT(i)) &
>> +			MA35D1_EADC_DAT_MASK;
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan, pf->timestamp);
>> +	iio_trigger_notify_done(adc->trig);
>> +
>> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0,
>> +		       MA35D1_EADC_CTL_ADCIEN0);
>> +	ma35d1_adc_write(adc, MA35D1_EADC_SWTRG, 1);
>> +
>> +	return IRQ_HANDLED;
>> +}
> ...
>
>> +static int ma35d1_adc_validate_scan(struct iio_dev *indio_dev,
>> +				    const unsigned long *scan_mask)
>> +{
>> +	const struct iio_chan_spec *chan;
>> +	bool have_single = false;
>> +	bool have_diff = false;
>> +	unsigned int count = 0;
>> +	unsigned long bit;
>> +
>> +	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
>> +		chan = &indio_dev->channels[bit];
>> +
>> +		if (chan->type == IIO_TIMESTAMP)
>> +			continue;
>> +		count++;
> Make it last in the loop, it will be standard pattern. Otherwise it's hard to
> read and find. Also it's recommended to split assignment and definition
> for better maintenance.
>
> 	unsigned int count;
> 	...
> 	count = 0;
> 	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
> 		...
> 		count++;
> 	}
>
>> +		if (chan->differential)
>> +			have_diff = true;
>> +		else
>> +			have_single = true;
>> +	}
>> +
>> +	if (!count || count > MA35D1_EADC_MAX_SAMPLE_MODULES)
>> +		return -EINVAL;
>> +	if (have_single && have_diff)
>> +		return -EINVAL;
> Is it possible IRL?
>
>> +	return 0;
>> +}
> ...
>
>> +static int ma35d1_adc_buffer_postenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	int i;
>> +
>> +	if (!adc->scan_chancnt)
>> +		return -EINVAL;
>> +
>> +	ma35d1_adc_write(adc, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
>> +	ma35d1_adc_rmw(adc, MA35D1_EADC_INTSRC0,
>> +		       MA35D1_EADC_INTSRC0_ADINT0,
>> +		       MA35D1_EADC_INTSRC0_ADINT0);
>> +	ma35d1_adc_rmw(adc, MA35D1_EADC_REFADJCTL,
>> +		       MA35D1_EADC_REFADJCTL_EXT_VREF,
>> +		       MA35D1_EADC_REFADJCTL_EXT_VREF);
>> +	ma35d1_adc_rmw(adc, MA35D1_EADC_SELSMP0, GENMASK(1, 0), 3);
>> +	ma35d1_adc_set_diff(adc, adc->scan_differential);
>> +	for (i = 0; i < adc->scan_chancnt; i++)
> 	for (unsigned int i = 0; i < adc->scan_chancnt; i++)
>
>> +		ma35d1_adc_rmw(adc, MA35D1_EADC_SCTL(i),
>> +			       MA35D1_EADC_SCTL_TRGDLY_MASK,
>> +			       MA35D1_EADC_SCTL_TRGDLY_MASK);
>> +
>> +	ma35d1_adc_rmw(adc, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0,
>> +		       MA35D1_EADC_CTL_ADCIEN0);
>> +	ma35d1_adc_write(adc, MA35D1_EADC_SWTRG, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_adc_buffer_predisable(struct iio_dev *indio_dev)
>> +{
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	int i;
>> +
>> +	ma35d1_adc_disable_irq(adc);
>> +	for (i = 0; i < adc->scan_chancnt; i++)
>> +		ma35d1_adc_rmw(adc, MA35D1_EADC_SCTL(i),
>> +			       MA35D1_EADC_SCTL_TRGSEL_MASK, 0);
> Ditto.
>
> Also looking to the cases of setting 0s, I would rather have a helper
> _set_bits() / _clear_bits() in conjunction with _update().
>
>> +	return 0;
>> +}
> ...
>
>> +static void ma35d1_adc_init_channel(struct ma35d1_adc *adc,
>> +				    struct iio_chan_spec *chan, u32 vinp,
>> +				    u32 vinn, int scan_index, bool differential)
>> +{
>> +	char *name = adc->chan_name[vinp];
>> +
>> +	chan->type = IIO_VOLTAGE;
>> +	chan->indexed = 1;
>> +	chan->channel = vinp;
>> +	chan->address = vinp;
>> +	chan->scan_index = scan_index;
>> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> +	chan->scan_type.sign = 'u';
>> +	chan->scan_type.realbits = 12;
>> +	chan->scan_type.storagebits = 16;
>> +	chan->scan_type.endianness = IIO_CPU;
>> +
>> +	if (differential) {
>> +		chan->differential = 1;
>> +		chan->channel2 = vinn;
>> +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d-in%d", vinp,
>> +			 vinn);
> Can compiler prove the buffer size is enough?
>
>> +	} else {
>> +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d", vinp);
>> +	}
>> +
>> +	chan->datasheet_name = name;
> Why not use devm_kasprintf() instead?
>
>> +}
> ...
>
>> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
>> +				     struct device *dev)
>> +{
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	DECLARE_BITMAP(used_channels, MA35D1_EADC_MAX_CHANNELS);
>> +	struct fwnode_handle *child;
>> +	struct iio_chan_spec *channels;
>> +	int num_channels;
>> +	int scan_index = 0;
>> +	int ret;
>> +
>> +	bitmap_zero(used_channels, MA35D1_EADC_MAX_CHANNELS);
>> +
>> +	num_channels = device_get_child_node_count(dev);
>> +	if (!num_channels)
>> +		return dev_err_probe(dev, -ENODATA,
>> +				     "no ADC channels configured\n");
>> +
>> +	if (num_channels > MA35D1_EADC_MAX_CHANNELS)
> Perhaps >= ?
>
>> +		return dev_err_probe(dev, -EINVAL, "too many ADC channels\n");
>> +
>> +	channels = devm_kcalloc(dev, num_channels + 1, sizeof(*channels),
>> +				GFP_KERNEL);
>> +	if (!channels)
>> +		return -ENOMEM;
>> +
>> +	device_for_each_child_node(dev, child) {
> Use _scoped() variant.
>
>> +		u32 diff[2];
>> +		u32 reg;
>> +		bool differential = false;
>> +
>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>> +		if (ret) {
>> +			fwnode_handle_put(child);
>> +			return dev_err_probe(dev, ret,
>> +					     "missing channel reg property\n");
>> +		}
>> +
>> +		if (reg >= MA35D1_EADC_MAX_CHANNELS) {
>> +			fwnode_handle_put(child);
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "invalid ADC channel %u\n", reg);
>> +		}
>> +
>> +		if (test_and_set_bit(reg, used_channels)) {
>> +			fwnode_handle_put(child);
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "duplicate ADC channel %u\n", reg);
>> +		}
>> +
>> +		if (fwnode_property_present(child, "diff-channels")) {
>> +			ret = fwnode_property_read_u32_array(child,
>> +							     "diff-channels",
>> +							     diff,
>> +							     ARRAY_SIZE(diff));
>> +			if (ret) {
>> +				fwnode_handle_put(child);
>> +				return dev_err_probe(dev, ret,
>> +						     "invalid diff-channels for channel %u\n",
>> +						     reg);
>> +			}
>> +
>> +			if (diff[0] != reg ||
>> +			    diff[1] >= MA35D1_EADC_MAX_CHANNELS ||
>> +			    diff[0] == diff[1]) {
>> +				fwnode_handle_put(child);
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "invalid differential ADC channel %u-%u\n",
>> +						     diff[0], diff[1]);
>> +			}
>> +
>> +			if (test_and_set_bit(diff[1], used_channels)) {
>> +				fwnode_handle_put(child);
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "ADC channel %u already used\n",
>> +						     diff[1]);
>> +			}
>> +
>> +			differential = true;
>> +		}
>> +
>> +		ma35d1_adc_init_channel(adc, &channels[scan_index], reg,
>> +					differential ? diff[1] : 0,
>> +					scan_index, differential);
>> +		scan_index++;
>> +	}
>> +
>> +	channels[scan_index] = (struct iio_chan_spec)
>> +		IIO_CHAN_SOFT_TIMESTAMP(scan_index);
>> +
>> +	indio_dev->channels = channels;
>> +	indio_dev->num_channels = scan_index + 1;
>> +	indio_dev->masklength = indio_dev->num_channels;
>> +
>> +	return 0;
>> +}
> ...
>
>> +	ret = devm_request_irq(dev, irq, ma35d1_adc_isr, 0, dev_name(dev),
>> +			       indio_dev);
> Make it a single line, here it's fine.
>
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to request IRQ %d\n", irq);
> Remove duplicate error message.
>
> ...
>
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>> +					      iio_pollfunc_store_time,
>> +					      ma35d1_adc_trigger_handler,
>> +					      &ma35d1_adc_buffer_ops);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to setup triggered buffer\n");
> So, it seems this is very rarely can be not -ENOMEM, and hence it's 99.99% dead
> code, just
>
> 		return ret;
>
