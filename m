Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764E3101B0
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184885; cv=none; b=Ye1R5CilYhlul6rnZzWuwP8+9ya0ORoQIh9RDpvjBG9JXcyxcCwmGynsXhmNHieboZzH4eesD7SsYsgocdY+r9XtkG4n2h+hV8FVPGvearniG9v6KAHcaOQZM8wkqcRXjqCl9TbXHHz5vXtZ/08vBOsqZ/IHsmAFpVBeak7Ki3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184885; c=relaxed/simple;
	bh=04fVH+Ybh/xOhNmHGiUOXfPQ1KtKmvbSXs3LJi9XWQU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7qEnYM/xWpX7kyb533dMDJfEAZ4pb2Ij7DKq552mmmb7bgi/gHcm16jdTor2xDWLt3XfMzUJqeYeIcD0Acy0qXvNdjXeT9Hmu1LR29v6RBrsYL+ihwkzP+lnahvZlGQyHCKlv/y3OxmgaPbqO2DF11EFUz1PHSwg9xwyLgkaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8sS4H2I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8sS4H2I"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso27475175e9.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 08:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769184882; x=1769789682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZZlt0wXGEeAJMNmrtm9rEmgb+VoKNl+2Pu9hilzxa8=;
        b=m8sS4H2IhkURVj7K4opc9WYKWxtHLGt7gxdtFfE2zOdBz9tEel7HgvKV18ekgN9cae
         zNLM767VvznXCdDiQfDOZiJ9ckLShSHeFM6psdkyyBT6Ezp2ziiLCjp8vwD1d+fzH6ux
         yMh2qd8et6Eyyk6L5b67JFD4ULBh5nu9bV2C8sI7FqO4Z3U2E2GikkGa1QAvQKxswpFN
         KKuG2TnwAZZKxOtrqLVuUMXKAMAOtdc0CYcSe5n0zP0RH54telVzIZds/5p/Pw0o9Zp0
         feRrctfNp3aR93/FLOUqAxLgcKshUgB7zsOhjn0vq+MPtvUPlWsGRtOkMbkB3fUMV9N1
         +pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769184882; x=1769789682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZZlt0wXGEeAJMNmrtm9rEmgb+VoKNl+2Pu9hilzxa8=;
        b=JYdwB+4Z9TgZ9F6fY1nGNYJbBH9vGxmOOTJMCaaU53F3WsFEbjOacF9UXH3n2HH2gI
         DHs0WPqrA6F35C99vfWCsmRzzF42DTJ7gI2qW7shsZzdlwIMIm1A3zGmKfxwYGrsuy8F
         aXXwUiZdRkXQh37dp7+KBdEZCXKPKkNOv/E5Tkl9OJOERd+YBfEmPsMGWU04QLP/J2OO
         s58nIe2StWrgixph3L1EswWo8jd5BEBXeQCFrN06g1Xf3vOEKopCBV8zBKppNfvI3hJF
         ogmCHvZv8NiLlZr0Ndyr1Albjy9p6NO6QXT7L39t7130FM7GdNU7ZKhF6Gvkbd66YM5s
         YidQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyc5ylVNR7pSgVN45H2svKF0KImKAgJK5ucFP/hWShp1Ro4GXii8ahZKqYolM4XTVDCamXSWDB8q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0NjVGOuSAKIU6buUScEjWJyIn3kQjFCPgzIkvL0H30GAUoneC
	KQcbJtTIF0VazwyKkxN7VKF6K/+BbRIo9edpCPoTKNzBdI376nUGyufE
X-Gm-Gg: AZuq6aIHOyWncxwoe4UC1swdYZo7CijcrqRLDUQVhL+XBglWvkq6ZiN4KhuY7MuNnRS
	5kexJPGxlC8m4x3Kh5bg7LwfIbB0/RlNSQz269o8VQ/BbybLiMu2li9L/3QyakLRLlylpFwcu2A
	+Z9bGqJdcPW+IMKN5M12uw916osXecebq1rg0K1pzZTqWKa6l/Pg325o/xDzwutaVrit68qZrwA
	8qKXQkEi6llCg+3xTZdjIwPEZ7o/dQkwXeCn9d4yJ5o0vdZ0U725IakUNOm9zRPinA+1lW0DlRm
	WbHThUnSURKTlFL5R0ef6R+MIyPntC5zBT3D+ORBDG2Nsqu8sHnpRxiR3I9eebHbAS9tvkpklAc
	pQe+iOLe/NKVDN6fQ0oiTAX7SoYPLXpdICCoFvm5VPJmm2LRHmYpM7n9Z48VLuCa6H0HnEeVcw0
	6oRlNZcNAEBvepbZ2+RRXiH2QWD8+ZXLjz40C6A9yOEiHU7xSV/W70s2JUTcmDTIit0GqNG8EAo
	UYZ
X-Received: by 2002:a05:600c:8b6e:b0:480:462e:d640 with SMTP id 5b1f17b1804b1-4804c9cfef1mr59266115e9.36.1769184881426;
        Fri, 23 Jan 2026 08:14:41 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbe1fb8sm24330765e9.20.2026.01.23.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:14:40 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 23 Jan 2026 16:14:33 +0000
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <3rtccxcqpxkwq54jjbl7l6rq3xm3ibsnlh5s7hiymo4okir7dg@ky43houswpjg>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>

On 26/01/23 03:53PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> to parse numbers from a string.
> A helper function __iio_str_to_fixpoint64() replaces
> __iio_str_to_fixpoint() implementation, extending its usage for
> 64-bit fixed-point parsing.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

...
> +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> +				   s64 *integer, s64 *fract, bool scale_db)
> +{
> +	u64 i = 0, f = 0;
> +	char *end;
> +	int digit_count, precision = ffs(fract_mult);

I've just noted that I should have used ffs64() here. 

kind regards,

Rodrigo Alencar
