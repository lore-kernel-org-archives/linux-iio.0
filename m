Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB7346ADC
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102162; cv=none; b=WFDk4lufE0dUjiOHgysh9jyh2H3ubDjvhO8SC5CDCv15edDia5gbsgboNqGlNpZUV6vFKZH++gto/oUh6Rdzozj1ytxSVzrjhaOtpd/forWHO4ZoZMBGaZG+bJLtJHI7GjKpKg+mCO1aFZrm/PPt/YoO36ykoFP2Wl0lJRPet6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102162; c=relaxed/simple;
	bh=8b5Cu/WzFELCN7I99cyIzKY4tM/BIzLp/hfo1qCjLvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFf/9QjjFDyZMbV89TihrpnQ8sW2i0Hsoi926WAnbBTrlfY9c4F5ocdSqjDbDk3ypiXXu8EoRBYp5A2bOhNPXHX4tHREjRdJSb789bPPT/SCqgFp81ClEBXtV9lkepek5vkrDNvHlHhzpfIaS0iLoYaAK1c4nVA6ZggHjEhDf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCWzWu54; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCWzWu54"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbedf433a99so2881470a12.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788102161; x=1788706961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4YMamzAVSqXj8/xPRdP9NGRtFgjUVXMOQM5Ll4+vfHg=;
        b=TCWzWu54thRUsTOA0kgj/XnMst9KtjAFE7JjcnqLIRcgcXbSIdC7MynZYvLMDRCdp3
         yQ23gZr1Nd/pJZfBDLOja8A3jtPxDFmwmAAuE+oN7lhdApXPNzsCJ1/qjhaRPeZjhm8q
         TVV+n2Z3KMjBXjapwFRiBbOUg32UlMTTD+3rDj6yz4bykW+9DFm6FtoTOJBLeK4tJh++
         JC1//hEIThLY6LAfTHTFNygzFV/UobPBLXPFku7/0hlsqiArFx2NRhZ1GwQr8GLV/rND
         LoRnpY16gdo1H51YJZj03mF5qEslyFb/Ya+H+y2HaFghAEqBRpnwOK4zYMGQ5scdr8/C
         iKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788102161; x=1788706961;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YMamzAVSqXj8/xPRdP9NGRtFgjUVXMOQM5Ll4+vfHg=;
        b=FztDqB7+VJv6vVLRaoMkwxuuhUbgWvXJo9tzo3/QjF/G9tWEUembBnCmzpsZLIEEZf
         js7PaajJwV8zKu+Kn1V+/SFDwy43heHkbrtSvk+3QMttjlGWINwnGAsMXlpwJIwT9zKE
         hBnOsnK38+c+t8vtSEMLDd9OTtPPzyCPZ0l7xl3hVUkeD9+kFf4g3XCSsfwI/9K9ZQG3
         CMbsCK26Jr8mlMYfv6Nxa3wlX37FnTQef9TkZcOhyH7Q7787LWn1kinm6c9nJXvS3LCM
         cH0ZVv66Po7Br0qanPqAl+e9DEKJZhrj8GlnDcQUGGu7G2tpqhIGgTajcDyzuZHNyvkn
         5huw==
X-Forwarded-Encrypted: i=1; AHgh+Ron/DObwUl1PzjUrhStTmUObHohfpIk5zQt2RmgnyW2c+Pl0PXpbxd8mbkpcXlH48OmcO8Vahb3U3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kDME4NrKhv57FzpK3zXYVO2WgLptPwQpcG5PHCdqm2wZfQf3Od
	6LW0V5tGAOGDmnJQPitP8Ez3ho0HedbVrJ80v1whGwsn38ugTcp+BXcV
X-Gm-Gg: AR+sD116oWCfGOrhJovpFnoWOqg8DUSmxl+9oK18rRfcpTTyYixBHrRVV9FXeBxXT5J
	U3K50DeFDj7mAsw2dftS/C4DIdaRsv/t9b8pZn8b9TgWd0uLFOej6Rhs961IqiQtW/3v0TaFF4Z
	FX76dMwkSMa3fJjvJj8m9GwhQm1qBfjWtWlsQZ4EIBghfxl9uAYd5g+phYBmG4LcSkywb+/nKvb
	90rKE38ExFl5yD6iaCljz+ned9Fr2vAllj3T4XhJDQvhIBDnI7BchmypA8yKz6yjKS4p9Z/gxVR
	8Hta0vbNiDPfvw1jQdViz+Tn9sm1ZPFTupXCgY+uLeE+r6UYggIzepdCsEuu3xkZjDKrfw9FXio
	YJ+D2jxQAbUELy82wwoIeOglyJ/1JmfsuBbupplnvoAsax5izqwk9XehwnXrGX+iknOSnLbcUa+
	milbuZwnYdW7IDshWFC6D1hteWvtZJZW5ZjlHnoTdE9W3Lghy5CK0zmE52PwwPqh+KBvoq
X-Received: by 2002:a05:6a21:496:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3d2672043dfmr35677104637.12.1788102160582;
        Sun, 30 Aug 2026 08:02:40 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm31939929c88.4.2026.08.30.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 08:02:39 -0700 (PDT)
Date: Sun, 30 Aug 2026 12:03:29 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
Message-ID: <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
 <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
 <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net>

On 08/28, Jorijn van der Graaf wrote:
> On Fri, Aug 28, 2026 at 01:18:18AM -0300, Marcelo Schmitt wrote:
> > > @@ -417,10 +459,10 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
> > >  		mutex_unlock(&data->lock);
> > >  		return IIO_VAL_INT;
> > >  	case IIO_CHAN_INFO_INT_TIME:
> > > -		if (chan->type == IIO_LIGHT)
> > > -			ret = regmap_field_read(data->reg_als_it, &index);
> > > -		else
> > > +		if (chan->type == IIO_PROXIMITY)
> > >  			ret = regmap_field_read(data->reg_ps_it, &index);
> > > +		else
> > > +			ret = regmap_field_read(data->reg_als_it, &index);
> > The above seems unnecessary. Why changing the comparison from IIO_LIGHT to IIO_PROXIMITY?
> > After the proposed update we would have the integration time for both light and
> > intensity channels being read from the same register field?
> 
> These arms now see three channel types instead of two, so the two-way
> branch has to put the intensity channels on one side or the other:
> keyed on IIO_LIGHT they would fall into the else and read or write the
> proximity fields. Proximity is the odd one out - its engine has its
> own integration-time and gain fields - so the comparison keys on it
> (the write_raw arms route identically, hence the same change there).
> 
> And yes, light and intensity read the same field: the chip measures
> the colour channels in the same engine run as the ALS data, over the
> ALS integration time. Stepping that field through the driver doubles
> the ALS count and all four colour counts together (measured on the
> device: ALS 30/59/120 across three settings, C 83/167/334, R/G/B
> likewise).

Ah, so both STK3310 and STK36C61 have register 0x02 for integration time and
gain configurations that applies for all light/color channels. I think changing
to compare with IIO_PROXIMITY makes sense then.

Having a closer look at the data sheet I found for STK36C61, I noticed registers
0x13 and 0x14 are not listed. Does the newer part has ambient light sensing
besides the clear channel?


With best regards,
Marcelo
