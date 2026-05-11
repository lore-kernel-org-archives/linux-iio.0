Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140EB370D69;
	Mon, 11 May 2026 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498946; cv=none; b=VriNYQPQHatDuwK1SpAbj6vigrLOooyAHF7U5iDucribnSk/gQblxkFoa4FoAFO0dSmPlWk7N1KxgOjEFz9Qen30Y10G7t/rc+xbCTU45Gyjpmd211S1+/7yV66UsUfaC0iQ2RJlChI1mQtmhQ7zPYzieFzJQhc3uPBtBtjFhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498946; c=relaxed/simple;
	bh=c0kzugRV8d85faO2BidZZOcFpyeXUdX4L17GVBQF2Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWgNNFChyjhIetsJ/xJsZi3wQ3Tj8XQbkUVg4kX2T70tD7U3uftPF19vgt6zI/ezI7KuG19PbIFC9TBVR1vamQ0QhFshykBHWaKpbkKwUkossGg2oQAnhn8ALCVkNbOzgjmnkh9VEZK0KA1vfgMLHoTlbD/c58ZwqDV1+alvTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an6VUAO8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an6VUAO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C12DC2BCB0;
	Mon, 11 May 2026 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498945;
	bh=c0kzugRV8d85faO2BidZZOcFpyeXUdX4L17GVBQF2Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=an6VUAO8JQJJsYLvAHQFhplH1QGYPBwOQ+APbppKKjFgMp9X8PvNLyMtRbHT498uA
	 0MNufUb7hi3k014HaeOmSXW0jNs6QtW2mbiTOVFDoW4xqijfmnp2LyXk2hbAlymZQi
	 TQeCQ0l35v5YUnMoFwSGhMfU68JQIPso1vHWTaEqHwjXSncV6c1rlnBpU/+H8V9lA2
	 tEgJGdOicxbNE8T8/tOZFEDxvW6DNnlWW5dueK8CgGFVsHMHmHYInnICTIQ412l6A9
	 wI7eXFiF+o7wwLLzmlwWK7vAfAriRSIp51JHPqRaSmzhh4UZZKTzGLf0+451oCZ3vh
	 jIfcZtEJi1LTw==
Date: Mon, 11 May 2026 12:28:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: scd30: make command lookup table const
Message-ID: <20260511122857.72300647@jic23-huawei>
In-Reply-To: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
References: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 17:39:17 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> scd30_i2c_cmd_lookup_tbl contains fixed opcodes and is
> only read by scd30_i2c_command(). Make it const to document that it's immutable
> and allow it to be placed in read-only memory.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Applied to the testing branch of iio.git.  Thanks,

Jonathan

> ---
>  drivers/iio/chemical/scd30_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
> index 436df9c61a71..bf465cc71be7 100644
> --- a/drivers/iio/chemical/scd30_i2c.c
> +++ b/drivers/iio/chemical/scd30_i2c.c
> @@ -20,7 +20,7 @@
>  #define SCD30_I2C_MAX_BUF_SIZE 18
>  #define SCD30_I2C_CRC8_POLYNOMIAL 0x31
>  
> -static u16 scd30_i2c_cmd_lookup_tbl[] = {
> +static const u16 scd30_i2c_cmd_lookup_tbl[] = {
>  	[CMD_START_MEAS] = 0x0010,
>  	[CMD_STOP_MEAS] = 0x0104,
>  	[CMD_MEAS_INTERVAL] = 0x4600,

