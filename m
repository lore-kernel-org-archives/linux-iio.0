Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B281724
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086709; cv=none; b=hG/B3TUpgjSTxnbJgq9ufl3rbVZ8I6vB4YrNArpgfR6sEBhkO9pFL9yPzwKdI8s5RJ0qjURXNKipj0srTlfnx0fVtZbuxnY02binqGMAQjECGynICRo5jQqrTJKrQPk7iP4zStetpJZVSMx5zPCLbyRZzVUDKpDDjER9hU60EU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086709; c=relaxed/simple;
	bh=3wLisE9N3ryCQYKierZz44zZcJUqejuAHNCQnCumPvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEo5KEoiFbHj7wngP4lqSwd2gYh6DBU1PoAMGfNL0HDxGzWajhPp3HvQymD9BS744AjYRTjzOCsWstAqV+nOh6s2hrctP6XgnWkjVMV1jpWUjDb65anVkDikZaGARFvl6/q0KKEzHQFFbmluyquFyS3LuSb3/jvHjplSI80CIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XnAqX1bA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XnAqX1bA"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463ba60966aso89272b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771086707; x=1771691507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJy+Z/rRGwPXFjLImK1xc39BIpSyCco5gJE0Pp8mGj8=;
        b=XnAqX1bAgvn8byCdESvR+3ddoC36xUD0XOWtX0A6I44bdpIf1XVJExgJLxTTysZad6
         BjH15LyfxOnV27QXi8j6HjKBTKgPgXdS7vsyr5YUh02mEQ039alAdQrYZ1KGuddHrkza
         yb2m8p6hjsfMusU+J61Q+t7gz8IBnSiJqzgdpDtZLip2YcT7GgMMqbUvtBDOePWtR/DL
         x5hQGCmhhcRE5ODPRa+zcDNF4zDtY6MkRQz+rDcAdFcj5DdJRSowaJ6wb80U2rK51SxU
         lJRL65+t+Lgp3GhSiO267Hv5culwsE1B/rQAafO193vGwDbti1T7knNrzd02GhvebpTa
         ya3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771086707; x=1771691507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJy+Z/rRGwPXFjLImK1xc39BIpSyCco5gJE0Pp8mGj8=;
        b=RO/t6BdZ4oukQJmBEpE6IEm+BegrkX3CzSlbIwZR7CtkVO5f312tlRVzFmKQx0xXtC
         xOd/jxOBHY40//+5ZvFILR0Imzzdig71QO0bgYeRoyJXl4QFm9BcYFiWSEZvKEPLfCKu
         VEstUIPNq+z6AIWDR0ftqwfZqsrc29p8tUJ3fYX9TkNsjyrnX+E5vqAi8RupwtnKBt+b
         IFudMH2odToiFrt+pxG4EM6OQu1c+tuyFCqpWFo2VJIUBTUt7JJdehNjHg0M6gmWj+aO
         +0G39qYiytHtI4GBdK8lr73CpWjxSfnnI+35i/Pk2xA7yT1OHTo4IhceuuURenSjUzvn
         c5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU/gKb7J27PP8YS+BSenAVL3fJu9exir+4GGKbVY6Z1ixLnpAqCCidshHt884hWzXP66sxSxWldHdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMa67lXZ1yKqmdQ2bA2psUefbJsZnvgFGyedCjaIPz+sb62ecv
	G4zELP6AM2sRQ0jQTHjIbKN9Z7bvZGBdwIIgRZnupCbV2w2Qrp5jjrRb2ixQIidz+QE=
X-Gm-Gg: AZuq6aJ9IEWhpsCr9y5gx2el8RI4OMFwYQkRFYvLzGEpDnB234JUkQlD0T+ZXrSNgbQ
	8Ay5q6kzmOuMuD4CHLdjPbJJKKzqr8pvsu7M9QapldAUmQIJztA23JkRMcUqL1RzWwyItJp/Baq
	QBe/clna7akRQeRQ2SsuHdJxsZu2R3gLRPW4eHtP2sdcStphUSUZ34PR0Q2HqgUq6thxbrO8/bL
	UTzvxgLfPqs+aF2L+fRrq0XscET62gWe5SLN89bx4NwqKTCX42I9vtVp8pdxz64b0m1XVe2yR+x
	aSehgpjqOLBW0ues4216wYSTrUclWOZtGU23t4lZkEdANgnk35+SbGByhXKkdVwjEolDCIj5zvv
	xL1LR7z5U2MeTiIyQJvyfUGgOh8tu6L5dsiYZ6JY8E7PpcsaxVWyPdkQGLsqenp1oLE79rJCIPO
	nyiZ92MHx83EwlOv46qbrU36o2fIW+soImkOXGhBRSPzh/GFcPHTpBnCYH8KzOcdTlkOGL6Q==
X-Received: by 2002:a05:6808:6411:b0:45e:d113:ed38 with SMTP id 5614622812f47-463b403b1b3mr1468474b6e.36.1771086707423;
        Sat, 14 Feb 2026 08:31:47 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:109:393c:254e:962e? ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463a4ede045sm2744429b6e.9.2026.02.14.08.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 08:31:45 -0800 (PST)
Message-ID: <f53438af-0177-4326-acc5-aa653046052b@baylibre.com>
Date: Sat, 14 Feb 2026 10:31:44 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] iio: magnetometer: bmc150_magn: minor formatting
 cleanup
To: Neel Bullywon <neelb2403@gmail.com>, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260210233945.40975-1-neelb2403@gmail.com>
 <20260210233945.40975-4-neelb2403@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260210233945.40975-4-neelb2403@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/26 5:39 PM, Neel Bullywon wrote:
> Improve initializer list style for bmc150_magn_samp_freq_table by
> moving the opening brace to its own line and grouping four entries
> per line with index comments.
> 
> Add spaces inside braces for initializer lists in the preset table
> for consistency.
> 
> Fix indentation of bmc150_magn_scan_masks array. No functional changes.
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index f254774d28e5..942c2f5e97e1 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -149,14 +149,10 @@ struct bmc150_magn_data {
>  static const struct {
>  	int freq;
>  	u8 reg_val;
> -} bmc150_magn_samp_freq_table[] = { {2, 0x01},
> -				    {6, 0x02},
> -				    {8, 0x03},
> -				    {10, 0x00},
> -				    {15, 0x04},
> -				    {20, 0x05},
> -				    {25, 0x06},
> -				    {30, 0x07} };
> +} bmc150_magn_samp_freq_table[] = {
> +	{ 2, 0x01 }, { 6, 0x02 }, { 8, 0x03 }, { 10, 0x00 },		/* 0 - 3 */
> +	{ 15, 0x04 }, { 20, 0x05 }, { 25, 0x06 }, { 30, 0x07 },	    /* 4 - 7 */
> +};
>  
Just an opinion: I think it is easier to see the patterns in
the numbers if we leave it as one struct per line. (Fixing
the indent and padding is still an improvement.)
