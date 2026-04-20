Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055B36C0D2;
	Mon, 20 Apr 2026 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707622; cv=none; b=MIvM6R6RAiHBCfN4Im5DW17k95J++1QcJYQek7Pn8Z4RISwCxzinZajpE8tQnswEbfnSmoRQYcudZaVB/L9X/5Y0orL/YLZolhkHFR96SX0oIJ6RjjXWsxvP6f7+hhiOVSVFq2LaaCCH8tibuMxYpT6EE4pk5w2pTbTY1z5CiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707622; c=relaxed/simple;
	bh=5acI+o4HFsnh2ccQchJrDcTLRKWq+npsKM/iml/SAhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeiJjX3RNWS02MefRnyupOf7LOi4JreJtsIv9/gFCOT0RjR07CkQt97aoH4Kl+WBIxE/Op2L32ciIy0B/SIQiP/B7mb5OccHL4opovWrF8bYHr3WzRFjcrDU2Kgq1dDPsbl5QdG2rSwwJx9f7DzNTXzae07rRQPgqffyWAnMxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmctomMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmctomMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB77FC19425;
	Mon, 20 Apr 2026 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776707621;
	bh=5acI+o4HFsnh2ccQchJrDcTLRKWq+npsKM/iml/SAhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MmctomMooNTfxbttxGS4jWZDvQFgaRS/lcnrYkBc67tnLAmLa67ZLHAViQkSYoXr9
	 A168dlKbqK/dVFzxlVcQYkboWySA0EG7bM6lRau/OBOKi5bfco2+gUn2qhTrz+iahv
	 jvON8U8qypnlOCmLyRDO4ZBeH7WD35d1qsitRLfV3X7oIT7OOVPtZaKHAgspPH/huP
	 tLJsH2yFTdHZIJCyjKPJnyTq329kz6e85BE9rEM8jIn90aN4lmcqF11RUSjrgX2Sve
	 Tm9J9CwCz64KcVQzc8Tjo7gq3+cKp+f1twtIzsMZ8qjHigEXb0AH6dyGyJubPtyxHF
	 LVzn9SxUN1npA==
Date: Mon, 20 Apr 2026 18:53:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: ktsai@capellamicro.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, daniel.baluta@intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 me@brighamcampbell.com, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4 1/2] iio: light: cm3323: fix reg_conf not being
 initialized correctly
Message-ID: <20260420185333.3bab224d@jic23-huawei>
In-Reply-To: <20260407151702.15208-2-aldocontelk@gmail.com>
References: <20260407151702.15208-1-aldocontelk@gmail.com>
	<20260407151702.15208-2-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 17:17:01 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> The code stores the return value of i2c_smbus_write_word_data()
> in data->reg_conf; however, this value represents the result
> of the write operation and not the value actually written to
> the configuration register. This meant that the contents of
> data->reg_conf did not truly reflect the contents
> of the hardware register.
> 
> Instead, save the value of the register before the write
> and use this value in the I2C write.
> 
> The bug was found by code inspection: i2c_smbus_write_word_data()
> returns 0 on success, not the value written to the register.
> 
> Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
> kernel. Before loading the driver, the configuration register 0x00
> CM3323_CMD_CONF was populated with 0x0030 using
> `i2cset -y 11 0x10 0x00 0x0030 w`, encoding an integration time of 320ms
> in bits[6:4].
> 
> Due to incorrect initialization of data->reg_conf in
> cm3323_init(), the print of integration_time returns 0.040000
> instead of the expected 0.320000. This happens because the read of the
> integration_time depends on cm3323_get_it_bits() that is based on the
> value of data->reg_conf, which is erroneously set to 0.
> 
> With this fix applied, data->reg_conf correctly saves 0x0030 after init
> and the successive integration_time reports 0.320000 as expected.
> 
> Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
Applied this patch, but patch 2 will need to wait for this to make its way
into upstream - probably middle of the next cycle before that is in place.

thanks,

Jonathan

> ---
>  drivers/iio/light/cm3323.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 79ad6e2209ca..0fe61b8a7029 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *indio_dev)
>  
>  	/* enable sensor and set auto force mode */
>  	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
> +	data->reg_conf = ret;
>  
> -	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
> +	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_conf\n");
>  		return ret;
>  	}
>  
> -	data->reg_conf = ret;
> -
>  	return 0;
>  }
>  

