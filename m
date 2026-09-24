Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0B3DC4CC
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244722; cv=none; b=tnJYrN8u9M32R7i8xfX81m/U/eWhVOU5u51ZD90HCmHTWiRwmtuiYEoMhTV6NEOSR+8jvvoV1RqfWMrrnhsLhHiimTrwXDP/xrlGRMnplX5mSf5d5X0wmgs8sQSvPaMboQ3x8ZOCbVrwaEzC8gdRmV2jmpXAMAL3SIL7hJsqLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244722; c=relaxed/simple;
	bh=okQkGFFiFGo2+bcfn/1mnbfxo9xuP8mMhLAma4LpIno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhiCFshuIasHNIJRgpl+At4utthvSR9ngtZ8Yfuw0s+ndCpMPhDesOULqAK8icYYUZ2D/uGvoC1TUlXVNmVJM+op6kdOaUEkiEQkVcewSly/jvdnx6w4a0sDXaDB5xwNklIJx4l6tf1BvRD6SvqrrYKlhci9xIlgeaj+SVW27i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mdN7Laig; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mdN7Laig"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so14381475e9.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790244710; x=1790849510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56SKaqZ0iXHf7acYt1UYQ55V03EGjf3BULjEnLjAl04=;
        b=mdN7LaigXaw5w13N0yHVuCvHSzJnd+TjSfxsrLqs5RfSfchnjpK+sKgieoS6SfLqcI
         cOrvh3RbFYJr7yp8EimDiDkGCPXvhnWiT7OSWe0qIeEbTzWexhziPBPtkcHU3e8Rb5+O
         /tlgILY1cCkR/oTb5Fer+MSi1wa3okdP3WxqUTKgg/gOOBLm5TK4nNdOcKXAB65ch5aP
         GGd9TchcnOhFzrRZQZogsnVKBuglVx2Uait8cdhIkUNXjuu0h3l7HEhI5o8D2DOPKK1F
         R7GWs7X/Dn/npBTUfkgOdXlC5rYhpGtLDfEkL8QyoHHIDRBSu/wiSymMPca5nUy5lvjw
         xPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244710; x=1790849510;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56SKaqZ0iXHf7acYt1UYQ55V03EGjf3BULjEnLjAl04=;
        b=g7WNr22N9mcDWBKHESFiPQTMrlgNWhQ1NRC04e3sjhpMzeoEAFrTMBVkkB7zWIhebJ
         fzujSmMa0xGBGY7QjreB7swQ5tHrQ6xLBveyydQyQigbwWQv+l6QXVDSLehsBIKr6gNM
         6DViVdWH1NwwfwtIHl3/jm0GDpegRgA6/F750W7WJDwIQb0GU2Ma2P4+VnWDAHkuQv9q
         G8y8mUmC5hcqA1CppXrHWqkRdsOoMhQre4F60Vlvf7raLq0TT4b6wTMYWMm762VGXEKp
         mlIBQtDWF0lqbqzSLh1icY+4jSiHfWOSz7lkuDraB81VrYhDKla0+6Owo86wfE1+70sT
         /iPg==
X-Forwarded-Encrypted: i=1; AKwUvBzlCAhPbbakTsv3nu/yMaJv1tcPhroKxouuwo6vmQTgGTf+fni+EUmlxT6LExV4NYoWFs73dWxKfXA=@vger.kernel.org
X-Gm-Message-State: AFuF++lfP8zFjxpHdC9s04q2Cqx2W046M1Pz3rt7Zq1b6V/UzQ6sfWXd
	SNhsPkQT+ZxKc666umfrpDLKW2DZyCx4c2jGz45oD4UO7KJfuVxDCnqqIBREEqY+TSY=
X-Gm-Gg: AYBFou2vlU4X6KcVn4fl+VTVEf/ZopQpnn0QTM7Pcc7pnvJjGglC1+NNOvNpZ6LWTiR
	cZJYQkubo4qWvtjGYlY1w4ea6XlPbLCJToes8+1CswmzbsopAokDI8bAqetgXCj7RT8F0TrmF3z
	066r4hb33xrH8lkpGDCJSwrcP2r+Fs8YNxh52XOPNOT/DJWnoc9CIiNWC7tx5SP7iPqvduJ7bBL
	Rlp0D3e5wD3G3/2bhbRJAcZqIxNyorgwqNOCb3e97Us7zlVWtt+QoQOeQOoncvRtiyo8onGJa6Q
	nqQHugZtyqHXI7SVA9rfGuNMlKOYUTqVX7CINJfBzZgi9o56vsfHKtXS0xvm7Va1Kri17XG+ojt
	AdLWaZ0Nlzpx2v622BezEY3G8M7eW67NFPuzIWpbh2gDkzLaL+fjjDo6nKSbC6XjKN7UX0XkK/S
	e558/bx89Bx20jFftuVODYxWr4CwNMjj7vvbdtXM9XUnEVByEHRjwJST9HhSvNlygzcfyx+WonH
	3SJjTj029SSZQvFNizXP3C7E3/R098S7BbDR4eKef4Ub5ZUNS4fznr4a7aimdqdJYEeGo0aVusN
	u0w/AjwGG6zj+aq1OhUFUKTNfQhPU2c=
X-Received: by 2002:a05:600c:6090:b0:49e:6e94:7cae with SMTP id 5b1f17b1804b1-49fe670424cmr28420905e9.28.1790244709782;
        Thu, 24 Sep 2026 03:11:49 -0700 (PDT)
Received: from ?IPV6:2a02:842a:161:af01:6a31:4b53:f1b7:80e9? (2a02-842a-0161-af01-6a31-4b53-f1b7-80e9.rev.sfr.net. [2a02:842a:161:af01:6a31:4b53:f1b7:80e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5e07bdcsm50921975e9.15.2026.09.24.03.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 03:11:49 -0700 (PDT)
Message-ID: <f5314ab6-e29e-4f92-8006-3679b1b28f5c@baylibre.com>
Date: Thu, 24 Sep 2026 12:11:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ti-ecap-capture: use regmap_assign_bits() for
 conditional set/clear
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 William Breathitt Gray <wbg@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
References: <20260924083448.461792-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20260924083448.461792-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 10:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
> the simpler regmap_assign_bits() call.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/counter/ti-ecap-capture.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
> index d77a256f0ed31..1b79031544646 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -254,10 +254,8 @@ static int ecap_cnt_pol_write(struct counter_device *counter,
>   	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
>   
>   	pm_runtime_get_sync(counter->parent);
> -	if (pol == COUNTER_SIGNAL_POLARITY_NEGATIVE)
> -		regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
> -	else
> -		regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
> +	regmap_assign_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx),
> +			   pol == COUNTER_SIGNAL_POLARITY_NEGATIVE);
>   	pm_runtime_put_sync(counter->parent);
>   
>   	return 0;

Acked-by: Julien Panis <jpanis@baylibre.com>

