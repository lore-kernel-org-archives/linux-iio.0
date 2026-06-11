Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DC42669A;
	Thu, 11 Jun 2026 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197996; cv=none; b=hE/obRFiuxrmCRmqH6DuscTFuSyhzG3hJb+niEaWLUCgqZYmOXrLEenjdrIulPs3OmaQ6t3DUvu4QYbF6r8wo7IBBXrOFQ/NIn3LUw2TML5Kp6a9bf/QROZTn6GEjelrK2Mx4E7P2OIsT4o4CL4BG5PgUg4dHGxbZkO/e2wD0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197996; c=relaxed/simple;
	bh=OD33JUqAzeV9ACewVGP7z2byt0W30/9CV+gWOFpNfMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0h6hwsx/ovJNF+45UKzw5sVDFvbNSk6BEQeAzjl0/Hub2X2Tpw0wT8n+4R/6RkVaeH/7r6v81i8bsIzplb0lnLDayH9P0LbIP5ns7hmFzPhm80HM6fQ6FDy6tHI1hKeVPhc7VUheB+yWQZYFHm1rs5To7oM2JOEQ1CnqbxpTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoNYQsCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoNYQsCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D631F00893;
	Thu, 11 Jun 2026 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197994;
	bh=fgHJxDcUwgvVCrhFds1I3bAEkOAfR19ANqZAFh+mRqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OoNYQsCNVNSNIOIvz4Kf4s1GzoahOZSwm3g/nzVfx7eCIaC5/0BecgumJpVANLAek
	 71tx8uWCbGZk/pCpOLp7GbLSJQT+p1gjghGac8nWNZ9P94gietUs20YzQMaPou0sZ1
	 anlJzU3D0ZAWr6lwxjvaIVGfGrfpjzRl7kVasrKNHfUGijeqnu4vh8soU7bMaFiMxY
	 A97rbKG1x0ZE4ZVVeuZw99CoANufWaAo8enJyW7/p4bluGh9bh+SN1YFZh520H3SYa
	 bCxt4z10XHnP/vkaR6GmzemtOXjSU4RfozujgP/Qh8ViOxbQ+ZOaSYAJqkBDoA7lqY
	 Bbl0K6WXNiZbw==
Date: Thu, 11 Jun 2026 18:13:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v5] iio: tcs3472: implement wait time and sampling
 frequency
Message-ID: <20260611181306.6ee42160@jic23-huawei>
In-Reply-To: <20260609155515.1004545-1-aldocontelk@gmail.com>
References: <20260609155515.1004545-1-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 17:55:15 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

I tweaked the patch title to include light so we know what type of
sensor this is as well.

> The TCS3472 has a wait state controlled by the WEN bit in the ENABLE
> register and the WAIT register, with an additional WLONG bit in CONFIG
> that if set multiplies the wait step by 12. The driver previously
> defined TCS3472_WTIME but never used it leaving the TODO comment on
> the top of the source file.
> 
> Implement control of the wait time through IIO_CHAN_INFO_SAMP_FREQ:
> 
>   - Reading sampling_frequency returns the chip's current cycle time,
>     computed as the sum of ATIME, the fixed RGBC initialization time
>     and the wait time (which depends on WEN and WLONG).
> 
>   - Writing sampling_frequency programs WTIME so that the resulting
>     cycle period approximates the requested frequency. If the
>     requested frequency cannot be reached with any
>     non-zero wait time, WEN is disabled and the chip runs
>     back-to-back conversions at the maximum rate allowed by ATIME.
>     If the requested period exceeds the maximum WTIME range, WLONG
>     is enabled to extend the wait step from 2.4 ms to 28.8 ms.
> 
>   - The user's last requested frequency is stored in the driver's
>     private data so that subsequent changes to integration_time
>     recompute WTIME and preserve the requested sampling rate as
>     closely as possible.
> 
> Add TCS3472_ENABLE_WEN, TCS3472_ENABLE_RUN and TCS3472_CONFIG_WLONG
> bit definitions. TCS3472_ENABLE_RUN bundles the bits
> (AEN | PON | WEN) that are simultaneously set when the chip is in
> running state and cleared during powerdown, and is used by
> tcs3472_probe(), tcs3472_powerdown().
> 
> Add a u8 enable_pre_suspend field to struct tcs3472_data:
> tcs3472_powerdown() snapshots data->enable into it, and
> tcs3472_resume() restores enable register content from the snapshot.
> This preserves the user's WEN choice across suspend/resume.
> 
> Bound tcs3472_req_data() polling to the worst-case cycle time
> (~8 seconds with ATIME=0x00, WTIME=0x00, WLONG=1).
> 
> Fix the event period calculation in tcs3472_read_event() and
> tcs3472_write_event() to use tcs3472_cycle_time_us() instead of
> ATIME alone. With WEN enabled, the chip cycle includes the wait
> time now.
> 
> Remove the "TODO: wait time" comment at the top of the file.
> 
> Reported-by: Sashiko <sashiko@lists.linux.dev>
> Closes: https://sashiko.dev/#/patchset/20260607112713.299968-1-aldocontelk%40gmail.com

These are (I think) for tweaks to a patch we hadn't merged.
As such they shouldn't be here. Thus stuff belongs in a patch
that simply addresses some feedback from the bot (and nothing else!)

I tweaked as Andy suggested + the stuff mentioned above whilst applying

Applied to the testing branch of iio.git. Note this will be rebased on rc1 once
available before it turns up in linux-next etc.

Thanks,

Jonathan


> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
