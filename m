Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3349279908
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770488025; cv=none; b=qxmzzHCMSuxbkfLuwVzbEvPFECZoBEb9bckA5dh2SSqXXBl/7KgC7lefFt3TZjGKTixRllwbx/kUWDr4/nHV2t/kdPmbnMr9KLITlLDRUrclA0zEz/07rKOJgVvzwa97w82E/PKls70Xml5bctqcicwPQ67L0gXBB6Od3n7DOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770488025; c=relaxed/simple;
	bh=VVehCyZb7ZKZZHn5tlvmr/MsuVCnRwTQpqyQj4UtmHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U1TW6SMgMYgsyV18yvjkvBIqWybPTQdkQ51up776+6sBLDW0kelukddS/91KOUbIbflUYvkieSryWFaIOvOtGBKo2kEIyiNjWMmbbPTVHBjxnrTWcR5qiR+pG4oRvFOtjuiKLjnQxkae1OhZql4My9l+243hbhwiqIQgleQqhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WAzKmzuy; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WAzKmzuy"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d18cf89e72so2502391a34.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770488024; x=1771092824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgp/KQONA+9TwYMY5yMwLxiWV0XsEspUSrew8y64ohg=;
        b=WAzKmzuyYMhPqB5ap6uwtTqxHSbEdEW8WwtEfJiXSG0R6zailiFCKvXc5OhHNsflvd
         mItnM0U9lYzTLCuUBaf7MM+f90BpLDsE/XmNz9SIHkQoW8ITWWcsBs62Q7QW+SV+GnUi
         6tKPU0KGOmYvm4UIGST2ZnHAxDzIcs2J53rBFvFPPsAvs+4PbQky4ePJyoPwlvlC9tUE
         ki6Yg5J3VWZZ6WUB/mijSieASK8lMeV70Kpoo8qLxYzbgaqmoR2s5/r/pWoPaUanrVZK
         xWC2xdKJOAoMbIpJEWTCFPlzVZiq38vN8pG3Ji4ZEUkKQJO7VH2qP3qW1sJVQuNrAWzm
         gG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770488024; x=1771092824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgp/KQONA+9TwYMY5yMwLxiWV0XsEspUSrew8y64ohg=;
        b=Oth1kOg9fbT8e/eoF6wk+Jj0wdmAdynToDn44BmIFdYdHPqjNQ7KGN0wM+z/sIzmed
         VzHqEPSh62R5kDVAw+mERT9OcTCPVU1sLz3/Szabkx7vHScQ1Y9XZiprQaYI3dTHN2Ae
         Nk0NWrq7hTVZVEGQt43r8MS0dFj9LKRGQLx31D5nQrk33OHb9aAbsv+ENNqfgtZfj1fA
         mj1qwlD3Gq1NeSTw13XsMBtTyD4x1YdNpPCUs/YUGWhtl51uYM/+q8ro7fq+AMuLD8BB
         TXjLypHylQ6eN+IB//Rsgyenvuge163zL2uHYMrDE//ewGcMviI5S1QlHrw4eyu5desG
         u8oA==
X-Forwarded-Encrypted: i=1; AJvYcCXPfMuVbF1BwHvJ6yCcTLVmPk6xOHla/4gM3Nn1FTAtj9EBaB88kyIKPct5Fd9KTkE+uMOFz/LSQLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKw9hg1ynhr7SGf3bEEX44fP+2RaVTLwFxKPyLu6N7Q/FSjAwn
	rLhy0PqQAT9CwYGPG7hhkVAgW0D/8jpywS2hseiAX2JyBHinDbzR6KyoxWb51Bqnw9pYsbMpu0b
	SxQpR
X-Gm-Gg: AZuq6aLMAVxrzd4BIydM9aKD5ReTJe4J2OBREI7pQubJJcxSNhZfbzvNUtAyehA4XN7
	TdaTj8YzHbnmFpvQllreaeAooDGlB5JPTSLjUjbiWguusvL1B3Y7CdUHLfrYq+Xc6r1gAgzwknZ
	IytlGCOtgFwBRtBjxmOGL5NOa87w/cHrBqXgMmErDVSushm9W23nHCmiSfhe3c+/Y2zBAIKjl2K
	f54BBlbrssDj/B2/tOPDHqIuyChunzBGNU2q4xzF+xmYVyJmDL/AW8Dilw4gqZVQBerYurI5UCT
	F35uXUy07I7ZleUY+tLK6GckJ8VMpZfaaGIxo+8afLSeRtpAMVsJyJGsFUAQbkrJYthUfGkyypo
	OSKNDdEA32DwvwaOj4c2V03QG/0sTHtKtHvaZIea/QF5w2BfK3/QGhYOxT0+OpvoENuzNz0p2vr
	mBRTNF9g+BcIeEs0kK9wnLfFJAM0YTtoFK/l7Iw3a3/2WfmbjfKt5Bf+xIyPQhlY+78/st
X-Received: by 2002:a05:6830:638c:b0:7d1:4e51:e45 with SMTP id 46e09a7af769-7d464485cdcmr4167077a34.17.1770488024677;
        Sat, 07 Feb 2026 10:13:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:74a6:843b:f33:21ae? ([2600:8803:e7e4:500:74a6:843b:f33:21ae])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d464785674sm4115004a34.19.2026.02.07.10.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 10:13:44 -0800 (PST)
Message-ID: <ce4849c0-eb27-4268-8c4f-090a6396513b@baylibre.com>
Date: Sat, 7 Feb 2026 12:13:43 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: backend: add devm_iio_backend_get_by_index()
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/26 10:07 AM, Antoniu Miclaus wrote:
> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
> 
> The new function directly uses the index to find the backend reference
> in the io-backends property, avoiding the need for io-backend-names.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 51 ++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 447b694d6d5f..3b692d48481e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
>  
> +static struct iio_backend *
> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       unsigned int index)
> +{
> +	struct fwnode_handle *fwnode_back;
> +	struct iio_backend *back;
> +	int ret;
> +
> +	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
> +	if (IS_ERR(fwnode_back))
> +		return dev_err_cast_probe(dev, fwnode_back,
> +					  "Cannot get Firmware reference\n");
> +
> +	guard(mutex)(&iio_back_lock);
> +	list_for_each_entry(back, &iio_back_list, entry) {
> +		if (!device_match_fwnode(back->dev, fwnode_back))
> +			continue;
> +
> +		fwnode_handle_put(fwnode_back);
> +		ret = __devm_iio_backend_get(dev, back);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		back->idx = index;
> +
> +		return back;
> +	}
> +
> +	fwnode_handle_put(fwnode_back);
> +	return ERR_PTR(-EPROBE_DEFER);
> +}

This duplicates most of __devm_iio_backend_fwnode_get(), so we could modify
__devm_iio_backend_fwnode_get() to call this function too.
