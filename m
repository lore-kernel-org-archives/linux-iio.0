Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1F1AAE28
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029766; cv=none; b=Wr7dcFZsu8GtWku43iu9+Xj5EbmNhhU3LRBPsi5pfBLSzHzlDSbQESF2oNvR+rLkCTRKxmKOPAOgcoBBVfnrBfoMhEP5ZbRDMFZ9MricsPOEmh077VytWiKuUka1xDIQLsAX11FDT76gp9TNHAbBiT1NZFA0Ov1oNTC535g5DGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029766; c=relaxed/simple;
	bh=/HrRGxU3Mdi3YMlYSb31QC06hPFb/CEcNo3lxTJtGS8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FlagIOCT9NZiWNe+zXeQ23avmcpXiYltLTK+EAJ64sAyQMkRvmI9mjDtBTE+3rhi3Fz92r/pezG93uVV7aa2NkuI+V2MH8WQtyCcyml9XO533md638zofhvJZIgVHJT78+K5UpAHfFtfu1Nn10p/YrwQkK2VmLFbjqDHbrOV2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM9EC0eR; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM9EC0eR"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcd89701acso5543258a34.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778029764; x=1778634564; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGpO04NWspWmSy3zWM7KQVfXbzQZ95lDkVNYXwJJQr8=;
        b=DM9EC0eRK6BcE74YjIml+q3Of3zKfBbhx/ckjM5AfddJS+VlStYFtoqdQ2mHfZxB1C
         EeJ0wIO4nuUegDU5bSPjk3OZdnU2/oO32ElMDFI5wPRhUKt3lafGYZucgp1kVwHd/DdB
         k38KxcJ4dLtjOXjsgKjGSs5YyF1tzGWVaLuTKEw/K/FgcjwYBxXpxCkqVMUdwcMDhSBi
         SFWVgUSZwy+pyhc9cmp9IitTxRvYKdgMlxmGIM2nb9IpH5wTmSwkkmRSiKpWkpaLy9H4
         CBrKbNwGCVfL4yN8fAzuhvBueCvRYUFpAzTq0TUE2QiT+fuppFduMEn8FRCiGBwtNDh3
         XffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778029764; x=1778634564;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGpO04NWspWmSy3zWM7KQVfXbzQZ95lDkVNYXwJJQr8=;
        b=h5bbSQwXCKJPwIvQb8zCGa7mC4/H9iwYygggk/za1vpgaRgYvKE1yTDZ+eUA6C4Abc
         w1DoLOnL+R8CMN5hx3YRMll+gNP6O7r1BfzO7xRnVAGpiqcS/YMe0+vkckKeykEZx23e
         T+XwGWSl+0REBlut4pY07MYhmbse8SavzGrC+3Mo0VV7HwBqfHNuJbORuiicmHj8SWWp
         3oT4fI/wSpFlZ0ShkxKOKpUzPsPS59UTNJM7Q5LVf3Maenu+t3s4MWgQhUH5/SUlCaXy
         oPInXdL0P38POXClPksW1dWL1hXCQCxISru+1N1mAIRTtrO5C/dRnk3sDVSptDrsyp0u
         9rEA==
X-Gm-Message-State: AOJu0YwPlHR0cA6l8eMhX1Lu+3nmazig2Z6R+Ss9abcCbU7BqqcO6EM5
	5Jr4HzoC53fV5NmDrttXcqe5ZoozPQ8hlG18Vou8ARR9dKLpTB63divG
X-Gm-Gg: AeBDievVb2mClYk2YqUXNABxfDQgmCgerFbNqwyJuDzd79Q9W9NfBhm5psNhJxn9WW7
	xikvduYO0VynT+sRfbXdH0dSk8FLD3uynmFO3xSV4LZOkc8OwvzrQIDlxG58oarm0MYBexDY1wR
	2drvjVWEhKXFhEKqyEftDHC96igrV8G59uMxYqQN5zssPZHVMrkjGwOSVIQD3aWIL4oyx5TdUfW
	ZShjoWTuqiEOjd8pGzW2IrbZUlWMv3WEbfP63bv3XuIKVULD0usP83DWFOu+OOsvpw4cXd1qp5X
	GAv9g8bSRSRoh5M+NdPygGtt/ZSzbyBWwMX3qc5g8QLSEhLsQYWUOCSO7vTcSut20GhlOdH66K+
	AFrqcd/tH7kBjv5xTvUOWezut8n0JAbocZLggLYzBqrpcn28CZiodQ3ulukGIpLw+Z2kfS3ezA9
	GaX7+DQrsJJBJisEi87ad43zZQczo8R5wI6bP6a88+BJLufn4nzplY3DORf8se
X-Received: by 2002:a05:6830:82b5:b0:7d7:f15b:bdcf with SMTP id 46e09a7af769-7e1df1a93a3mr687638a34.28.1778029764250;
        Tue, 05 May 2026 18:09:24 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decae680bdsm11375925a34.27.2026.05.05.18.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 18:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 20:09:22 -0500
Message-Id: <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
From: "Maxwell Doose" <m32285159@gmail.com>
To: <joshua.crofts1@gmail.com>, "Joshua Crofts via B4 Relay"
 <devnull+joshua.crofts1.gmail.com@kernel.org>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>

On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Add a check that ensures that valid data has been read from GPIOD. If
> not, log an error and return the negative read value.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index 129c98c97071b4cf8efa3abf2364a3abbde129ba..b3caf5f3ebf29bf701bb214aa=
480fa7afb2651c6 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak89=
75_data *data,
>  				 timeout_ms * USEC_PER_MSEC);
>  	if (ret)
>  		return ret;
> +	if (val < 0) {
> +		dev_err(&client->dev, "Error in reading GPIOD\n");
> +		return val;
> +	}
> =20
>  	ret =3D i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
>  	if (ret < 0)

Small nit but I wonder if we can change:

	if (val < 0) {
		dev_err(&client->dev, "Error in reading GPIOD\n");
		return val;
	}

to something like:

	if (val < 0)
		return dev_err_probe(&client->dev, val, "Error in reading GPIOD\n");

Would be good for code density.

My rb will apply either way.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
