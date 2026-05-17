Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35592173
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022654; cv=none; b=Xj0rmQJHNhDgP0jRSMRIZM1VoSHkeIdnyPDZvNXpB9StpwoitpZzNPRehp/P5cPLdhgFto2bNe49Ev2e+ACokNBzgC1/M28FwGrZmGrvVP/E04+EizeswUCEYhYK7fqlAyBOk//Bkhm6JxLYkC8e6UgTrJ3g6d/zfEWzx8I2gKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022654; c=relaxed/simple;
	bh=S1iUd6u6BW3uxvRj8LHWsmLcaClUttw0mwdSROHVzJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l72FYFRgRNmXen6JKZtF1JHzqftL0ydDU5Ozewv7S+1RqlUSgQzVRU4nQPTfqGs1FhJUABR/Fr7jO0zhuff0GFljNq2UzqROTNAwZPXfHkZu2tusCYt5e5x88ff9wLsRCylFx+b9BuHxZ8YnfVOCgdZkOMd6feiAetHL8j//EHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpVFXOJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpVFXOJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376ABC2BCB0;
	Sun, 17 May 2026 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779022653;
	bh=S1iUd6u6BW3uxvRj8LHWsmLcaClUttw0mwdSROHVzJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QpVFXOJcVkTinzec/+ff7SbD6pSWabS77WuZJRi1AMj7NYaFK7wKgZTnXIeYSyila
	 +JK+MpmgLs2zKXniVd5vgIfd9wETtAriyWuRxvaCBqVTC2XylWmNUg6czaonEcptCR
	 ivuOO26tfI3xdnxCBVdnYSJbavDRObsnvghykLRciWfCEzxBx4afwmSRqWnu5RNmIx
	 YdwWuGeRx2ykT33qCBNgUWjCTH/RkXKHQIeEh9ub2MnSqIBoDH/9cCLkOvDk6VzLXX
	 deQFIacd6Zf3TCNq2D3P/p1UdmRsESei9MTQCcMfY1RJMEcJVg/EkPhLrfNHE0Pdbt
	 KSZin2oemHIFw==
Date: Sun, 17 May 2026 13:57:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: dlechner@baylibre.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: adxl372: Add timestamp to FIFO data
Message-ID: <20260517135619.55f9b50a@jic23-huawei>
In-Reply-To: <6a09881c.7a23d47e.35947f.2f62@mx.google.com>
References: <20260516211935.36773-1-shofiqtest@gmail.com>
	<6a09881c.7a23d47e.35947f.2f62@mx.google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 02:19:24 -0700 (PDT)
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Hi David,
> 
> Thank you for the two review comments.
> 
> Regarding the timestamp accuracy concern from the v1 discussion: the commit
> message in v3 now explicitly documents this. The timestamp is captured once
> per FIFO watermark interrupt and reused for all samples drained in that
> invocation. It is most accurate for the last sample in the burst and
> progressively stale for earlier ones. This is noted as an acceptable
> approximation for coarse event sequencing, consistent with watermark-based
> FIFO readout in other IIO accelerometer drivers.

Hi,

No this is not valid under the standard way we handle timestamps for FIFOs
and if we made this approximation in a given driver we would then be more
or less stuck wrt to fixing it in future.  If you wanted to discuss
that more you should have replied to the earlier feedback saying no
to this approach, not wasted time on new versions when such a fundamental
objection ha been raised.

So I'll be ingoring this series and all other series adding timestamps
to FIFOs that repeat a timestamp. 

If you have a usecase for adding this then you need to look at how to
do a decent approximation of timestamps. If this is feature addition
because you feel it might be useful to someone else, then find that
user and work with them.

Also, replies to reviews need to the to the review not to the thread.
Fix that before replying to other reviews as it is making it very hard
to follow the flow of discussion.

Jonathan

> 
> Regarding the function choice: Stepan Ionichev identified that
> iio_push_to_buffers_with_ts() writes the timestamp directly into the source
> buffer during the loop, corrupting subsequent FIFO entries. v3 switches to
> iio_push_to_buffers_with_ts_unaligned() which copies into an internal bounce
> buffer without modifying the caller's data. The size argument remains
> st->fifo_set_size * sizeof(__be16) -- the actual per-sample data length --
> which _unaligned() caps at min(scan_bytes, data_sz) internally.
> 
> v3 is at:
>   [PATCH v3] iio: accel: adxl372: Add timestamp to FIFO data
>   Message-ID: <20260517091735.135610-1-shofiqtest@gmail.com>
> 
> Md Shofiqul Islam

