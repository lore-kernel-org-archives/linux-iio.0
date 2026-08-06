Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8E3AA1BA
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980235; cv=none; b=a3xYdUMa8pulU/5dM7QpbX5BZ7FLY0pdGf7Dq18zkndhUMfHrhRVA63lFZ8nR4Ev1gD1w0op4eqqOiJxGq4BvWyP47kYmceTvTk5FCpCuVLn7A6G/H6Ll5UtFxBOHrX/oo4xVx02DsYhPjIxv2o2qHHqGpHEytSPV6X3QDA83sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980235; c=relaxed/simple;
	bh=2bPmce2VvElbr9s+Y3BqN8NxKw7USlulDA+SOx5EnbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2Q5HVORFw22HgikwePLr3euYwaNOpWcyywgGVxqP5L5rn5rnQbcjwc8hHyYVtJMyWjfcIsp2GIelqXLEk6bKOpouSGRX73owk4BARyTJy9j0lZ8LPZV2CnhPX9TQKitv2iu4HfFmiCt5GivuiuiRtqnQfhAE1p3ss/XXzB3O5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgrTgYEh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgrTgYEh"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ee6b2da98so24575457b3.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785980233; x=1786585033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YwMB0g/fJOrIyIUhv0tBgJ3DoHlp79+JSCvFcZYypKo=;
        b=JgrTgYEhu/tSD1i0P6r5jyW3VFpoC13WfzSgI31h3zd2sBzY711gFbvDFZV9fxhWBX
         7K/zIXDGgR+6tr2I+8t67vcZrFUGpbLGpL2PkaRZp9qmLiHt6kmIegYEVayFRKd09Mup
         aImw5SQOfqgjUuUcZhp+F2dq0YFYg0m3ZnYNRHQwE1anyK7CpVn8WGqLNJHSlPNdSnPm
         YmcJwn97P1OR6aaTHNqzA+gNCc88gYPpqtJDCJfQRtyargYF/lf5dPYq/NT3YZDxlnwr
         02aqN8XFpG7E24kXoC6fmXNR4T6nVCPOalYWNt1OZ+1cXNBjrZI8MmRKx7h1/+SGyz2N
         wd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785980233; x=1786585033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YwMB0g/fJOrIyIUhv0tBgJ3DoHlp79+JSCvFcZYypKo=;
        b=Oh5jY231SsKUJzOp5F8QmXprurLDIfQd9XA4oiVcZsvKDy/5J6G9v69DDLkzlnX6Ij
         zr/08dFEeamPWdKkMjWPAi/RA9zJt3Mrl0LLk8wZsjYGRXYHX2itE3seYCoQf8wLNodS
         Zsxqj4S191+dOcOLWMCbjNhwcnJ0lX5Yq3q5nBFxDMehauLAItZy9C+Y9y621BDQMFKj
         A2s0CCA1XnklHKcYOHnlmC/T2wW0YJYTkPVKRGg3DYQQ12Yo459nYOAKAtn3SfzrdW3X
         wq9LAhioTfMJp9Fp2k5pBtGKzkuGdv6dPnf+TiFgHOVkyHBjM6ylBrielQ6ORTwfW1Z2
         634Q==
X-Forwarded-Encrypted: i=1; AHgh+RojFTHAd/3rTfjcz2aKCMBpV11DX+b7QVakQJ7XnTV3/yIDVI2ZQ9etGaUDdVDDwlfefoIps8LZnSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhTk8gKC0W04k52FYeoLLoCg9/wW23WNMLhpvrLKIf0bE/bJZ
	FBnb6b/MXDKkmMsFIzUdEfTWp0RF7Q0L8Eh5mICPTlPxvdq9ex3Om1cnK+1EuHr9
X-Gm-Gg: AR+sD111rrYfW7yf2eWzalcaFp2aRnFf1fi3dwG90aHpdHRnHk0fvZUh+MGsZf1FleB
	sLhv0xKjllm2h6iw4Tfj2jBkgoMGvjF3410jziWzzR7kV7SkONmcnGG9bxzbT/+FhfF/krDFCc9
	1JmwQP5vY+cQ2h3LQX2PC5vHDQzpVX3v+qPu6eWvJvt+KdL/Wx2kUzhpT9kJnjfe+Q/3hMibKTU
	RjSMDgBS05XHFA6DCnpk4Qbzq5eI7E9bs4KvJ+2ytaOBimX5eeNaxH/5rtgsrYvbocCJpylYDuA
	cBH1259iKGmHguMYL3T6BTKa0sAyAGtj41Ii/r/HStMDm5whYVJ0hcD+1E9rK762UnR32Y3XGYI
	++33UL0G89Kxla6d/d/LxTrFpHaGGSoPtwQKGfWc4hnMLWDJV5wc3u/9mKfHsF/l3EdrxY6DVgL
	wScAMG4/DGj6UremF68zqgMUd6GldbZN9LaStkU3UGc6H2mLcDsJCI+5FJY0p2K4BnI2hefSxix
	rNBlZk=
X-Received: by 2002:a05:690c:6212:b0:81f:64cf:2c58 with SMTP id 00721157ae682-8201bccf8ddmr66971477b3.6.1785980233193;
        Wed, 05 Aug 2026 18:37:13 -0700 (PDT)
Received: from localhost ([2804:30c:166c:b00:15f4:95ba:67e9:7ce8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82013261c83sm30848417b3.18.2026.08.05.18.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:37:11 -0700 (PDT)
Date: Wed, 5 Aug 2026 22:37:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: =?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: am2315: add am2320 to i2c_device_id table
Message-ID: <anPlaMvCo5aPmIut@debian-BULLSEYE-live-builder-AMD64>
References: <20260805183733.1000550-1-nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805183733.1000550-1-nico.antinori.7@gmail.com>

Hello,

On 08/05, Nicolás Antinori wrote:
> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
> 
> Add the "am2320" entry to the i2c_device_id table.
> 
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---


> Tested with Raspberry Pi 3b+
> 
> Used as reference AM2315 Datasheet [1] and AM2320 datasheet [2]
> 
The two designs are pretty much the same. Skimmed through the data sheets and
spotted no relevant divergence among them. The sensor external casing/appearance
seems to be the main difference.

Few changes, new device supported. Nice patch.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
