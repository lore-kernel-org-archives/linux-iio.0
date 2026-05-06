Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B654921A6;
	Wed,  6 May 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085147; cv=none; b=N1Vxduc3KnZpoWgXBQuChKj3eB2HdpqRTH6Kt/MNxtk5Z6DU0PsW4BtQ6bHqZ86cl+apsPRD/fjJTR9omqZ485Ri4ATDwZP/dxbF/CVXzpTXSrR9DyAqOc1o8TLrRrqu41uxxz3g7buw7rNYYxkckSSmam0OCB487affVM+74iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085147; c=relaxed/simple;
	bh=kj9v+XJI+TIb5FLhChn+YEftA75XrLFvIr6DBey1ly8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLIGYMbvDt9de65tMH7lA/+HcW+7L9ERl7De6y3Y/uT9swOQuzhS4RLqIgCEWpwVq0ahXw9ctnCg/f809W7l7SRINJUIprBfe6m/yrdQhK4IOl4J90lUSEkvztZJBTtet6RdzeKObx98rIy1yhBY39d4Bbt2M/58+Su0caDRZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gswsmjv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gswsmjv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB87C2BCB8;
	Wed,  6 May 2026 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085147;
	bh=kj9v+XJI+TIb5FLhChn+YEftA75XrLFvIr6DBey1ly8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gswsmjv7x0qjMOrgan8ohyFVQ5z48Czq4Sa2oH721OM+41S8PBKlinJHsg4LKhba0
	 lbrwDr+XRgDpQLNlGNEQsSbzZ5G66neI5C56bPbvcn5VBkUpOtbA30qyO1I4wyKkiS
	 u99LyvFdaVINx5tVMKj6lDiF+xUQrzt4mbWWOvwQLSXUxdbdmzjsHjTabVE0b3pTE4
	 3rREsY4GoTF1JraXjwszCvhuNTfWKm6hmht8bBmzCLbaTewJrQvtxuwpTlgDR1mtwS
	 b7P4kbY2j8azc+wIP1yvZbb1kLtiYcgJyHdMh4aK5EUn9otDkxn7OEJuPHc8lz1JCG
	 e9LNmOGBWCAlg==
Date: Wed, 6 May 2026 17:32:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: tsys01: fix broken PROM checksum
 validation
Message-ID: <20260506173219.18e7d1d1@jic23-huawei>
In-Reply-To: <20260505071025.69221-1-salah.triki@gmail.com>
References: <20260505071025.69221-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 08:10:24 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The current implementation of tsys01_crc_valid() incorrectly sums the
> first word (n_prom[0]) repeatedly instead of iterating over the 8 words
> retrieved from the PROM. This leads to a checksum mismatch and probe
> failure on hardware.
> 
> According to the TSYS01 datasheet, the PROM consists of 8 words. A valid
> check must iterate through all 8 words to verify the integrity of the
> calibration data. The current driver only checks the first word 8 times.
> 
> Note: This fix was identified during a code audit and is based on
> datasheet specifications. It has not been tested on real hardware.
> 
> Fixes: 43e53407f680 ("Add tsys01 meas-spec driver support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
Bit of a gamble without testing but seems correct to me so small
gamble. Even taken it slow path doesn't really guarantee anyone will
happen to test it - so...

Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
> Changes in v2:
>    - Update commit message to clarify that the fix is based on the
>      datasheet analysis.
>    - Add a note mentioning that it has not been tested on real hardware.
> 
>  drivers/iio/temperature/tsys01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
> index 334bba6fdae6..104dd45598b0 100644
> --- a/drivers/iio/temperature/tsys01.c
> +++ b/drivers/iio/temperature/tsys01.c
> @@ -119,7 +119,7 @@ static bool tsys01_crc_valid(u16 *n_prom)
>  	u8 sum = 0;
>  
>  	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
> -		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
> +		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
>  
>  	return (sum == 0);
>  }

