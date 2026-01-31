Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD031ED96;
	Sat, 31 Jan 2026 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878890; cv=none; b=kZUfvlHAmpZ2bP/1mA2uAqDga20ZQ18a8Yc+VEAfmvzHEMM3BMzOmPJk6aByAkktjdsXUegs74hUMeIm/j6U4fqcboN7SlcqlwBRWr9NBzLrK26EOnb4hDw/qHiGK6+dkpX0/rcZZYNHYvmMFBnEUFM61oH4B4BmjKuhsNureXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878890; c=relaxed/simple;
	bh=Pt2FyOiNS5wy7cj0H7PckNntWSxkJeZkuO49mjJO0Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgxiXqdQRql8U/VR13APX6Kbca+DXsPMymtlhl6Z7hujHOMdfAvn5hSd+hDVOBckpuGAe9OT1RmFFY0qLx4cDf6oUdmAK7E8uXBo9vfo7s+MKUOBQellx2cM3DsSn7luZH7FgzQBHx6+veAoMzE/cBn/NpM2rXjxm+qvrLDrnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/0dCW4O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/0dCW4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6B8C4CEF1;
	Sat, 31 Jan 2026 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769878889;
	bh=Pt2FyOiNS5wy7cj0H7PckNntWSxkJeZkuO49mjJO0Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/0dCW4Oe3FV0wwhn2QHNnNgkCt+44UrqITO/Fw7A557+5Ylsr0cF9e6TAJ/VbcEM
	 6kPPPESasI47vF0m1BKjCQ2Fhk52PuC0iSlut1NYDpsF5SJoUVdVgX9LwvLvysy7KY
	 +gxYbpaq02UmJcWhlTM26ifl+DjFPdLs57F81sCtdetbrjW0u6h4lJYeA1FxoYYbAa
	 EJNXUdeRc1yg3PSE1ef8CAGh5IOb6fZ3OOl714wVVFsUJ1n2dRN795cD0IPBKOzsPc
	 jTyBqhC7gwDSly2h6p4bQcmcdq3uDfdfchwtxrtEsqdYQOVMUA6diG2q6qd/9Ryqad
	 NVL44dqHacqAQ==
Date: Sat, 31 Jan 2026 17:01:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Eugene Zaikonnikov
 <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: humidity: hdc2010: remove unused interrupt_config
Message-ID: <20260131170121.59ae87dd@jic23-huawei>
In-Reply-To: <20260129174253.39574-1-antoniu.miclaus@analog.com>
References: <20260129174253.39574-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 19:42:35 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Remove unused interrupt_config field from hdc2010_data
> struct. The field is declared but never accessed in the
> driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
This set are also incorrectly threaded.

Also, don't have more than one set of patches posted at the same
time addressing the same sort of thing.  Just post one set with them
all in, or wait until first lot are merged.  Having multiple such
sets in flight just causes confusion for reviewers.

These are fine, but I'd like them inside that other series I'm requesting
so they are all in one place.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hdc2010.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc2010.c
> index 894a8b4ab193..1a0f18251381 100644
> --- a/drivers/iio/humidity/hdc2010.c
> +++ b/drivers/iio/humidity/hdc2010.c
> @@ -44,7 +44,6 @@ struct hdc2010_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	u8 measurement_config;
> -	u8 interrupt_config;
>  	u8 drdy_config;
>  };
>  

