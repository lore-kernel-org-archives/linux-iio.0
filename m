Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112C2882BE;
	Sat, 16 May 2026 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928574; cv=none; b=pRtcskTfCRByf0eGZWFFKWdHLYsP0hkLMUbDb7DSHmhNAK6MfXiyLtkwFO0ubpMPJ1YXIexuDEh0LpovxG7qMuLtoT3JDUdcneBSbKe3qps0VlmkhqYmVa7LNwezF1dF271Jaoxd4euRUyhx4wz1X+2bHhVFXD5fP6Dp0RSoL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928574; c=relaxed/simple;
	bh=XZq193zuMYXEaB44tkd+FlCUgZXZjY7vz1COsu5GWPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzMJGtCoiGgbegtBtKcsvch5fFYsutkRKa6nexX6w9kLf5Et8pHDf0upodBMl7+6CEReWwi7/Vl8nbW7S3oRO0OklsdwyxBnfwKtLi5BBvEdWH6T4YYugc6pmx5+zTsx6u0O1gM3IxK3j4lprY1boYHmdpi6uYlaPjpJVE3JzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0LwRGtt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0LwRGtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2F6C19425;
	Sat, 16 May 2026 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778928574;
	bh=XZq193zuMYXEaB44tkd+FlCUgZXZjY7vz1COsu5GWPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0LwRGttgFQ5k7lqvJCp0IO4ZyCzs+5qABpHWNBzrXo8ZxxnZt6cUvZFzJLB9ss8z
	 UaZRz1Fsg5Yf3rEPxyh+0xHTilyVyE9O/c1PCaF36Fh+HfckWfmG87u+AxdTz/U31H
	 c3PSEl/fUGNL5Yeidcdi+XWLPBNL3zGLjMOyi2DEpf1n0NqTPnZMRCZFmv3+eW5PzC
	 SaQPND7p9jPGBLc/qpwHJZ1uGOwalKE5Lm1qObWKLdsjQnLWLJpOJ21PTjtoIH1T+Y
	 y5n2ZBY43EaXUIkqBdnU9gxEh+va3qzg9kUqEGQAG7t6JyLI1y9rnkN5EKS+dSBjJg
	 Yfu6smxLth/iw==
Date: Sat, 16 May 2026 11:49:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: bmg160: wait full startup time after mode
 change at probe
Message-ID: <20260516114926.3a8b7d38@jic23-huawei>
In-Reply-To: <20260511154704.76967b74@jic23-huawei>
References: <20260511062755.30-1-sozdayvek@gmail.com>
	<20260511064020.362-1-sozdayvek@gmail.com>
	<20260511154704.76967b74@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 15:47:04 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 11 May 2026 11:40:20 +0500
> Stepan Ionichev <sozdayvek@gmail.com> wrote:
> 
> > bmg160_chip_init() calls bmg160_set_mode(BMG160_MODE_NORMAL) and
> > then waits only 500-1000 us. Per the BMG160 datasheet
> > (BST-BMG160-DS000-07 Rev. 1.0, May 2013), the start-up and wake-up
> > times (tsu, twusm) are 30 ms.
> > 
> > The same file already waits BMG160_MAX_STARTUP_TIME_MS (80 ms)
> > in bmg160_runtime_resume() after the same set_mode(NORMAL)
> > operation. The 500 us value at probe was likely a unit mix-up;
> > the old comment said "500 ms" while the code used microseconds.
> > 
> > Reuse the same constant via msleep() and add a code comment
> > explaining the datasheet basis for the wait. Without this,
> > register writes that follow the mode change can hit the chip
> > before it is ready.
> > 
> > Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>  
> Some process stuff.
> 
> Never send a new version in reply to the older one.  Always
> a fresh thread - the reason is mainly that the threads become unreadable
> if you got to more than one or two versions.
> 
> Also, don't send a new version for a reasonable period of time.
> Something small like this maybe a few days, a bigger patch 1 week.
> 
> That lets multiple reviewers have time to take a look.
> If you have a lot on list already then slow down in general and
> spend some time helping to review patches coming from others.
> The biggest bottleneck in IIO is reviewer time.
> 
> Anyhow, I'm going ignore this for a little while at least...

Applied to the fixes-togreg branch of iio.git and marked for stable.

As fixes go it's pretty safe given it just extends a sleep, so
I'll grab it now rather than waiting longer.

Jonathan

> 
> Jonathan
> 
> > ---
> > v2:
> > - Use msleep() instead of msleep_interruptible() so the wait is not
> >   cut short by signals during probe (per Andy)
> > - Add a code comment with the datasheet basis for the 80 ms wait
> >   (per Andy)
> > 
> >  drivers/iio/gyro/bmg160_core.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> > index 38394b5f3..6d9019451 100644
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c
> > @@ -258,8 +258,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/* Wait upto 500 ms to be ready after changing mode */
> > -	usleep_range(500, 1000);
> > +	/*
> > +	 * Wait for the chip to be ready after switching to normal mode.
> > +	 * The BMG160 datasheet (BST-BMG160-DS000-07 Rev. 1.0, May 2013)
> > +	 * specifies a start-up / wake-up time (tsu, twusm) of 30 ms; use
> > +	 * BMG160_MAX_STARTUP_TIME_MS (80 ms) as a safety margin, matching
> > +	 * what bmg160_runtime_resume() already does.
> > +	 */
> > +	msleep(BMG160_MAX_STARTUP_TIME_MS);
> >  
> >  	/* Set Bandwidth */
> >  	ret = bmg160_set_bw(data, BMG160_DEF_BW);  
> 
> 

