Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629183D7D94;
	Sun, 20 Sep 2026 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929162; cv=none; b=Y5FQdbVQqmirJiHh9ih/3hWkWqob/Y7L4Fml02PQuEvY/CgBhyp0GnlwbfhOWUM34msdatpRI+KbVUxjFumttpfZq3r2ca6x/uloSjQT/an+D9JI4OK8hKXbNbot6T5IbIA7Irrn9EcwmhmdquTyzzi2sKAELr3tIqxhN70LYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929162; c=relaxed/simple;
	bh=umauhoqu0UVvSQX/fylUbJclbfTXQ8TBeECjK6xihV8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=utWZlhCp3t26kLlvfmo+yEPiXkEde6j4hZBfykLHARojtjlDfIOWwMi+95Q51aylUonS/d2W+a1k4hpMSLrJA0ZxzrXj+k1S7RTCKRyPdN8kChBdz4V87ZTkeWl1YTCQmG4p9Vyt9MDrB05EEkKKe6nFoZn7RxIDYW5bBKqVyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIPq4CSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIPq4CSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE90E1F0089A;
	Sun, 20 Sep 2026 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789929161;
	bh=NBQcG8nvSkpAruHbNtR070hq9oWPoxtAh08lbKgEihk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=CIPq4CSA4dYHmIneY70FWLTeAv0c7Lx5rsYW4jnvKmOTb4x69vinGbiFHGvoRqllZ
	 bNt3H7MPDcUId49gRVn26tfpwW2N6BgSjDXZOtbX7Poh4qLe28dtNBemUvLqpV3dSw
	 mcpUIFPNBJD2hPVPK0tguls6gZ/lc/tLSBwFkNK4/jYFyYRBi6vaMamWS+KNPNZk3w
	 rMssQGMzxCOVpeK4l2HyFHseA+loHr1QwMG7x4CNAlTjyuEqxwzBathjubOzE/8gmU
	 le/O3eF7VVA3SnPe2rbk1v0F/4PyKHIRi4nbiBJnncLVVCnn8U9FxqcZGMGvOJyxK8
	 HXuyyLyWhn0Iw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 09/10] iio: pressure: dps310: implement
 .hwfifo_flush_to_buffer()
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>, 
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron <jic23@kernel.org>, 
 Justin Stitt <justinstitt@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260918122517.377565-10-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
 <20260918122517.377565-10-zoone.rupert@gmail.com>
Date: Sun, 20 Sep 2026 19:32:13 +0100
Message-Id: <178992913316.706584.1446996024286841775.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=umauhoqu0UVvSQX/fylUbJclbfTXQ8TBeECjK6xihV8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsCbGUD2vQCnfN0UnDSBJW74b96t/O9DNVjDom
 wGszaNevJWJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarAmxhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiKtHD/9KNM27fsN2qH75nACPseNksbifW5nAfEyBMoJz25TIU3I
 WIOypp2lTlqAdg9aOWEndV9y3CNXNOxpGnkw+wsvNbT7Wi/KsZYT7MfygteGkBGTzA8oDqWqs3b
 O0L93oJSzTnwf3yPoLWtj9d3+KtVL4I/ZQpRirx0pwMtq5vcOklRIFpsGJOXgJImJZSwYx768Ce
 HlEzlY9PZ0IsQz1bKQu4krJdR6GOFI2h0mDgolsKeyggURnCIeaXHGSnME/NEGmBnHqofO/3v+T
 Ux/0jwKW98d50b4DSMAOIxiMuxrgi6L/OGc94QLk4lsV0MuNO8ft08/MY3/ooFktoBUWI9q+HQc
 0dzzGopHy+MMiq+5KuwwRQT44jsFyVZM1HaTEbC4Ee8b71eKHBbtG27pjo6lQQpmczihP5gr0dW
 vPXHOj9UETiz5iDf3SPZ+5ZCjlH0Rcsu3AuKntcn0PBT/I23nbHUMN/F4FxlixfPtFvOfrc2UFB
 J/h6Qk+sPABAZvB+PLe7VwyXvPBFjEgCoIR0M0kz1Z7fp7pL7LY4ijpT+5qpCliZWGqD39NQQJ5
 bKQu62SlS1dlNFVqaG5+I7vtdwlpGDi45iy+uSBscdYTWCNAWfFBVAp+gqEJg21UEsBPnSRqqL9
 NEUEaO/yMFhm4I+p0oo2ryKydnsil50EiU5KkLg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Let userspace drain the FIFO on demand rather than only from the
> periodic drain.
> 
> With a trigger attached the FIFO is not running, so there is nothing to
> flush and the hook returns 0.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Sashiko calls out a race condition in here on buffer disable.
We've been working on a few of these recently and subject to one
gap in buffer remove (hopefully fixed shortly) the simplest solution
seems to be claim_buffered_mode for regions that are accessing
the specific buffer mode, or the_active_scan_mask.

https://sashiko.dev/#/patchset/20260918122517.377565-1-zoone.rupert%40gmail.com

See the OSF sensor thread for more discussion on closing pretty much
the same race. It is present in a lot of drivers, so we will probably
be fixing this one for a while. 

Thanks,

Jonathan

>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 024fcdc7f4e7..f888bff2c996 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c


> @@ -1205,6 +1217,19 @@ static void dps310_fifo_hold_free(struct dps310_data *data)
>  	data->fifo_hold_max = 0;
>  }
>  
> +static int dps310_hwfifo_flush(struct iio_dev *iio, unsigned int count)
> +{
> +	struct dps310_data *data = iio_priv(iio);
> +
> +	/* A trigger drives the capture instead and leaves the FIFO empty */
> +	if (iio_device_get_current_mode(iio) != INDIO_BUFFER_SOFTWARE)
> +		return 0;

Sashiko: - this is the one I think we need to close.

[Severity: High]
If a user concurrently disables the buffer via sysfs, it calls
iio_disable_buffers(). This executes predisable() (which briefly takes
data->lock), frees indio_dev->active_scan_mask, and sets it to NULL.

Because the INDIO_BUFFER_SOFTWARE mode check is lockless, could
dps310_hwfifo_flush() wait for data->lock here, wake up after
predisable() finishes, and then call dps310_fifo_drain() which
dereferences the NULL pointer?

dps310_fifo_drain() will execute:

    bool pressure_enabled = test_bit(DPS310_SCAN_PRESSURE,
                                     data->iio->active_scan_mask);

Will this cause a NULL pointer dereference or use-after-free?
-

As talked abotu above, I think iio_device_claim_buffer_mode()
will do the job here as it stops the IIO core transitioning between
modes until afte this is done with the active_scan_mask.

> +
> +	guard(mutex)(&data->lock);
> +
> +	return dps310_fifo_drain(data, count);

Sashiko comment:
[Severity: Medium]
The hwfifo_flush_to_buffer IIO API contract specifies returning the number of
samples flushed, and a negative error ONLY if no samples were flushed.

If dps310_fifo_push_held() or dps310_fifo_push_scan() fails midway through
draining the FIFO in dps310_fifo_drain():

    rc = dps310_fifo_push_scan(data, data->fifo_temp_raw, raw[i]);
    if (rc)
        return rc;

won't returning the error code directly discard the successfully pushed sample
count (pushed), violating the IIO callback contract?

Returning a negative error when pushed > 0 causes iio_buffer_ready() to
swallow the error, return false, and force the reader thread to sleep instead
of reading the newly available samples.
-
In event of a hardware comms error I'm not sure we care that we drop
a few samples we might otherwise return. So I'd ignore this one.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
