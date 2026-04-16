Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0523B8D40;
	Thu, 16 Apr 2026 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342664; cv=none; b=X4iWziMDmdqPAhh/cyzYGMf24kanbzgWOFWPjWPUTDpLtOleztfeboUFv2j3kOEWFCpQaGcxe0Gbzp9tREb/7qFP2au9GCJWVeSQcSP7bpINCabfEtk0LC7ROQZMs8+0KQlpTjmzOxJnqnJgc6DNkLUezf3B0Zcwi6sVK1gbnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342664; c=relaxed/simple;
	bh=98rAaX+oAjU7ECenp0524ZUCwpg85vopPqdsir+vbvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/sKLDA95LuPms3W0LKjLMJUE702cNLldvgQqf73bHjg+NnzjKuH+pyHKHM7iAFhbKGp8G3wTkqwgxu8DGrl+RtXkiQuybeTibcMD6fqHkda4dAPcahaaszrwxO0mX30HuPc7lE7m58/h4IAzmz6j0CY9zeRdSuCoLQhf3tPGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/uyhnzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/uyhnzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFE2C2BCAF;
	Thu, 16 Apr 2026 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776342663;
	bh=98rAaX+oAjU7ECenp0524ZUCwpg85vopPqdsir+vbvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C/uyhnzYPzmts5FMCqGJztOhscs/KNkLyc81zaoaXKHZXYhoxiK/Rv9brbJoEw1fp
	 2WL5LfJcmZtk9gzpOJR8vK2qTzWVCXi/UQRE+0E0dxjgI3moE4hv287q4c/c+lzlhm
	 oMsfDM3Adc9ol+QxZ4ssOybMzPn856H1fJBa1vhLN51ZwF/cZlaIcg5NzYr6eUDWoK
	 Jmy+1MdQQlZLaPy80JcJnXkXcvVEty9VGLvv2ZPZnAXlmv0mCB40+Hue+/sYTawDtr
	 gUpRkCo+YcX4MYUxv9d+yHa5RtoK1Pbo8/Rl5UzkTuih1ChVvUYCP6R84dmrcf4UNN
	 grT5y5Ly64xWA==
Message-ID: <533baaf1-4ae8-4401-b5b0-67e495a426ba@kernel.org>
Date: Thu, 16 Apr 2026 14:31:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: Fix iio_multiply_value use in
 iio_read_channel_processed_scale
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260416111442.61932-1-clamor95@gmail.com>
 <20260416111442.61932-2-clamor95@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260416111442.61932-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 16-Apr-26 13:14, Svyatoslav Ryhel wrote:
> The function iio_multiply_value returns IIO_VAL_INT (1) on success or a
> negative error number on failure, while iio_read_channel_processed_scale
> should return an error code or 0. This creates a situation where the
> expected result is treated as an error. Fix this by checking the
> iio_multiply_value result separately, instead of passing it as a return
> value.
> 
> Fixes: 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale() precision")
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Thank you, good catch:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/iio/inkern.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 0df0ab3de270..9ce20cb05a9b 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -738,7 +738,11 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  		if (ret < 0)
>  			return ret;
>  
> -		return iio_multiply_value(val, scale, ret, pval, pval2);
> +		ret = iio_multiply_value(val, scale, ret, pval, pval2);
> +		if (ret < 0)
> +			return ret;
> +
> +		return 0;
>  	} else {
>  		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  		if (ret < 0)

