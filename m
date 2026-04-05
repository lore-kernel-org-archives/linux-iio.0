Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62E280309
	for <linux-iio@vger.kernel.org>; Sun,  5 Apr 2026 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401952; cv=none; b=mdkz1BoPeQoDoyI2CwnyluA/QiZLS66qq9/y9B3bdzddedpcjv2C/zEsSSlAP2FeVeVoGFWns5TOaJb6Ln0kqd8QlZqfJXsgLydMtUEA7b3H4BVsdyljX1dAyMQxctapb16tRY9Fp5Uv7BxcDcMEePiOOKE55ZXjT/QwC8dYJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401952; c=relaxed/simple;
	bh=Clxc1TNqdtfpEHL/HS2PI3FNSIwolS3sq/7BAEx+TJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPzLndwPNl1RGSU5wC0Zr9eHrkuSJZmSWQ20zEl445OxR+mcgJOaC668mPZR41r1Wy5njiP4bhG9KmrKsXXPtg7QjQSUhs8TvsAzoUw6U9BBrxLQ84VeTdnyET5XholCLMlvIHdCa+Wy6hk+xlNFaLqtumj/3rtRvXlQAPwhWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=pR3s0D9R; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pR3s0D9R"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-682baaa9f1aso470068eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775401949; x=1776006749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BANRRy4E4zRqxqgNimKW4aaAELzYPRotrVokPpoURw=;
        b=pR3s0D9RUJl3A1IJ+j8tgUOgTw5E0lKDfuJMN4WVjBTpv7QqSU8HjJf3lBUWqN7YBp
         hubdcy2AoPb2SIUVc9iO6rtZdBUT9b1DoadHAvqMqegiOaDI4Y7t7hMuvarUVp+GdHtI
         D6t9bO/RBN7+O3bWmdOtvS/GnKr441ficietAruGbfTVs4VDDUg3RQocYQfVBBopv7Hd
         L3dCsxx37Qcu5eXyUcJqvgQ6ABqz2Rppq7Klm8bmXPs5pOCkRs3iXl7gy4YuWm8TVY6W
         j6oJ92f3v6ZEjp2Tp7ezFL5caTXSa3zBUJKOBepmUysoKhSKXxLCkp86s3DRhTHveblx
         k/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775401949; x=1776006749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BANRRy4E4zRqxqgNimKW4aaAELzYPRotrVokPpoURw=;
        b=gEy8eLfzfeDKZJ6dVS8iZlC54BU62SVisI2bKj/wEcMouYlXAaGSUK9pDThfYsdvv5
         rxlSwD2RMwPjEnjWHuVcruJU4C8ACnM2usVodbBLWBu1SA4/OqVTLKf8c2NM95k55npt
         EYOJGn06s88bwdYOKz9a5pdb1kVFMp6bJbrP7+70r/sqyvK8YchZO2JMHB0/+Xxhw1dV
         fS+plXBA57t3BKcVz4dno1oJjEuiOFKVDJmMDliAPAU0ErJLPzxr+dz5+daFaPpdpibV
         VgM67qCMWcBV0PcdAJA/wxr50xjKni6dBMK2IB3UMWFR9PqF9uYvUsXlsrazR+bJ06So
         QiMw==
X-Forwarded-Encrypted: i=1; AJvYcCXXFfXaXdmHfIkAVlHG4PwjoN7nO5FRE3noawnvsUrCU4G7lqKtnsJ7xbs8tBGmD9DUEu3RUYM4oJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmriTy2Io3HBICv3Aed+rbnzNzOrXMds+otDC0SLL0kl9mt+wQ
	zZGsQ5ws72nB+veb5Za/Vc52D8/Om+lXU8SmYx7ZjngP29b8+4TcMiHS8b65PwdzWbA=
X-Gm-Gg: AeBDievWuf6StvoKKEvf6XMkQqiUMvo/TGU6K9yu/umQCD7QShTgXg8ZmO/6zwOF7Xa
	YW/Y0Dns0CVf/M+nU3kIBt/lvY51KGb3SBhuQdT8bOf+1YHfB1IAY/QRK9uYK7TLTfE3vnBT+3f
	Gy7HMKS3kbX16cd2GG8TvUNg3DrbVap7l3ZGYlw9laVE6FaTPYhobQRCVr85hnLIuQqAqdAfvmO
	LQkBi0VQq6ffTjfSnlExN85t9K2cTqxvM00gM/QP6MrH0R/nWUenhrHc4Bx5o3PzPRJdxNLFK5p
	1Thc4ft/Z+Cu1l5dov9zK4mBISs7kwTcxrdxPnLN9GvXntUDbRHCyn5LVPPe6+dqHVkAlmDKIN/
	JCfUgP2AK8HfvADjG6QnJcAwnZytNpnM2H4uJjYdwHpLyDK+D2NXcjQ1iRYETsWMJV0pkmxvLti
	XNZy/t5nRSabyn8wq5pmGycH5l30sZTeHGhGJuVHjYa/w8V83CzMd8sGNSftQ0RPFpJ7xlIJ8Jd
	g==
X-Received: by 2002:a05:6820:1686:b0:685:5300:f1ab with SMTP id 006d021491bc7-68553103d5dmr897234eaf.34.1775401949238;
        Sun, 05 Apr 2026 08:12:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e80f:4ea3:56f4:bada? ([2600:8803:e7e4:500:e80f:4ea3:56f4:bada])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb25a55asm9790995fac.10.2026.04.05.08.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 08:12:27 -0700 (PDT)
Message-ID: <bb46e400-4d1f-475e-bf36-7035554b453a@baylibre.com>
Date: Sun, 5 Apr 2026 10:12:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: cm3323: use dev_err_probe() in probe
 path
To: Aldo Conte <aldocontelk@gmail.com>, jic23@kernel.org
Cc: ktsai@capellamicro.com, nuno.sa@analog.com, andy@kernel.org,
 daniel.baluta@intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 me@brighamcampbell.com, linux-kernel-mentees@lists.linux.dev
References: <20260404205853.18559-1-aldocontelk@gmail.com>
 <20260404205853.18559-3-aldocontelk@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260404205853.18559-3-aldocontelk@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/26 3:58 PM, Aldo Conte wrote:
> Replace dev_err() calls with dev_err_probe() in cm3323_init() and
> cm3323_probe(). cm3323_init() is called by cm3323_probe(),  so using
> dev_err_probe() ensures that deferred probing is handled
> correctly and simplifies error paths.
> 
> Remove the redundant error message in cm3323_probe().
> 
> Tested on a Raspberry Pi 3B using i2c-stub. The driver probes
> successfully and successfully read integration_time after this change.
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---
> Changes in v2:
> - Add struct device *dev local variable to shorten dev_err_probe()
>   calls to one-liners (suggested by Andy Shevchenko)
>   
>  drivers/iio/light/cm3323.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 0fe61b8a7029..5b36fc265c6c 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -80,22 +80,19 @@ static int cm3323_init(struct iio_dev *indio_dev)
>  {
>  	int ret;
>  	struct cm3323_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
>  
>  	ret = i2c_smbus_read_word_data(data->client, CM3323_CMD_CONF);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_conf\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Error reading reg_conf\n");
>  
>  	/* enable sensor and set auto force mode */
>  	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
>  	data->reg_conf = ret;
>  
>  	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_conf\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Error writing reg_conf\n");
>  
>  	return 0;
>  }
> @@ -236,10 +233,9 @@ static int cm3323_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = cm3323_init(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "cm3323 chip init failed\n");
> +	if (ret < 0)
>  		return ret;
> -	}
> +
>  

checkpatch.pl should have warned about having to blank lines here
now. Prefer only one.

>  	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
>  	if (ret < 0)

