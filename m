Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D833537FB;
	Sun, 14 Jun 2026 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442321; cv=none; b=bYoQN/zogX2UuRg26r2Tdt4aqnIVae0vZmQgDMx3qrzXpV/I6P5A0T7xkXuTSFdBQk2KS9BKd5Ut/YvopffdFJHVM8NqqcQcFFxhUTBjKznwB5GFWv3uFQHz0Jfb00pPdX9QazomAaadR32FpdTxiF9MxfFmTl1s6K7UsFIiXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442321; c=relaxed/simple;
	bh=thhprmwI8/zTw8oYPTuF002KaEL2YI22oDxA7cG577E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mt7pKJRKofm7O18AckFHM3x+g4X8cUzCeAra/u6zOYhQPfIeSI/YqcIGZ7d2dvinmeWKjjflCRNYRD0E0hiotekL9J9TpB5tpS4xTA86J3fXcxMwhkc0jBAWXBm7JZe0uLYfeBFNWXy3zFItKVhyO77ukYQ3YFPahR06IJ81GiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgKq8LNY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgKq8LNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8BE1F000E9;
	Sun, 14 Jun 2026 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781442320;
	bh=TI2uFsNZwTo2e+iXd8A9AUahqQkAj8k4o473BA8RjuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DgKq8LNYGTyYO2CMW0eBnwboPTbl1TwtVwGUe1ZRhBNQ63QD4GNALp3UEnl8qJLTN
	 TyhJKzcSUPw3PII9ZF9zni3lealfp+7LwXDIr7LIiv4XIOK6RlZIgTI9oA05kf5LgH
	 XifHdJV0sndYkFTgu6A/+llSL8wpUrYrGvbpHpm+9oYL164kRdPkbTJidu1FscbHJT
	 30kG/ORSEx4vgOx8lFg+tWBRJVtDUCo3cn0Me6BJdOtBoSpj/kQPdAqzLODqnmpdKn
	 Rpg3HjZh3ta8dVRH+9nhAZAmnfgBlzNk1enfNOdDRPSNvghPNy36kJc2nZHA/LXf3v
	 BvAl0AxTuTT7Q==
Date: Sun, 14 Jun 2026 14:05:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Message-ID: <20260614140513.0482ed22@jic23-huawei>
In-Reply-To: <20260614084349.25823-1-email@sirat.me>
References: <20260614084349.25823-1-email@sirat.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 14:43:38 +0600
Siratul Islam <email@sirat.me> wrote:

> This patch series adds some cleanup fixes for the vl53l1x-i2c
> proximity sensor driver.
> 
> - Sort register defines list
> - Extract data-ready polling into a helper
> - Fix regmap_read_poll_timeout() arguments alignment
> - Add field definitions for BIT(0).
> 
> No functional changes.
> 
Series applied to the testing branch of iio.git.
Note that will be rebased on rc1 once that is available.

Thanks,

Jonathan

> ---
> Changes in v4:
> - Remove blank line in commit message tag block
> - Align regmap_read_poll_timeout arguments
> 
> Changes in v3:
> - Use proper field definitions
> - Split changes in two commits
> 
> Changes in v2:
> - Rephrase commit message
> - Remove cover letter
> 
> Link to v3: https://lore.kernel.org/linux-iio/20260611134245.30042-1-email@sirat.me/
> Link to v2: https://lore.kernel.org/linux-iio/20260608124027.35879-1-email@sirat.me/
> Link to v1: https://lore.kernel.org/linux-iio/20260608033218.26514-1-email@sirat.me/
> 
> Siratul Islam (2):
>   iio: proximity: sort the register values for vl53l1x-i2c
>   iio: proximity: cleanup fixes for vl53l1x-i2c
> 
>  drivers/iio/proximity/vl53l1x-i2c.c | 39 +++++++++++++++--------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> --
> 2.54.0
> 

