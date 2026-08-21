Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B6175A9C;
	Fri, 21 Aug 2026 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272915; cv=none; b=ZAacVhFizJST7Hc50Zc70oHiAv+nptrd6WuI1lrWDdhzCMksowM39w7hZBpB+1ohbVeAmTRouQX+5HoWIN+8uZmbNu53OBNNrI7ikD6fnmCNdo0golFIV9z1exifkAIKO4seB1G4OkqZj27K4lNHBw5/j1fqKHP3bk038h1LeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272915; c=relaxed/simple;
	bh=5BC+9R0TvKxxjgeQBxQkOubrWwFVKhMtGh0QHpuOCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p29MECQ5s86Hyv6tfT6zgjWts3t0JN4HU2ATSPi/1s+yuO7GdauIa/ty29DvRu7MlCrXYTF5z5gjvVZZWTzvsYGahpHlGB2BTU+LfmKpJn+JYhgnk0vMbAMtPCaenOsiTnzu+pa9immRsj1EuxlOKKGQc3hB4CV+DgCB37yGlKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKCritH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKCritH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209861F000E9;
	Fri, 21 Aug 2026 00:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272913;
	bh=Ur+Aw3yJ1DjcnVpNNfD4tzrU1RqRb5jL/K7wPuZkqLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lKCritH55cE8n880p+F/5nDp23fpYoh56frNhQbN09JG0NqhO2o9XgL+9ox2SFRyD
	 qLRlE4yPVtIYbylJrT3uxB4zfaz1UmSR2tIsZTNJoMuTmcPfhw7t4vpnq7LOuggibt
	 qTVde/DeNKCX1//P/HRxXSViQvjXSfY0Tb36GCKb4LiFc4WTt8ibDj1Z7M5PQllqTH
	 PQ1qEB9NfyY4jM4Ugr/w+uDr/DKAfgIR567EIqemTA9pk+2RUB5CyCH7yO6AcZxSk8
	 nXBkIRvuGF+DldI4V4Y52z8Z51hstJFLsCohouLduN+uNag5eOlDapLFkckyPplTVM
	 APhNU1fcUKWSQ==
Date: Fri, 21 Aug 2026 01:41:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: pressure: ms5637: Add missing ms5803 I2C
 device ID
Message-ID: <20260821014148.691bb65f@jic23-huawei>
In-Reply-To: <20260820141224.23730-2-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
	<20260820141224.23730-2-adamianlouis@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 10:12:16 -0400
Louis Adamian <adamianlouis@gmail.com> wrote:

> meas,ms5803 is in the OF match table with no corresponding entry in
> ms5637_id.
> 
> Fixes: 649ef114a0a0 ("iio:pressure:ms5637: add ms5803 support")

Hi Louis,

What is the result of this entry not being there?   We need
a reason that this is a fix rather than simply a cleanup / consistency
improvement.

> Signed-off-by: Louis Adamian <adamianlouis@gmail.com>

Please make sure that a series has a cover letter in future
--cover-letter to git will provide you with one to fill in.

The rest of the thread will end up in reply to that. Brings the
advantage of a place to provide a short overview of what the whole series is up
to; somewhere for comments; and a useful name in tools like patchwork.

Otherwise this looks good to me.

> ---
>  drivers/iio/pressure/ms5637.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index be8921644558..4f9f556bd123 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -215,6 +215,7 @@ static const struct ms_tp_data ms8607_data = {
>  
>  static const struct i2c_device_id ms5637_id[] = {
>  	{ .name = "ms5637", .driver_data = (kernel_ulong_t)&ms5637_data },
> +	{ .name = "ms5803", .driver_data = (kernel_ulong_t)&ms5803_data },
>  	{ .name = "ms5805", .driver_data = (kernel_ulong_t)&ms5805_data },
>  	{ .name = "ms5837", .driver_data = (kernel_ulong_t)&ms5837_data },
>  	{ .name = "ms8607-temppressure", .driver_data = (kernel_ulong_t)&ms8607_data },

