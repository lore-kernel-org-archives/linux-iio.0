Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539B4AA1F3
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051882; cv=none; b=CH1iSp2fbMqzV1jKnkExO3hgPpC6uf2Cy8bd5hspXEEd+96aias7oSCmxlsVKRpUKkxahrwpwBOdGX+y9xBZfWnHq+cQ3frhAeFfRuwnAfJui+QM6nKWJAkLhFsxgz2Ijg0USm21PU9jROlGHDXntHreekSmvMCVHNDt8zbsLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051882; c=relaxed/simple;
	bh=qs5S8QPTPOrh1lF7eV5s6cjsPd+SeVHGUW9kmsUQVWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHMcKZghzjKye1WhAe9nnGzjHtb3dtEGVrIvYYpw2173G4Inr3MYYBZPpLj8z2D6QLH9nr6szdsOFT3QNK1E2Um16oOcNwdcwrHu/GUUxEoavInMHOzgFsZ4rQXKtVdTT9It6M0thsPE4g5fJntPV48u0NwfPR2ViiuLi9VnNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5kRYIpZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5kRYIpZ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so44531035e9.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792051879; x=1792656679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/jkRp80+cF/FczhU2bxYxtjRt93BJyvM0wCmsP66FY=;
        b=E5kRYIpZhoFW7HyNjFot/gehXvjfaaTLqO7BNSTODqYrE2P7u/asW7Z2l4Ub322RUE
         M7RNJyXOug9N75xBpFrmn8oGGntTyIQgO+QPBjOzofbJxpL7/LokTMViCMTtd5u3fts7
         rsrpit+LZiH1qnJ8UtF1il6eOb7X6mJIIdyQx6LhdhAu2J6Ov6rtzu73SUpwLqj7uRYH
         D3zTAgXMz4RnEGCN/j8UuIebpSG/ai/QGMBS8N5lrZePbAoAk/+9Hc0JrolxuYUZyg4l
         TooVkLKTP2nhtVPWp/7Q7JBSlHpSdTzEN3QdYC5HWB7w9j9GG1NnhoYCUEAwW860E6LD
         U53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792051879; x=1792656679;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/jkRp80+cF/FczhU2bxYxtjRt93BJyvM0wCmsP66FY=;
        b=mOnWwVUFcZ2akA0Dp3rX0zMB82wNP2i8ouxcIN2QPy18yckvtMR1dP82inSTsu1dVR
         bRRWNFDToZq6+p83gRvGhrqD/TXkJQAZQrBd19upLV3lLzr0jRaQo9reIjF9q7vQLhfY
         YdSgqi/hpHi2vOjKDQGZJ/Pct46GLEFhd35BtiY+hHfPSKBP31xeAJT8fo/gx2zd0L6u
         iypY4ddzgyGafYYxGrMV+K5IxanFtsqO0vumsWXYVkOJCaGdPTMMBAXgfLtarGbsw0Mk
         dkH3LMoKmuI4nmm2z28i9UWUUsQGImxQqAetLcfmQnGMaSKG5FufwcoagKXawFVZLX43
         +LZA==
X-Gm-Message-State: AFq9FYIsv7G9Ypw4OgajW95fgl9Fre5ZHMHk9Km9aiw77WFltkUxLSn5
	QmIFIJXYfgY8RJldc+Id8fP4sKVm6SIGagNTS2cyt+mOoQYZrFJUe6Si
X-Gm-Gg: AYBFou0LRNY6jT41YV0J4O9XDsAB/1nx8p/Ajpm63JBQpxt7kc11FOL4UJ5Ep1ZXtPC
	7I+NySWqNVIEm/dIOeO3xWsUWwTh0mOKe8Ub0mtaNp42QVlYPLf6Mb/s+Vxgypn798ur6GWsJHf
	uu4yFx69lup3H1L+Ucntwh5HLtvVW9YaAKMmIxJV+uiUHeMLomplq8IgDLErefSY8kHnBcRUu5Y
	J+OMMyJvzK+2scE3kLjWnJ2315SHDmbbQLNH/AGqH1pNm5PMFiHW7VFe5hRPo1x79ypbPt1DtpP
	GQkB8keTb6W0kOChhhIGOZzyxub61+PnHl1zgHeVUttUqzGmjXQFp8xUlhGSUZcasxigrpj2QVJ
	YzlpMtJKoayG6BHhmBh4HhzSaKnYs2scJTStARAqV5cXPtBneIugOeVFvCCb0lMOFGm24sW7obe
	dQwvigWzue8qW8p/UJ7qvFXcXMsSh0nqbH11Frbj+em7F2kMc1N1rJ8FcNezonY0Avz1FJCJWUC
	ydCrkR0p5dcBVTMpaSn0O+NDNiWDdDlQouWluKOSPzzmVhkhHJAblwpWLKEXwzQ5FQOfRyXfrYC
	eJ2MnwMjdlPSFQ7ydek4IFtrkgsl0ko1oNx7sm8ULQmhT6D4L/qSJTVQQ6Qz0lAp/vazBGUf+cd
	4mppi6fsjOxuAM6PKRBBMmSoexIdfJleY269ZY/RYmzUm8hsYuHktb+sj20anJAFAoGx6zeZ0oT
	NcnOIuKMRVht2ale8=
X-Received: by 2002:a05:600c:6994:b0:49c:dada:30b7 with SMTP id 5b1f17b1804b1-4a18e446f3bmr362793635e9.2.1792051878885;
        Thu, 15 Oct 2026 01:11:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd69b2a2sm22018415e9.4.2026.10.15.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:11:18 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:10:12 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH v4 0/2] Add support for Analog Devices MAX30210
Message-ID: <20261015101012.00006cc8@gmail.com>
In-Reply-To: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
References: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 09:21:57 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> This series adds support for the Analog Devices MAX30210 I2C
> temperature sensor.
> 
> The device provides a 16-bit temperature output and includes
> features such as a hardware FIFO, programmable sampling rate,
> threshold alarms, and interrupt support. These capabilities map
> naturally to the IIO subsystem, particularly the buffered interface
> and event framework -- hwmon has no equivalent buffered-capture
> framework, and its alarm attributes are polled rather than
> interrupt-driven, so there is no path to supporting the FIFO or the
> autonomous threshold comparators there.
> 
> Although the MAX30210 belongs to the same device family as the
> MAX30208, it is implemented as a separate driver. The MAX30210 has
> a significantly different feature set, including a 64-sample hardware
> FIFO with configurable watermark interrupts, programmable sampling
> rates, and event support. These features require buffered operation
> and IRQ-driven data handling which are not present in the MAX30208
> driver (which talks to the device directly via i2c_smbus_*() calls
> with no regmap, and has no IIO buffer or event interface at all).
> 
> In addition, the MAX30210 uses a different register map and a more
> flexible I2C address selection scheme. Supporting both devices in a
> single driver would introduce substantial conditional logic, so a
> separate driver keeps the implementation simpler and easier to
> maintain.
> 
> Patch 1 adds the devicetree binding.
> Patch 2 adds the IIO driver implementation.

Please send a link to the datasheet next time, it saves time and at
least we know which version to base reviews on.

I believe Andy also asked to to add a Datasheet tag to the commits.

Q to others: should we try to make the Datasheet tag official?

-- 
Kind regards,
Joshua Crofts
