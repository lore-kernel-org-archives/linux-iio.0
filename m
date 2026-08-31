Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427F28488F;
	Mon, 31 Aug 2026 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788138899; cv=none; b=OmZztBv+h3w+VjbmUhfwzce2BoUuliO9tLFZV8K7H4NykkEZwk9nhYSSE9TSYbqupm80+xsGUPxvC9VwdQKi/a/wEYWlFxDA3XUHZQ1ieKljKx6HZl7k5wUmXUzxadck4IyfL/H8Mz80msPZGfoIxAUJbs915uj3jugdUXK8gdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788138899; c=relaxed/simple;
	bh=cWBLqsUxbaqeI/ZEa6y2VPdUHZ8BopV6mZdJvS7PJkY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=X4nG2e9u98/cg9ofv1SzVeYToAfio437LjrnzJSRp1Df/r1ybBckepWjdVI1vhkSna/5S5ylIXqRNNt9V0n2SMpd2jFXMa9plmfmOzw8Hkwb+4M3hPjuj6uN4gY7W/0rVfIuMPWZCqy3QHIFrFA0f7ZDZ7LH8UUC8B+FAFjJ8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTkAgUmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTkAgUmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F4C1F000E9;
	Mon, 31 Aug 2026 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788138898;
	bh=0Y1vBNOeGVR/F0ttHRty2KzqByatI5I7w4JW81kXT6Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OTkAgUmvuqLP6GPXFreM5S3cDf7fA87FCj6Grx/Wf1v7NBIxtHqmLTrBQcKB42Se0
	 yHpa60VFr0GTfn0X5/htbpOaD7PNMhkDyEQCvwsQQlbxUoWnUJFqE1LJag8v9ZVpvp
	 QLHoYHkiKGJJjU2N50XyGX6oLRbdA7e2ROLKpsNSjzyBD4b9W2Rh/tdx1nAedrLwYl
	 RUElFZlpdmVjfKMYpmHwxWEFnj48yUsNufj/nndRrk6L3nefN6rOTv9/YB1XhEZf+Z
	 ovcdwdrUd3EqqMVhoUDzh5uVIAFrwTxjFDclyPD+kGFHhr93SmPbWXf0gMS1oqnTDP
	 84RASNpgJ6P3w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 4/6] iio: pressure: dps310: add triggered buffer
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>, 
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260824201203.396651-5-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
 <20260824201203.396651-5-zoone.rupert@gmail.com>
Date: Mon, 31 Aug 2026 02:14:41 +0100
Message-Id: <178813888150.2788519.17461592150162820073.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=cWBLqsUxbaqeI/ZEa6y2VPdUHZ8BopV6mZdJvS7PJkY=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlNWEdO1Xfa81MW0lRp7LU9ziPhIxZ76bGCEtM
 QFwjyeU77WJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapTVhBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiA8OEACG/BBX6mmwCMyHsFpOOQE4gOvVW+hyMjf2QXqzryOPAaE
 +ZqN/D15sOIsvk//4kOf8pEeOU5X8jy3V1x/gz2x1pRyrH6KP/83tA6qaNV5JEsejmPsen5u6aL
 Sim0aYQh4diChPUTLIFR4OKwfZnyqQxXfSuMczTdlQnVPODBgjjzZyTnkmYf8I4oMAWLDZGI4vy
 6OhtEqgiA8znd+o5MX8NxKE6RAfjY2s9EClEroRYLKhWIh0opRK3KLeKc0nkWgj1kl6l+hTwbRK
 VWYdI+JccN1q6u3sMFeWkM7lbGUF3rQZv7ZYIdL8hrODnXbVYQ0w9traUsi5tgka3W0LS7wpoWN
 itgKV1kRJpPnQ57Fldv8L+QvfEgWFV+AKQWph11pwoBdKF+WogE4fKj0c55TrLxBCqDoGjV2Avq
 XPMuB7ppx0uJBJQbr0ZMDTUMH7JEK+plvGxieP6YAkBoY3QrYTK0pf24Jas3jw1I8w+5+igAOpQ
 Lrrh1nxy2rK5AijA5xM+x/O6lnksMeHLPwHiHJG4ERoZgRAXpAQQHP+xKnYh0HgGGsv2yTJCkR8
 r/yPhAx/Gx+5KXO1c7cT1YZzy/gzcKJtyagMjTwDjMMwsAKrNAs4QSQa8IvrOAr0WgeLIyelacC
 q48Nks88yWs3WLr2v1IZMLpSGFyCaWQ1n10ggWA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add a triggered buffer in order to capture continuously on both channels
> instead of one sysfs read at a time.
> 
> Raw register value is not useful on its own, pressure has to go through
> the compensation polynomial and needs a temperature reading. Report raw
> in Pa with 1/1000 scale to keep full resolution in the buffer without
> changing what the existing processed attribute reports.
> 
> Raw and processed reads return -EBUSY while buffer is on, so does any
> reconfiguration.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
>

A few comments inline on how to simplify things by
choosing carefully what parameters to pass around.


> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 269a71ea3e7a..f122acd72b0c 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c

...

> +
> +struct dps310_scan {
> +	s32 channels[2];
> +	aligned_s64 ts;
> +};

See below - we normally define this locally where possible
and I think that makes sense here.

>  
> +
> +static int dps310_fill_scan(struct dps310_data *data,
> +			    const unsigned long *scan_mask,
> +			    struct dps310_scan *scan)

As this isn't filling in the timestamp, I think you'd be better
passing s32 channels[__at_least 2] as that final parameter.

> +	__must_hold(&data->lock)
> +{
> +	int rc;
> +	int i = 0;
> +
> +	/*
> +	 * The pressure compensation needs a temperature reading, so temperature
> +	 * is sampled even when only the pressure channel is enabled.
> +	 */
> +	rc = dps310_read_temp_raw_locked(data);
> +	if (rc)
> +		return rc;
> +
> +	if (test_bit(DPS310_SCAN_TEMP, scan_mask)) {
> +		/* Millidegrees Celsius */
> +		rc = dps310_calculate_temp(data, &scan->channels[i]);
> +		if (rc)
> +			return rc;
> +
> +		i++;
> +	}
> +
> +	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
> +		rc = dps310_read_pres_raw_locked(data);
> +		if (rc)
> +			return rc;
> +
> +		/* Pascals, see the comment on the channel definition */
> +		rc = dps310_calculate_pressure(data, &scan->channels[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t dps310_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct dps310_data *data = iio_priv(iio);
> +	struct dps310_scan scan = { };

I'd pull the definition down here as
	struct {
		s32 channels[2];
		aligned_s64 timestamp;
	} scan;
	
> +	int rc;
> +
> +	mutex_lock(&data->lock);
> +	rc = dps310_fill_scan(data, iio->active_scan_mask, &scan);

Then make this *fill_channels() with only the relevant part of
the structure passed in.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
