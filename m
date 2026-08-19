Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C972630
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171537; cv=none; b=lNDrOxFmYflBW/Jl/JMBR0gtdNGqJPOGX+HDC4jU/zPkQP9C673CC8C3fwafbCZynezBc5gDwNgEwQ6E5/b8ubwzxl21tr/jL8pJg4S8Fy6BhSBg1egALwmQYqIQZ4UARcf4uxC9J/G5esxN44O211WGVd1eIlkpkYjFC5LqCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171537; c=relaxed/simple;
	bh=sR917INAPqiRWTwUavwb9f+zXWLqhKiK8ywqX9IbxYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyi8ghEQ0IInQL7JZw3cjmuRV9z3slPQ2Q7rtgsL+zUgjnEKBH67q3c5wrky9qXlY9nwEwZqvkEsNRTJf/eYMPMoZ8gd1bHFQZkATUZGZHqsywZnEgeAh5FIF174/Uk6UWG6MF5uhu/DHMFso+YPd+WNnJUDkSXO4SChL4ZQsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp1RrccS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp1RrccS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1617266a91.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787171535; x=1787776335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kakQd7SwwB4qJFxzAT3GLQtskQ627s0NDgwkRoO1YnU=;
        b=Wp1RrccSlW1X9+Uaa1CnjB3s3pmxp7EniiOiDc+oDMhRJ6u8Tk5F2zuqktrdtcNhzV
         M05YvG3dnqFyPg8Rrs85KXdVDVM8jnXUco8dRrKVhfDahOSRUuchMInR2YiYfFBVTH/p
         Nkxc2Q+cXV77WyL93cqYvy7OUjulbrY045zyjER18oCu282KE8BG2txIAJy+WhBCE4Tl
         nG2fQ8j3JZtIuOuXSTuqmUY180bhQo3EjyFgCfoA/jz020Im456ZWaDGgqg5bWRLkDwr
         mWyickHWeugP70D72A+1XE/fWH8wF4tdxOEiJ22QUA+D+iUkpJxnqHy9PRAxvzpPnGR3
         TuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171535; x=1787776335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kakQd7SwwB4qJFxzAT3GLQtskQ627s0NDgwkRoO1YnU=;
        b=gk2A9JvGun3o9DiHsoX6cXbGZAzKknaBzg13zIWPpMOWdI3Gt+onztK6BrwArY6bHl
         c75OYKVnsHx+DClXRZPntL9h1PxrZ7aIvc5w7lOMGg8pdYz8jLu8Kdq92hYNEzBlbOJc
         hNNdGpqnRfl+v5Bi+Xuo8w8K03dAmIP82NUQR52Bue6V5crASBVk5tI8I06kPHYzYmJh
         88ZQbjPf3q2g4EMnsoRWmuXxZkKNowRzJqdIQlDjkom2/84J1Tubb4hQ57f1Gcz7Zi2c
         MJbK3Rm/PQlK4XBXvsql2IGf3Jrlm4lwWdAbNQ9A8iVR0LHij4/M9nsTSoCJD7vS0adm
         RMdw==
X-Forwarded-Encrypted: i=1; AHgh+RogsqViZLzUI0zLb/FHYPbKoCILarFTpeabmeZL6c6qnBSCcceT2w1ygOVrqqNFtjOWv8R0ynAL7AY=@vger.kernel.org
X-Gm-Message-State: AFuF++mP2fwEyQqs18nWVRfeNRYyfNmozu38nYfXroBiBirybgSLjixE
	3/1Ucq6VxaffMPE5G/45JRew0C6a3QfO9ah8sTX+d5HrGEcFiKwEqmDp
X-Gm-Gg: AR+sD100aSaP6yiVxllDDdrgBxfS8tL6t2G42vM1c34+zATJMQkJiX2lDoAxkncwlJs
	/7E8Is3gxChEar7mTXWwUsUhAzBLBw8n5SUkgjnVG9HzoF2A2r+3NSujxFY2ojEaM6iS3Q0aEg7
	TSEDxJ/3T9zlEAKrsijYZXdpkztiH9hiaBFcQCanxAp1qkqAS9Wzd5jfyKuoAxx+YhxCmWOendf
	23Po1ZG4b0Omb2+/TNn9XD9SyyJD76hIbY5gYp+3u/RygB7StQ13yEuMQ+9WWAINwhsNmD+erK5
	OSfGPL9kLTp8wFpu0Z4SXMo8gAc34njI+DUK7msz1aprHjw/ek6ZG8hSqzBN8o1qCSQA/3zaRdT
	FaxN5yGmf3oyZ1Gx3XBFzOG725/57SqmMJkC2Vaf624Exhf3p7Zx6KVCKniv3Efi4lJwkEdaUWt
	ojwhycAbvBYS7dOREiMj6oPUbs+YuMjI5cnWCOGGwv2k1GswiEOuRZvuLbomO6mnbLghBQAzgd2
	Q==
X-Received: by 2002:a17:90b:4a8d:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39580553dfamr13842543a91.0.1787171535016;
        Wed, 19 Aug 2026 13:32:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad6060asm16706081c88.6.2026.08.19.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:32:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 19 Aug 2026 13:32:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 3/5] hwmon: (ltc4282) Make sure clk_init_data is
 fully initialized
Message-ID: <0ee768d3-f913-4d29-902b-39f8bf973dd6@roeck-us.net>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <8ec3c5cbd2df675a938f090470f5da5f22008517.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec3c5cbd2df675a938f090470f5da5f22008517.1787165329.git.geert+renesas@glider.be>

On Wed, Aug 19, 2026 at 09:05:17PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> ltc428_clk_provider_setup() does not fill in any parent clocks, and
> assumes that init.num_parents is NULL.  However, the latter in
> uninitialized, and thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: cbc29538dbf7d740 ("hwmon: Add driver for LTC4282")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.

Thanks,
Guenter

> ---
> Compile-tested only.
> ---
>  drivers/hwmon/ltc4282.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ltc4282.c b/drivers/hwmon/ltc4282.c
> index b1675dc5b3c7fd2f..54ba4b8542e94b7b 100644
> --- a/drivers/hwmon/ltc4282.c
> +++ b/drivers/hwmon/ltc4282.c
> @@ -1106,7 +1106,7 @@ static const struct clk_ops ltc4282_ops = {
>  static int ltc428_clk_provider_setup(struct ltc4282_state *st,
>  				     struct device *dev)
>  {
> -	struct clk_init_data init;
> +	struct clk_init_data init = {};
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_COMMON_CLK))
