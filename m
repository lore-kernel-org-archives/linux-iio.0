Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF517274B58;
	Sat,  7 Mar 2026 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881210; cv=none; b=ZNwcmYkeOvlq3I5jwvKjmfJNT53p2usfO1+kdfOHZRDyZp/bzauJKXx/cqfRiObhHwoIx/Qci1QWH/jKbU2jgznrfiWYCVzCwDM4vNNMuNC/ebjaJUbPr8vKKeh3iWNdwDfQOpAQaEnTeBhYwQ/BPFWL5/PDSbR46DKsdTFAnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881210; c=relaxed/simple;
	bh=M0d9Pl4EXKENXdlrYGKAe19iW4l2z+VxMe/CDDorEq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0fJrdTfU+vf+N75fNIEwOHUdMo6NcuHH1xmWlaw/TEA7fCcbodQPvwq6vADHgkGL63K3twVyPmW0U7hM3QzBaCAfxqAUhdqXKvpwlMm5bNOX4pMroF/7vqx4wZrbkdWXgwqD9F10qaTBB/Uc2HibRy0En/S03RnnckHThgqEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6CSn4Ib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6CSn4Ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5269C19422;
	Sat,  7 Mar 2026 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772881210;
	bh=M0d9Pl4EXKENXdlrYGKAe19iW4l2z+VxMe/CDDorEq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K6CSn4Ibm7R9244ykpCyHqzbxr7ZrE9E62cwXDQ69CWSEs3AflO5PNwnHnIQnB9u/
	 2KKZ76pNDaQb1830g4DLwtRMp06GPR3i5EUabw/iiJQWml3kdkCrNN2wZFEXCZhPXV
	 0V8o3cO9PIzicyIGUNAaJKDgVjtnkk3LU/YQomcS6y7htAJ+tfYQN8vT48HPWmgzYE
	 rHK7ziWVM3T5eFZ0HLEugSlcYT+nP+mxTP1M7pV5736AWLRQCkko4Pzu2VwOx8+Ls0
	 JEH9dcSmEEOK5KA9z8pSl6ni5Nc9QkdQTRO/0sDz7iPZYSE1i4eYMhsWW+4M7AIUkv
	 oz5w2GMilK7rA==
Date: Sat, 7 Mar 2026 10:59:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, "Rob Herring"
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Petre Rodan <petre.rodan@subdimension.ro>, Jorge
 Marques <jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio: accel: adxl372: introduce chip_info
 structure
Message-ID: <20260307105959.33167730@jic23-huawei>
In-Reply-To: <20260306151859.131934-2-antoniu.miclaus@analog.com>
References: <20260306151859.131934-1-antoniu.miclaus@analog.com>
	<20260306151859.131934-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 17:18:21 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Introduce a chip_info structure to parameterize device-specific
> properties such as ODR/bandwidth frequency tables, activity/inactivity
> timer scale factors, and the maximum ODR value. This refactors the
> driver to use chip_info lookups instead of hardcoded values, preparing
> the driver to support multiple device variants.
> 
> The sampling_frequency and filter_low_pass_3db_frequency available
> attributes are switched from custom sysfs callbacks to read_avail()
> based handling via info_mask_shared_by_type_available. This enforces
> consistent formatting through the IIO framework and makes the values
> accessible to in-kernel consumers.
> 
> The SPI/I2C probe functions are updated to pass a chip_info pointer
> instead of a device name string.
> 
> No functional change intended.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
One really minor request for a comment on where the 3db frequency
number of entries comes from + some musing on whether it would have
been sensible to do the read_avail stuff as a precursor.
Otherwise LGTM.

> ---
> Changes in v2:
>  - Switch sampling_frequency and filter_low_pass_3db_frequency available
>    attributes from custom sysfs callbacks to read_avail() with
>    info_mask_shared_by_type_available.
> 
>  drivers/iio/accel/adxl372.c     | 125 +++++++++++++++++---------------
>  drivers/iio/accel/adxl372.h     |  16 +++-
>  drivers/iio/accel/adxl372_i2c.c |  12 ++-
>  drivers/iio/accel/adxl372_spi.c |  12 ++-
>  4 files changed, 96 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 28a8793a53b6..6918a5834d74 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c


> +static int adxl372_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
>  
> -static const struct attribute_group adxl372_attrs_group = {

In ideal patch break up I'd have liked to have seen the switch to the
read_avail as a precursor patch but given there would be a fair bit
of churn as a result maybe it wasn't worth it.

> -	.attrs = adxl372_attributes,
> -};
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = st->chip_info->samp_freq_tbl;
> +		*type = IIO_VAL_INT;
> +		*length = st->chip_info->num_freqs;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = st->chip_info->bw_freq_tbl;
> +		*type = IIO_VAL_INT;
> +		*length = st->odr + 1;
I know there wasn't one in the original code, but this length is odd enough
that I'd like to see a brief comment saying why.  My assumption is because
you can't filter above half the sampling frequency (Nyquist and all that
would mean it was at best pointless) but good to state that.

> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}


