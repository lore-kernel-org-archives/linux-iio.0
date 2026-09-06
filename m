Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B923C1D56;
	Sun,  6 Sep 2026 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666630; cv=none; b=Nx5LWghz8Rt8wqajNDP4MjMjEv7H43X+buSkjA3rY+JmoJshxee4Spff7/ezoAhbAjAEvQJ3Z88hfustrYI0+K0sVQ8heG1E2rqwOrhF6mQlAUJXs9io0FHKwbHk38SwadIiV9kv4TWattPX0pBXI1VXAyom0a7RpRKeeW3JpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666630; c=relaxed/simple;
	bh=3fGxj/LMO/tlRVFWipP6PXFdmMoN3iPZH12tQhgdmNc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jvTOZs4JarOrieYMk8mWxitpLupxTpLVZR5FbQn2HgZchv/XVC/o6sC6ryfPzazOxS6R88XXIkvxfMMwm8Chl/gUuYgxJq4hzZlML7I/OUHGjBJ71ZNxVCzvSU6Pko8b+KEMrOBSgifwme/Qav6jOrGCdpOG1YIIVWYnVJ2BwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syjpgfo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syjpgfo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816451F00A3E;
	Sun,  6 Sep 2026 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666628;
	bh=xSIpk+ati2gIGu1zdo48qFw5ioS7rp/Qb8S0eB+cZ2w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Syjpgfo2efQrWArDKEniEM9u792Ag/kE9jkLFnVM0gCGsXeIBYA1+Nr1X5R3subbz
	 ADJ8PZpLmTqHS6xI510JtSLrLlBXpgyTPuJEkHwh/VRCGxb90Xsh0eG/zSVZbSmp0x
	 zF/uudk+3sCjPVwquDuOH5lPCZNWlSiXClAKSTPAWACqLaFjgFimEmPschyJTm809D
	 PEYOQyABDESQu634snMtXPEPnmwzhLHWydhluJ+OwI3Ov4C4cf5bqNifLZUnmm/gkc
	 Ljnjy+JPaJNYaPeUzSpoby8iIZQAlWV9ApCWIFBdXgxfmK5E4TGC06RR31q6DkM9KH
	 X8+OIMJZZuVHg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 05/17] iio: adc: Add AD7768 and AD7768-4 core
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260904-ad7768-driver-v6-5-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-5-e4378f946bfb@analog.com>
Date: Sun, 06 Sep 2026 04:50:02 +0100
Message-Id: <178866660277.3402141.13365217395986099796.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=3fGxj/LMO/tlRVFWipP6PXFdmMoN3iPZH12tQhgdmNc=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnOL+MlAxk3QVlmXOjsdB3IN+disaB59XtAzed
 TNwlWuSOKWJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzi/hEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiDM7EACEjt3juTHhhSwGEG96HFJdhQR8pBywE1S3eumZJFQwzrM
 oZbOUg5cKbRxSn4912b9HNTU0J+H6EKgDbK0nK0GBaaXBPbvUZon5mU4rnOzfaRGwuyGA+CJSLf
 xBTjTStKMvbMAwae396+/BVRn7IgHgbpcuc9YxIjJqBNdA5ixgQqvKsaaHP5BlgmWXJLsYrzK/Q
 nikXyYg15Bkbijp6lNQTLTR23EjoM9DAGFsKTFZwJXk4BvsmVqHQqvR3vEFpPYQdK3FGofKw1Cv
 RlnRXz9Hx1b5oofhVJu+NzO+3w1rTS9aCODadluzXtVKKZIAs3Ko+tqIOp3iRfx591OIzoc81MV
 OZ8QTKN0qD1yLK7o/6+LNp+tM2kXOq6owWSQYFfzPShfAOkMbDix0o1rLe+vN0NITSFsX4opxCV
 4YeJBgTmFroqBLHv5HHFBFX0bj6juwkH8eALGXsNfx39QE8Pt0wSIN3pasI6uiWHg6GSOwYTUhY
 +N4U7infpJBVWs1wyL+nL27TOBSELZ4RwHJeowDpK87CwNKVoL4dXqcHosiCiPE3nSco09/91Fj
 +oJuwda8MuU6Fo5G0dcAScAxFjcH4ipowxQ3IgzpqLlpkSeq6VEAo0lLvlOCMK8prahlFW5q+ne
 G3A5PJ75dzoLuwFZCPfPY9JXhByfJuYk9J9eVMw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Just a few minor things I spotted on a fresh look at this.



> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> new file mode 100644
> index 000000000000..c80056a9edd8
> --- /dev/null
> +++ b/drivers/iio/adc/ad7768.c

> +
> +static int ad7768_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct spi_device *spi = context;

I'm not seeing huge value in teh local variable. I'd rename context
to spi and just pass it directly to spi_write()

Not important if you strongly prefer this way though.
> +
> +	return spi_write(spi, data, count);
> +}
> +

...

> +
> +static int ad7768_get_enable_vref(struct device *dev, unsigned int index)
> +{
> +	const char * const *supply = ad7768_vref_supply_names[index];
> +	int refp_uV;
> +	int refn_uV;
> +
> +	refp_uV = devm_regulator_get_enable_read_voltage(dev, supply[0]);
> +	if (refp_uV < 0)
> +		return dev_err_probe(dev, refp_uV,
> +				     "Failed to get %s supply voltage\n", supply[0]);
> +
> +	refn_uV = devm_regulator_get_enable_read_voltage(dev, supply[1]);
> +	if (refn_uV == -ENODEV)
> +		refn_uV = 0;
> +	else if (refn_uV < 0)
> +		return dev_err_probe(dev, refn_uV,
> +				     "Failed to get %s supply voltage\n", supply[1]);
> +
> +	if (refp_uV <= refn_uV)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid reference %u voltage\n", index + 1);
> +
> +	return refp_uV - refn_uV;

Do we never care about the offset inherent in where the negative sits?

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
