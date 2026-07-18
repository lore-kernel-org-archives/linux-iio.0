Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316A379999
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784414415; cv=none; b=MXtppCrVkw8n6E4hLVdTpbskTAAFdeUOdh07fH7IfpZgz4gH4fjUIFC3YshSEMHPyMpbkpAAcwFXnv/qCjhu54dLrFGuUJd0q7+fRAynYJPFhZJwn+v9Yl3qXMCBfHQ79EGp5biURAwNZCxBfXlq/kwMOZPLM1xOsOpBQdVIqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784414415; c=relaxed/simple;
	bh=ij9zSvaARFFdNiQibj8Hn+xroqdI78iNy60qatAmMN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFhkoulG8JZMCcm/tQJ+D7CLSL7jYZs0OHMJ7TSAAs5JwTziqXU8OodJuI5rxuBVXvFquGV42QgH6ITKdEGMM518ZOd+0ZztAskeT5PwVpPHEqx1R0ZTXtFvzGApLFy2bQIn5Jc6PilFPD5VWBSHUFXiON9fLhMmZVsfML2uRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CQwqE0Ix; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lf6MwBym; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CQwqE0Ix";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lf6MwBym"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJr5jk1430700
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFDnOTEdzHVmM59NkckRT1t2GNOeWUkaT0VyaskjyP8=; b=CQwqE0IxaCXiQLFO
	4ICgfn+lRqE1Z3PJrvjblq0qK/YrnyrEfqcmc3aFIdz2uGV/wKqpaw9xdO63fCKL
	V0pGAUffAOpG6gTBmPEjf5v7m7JP8nsQvne3ojoxch7PwR1cgfo4kSqVzsyqhDzK
	z2zWbFPqzrvtHnYAAKChvZBwTYK05DAtgDV+7DBfKaFOfr8/EHjHhcgd+DfQ593A
	3fJy85gOFpyBb8QKOk/xMj5lrbW1Vc7VpWb1LQtGxrfDJ0KWSjigEQ3C4rutZJz/
	ArUURrNHO8KvHJSPXbaPr6Rxms0Jh2qph1OKhToKOsu1xneCSu8pK8WDhZU6s3vh
	ZadAdA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chhpav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:40:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb74d5db64eso13653a12.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784414409; x=1785019209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFDnOTEdzHVmM59NkckRT1t2GNOeWUkaT0VyaskjyP8=;
        b=Lf6MwBymu5jNfESC9VTXu1GB+IX7Ua7dPaK6sWUvUKuVK1o5exzMljqXstc8FqlUOE
         QqYHO+PDu99oDdTjHf1QgalQ7Q0OkGWyygAfUqc9iyuPB8kCnMEvd0ZdQeAKALwrlKeR
         gn49sxkyltSJNJSrIj17YqtQcihNpYAURMdZKH/H7LrgK+GthZX2DRXjnKeRenX5CfQf
         zrbCoeBvFD/opFhAMWiF9FLsFd5Dw4eY7fXoJZG6at4OtytT9LYO4gis8EkSQ0g+AoqR
         Rl6MKmgyFprUrwLEazWESH1whzq2cl8UDN8zgmdiWald4vs4cqvs5udAQGAeQRUiuCwk
         yLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784414409; x=1785019209;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFDnOTEdzHVmM59NkckRT1t2GNOeWUkaT0VyaskjyP8=;
        b=WG9dh7r0nhP9HPVlaRGw3Z+IMTZSxWP8ynRKENKUK6qEhnfwdqUpj53yeu6ros07mN
         +uTXPqsl1QeUC2pb08F81wyzFlFceONWQL7wyGIYsMDHj7hEBH/O62RiVsGF0PxDFBZJ
         WWnE8xN0XCSVlrwC5E96Gf+tfY1ZI83zacT3BXvOcPqAbd/sJ0WTygXPyEpvI9Nzs8lY
         LXNX4herju2gJVA5ZfDGW0TTHGfpvYzptPAMhLCdu6IVlq9eTDTsxXKkBBPZiIRDnlge
         UevrEWZClw06nsfE370GFaaWdIgVnNbcmegVjkjufQIEX4NuhceOxqYBfZc03imiYmoK
         IsmQ==
X-Gm-Message-State: AOJu0YwB0ywLbayWJzCFERyaOvjeJwMks80bHaBnM3vABsFOI/ofrVxw
	uAWrZIalY6JU2abG0f0OQkt/KZ1HXjX7RM81mUtv3S+zaeeEmuVvvkDGVp13M2bsHPTbFYHVbFn
	b7SBMKoBle9VPSQZTqNpDHlH6OoRcdpqOGJYdpW6KGUpef4h4gztt5R8/2c2sO5A=
X-Gm-Gg: AfdE7cm1ELG+OJHIgoOGdrcmFBoA5CiOjo7jhCNFB1s1PCX5IZfs+uXDCMqCGMNrqR2
	M5pZMw3QjlYaM3iYDc07l9MoyosCq/ZqCFKcx0Pox0HBObthFOpJPvXx3bLpY9/KUf9SIYtHdCU
	caLseQlbHEFlHWtD31mEIi1OW6CWi+4bG5UDtWa/rs/z5ibTpNcygGRR82rbHneIWiKccxVjVE0
	6tsITrN8eE5lhnSFGQaVk5HadXB/ATO1/JnvFfXjDZDcOllTwSdVqARPdKT8PWMha66iWrMMvhL
	Gk6Lr+G8Nj3nBb82u3EL9E5phgVhpaqPkRxePehhLLEcutKY7hb3Atf2mkgfjYH3sa5i+uuPW/P
	CiCdHA8uqyByx0A5s
X-Received: by 2002:a05:6a21:512:b0:3bf:7f0b:2f6e with SMTP id adf61e73a8af0-3c3ad9d1ba1mr8201485637.46.1784414408610;
        Sat, 18 Jul 2026 15:40:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:512:b0:3bf:7f0b:2f6e with SMTP id adf61e73a8af0-3c3ad9d1ba1mr8201476637.46.1784414408156;
        Sat, 18 Jul 2026 15:40:08 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb334sm2620363a12.18.2026.07.18.15.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:40:07 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:40:00 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andriy.shevchenko@intel.com,
        u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com,
        nuno.sa@analog.com, Michael.Hennerich@analog.com,
        dlechner@baylibre.com, linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260718233949.2b1bc12f@jic23-huawei>
In-Reply-To: <20260717201138.1078019-3-shofiqtest@gmail.com>
References: <20260717201138.1078019-1-shofiqtest@gmail.com>
	<20260717201138.1078019-3-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzNyBTYWx0ZWRfX6157t8+w6ozh
 BoHJ68D43CcS/i3+n4SPK+RPj+0itJI7+RWNvDB1mYbs0rHBU1zpkIakp/NLMASjiHN1BMfzvfI
 R4uBG6TNMN9zeFht/nl9uy9BluxCUNA=
X-Proofpoint-GUID: FJGF3r0WH0udFNv9aPMDo5ch774i8FAF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzNyBTYWx0ZWRfX3vrfQz6c8ucL
 e8Uet3vtn6Fd7L0oXF84DvKyAMiT4gk0m3vpcjfYbxTOXgIi5777F4U16c//bWYkq1BcNeQvf0N
 IjpT4lllkNqeJ6aVo5VCpoADCkcXKMlYVNPfi8lwqcik1WlyQCzvVUIjWPVWO6roUuEQqhbQAWa
 qYdtnlOyQ+LYZQewiv3ERVn2EhbXgIf1xvagpKU0oClkIhvKMcxrllYPFkX7uEyQGG4hQ2fvIJb
 mfQVLKacNuh560CZri2CpuYH+d3Ooi3yBWqFEnTPt5+qWw4WbQjFEPU/Yhoeeyt/D6d2h/ZI7rr
 sK029dVr13CCXLvbnPomCsLdoXVT9UIhnkoeGehE33xMYR9CZAfWfwqlVQppRWSf6gI+j3hOTxQ
 Wnyj3oPjqAz7qIGp0etZ1yJifGZvE+bf/iF8v+R/MoKEBLo3S4mMdz6kRfCSycNVwofBxrOVmhu
 A+TX4s3ZXE7lRrQTTQQ==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5c00c9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=80GZHuB-04ZerDwFyH4A:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: FJGF3r0WH0udFNv9aPMDo5ch774i8FAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180237

On Fri, 17 Jul 2026 23:11:37 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Add a new IIO driver for the Analog Devices MAX86150 integrated
> biosensor, which combines two PPG optical channels (Red/IR LED) and
> one ECG biopotential channel in a single I2C device.
> 
> The device has a 32-entry hardware FIFO with a configurable almost-full
> interrupt. The driver uses the standard IIO hardware-trigger and
> triggered-buffer framework: a hard-irq handler reads and clears
> INT_STATUS1 to de-assert the line before calling iio_trigger_poll(),
> and the threaded trigger handler drains the FIFO and pushes samples,
> with timestamps back-calculated from the interrupt arrival time by one
> sample_period_ns per step. Relying on the trigger core's own
> attach/detach synchronization avoids the need for an explicit
> iio_buffer_enabled() guard or synchronize_irq() in the interrupt path.

Why is it using a triggered buffer + trigger?  We normally don't do
that when a hardware fifo is involved. That stuff is all about when
a trigger indicate a scan of channels (one set of samples of all channels).

Look at the drivers that register a kfifo directly.  Sorry I didn't
raise this earlier.  I think I got too focused on the narrow details
rather than the big picture.


> 
> Key implementation details:
> - Part ID register (0xFF) verified against 0x1E on probe; mismatched
>   devices are rejected with -ENODEV so the driver cannot bind to the
>   wrong hardware
> - Stale A_FULL and PPG_RDY status bits are cleared before arming the
>   interrupt or polling for a sample, so a previously-latched flag
>   cannot fire the handler against garbage state
> - 24-bit FIFO words decoded directly from the raw byte buffer
> - regmap_set_bits() / regmap_clear_bits() for single-direction writes
> - Device remains in shutdown between captures to suppress LED current
> - vdd, avdd, vref and leds regulators required per the datasheet power
>   tree
> - iio_get_time_ns() used for timestamps so they respect the IIO
>   device's configured clock source
> - A_FULL status bit used to detect FIFO exactly full (wr_ptr == rd_ptr
>   with OVF_COUNTER == 0) so valid samples are not silently dropped
> - No IRQ trigger-type override: the device has no register to
>   reconfigure interrupt polarity or type, so IRQF_ONESHOT with
>   whatever type firmware provides is sufficient
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>


> diff --git a/drivers/iio/health/max86150.c b/drivers/iio/health/max86150.c
> new file mode 100644
> index 0000000000000..47d96570a95fc
> --- /dev/null
> +++ b/drivers/iio/health/max86150.c



> +static int max86150_chip_init(struct max86150_data *data)
> +{
...
> +	if (ret)
> +		return ret;
> +
> +	data->sample_period_ns = 10000000; /* matches MAX86150_PPG_SR_SP_100HZ above */

Probably express as NANO / 100;


> +
> +static int max86150_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max86150_data *data;
> +	unsigned int part_id;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable avdd supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vref");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable vref supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "leds");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable leds supply\n");

Given there are 4 of these devm_regulator_bulk_get_enable() probably makes sense.

> +
> +	data->regmap = devm_regmap_init_i2c(client, &max86150_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to init regmap\n");
> +
> +	ret = regmap_read(data->regmap, MAX86150_REG_PART_ID, &part_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot read part ID\n");
> +
> +	if (part_id != MAX86150_PART_ID_VAL)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unexpected part ID 0x%02x (expected 0x%02x)\n",
> +				     part_id, MAX86150_PART_ID_VAL);

This breaks fallback dt compatibles. Normally if we get a missmatch we just print
a message and carry on anyway.  If we need to not do that for some reason here
add a comment to that affect.

> +
> +	ret = max86150_chip_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Chip initialisation failed\n");
> +
> +	ret = devm_add_action_or_reset(dev, max86150_powerdown, data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name         = "max86150";
> +	indio_dev->channels     = max86150_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max86150_channels);
> +	indio_dev->info         = &max86150_iio_info;
> +	indio_dev->modes        = INDIO_DIRECT_MODE;
> +
> +	if (client->irq > 0) {
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &max86150_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		/*
> +		 * The device only ever drives an active-low interrupt line;
> +		 * there is no register to reconfigure its polarity or type,
> +		 * so the trigger type from firmware needs no help here.

Not need to say this.  It is most common situation.

> +		 */
> +		ret = devm_request_threaded_irq(dev, client->irq,
> +						NULL,
> +						max86150_irq_handler,
> +						IRQF_ONESHOT,
> +						"max86150", data->trig);

Using a trigger for a fifo full interrupt is always a little bit overly
complex.  In this case you have both validation function set so
you can't use the buffer without this trigger being available.
If it is meaningful to trigger this from another source then
maybe you use a triggered_buffer.  In some cases where both types
of operation are things people want (maybe from a sysfs trigger) we don't
necessarily register a trigger for the fifo interrupt. The lack of having
set a trigger can mean that path should be used.

Normal thing to do in this case is no trigger + directly register
a kfifo to fill from the hardware fifo.  Simply turning that buffer
on is the signal to begin capture.

> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_trigger_register(dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to register trigger\n");
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      max86150_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Set the default trigger AFTER buffer setup succeeds.  Setting it
> +	 * before would leak the iio_trigger_get() reference if buffer setup
> +	 * failed: INDIO_BUFFER_TRIGGERED is not set on that path so
> +	 * iio_device_release() skips iio_trigger_put().

I don't believe there is anything stopping you just registering
the triggered_buffer before the trigger.  That would get rid of
this complexity.

> +	 */
> +	if (data->trig)
> +		indio_dev->trig = iio_trigger_get(data->trig);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
