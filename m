Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1E246783;
	Mon, 21 Sep 2026 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955466; cv=none; b=fKS0widwScQJeoZfp2WD/fhg7P05BvGtYlU2RkjdzJf1gax/bnOGVO8UmXgB5pvL4xCPIBy3y48r2/j2xN4vh4yh4Cp9t3fo1Qc0XGKh0qYxNaDyC5nvLJzKeW2e4ia1Bg+67HNWQddcFmuZJCfExVsKWFQM0QNinbtZfNNsbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955466; c=relaxed/simple;
	bh=L4peYC/uStLa0E1B5s3XEsLhDHeHqY4n3ae5nAc120E=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tyLxUPlIIEDjIssuz+YirR2OMBoURG1R5yQdCQu+nG3Uj6LspcoPBTKFtB5F2klC1Nap6KSB5pJ4VACCJ2l40e/gytih7uN9AHWKlzyKoLQGrb+YuHLwp4cRPL58E+wOBYyc7/JvyT8DoeLL9RG0SFkqHCBZza4ghzjmZ5uUqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9k02HUb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9k02HUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8097A1F0089A;
	Mon, 21 Sep 2026 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955464;
	bh=AvTXOBr7Q9KhUBAENNn8Z5xYN4AN/p1zbbVx+ksqnyc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=i9k02HUbpbin32YcDPTMV5Kt9DH528PFYCkFfzLbENm/2re+asOfVil04ejF/4ZOV
	 WWNgwg8AVfvXLZXyKervmj1xHBwHLqKJn6drOJzyML3jOhOqIeFvfgGuHBEdJopExq
	 lwqx2oNwTm4ovO5meUldea4yYqf3Ui+6nqp3uxZN6JxUodaXq7mJaPvw/fygYU3VGj
	 dUKdqYYQy5TpvirqtXYWT8/EcIIsFNcXBQn5ygFSu5EI/ykcOIX3cStcWBHzPpHl9y
	 wfgDwLm/V+xar0XNY7/R/LoYxS4RUcBu0cJmThRA5gjz60tf3S+Mt6YJdieljVPNKr
	 HJH4P7zVd9j7A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 08/15] iio: adc: ad4134: Support buffered data read
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
 marcelo.schmitt1@gmail.com
In-Reply-To: <dbc37d95fe7f96bd158d8e3339c41205524ae217.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <dbc37d95fe7f96bd158d8e3339c41205524ae217.1789494473.git.marcelo.schmitt@analog.com>
Date: Mon, 21 Sep 2026 02:50:45 +0100
Message-Id: <178995544507.955708.14374719433731561725.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5504;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=L4peYC/uStLa0E1B5s3XEsLhDHeHqY4n3ae5nAc120E=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsI2EWkcZt837rrvogCvfuKVRFjum+e3PjPaDP
 d2GPXiwge2JAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarCNhBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiDtyEACqlYNuMFZAXY1tIu3UBbDieZOJAZbt4tJRWC971PLaVcA
 fkyAviXKDScvAZTiFTpp9Jjtcud1Hy/5NL3oK+X/DsAG3jw38Rzz6ZcvukYdmYopM4yFRxJHLmV
 08jkfyu0vSMKott14MUtYg4bjAOe+xdba73Em7Rs5EKrVcj6/yLrJQIoZBZ55UoyKO6UAU/Q+gs
 WlCEipxMVTbN6NiDoysTSg6fhma/hwTNEVKSCMnFNZgGiEaaoD8S8v0JQ/AxEj/12kz1Ik+H3j/
 9Oo9k2X0jJCdIpBNZPLDianoW7LUP5g2hgGf5KituWdnj96PC4Km+LiV4aneLNMaqI2dwSXgb8z
 eUQDvKpPfPu9zwRFa6JDLJkMwb+yFCVTvl+FcCZ8GdNZ+HQhLmZHpxwUlR+W7+L5j39I+hYn4+9
 N722xZMYbhngM3RyzubIeVZLPjINEmNWagOu6W/egIf9twKaX0z7GLEHcWJIFvq3wR9eDqTagFQ
 WF6jWL3A0ckFEBdxzCxfIs8LJLsYy+mLH8kOApfaTLDB9ZK2ojrgphLk9kNvz7PGGiIeknrA02H
 VNQOriK65aMkal3jVUzXTzf1Z4HYkQJZlROxZ3pFBpj8o0XDX8Eb6FyYcFStsVuwupoQEjPMjkN
 FKb64OK8JbQmewWb4IGAnA9jhn0UEOkLxGto8dA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Enable users to run buffered data captures triggered by IIO trigger device.
> Add an IIO timestamp channel so each data scan is provided with measurement
> time information. Require single-read operations to be in IIO device direct
> access mode to prevent buffered and single-shot data captures to disrupt
> each other.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Hi Marcelo

Sashiko had a bunch of feedback on this one.  Note that you can save
time if you check out what it comes up with and reply to the thread
to say what is valid and not.

I haven't yet asked for those emails to go directly to linux-iio
as the quality is mixed and I am reluctant to confuse newcomers, but
most like I will ask them to turn those emails on in a month or so
if not before. In meantime more experienced folk can look at the
website directly.

> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 30c7b1d1bc67..0b6843bf8a9e 100644

>  

>  
>  struct ad4134_state {
> @@ -149,7 +161,10 @@ struct ad4134_state {
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
>  	 * to live in their own cache lines.
>  	 */
> -	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	union {
> +		u8 reg[AD4134_SPI_MAX_XFER_LEN];
> +		u32 scan[ARRAY_SIZE(ad4134_chan_set)];


Sashiko:
[Severity: High]
Does this array size fail to account for the timestamp's alignment padding?

The array is fixed at 20 bytes (5 elements). When all 4 channels and the 64-bit
timestamp are active, the IIO core computes scan_bytes as 24 bytes due to the
timestamp's 8-byte alignment requirement (16 bytes data + 8 bytes padding and
timestamp). Passing sizeof(st->rx_buf.scan) to iio_push_to_buffers_with_ts()
later in the trigger handler will cause the IIO core's safety check to fail,
aborting the buffer push with -ENOSPC on full-scan captures.
-

That does indeed look wrong. I'd expect to see one of the DECLARE
buffer macros used here to ensure a large enough buffer.  This
should have shown up in testing so I'm curious why it didn't.

[Severity: High]
Can concurrent lockless accesses corrupt the rx_buf shared union?

The ad4134_trigger_handler() executes locklessly in a pollfunc context, while
regmap debugfs reads/writes (which do not acquire the IIO direct mode lock) can
concurrently use st->rx_buf.reg as a DMA buffer. This can result in corrupted
SPI scan data, corrupted regmap read/write data, and potentially invalid
hardware configurations or ADC samples if debugfs is accessed while a triggered
buffer capture is running.

-
Also sounds valid though I haven't confirmed everything stated.
A buffer like this should be protected by a local lock, not rely on
serialization via the mode claim mechanism.

> +	} rx_buf __aligned(IIO_DMA_MINALIGN);
>  	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
>  };


> @@ -281,7 +296,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
>  		 * Clock out data from all channels to avoid that.
>  		 */
>  		if (i == AD4134_VREG_CH(reg))
> -			sample = get_unaligned_be24(st->rx_buf);
> +			sample = get_unaligned_be24(st->rx_buf.reg);
>  	}
>  	*val = sign_extend32(sample, AD4134_CHAN_PRECISION_BITS - 1);

[Severity: Medium]
Does this leak uninitialized stack memory if the soft timestamp channel is read
as a virtual register?

Because ad4134_regmap_config sets max_register to include the soft timestamp
channel (ARRAY_SIZE(ad4134_chan_set) includes the timestamp, making index 4
valid), userspace could read virtual register index 4 via regmap debugfs. In
that case, this loop iterates only up to AD4134_NUM_CHANNELS (indices 0 to 3),
meaning `i == AD4134_VREG_CH(reg)` (where AD4134_VREG_CH(reg) would be 4) is
never true. The sample variable is left uninitialized, and an uninitialized
32-bit stack chunk is processed and returned to userspace.
-
Please check this one.
>  



> @@ -333,6 +348,37 @@ static const struct regmap_config ad4134_regmap_config = {
>  	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
>  };
>  
> +static irqreturn_t ad4134_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad4134_state *st = iio_priv(indio_dev);
> +	unsigned int i = 0;
> +	int ret;
> +
> +	gpiod_set_value_cansleep(st->odr_gpio, 1);
> +	fsleep(1);
> +	gpiod_set_value_cansleep(st->odr_gpio, 0);
> +
> +	for (unsigned int ch = 0; ch < AD4134_NUM_CHANNELS; ch++) {
> +		ret = spi_write_then_read(st->spi, NULL, 0, &st->rx_buf.scan[ch],
> +					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
> +		if (ret)
> +			goto err_out;
> +
> +		if (test_bit(ch, indio_dev->active_scan_mask) && ch != i)
> +			memcpy(&st->rx_buf.scan[i++], &st->rx_buf.scan[ch],

[Severity: High]
Does this conditional logic permanently corrupt the scan data by overwriting
active channels?

When the first active channel has the same index as the destination (for example,
both are 0), the condition `ch != i` evaluates to false, short-circuiting the
if statement and entirely skipping the post-increment `i++`. The next active
channel will then overwrite the previous data by being written to scan[0] again.
This triggers on any standard buffered capture involving multiple channels.
-

Check this one as well. Looks plausible to me.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
