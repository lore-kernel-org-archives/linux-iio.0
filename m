Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com [101.71.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2301898FB;
	Fri, 17 Jul 2026 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256214; cv=none; b=bqVQK2UmdzxeLdi7gE3wxGLMqs5TdV6JxEF4HV60Wr4PfCy6CNS+QGAktxJSz1OUd0ecPrycuQwMpcy1jX/JGxKp0BfzeX/ij1mJGerdqA0/y4WUebvF/R1dHUccLVXSiI5uk9Dn34K6P5zZA53Nk6yWI9iM+4/yJ627DkdqBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256214; c=relaxed/simple;
	bh=mgbTsIvSpUkt8yfPB9/LCotfwQcKSFgw9CN0tbcjYbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCCnyB3VeRTZL3aSB2pUSR3DHn+j89RzFm13vlq2Gy8b7q5e5LV7FxtV8lcPbFESctX6TAdZFtC1gQOyDQZRVGOLAepAuog2r4YY3nMMQUgL8lRD+rIooSIRDvJMbb0mHj+C20d2A7Gkcn2aAwIykuIbe8q1t1901/YstTw9nLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XgfBY9Ty; arc=none smtp.client-ip=101.71.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XgfBY9Ty"
Received: from [172.16.12.74] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 46859c9bd;
	Fri, 17 Jul 2026 10:38:08 +0800 (GMT+08:00)
Message-ID: <cb0d7306-ee3a-4df8-aed4-e7e5b4e2cc16@rock-chips.com>
Date: Fri, 17 Jul 2026 10:38:08 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
 <alDK7JahbqYpwQmZ@monoceros>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <alDK7JahbqYpwQmZ@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6df03d4603a8kunmde6ff62349f89
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHxpDVktOQ01PQ0lJGBpNGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XgfBY9TygDAgGW+TnQhdKri9XOCiteJldFJIFc92VlZOH4m4c8Hrv1MuWydsFFtdFO+0ihNUUH4V/uzVZrx3GNcsycjs/F7cIEOxM1QmBpvQSJKfgAWTtKZbKDUy4bb2SLkMb27wtSpy+GBP0okIG6SC13XlC9URiLwuQDHxgW4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=4+trae873noI6M/KTwB+mA2F5xNHhg6Nh9ODu1W4DXc=;
	h=date:mime-version:subject:message-id:from;

Hi Uwe,

On 7/10/2026 7:02 PM, Uwe Kleine-König wrote:
> Hello Nicolas,
> 
> On Mon, Apr 20, 2026 at 03:52:40PM +0200, Nicolas Frattaroli wrote:
>> [...]
>> +/**
>> + * rockchip_pwm_v4_round_single - convert a PWM parameter to hardware
>> + * @rate: clock rate of the PWM clock, as per clk_get_rate
>> + *        Assumed to be <= 1GHz for overflow considerations
>> + * @in_val: parameter in nanoseconds to convert
>> + *
>> + * Returns the rounded value, saturating at U32_MAX if too large
>> + */
>> +static u32 rockchip_pwm_v4_round_single(unsigned long rate, u64 in_val)
> 
> very picky: if you name this function rockchip_pwm_v4_ns_to_ticks it
> becomes clearer what the purpose is.
> 
>> +{
>> +	u64 tmp;
>> +
>> +	tmp = mul_u64_u64_div_u64(rate, in_val, NSEC_PER_SEC);
>> +	if (tmp > U32_MAX)
>> +		tmp = U32_MAX;
>> +
>> +	return tmp;
>> +}
>> +
>> +/**
>> + * rockchip_pwm_v4_round_params - convert PWM parameters to hardware
>> + * @rate: PWM clock rate to do the calculations at
>> + * @wf: pointer to the generic &struct pwm_waveform input parameters
>> + * @wfhw: pointer to the hardware-specific &struct rockchip_pwm_v4_wf output
>> + *        parameters that the results will be stored in
>> + *
>> + * Convert nanosecond-based duty/period/offset parameters to the PWM hardware's
>> + * native rounded representation in number of cycles at clock rate @rate. Should
>> + * any of the input parameters be out of range for the hardware, the
>> + * corresponding output parameter is the maximum permissible value for said
>> + * parameter with considerations to the others.
>> + */
>> +static void rockchip_pwm_v4_round_params(unsigned long rate,
>> +					 const struct pwm_waveform *wf,
>> +					 struct rockchip_pwm_v4_wf *wfhw)
>> +{
>> +	wfhw->period = rockchip_pwm_v4_round_single(rate, wf->period_length_ns);
>> +
>> +	wfhw->duty = rockchip_pwm_v4_round_single(rate, wf->duty_length_ns);
>> +
>> +	/* As per TRM, PWM_OFFSET: "The value ranges from 0 to (period-duty)" */
> 
> Have you tried what happens if you break this rule? That seems like a
> very arbitrary restriction that might just originate from the
> documentation author.
> 

According to the IC design, any offset value larger than (period - duty) 
will be clamped to (period - duty) by the hardware internally. Given 
this hardware limitation, the validation check Nicolas introduced does 
serve a practical purpose.

>> +	wfhw->offset = rockchip_pwm_v4_round_single(rate, wf->duty_offset_ns);
>> +	if (!wfhw->period) /* Don't underflow when pwm disabled */
>> +		wfhw->offset = 0;
>> +	else if (wfhw->offset > wfhw->period - wfhw->duty)
>> +		wfhw->offset = wfhw->period - wfhw->duty;
> 
> You don't enforce wfhw->period >= wfhw->duty, which however seems like a
> reasonable restriction. When knowing that you can drop the explicit
> check for !wfhw->period and just keep the else-if branch.
> 
>> +}
>> [...]
>> +static int rockchip_pwm_v4_write_wf(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				    const void *_wfhw)
>> +{
>> +	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
>> +	const struct rockchip_pwm_v4_wf *wfhw = _wfhw;
>> +	bool was_enabled;
>> +	int ret;
>> +
>> +	ret = mfpwm_acquire(pc->pwmf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	was_enabled = rockchip_pwm_v4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
>> +								PWMV4_REG_ENABLE));
>> +
>> +	/*
>> +	 * "But Nicolas", you ask with valid concerns, "why would you enable the
>> +	 * PWM before setting all the parameter registers?"
>> +	 *
>> +	 * Excellent question, Mr. Reader M. Strawman! The RK3576 TRM Part 1
>> +	 * Section 34.6.3 specifies that this is the intended order of writes.
>> +	 * Doing the PWM_EN and PWM_CLK_EN writes after the params but before
>> +	 * the CTRL_UPDATE_EN, or even after the CTRL_UPDATE_EN, results in
>> +	 * erratic behaviour where repeated turning on and off of the PWM may
>> +	 * not turn it off under all circumstances. This is also why we don't
>> +	 * use relaxed writes; it's not worth the footgun.
> 
> I wonder if it's worth however to delay setting PWMV4_CTRL_UPDATE_EN
> until after the clkrate is handled to (maybe) prevent glitches?

I agree with your point. For the PWM enable sequence, we should enable 
the PWM dclk before any register operations. Conversely, when disabling 
PWM, it's better to carry out dclk disabling only after all register 
accesses are fully completed.

> 
>> +	 */
>> +	if (wfhw->rate)
>> +		mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
>> +				FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK,
>> +						PWMV4_EN_BOTH_MASK));
>> +	else
>> +		mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
>> +				FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK, 0));
>> +
>> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_PERIOD, wfhw->period);
>> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_DUTY, wfhw->duty);
>> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_OFFSET, wfhw->offset);
>> +
>> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL, PWMV4_CTRL_CONT_FLAGS);
>> +
>> +	/* Commit new configuration to hardware output. */
>> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
>> +			PWMV4_CTRL_UPDATE_EN);
>> +
>> +	if (wfhw->rate) {
>> +		if (!was_enabled) {
>> +			dev_dbg(&chip->dev, "Enabling PWM output\n");
>> +			ret = clk_enable(pc->pwmf->core);
>> +			if (ret)
>> +				goto err_mfpwm_release;
>> +			ret = clk_set_rate_exclusive(pc->pwmf->core, wfhw->rate);
>> +			if (ret) {
>> +				clk_disable(pc->pwmf->core);
>> +				goto err_mfpwm_release;
>> +			}
>> +
>> +			/*
>> +			 * Output should be on now, acquire device to guarantee
>> +			 * exclusion with other device functions while it's on.
>> +			 *
>> +			 * It's highly unlikely that this fails, as mfpwm has
>> +			 * already been acquired before, and this is just a
>> +			 * usage counter increase. Not worth the added
>> +			 * complexity of clearing the PWMV4_REG_ENABLE again,
>> +			 * especially considering the CTRL_UPDATE_EN behaviour.
>> +			 */
>> +			ret = mfpwm_acquire(pc->pwmf);
>> +			if (ret) {
>> +				clk_rate_exclusive_put(pc->pwmf->core);
>> +				clk_disable(pc->pwmf->core);
>> +				goto err_mfpwm_release;
>> +			}
>> +		}
> 
> Can it happen that we have
> 
> 	wfhw->rate && was_enabled && wfhw->rate != clk_get_rate()
> 
> ?
> 
>> +	} else if (was_enabled) {
>> +		dev_dbg(&chip->dev, "Disabling PWM output\n");
>> +		clk_rate_exclusive_put(pc->pwmf->core);
>> +		clk_disable(pc->pwmf->core);
>> +		/* Output is off now, extra release to balance extra acquire */
>> +		mfpwm_release(pc->pwmf);
>> +	}
>> +
>> +err_mfpwm_release:
>> +	mfpwm_release(pc->pwmf);
>> +
>> +	return ret;
>> +}
>> [...]
>> +static int rockchip_pwm_v4_probe(struct platform_device *pdev)
>> +{
>> +	struct rockchip_mfpwm_func *pwmf = dev_get_platdata(&pdev->dev);
>> +	struct rockchip_pwm_v4 *pc;
>> +	struct pwm_chip *chip;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	/*
>> +	 * For referencing the PWM in the DT to work, we need the parent MFD
>> +	 * device's OF node.
>> +	 */
>> +	dev->of_node_reused = true;
>> +	device_set_node(dev, of_fwnode_handle(dev->parent->of_node));
>> +
>> +	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +
>> +	pc = to_rockchip_pwm_v4(chip);
>> +	pc->pwmf = pwmf;
>> +
>> +	ret = mfpwm_acquire(pwmf);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Couldn't acquire mfpwm in probe\n");
>> +
>> +	if (!rockchip_pwm_v4_on_and_continuous(pc))
>> +		mfpwm_release(pwmf);
>> +	else {
>> +		dev_dbg(dev, "PWM was already on at probe time\n");
>> +		ret = clk_enable(pwmf->core);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret, "Enabling pwm clock failed\n");
>> +			goto err_mfpwm_release;
>> +		}
>> +		ret = clk_rate_exclusive_get(pc->pwmf->core);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret, "Protecting pwm clock failed\n");
>> +			goto err_clk_disable;
>> +		}
>> +	}
>> +
>> +	platform_set_drvdata(pdev, chip);
> 
> This is unused.
> 
>> +
>> +	chip->ops = &rockchip_pwm_v4_ops;
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Failed to add PWM chip\n");
>> +		if (rockchip_pwm_v4_on_and_continuous(pc))
>> +			goto err_rate_put;
>> +
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_rate_put:
>> +	clk_rate_exclusive_put(pwmf->core);
>> +err_clk_disable:
>> +	clk_disable(pwmf->core);
>> +err_mfpwm_release:
>> +	mfpwm_release(pwmf);
>> +
>> +	return ret;
>> +}
> 
> Best regards
> Uwe

Best regards,
Damon

