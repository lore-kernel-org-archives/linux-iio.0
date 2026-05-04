Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F53DD53E;
	Mon,  4 May 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910617; cv=none; b=uSFN1pU2ddh+WjUi0ifCoyxktrBgYAm2Z+BlKdEvW0mGSE/RYzkVOC8n8seThepgkZkBfJ/qxoKhjJj8fMDxsReIUwDLO9PpVUtJSXTt6/ZmJkQdloiq/Ry/Yo15w+FjMybIfydEdbPSla6drDZYgq+Z2rMUHfvuSnO26L56r/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910617; c=relaxed/simple;
	bh=jtVBnt9qDne+Ngjy5Mz0NdZ7Zcbdj3YhqhPzN2nbZSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRYVA7pXsl29b5OMfqoWs+qi4UnNQDYzsKXrlMZjVTwvp+U0DXoK5H80xlLCeICzLLCx4LPP51hm7lBRSK/03Qx+yrk712cFXa2aGJaI2j8M1Bzc8+GwQxV2FV/kpVVgorTogl3lAfpQHKvIjp36T5L8c/EoRwLAF4kbSQlTDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdXW34f4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdXW34f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE53C2BCB8;
	Mon,  4 May 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777910617;
	bh=jtVBnt9qDne+Ngjy5Mz0NdZ7Zcbdj3YhqhPzN2nbZSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdXW34f4nRqDlg1eRqhTCQoHYKxUPOMc5SUzvyaeYgAUUwIzDP+a+irErw7SGd6QT
	 dvgnuGDjqMfTOMyG/kLBcOiAYk4D1qbYou7iitFbTxZSk48a2qkbwxC/iw6oQLk5li
	 JW2w/gJMsJhvoOLeYfLqoEX1PuZmebRuOeWM7Tm8Y96fPXQ1/wBxcK9sF1yRgBjNsm
	 Oftfk+IHplW7VZFcCwn7LB/Njxl3wL32Pk5kBXHO76TVoRkcHf8AFNnoGypaD2Sr0Z
	 JXd5afc/KPMbpeDsfoPnxyzmp9XQbivcee2d0/KhGs93uoXbYm9JirKW77Sjb93zyY
	 p1LZ2XueHTkZg==
Date: Mon, 4 May 2026 17:03:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/11] iio: adc: hx711: split variable assignments in
 hx711_read and hx711_reset
Message-ID: <20260504170328.5d05a6b9@jic23-huawei>
In-Reply-To: <20260503120949.80292-9-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
	<20260503120949.80292-9-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 May 2026 17:39:37 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Separate the initial value assignments from the declarations in
> hx711_read() and hx711_reset().
> 
> This is a small preparatory cleanup before the later loop-iterator and
> variant-specific changes adjust the local variable layout in these
> functions.
> 
> No functional change.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
>  drivers/iio/adc/hx711.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 637114635867..b2de8db285b2 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -159,7 +159,9 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
>  {
>  	int i, ret;
>  	int value = 0;
> -	int val = gpiod_get_value(hx711_data->gpiod_dout);
> +	int val;
> +
> +	val = gpiod_get_value(hx711_data->gpiod_dout);

Not sure. Maybe Andy's feedback crossed with new version as I'm fairly sure
he commented on this in v5. Anyhow...
Remove this blank line.

>  
>  	/* we double check if it's really down */
>  	if (val)
> @@ -204,7 +206,9 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
>  
>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> -	int val = hx711_wait_for_ready(hx711_data);
> +	int val;
> +
> +	val = hx711_wait_for_ready(hx711_data);

And this blank line.

>  
>  	if (val) {
>  		/*

