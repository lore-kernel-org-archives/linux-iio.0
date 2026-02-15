Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24623BCED;
	Sun, 15 Feb 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771178346; cv=none; b=P1CkLvigKRkxI9tYUAEdNGh5uzeCkJLQkTcLi60i0tiBk2E2V3WjIoFjQoFJhDeLHi4v/sRP1+k/e54ldL3rMM6b0LdLk0aAT8MPdIpIw79SO7hU9onaCsgbdwew5pIuVhtIZQ/tQA7k2MQmuZ9IYXgADGF5yoMv7egdKpLirwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771178346; c=relaxed/simple;
	bh=AK8bkY1Hzt0K1o+QkAdUXIn+RKmgl6uBFyfeLad4pZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssWR4sNEj75TjVCpXQj8R45fSgt3YpYpNVJzWPGPb/DKbWdrLzoz92kNHcGPgiSIlUvnBtXeSoD+rb97jWPB3dIaMGkCFNMb5/LSnhc9vbk4VDuarx458k98rpAhOmHEvpFhqRD1Vw3Yz5rNByKA6RLRQHRD94gWbYOF3fN+FbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTtTGAxR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTtTGAxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757DEC4CEF7;
	Sun, 15 Feb 2026 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771178346;
	bh=AK8bkY1Hzt0K1o+QkAdUXIn+RKmgl6uBFyfeLad4pZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BTtTGAxRx3+RSFDTWOjTVaaNt1CPCqhB+emH7/ElizjcPZCUVRmpx2t+UIRbPDYTq
	 JauumOsGxip/kCZ9PAOUJYK8nHz8KNMlR3FgoqR7RIMqg0dWxYBUD92gso+zNZcIph
	 Lsa0W26vfOPVzOd5uzrC0jTuOSZBs3nrK1aLW47w1ond1TR14tVkjQcMHe+fNToiUa
	 gfnIkyKqQib8fm9WizJqIjfhm9G2q3+U+jnY1MXyL9A8eNAwo2WleGzPyiH+8d9DY1
	 wYxb1DceIMoPM1ZM8g+oOepKLz2nm/ehEYXOY0bdmxF0BONT2hLu3ls2uAea/HHs0F
	 Z1OyHEzli/B4w==
Date: Sun, 15 Feb 2026 17:58:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Message-ID: <20260215175857.4085bc2c@jic23-huawei>
In-Reply-To: <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	<20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 14:48:35 +0200
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip MCP48FxBy1/2/4/8 series of buffered
> voltage output Digital-to-Analog Converters with nonvolatile or volatile
> memory and an SPI Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Hi Ariana,
Given the much larger outstanding question on whether this can share a driver
with other similar parts I only took a very quick look at this version.

Comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/mcp48feb02.c b/drivers/iio/dac/mcp48feb02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..20955f77053329a9c385f55c7314032eb6b04dfd
> --- /dev/null
> +++ b/drivers/iio/dac/mcp48feb02.c

> +
> +static int mcp48feb02_init_ctrl_regs(struct mcp48feb02_data *data)
> +{
> +	unsigned int i, vref_ch, gain_ch, pd_ch;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_VREF_REG_ADDR, &vref_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_GAIN_CTRL_STATUS_REG_ADDR, &gain_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, MCP48FEB02_POWER_DOWN_REG_ADDR, &pd_ch);
> +	if (ret)
> +		return ret;
> +
> +	gain_ch = gain_ch & MCP48FEB02_GAIN_BITS_MASK;
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		struct device *dev = regmap_get_device(data->regmap);
> +		unsigned int pd_tmp;
> +
> +		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP48FEB02_DAC_CTRL_MASK;
> +		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP48FEB02_GAIN_BIT_MASK;
> +
> +		/*
> +		 * Inform the user that the current voltage reference read from the volatile
> +		 * register of the chip is different from the one specified in the device tree.
> +		 * Considering that the user cannot have an external voltage reference connected
> +		 * to the pin and select the internal Band Gap at the same time, in order to avoid
> +		 * miscofiguring the reference voltage, the volatile register will not be written.

Spell check comments.  misconfiguring

> +		 * In order to overwrite the setting from volatile register with the one from the
> +		 * device tree, the user needs to write the chosen scale.

I'm a little unsure of why we need this extra gate on updating things to match
the device tree provided config.  Why should the volatile register at this point
match what DT says?  If it does seems to me we should be noisier about it than dev_dbg()


> +		 */
> +		switch (data->chdata[i].ref_mode) {
> +		case MCP48FEB02_INTERNAL_BAND_GAP:
> +			if (data->phys_channels >= 4 && (i % 2) && data->use_vref1) {
> +				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
> +				dev_dbg(dev, "ch[%u]: reference voltage set to VREF1", i);
> +				break;
> +			}
> +			if ((data->phys_channels < 4 || (data->phys_channels >= 4 && !(i % 2))) &&
> +			    data->use_vref) {
> +				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
> +				dev_dbg(dev, "ch[%u]: reference voltage set to VREF", i);
> +				break;
> +			}


