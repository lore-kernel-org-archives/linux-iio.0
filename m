Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D24534A3;
	Wed, 27 May 2026 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906630; cv=none; b=AHepVB08NWO+ySAUA12r5+eJ2yB9WXottzq7ePy0qDVyg41wJXXpFnybQmLmeZYE0N8oE4klOuvvei7CDvqrjf2edW+Vu1ryDI4rw1e6yHGhPqZuRqcI/ehndqPe0McR5fdmLE0+y6zWOXLB4N/OniR7O7eVIOI/PAlE9e5IXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906630; c=relaxed/simple;
	bh=IbyoxHcpTyADmQDw6LoqtQZmLqElPhTftmfvTzpUplQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffw5ve18yFxbLULv6vZNNWpbhODxnL27dPxyXk38HfX6tQAMwyqqqa5ywPLYbuJOAwzodmNA98r1Sq7tWc5uoFyFOuoYmBcUame6jTCM7MzxTik01RMwyPpzeTXFfKpIOx8pFHfAi74UzyeIS3ez9F6CploFYjDL5h5ipQ2ABcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB6c9qPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB6c9qPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FB61F000E9;
	Wed, 27 May 2026 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779906626;
	bh=A2d4KJWTWOKVjHxH6j5gyIYie8+/9yod2g3BPdoJjVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VB6c9qPglZQ6qp3iTA9gjWidMOYvQ2m8uTqpuGMkeBLv5/c6+Y59f13neP030bOFo
	 3KDroMDfWhr1U0rnzRPN/MXFnJh4Ak29LloS5N2w7a5I86MS/ehCk1p6nn53OoIA9L
	 AmF6FhNN5ME9qARn80zHjdTa1z1OdrCffOIBzXsXRAeVmr1MuVlJTmufukrMqcm13h
	 UVgQ0xe9NygbKdiqbxCmgLUSFPgA+oVDFT+el73AfBeD68TGk8Y3PlpxneHi6ORYcy
	 cGNlY5XRw0sQK9EcEqjRE3K2n6AeoE/NLSfMTolPm4PrTkTMFAaIlcg4e2uijlMIpR
	 9OYqHHX9m+TQw==
Date: Wed, 27 May 2026 19:30:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v4 3/8] iio: light: opt3001: ensure correct parenthesis
 alignment
Message-ID: <20260527193019.367da1db@jic23-huawei>
In-Reply-To: <20260525-opt3001-cleanup-v4-3-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
	<20260525-opt3001-cleanup-v4-3-65b36a174f78@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 10:20:17 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Ensure correct parenthesis alignment per checkpatch.pl report.
> 
> No functional change.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
I was optimistic we could get the fix in via one tree and the rest via
another but nope - this changes alignment of stuff to close to that fix.

Ah well. This will have to wait for that fix to make it into an upstream
release. I might do a pull request for fixes sometime later this week to
get that going.

Jonathan

> ---
>  drivers/iio/light/opt3001.c | 73 +++++++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index efaad85dfaf3afc9199fd3124d832ee2a297f0b3..532929e8fa8b4172eadc696e927315017a07dac1 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -223,8 +223,8 @@ static const struct opt3001_scale opt3002_scales[] = {
>  	},
>  };
>  
> -static int opt3001_find_scale(const struct opt3001 *opt, int val,
> -		int val2, u8 *exponent)
> +static int opt3001_find_scale(const struct opt3001 *opt, int val, int val2,
> +			      u8 *exponent)
>  {
>  	int i;
>  	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
> @@ -242,8 +242,8 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
>  	return -EINVAL;
>  }
>  
> -static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
> -		u16 mantissa, int *val, int *val2)
> +static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent, u16 mantissa,
> +			       int *val, int *val2)
>  {
>  	int ret;
>  	int whole = opt->chip_info->factor_whole;
> @@ -364,8 +364,8 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
>  	if (opt->use_irq) {
>  		/* Wait for the IRQ to indicate the conversion is complete */
>  		ret = wait_event_timeout(opt->result_ready_queue,
> -				opt->result_ready,
> -				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> +					 opt->result_ready,
> +					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
>  		if (ret == 0)
>  			return -ETIMEDOUT;
>  	} else {
> @@ -474,8 +474,8 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
>  }
>  
>  static int opt3001_read_raw(struct iio_dev *iio,
> -		struct iio_chan_spec const *chan, int *val, int *val2,
> -		long mask)
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
>  {
>  	struct opt3001 *opt = iio_priv(iio);
>  	int ret;
> @@ -506,8 +506,8 @@ static int opt3001_read_raw(struct iio_dev *iio,
>  }
>  
>  static int opt3001_write_raw(struct iio_dev *iio,
> -		struct iio_chan_spec const *chan, int val, int val2,
> -		long mask)
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
>  {
>  	struct opt3001 *opt = iio_priv(iio);
>  	int ret;
> @@ -532,9 +532,11 @@ static int opt3001_write_raw(struct iio_dev *iio,
>  }
>  
>  static int opt3001_read_event_value(struct iio_dev *iio,
> -		const struct iio_chan_spec *chan, enum iio_event_type type,
> -		enum iio_event_direction dir, enum iio_event_info info,
> -		int *val, int *val2)
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
>  {
>  	struct opt3001 *opt = iio_priv(iio);
>  	int ret = IIO_VAL_INT_PLUS_MICRO;
> @@ -544,11 +546,13 @@ static int opt3001_read_event_value(struct iio_dev *iio,
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
>  		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
> -				opt->high_thresh_mantissa, val, val2);
> +				   opt->high_thresh_mantissa,
> +				   val, val2);
>  		break;
>  	case IIO_EV_DIR_FALLING:
>  		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
> -				opt->low_thresh_mantissa, val, val2);
> +				   opt->low_thresh_mantissa,
> +				   val, val2);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -560,9 +564,11 @@ static int opt3001_read_event_value(struct iio_dev *iio,
>  }
>  
>  static int opt3001_write_event_value(struct iio_dev *iio,
> -		const struct iio_chan_spec *chan, enum iio_event_type type,
> -		enum iio_event_direction dir, enum iio_event_info info,
> -		int val, int val2)
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
>  {
>  	struct opt3001 *opt = iio_priv(iio);
>  	struct i2c_client *client = opt->client;
> @@ -626,8 +632,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
>  }
>  
>  static int opt3001_read_event_config(struct iio_dev *iio,
> -		const struct iio_chan_spec *chan, enum iio_event_type type,
> -		enum iio_event_direction dir)
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
>  {
>  	struct opt3001 *opt = iio_priv(iio);
>  
> @@ -635,8 +642,10 @@ static int opt3001_read_event_config(struct iio_dev *iio,
>  }
>  
>  static int opt3001_write_event_config(struct iio_dev *iio,
> -		const struct iio_chan_spec *chan, enum iio_event_type type,
> -		enum iio_event_direction dir, bool state)
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
>  {
>  	struct opt3001 *opt = iio_priv(iio);
>  	struct i2c_client *client = opt->client;
> @@ -812,16 +821,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>  			OPT3001_CONFIGURATION_M_CONTINUOUS) {
>  		if (ret & OPT3001_CONFIGURATION_FH)
>  			iio_push_event(iio,
> -					IIO_UNMOD_EVENT_CODE(chan_type, 0,
> -							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_RISING),
> -					iio_get_time_ns(iio));
> +				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       iio_get_time_ns(iio));
>  		if (ret & OPT3001_CONFIGURATION_FL)
>  			iio_push_event(iio,
> -					IIO_UNMOD_EVENT_CODE(chan_type, 0,
> -							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_FALLING),
> -					iio_get_time_ns(iio));
> +				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       iio_get_time_ns(iio));
>  	} else if (ret & OPT3001_CONFIGURATION_CRF) {
>  		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
>  		if (ret < 0) {
> @@ -884,8 +893,8 @@ static int opt3001_probe(struct i2c_client *client)
>  	/* Make use of INT pin only if valid IRQ no. is given */
>  	if (irq > 0) {
>  		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				"opt3001", iio);
> +					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					   "opt3001", iio);
>  		if (ret) {
>  			dev_err(dev, "failed to request IRQ #%d\n", irq);
>  			return ret;
> 

