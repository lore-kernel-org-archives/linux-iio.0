Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46843DA5C;
	Tue,  1 Sep 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280866; cv=none; b=E/ePG8sVuWFTS865qUmV00YSerNWmno1PZzWNC9KEu4eMiJgyVnoYYWe+j4XjCi8bvpdwmCGGdqBSAf3ln2gsGSvdHQjZTg9a56cScGJoYLnh3nRH5lTxNCH8WBL7W2LSO4/4gmzNROJxY5vlvQ5GdWoJcZYr4YXNC5j7pak8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280866; c=relaxed/simple;
	bh=hbYcEZ5t1jKLdhhzBsDiDxzVfK9mLxWF7x5pUlvRtKw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=j++LC9OWTbYbnqHvh1Lso70So+n20xllTUJqP0jN8qhiWoptwRboSIe9gfmivsYUTGUvBk8tjOXLrPhlhcPz7Ho9yxag+QLypoOpa6PQB60umy8PKSyIVJbxL0+XzKEg5vNVw+Egcwxl+4RJE8UVjQJJHaClOhNU6FTyodsO2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdR5JF/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdR5JF/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AA21F000E9;
	Tue,  1 Sep 2026 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280864;
	bh=BquFv9yL+oqsu0iQAMjKTxvhkEp4Ce4d3z7hB0ao2xo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GdR5JF/Dmj2wZevDdv7KegcbJudOgutQNKy34uQpxez/dctKOb4zz44h2Rz2TRcx6
	 2yMFhiM3AtvWh9Xf1VJbO10cn490cDPuoPpnVkrVhDfjTLKITznz01zuqMkxE05Tf/
	 VZZrp2J7/0GV1N1eatTN5GALxUHhWzqHvGd0VhB+PzGGm3W4AFHIXZrZpTkWaUFne0
	 KCxb2F5pHoP8TjHsSVgMIJoQVlgdc7RMH2UueUBQjUHFKSRoozXlk8GEbX33rL1/Ft
	 jrWZ54OkKEdLaztPBClepf3fv3w1MXV7aX9JIWN2IkL6TGj3xrHynhtNEywifxiVDJ
	 zIpqgDsXN7l4w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 4/4] iio: accel: adxl367: add support for INT2
 interrupt pin
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260831083122.3486-5-antoniu.miclaus@analog.com>
References: <20260831083122.3486-1-antoniu.miclaus@analog.com>
 <20260831083122.3486-5-antoniu.miclaus@analog.com>
Date: Tue, 01 Sep 2026 17:40:47 +0100
Message-Id: <178828084760.2788519.15283878760227392025.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=hbYcEZ5t1jKLdhhzBsDiDxzVfK9mLxWF7x5pUlvRtKw=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlwASftjEjfF3ZyUA6ese3Ya24ehr89RVnfPPx
 ORps2fw6wiJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapcAEhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiB45D/99eOXNRUuVsk/PP5iZpNLacTHlahYX0ZZvUJkbAkb1tHU
 ukpiURwyRIdyBIGVR8fsZunhVk9NOtHcFP+siR937JMzYgqt+49Gujb40nyRJIpelHsRSoHjglg
 3FkjgfXpFn6YTZjI50elzyx/iSAdf0YvZUKGb5DO0rSPaOMNZM2L/qeFLdmVBN9Abo6L8b+CNtQ
 58+vnZvqz5YNJWbl/EpRWcKKJRu5+IoN585yCGwlC9JY7Uj1z37SKVfIx6LzE5AZImg4TsWrVXx
 EPEROwS67pv878cse9YGVcbp24MUL7OnKf4BPka0HlJy1goASt2uo4Wv/d9ZYvnXjEb+7tecVMA
 aZKaW8Wi185FYinTLm4VKUG7Kk+b7K8w1JNbXFLQYK8GLUwIH7i05ee2zewoi+oluk5WOmvIGkP
 a4/aGQMS5KVA5V8ZP3EvNnnkZy4O1D8Aw5HM6kd34TMRBL0SnvwfYt+eitplrXwvqXZSYVmTH8M
 oPmaBXntVs5S0wU5iw5zVO5aHpI1krZzQbkTlP/A4q8Vz6VMJwaNBJrRvQiJumTilTqomIePcx6
 tdSDxhHDFYlT2166a2yC+lE6AtNTDgFpEXu3aJN2aa2MWgk8kguU/WnFP/7RnPTEpqJ+QEZsRMy
 VwZ4o15VssTpK5iZjioHPJChp6/h4FyCAjrj7pg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The ADXL367 provides two independent interrupt output pins, INT1 and
> INT2, each with its own event mapping register (INTMAP1_LOWER at 0x2A
> and INTMAP2_LOWER at 0x2B) sharing an identical bit layout. Until now
> the driver hardcoded INT1 for all interrupt mappings, so a board that
> routes only INT2 to the host could never receive activity, inactivity
> or FIFO watermark interrupts.
> 
> Determine the connected pin from the interrupt-names device tree
> property using fwnode_irq_get_byname(), and route the interrupt
> mappings to the matching register. Use the interrupt number returned by
> the lookup for devm_request_threaded_irq() so the requested line always
> matches the routed INTMAP register, regardless of the order in which the
> interrupts are listed. When no interrupt-names are present, default to
> INT1 and the bus-provided interrupt to preserve the existing behaviour.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>

One follow on thing to look at via sashiko.

Otherwise, this looks good to me, but given the active discussion on previous
version I'm not going to pick this up until plenty of time has passed
or tags have been given.

> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index b4e8dc6d6a5c..9b47e66c49ea 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c

> @@ -1430,6 +1434,36 @@ static int adxl367_setup(struct adxl367_state *st)
>  	return adxl367_set_measure_en(st, true);
>  }
>  
> +static int adxl367_set_int_map_reg(struct adxl367_state *st, int irq)
> +{
> +	int ret;
> +
> +	/*
> +	 * Route the mappings to whichever of INT1/INT2 is named in the
> +	 * interrupt-names property. -EINVAL (property absent) and -ENODATA
> +	 * (name not listed) are not errors; anything else is.
> +	 */
> +	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> +	if (ret > 0) {
> +		st->int_map_reg = ADXL367_REG_INT1_MAP;
> +		return ret;
> +	}
> +	if (ret != -ENODATA && ret != -EINVAL)
> +		return ret;
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
> +	if (ret > 0) {
> +		st->int_map_reg = ADXL367_REG_INT2_MAP;
> +		return ret;
> +	}
> +	if (ret != -ENODATA && ret != -EINVAL)
> +		return ret;
> +
> +	/* No INT1/INT2 named: default to INT1 and the bus interrupt. */
> +	st->int_map_reg = ADXL367_REG_INT1_MAP;
> +	return irq;

I'd like to explore the helper idea for this, but it can be a separate
series when someone has the time.

> +}
> +
>  int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  		  void *context, struct regmap *regmap, int irq)
>  {
> @@ -1486,6 +1520,11 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
>  	if (ret)
>  		return ret;
>  

[Severity: Medium]
Since fwnode_irq_get_byname() inside adxl367_set_int_map_reg() can return
-EPROBE_DEFER if the interrupt controller is not yet ready, will placing this
lookup after adxl367_setup() cause repeated boot delays and leave the device
powered up on deferral?

Looking at adxl367_probe(), it resets the hardware, sleeps for 15ms, and calls
adxl367_setup() which powers up the device into measurement mode.

If adxl367_set_int_map_reg() then returns -EPROBE_DEFER, the probe aborts
without an error cleanup path to power down the device.

Could this software resource acquisition be performed before the hardware
interaction to avoid unnecessary boot stalls and power leaks during probe
deferral?

-

This obviously isn't new, but it might make sense to turn the device
off at least.

Can be a follow up patch.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
