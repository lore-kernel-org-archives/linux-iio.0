Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C448481668;
	Mon, 18 May 2026 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111017; cv=none; b=ZfZrP7TaEpuwIh/9HKr3CQt/5wmP8yKS3+8HFiGukdW+pS0j+tELdJCWruSScDBcTQZSzKPjuI3XRV33TCVC86UIpD9mUfzUPK0MXo1eL8+BDsrjdBKnOCyKZ8zmNKgvyhSFarIbZg4pgfS5KU6C4aLsnBkkKYXNazQKbU35BCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111017; c=relaxed/simple;
	bh=o9pmSy46f6ezMGr8HuwuyfBUyjskQYTZEUTKG4Vfl+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=God8I3jN0yoB4CQ+3Y2s98MUfwSVuoEl77M2l9dRGWVa9erOc0enS92gjWG8QQ/ZhnZYWh3mjG5oB/whCheAt7RlMaRVRUc2EdUb5ssPnkzKESBD2/4xCKeSm3WWot2mMfKyK4S/DNsKmRbVuuNrI/zfRonnDelCGvT+T5PN6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sctkB2Cw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sctkB2Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FCCC2BCF6;
	Mon, 18 May 2026 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111016;
	bh=o9pmSy46f6ezMGr8HuwuyfBUyjskQYTZEUTKG4Vfl+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sctkB2Cw8hWwnP1roV9yP9gIHxg4uRo/YvSraKInQLoUgFzTh3bqA6eM8+aQaIpUP
	 MC2N+OUeTYDgLakSOp8OI8Sj4clcsswsA55oGnluGBXex521p4oWQqa+TF67eB9dKR
	 7LlQ9NRK6WMHUoA8F8/ncVJunjmLD9HHJroIWJNnZDsdMQFp/kjXA+pEauRefJB2Sk
	 2JROTgSiS6FzO6mAm2DyblCORRkkD8TQaO1EF4xctSQtcsOCtPdwDBB2UaKABE1kI7
	 GBr3VM16F65b2HvlepzXUPLnobKtsGCEQlovXobEXDzlfA0xypEh2ZuRHIYMrGImue
	 +7A22JemkO3Ow==
Date: Mon, 18 May 2026 14:30:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] iio: accel: mma8452: handle I2C read error(s)
 in mma8452_read()
Message-ID: <20260518143007.6e4d677a@jic23-huawei>
In-Reply-To: <20260505174640.3998281-2-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-2-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 23:16:31 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Currently, If i2c_smbus_read_i2c_block_data() fails but
> mma8452_set_runtime_pm_state() succeeds, mma8452_read() returns 0.
> 
> As a result, the caller mma8452_read_raw() assumes the read was
> successful and proceeds to use a buffer containing uninitialized
> stack memory.
> 
> Add proper checking of the I2C read return value and propagate errors
> to the caller.
> 
> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Given we don't have reports of this causing trouble and the load
of patches queued up for the driver, I'll take this the slow way

Applied to the testing branch of iio.git.

> ---
>  drivers/iio/accel/mma8452.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 15172ba2972c..cefc7cf4bd83 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -252,6 +252,8 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
>  
>  	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
>  					    3 * sizeof(__be16), (u8 *)buf);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = mma8452_set_runtime_pm_state(data->client, false);
>  

