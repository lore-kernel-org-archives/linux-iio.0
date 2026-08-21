Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8B379EC4
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328170; cv=none; b=c+1h/Q5p2zUum8n1it8hjDVTnvy1ClR0PxQ8CS9a4/N3dsqn0Xov4XC13gPm/Sr6Hmb0GVvLUGlCElDaYGIv4JHdeCAkLt3Tq3QnFohrP9FVn3JQWuuMIizJIe/M0sgRmR4ZONGMRDDgMIzmsKv6UTBENcb+VEOO/KVX7RUONeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328170; c=relaxed/simple;
	bh=mn6UejKbYkUvw4/VNNYmDeinXZGEQSxfE1rz+AV/JjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fmb7FFheJiDIbXRg3DGOPD/pUVHDKhkby0Yj85FA+0sZzmTEC5m/D8xMeVxyUVJ7ZP3BBR4W3l6aqolziLNnEdX1MopJVFfbAfwUd8yW1bHXuIjiN4OA4e8PRG1e5qJQTQ4af9+yJ5HjsJPIQf+GPG4LbpHF/ZcYupfSI1esrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZYdrOuT8; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZYdrOuT8"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836cde02992so14594527b3.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787328163; x=1787932963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0dZzEevn51g9AXgQqOI5uA/Xxatf9zurz5TF1P+mh5g=;
        b=ZYdrOuT8GevK0VXF6r/bBB5UiVTYLPPVVa8c35OlkJ6oD6EoGoHbZyUlCnBf2VGSxw
         b6ooGzJpHL1hAiYG3+O4yZ7c7A4FAWaH195OBdjdht495BHBGl4xZ3S2k0SHmjFSq8Ti
         8inzf8NEnuE+2DBB9v3+q15v4KCR8Yh/vWk98dFQPRHMh327wohj/wLzay6vam//KSXm
         l6YzgHa5EhbiyENJuar6k60N9rEWmPoHLetDBXFpTnGZgkU+dBq4VUx/unysFWpNxrWA
         U63CUuH0coJhQDg2ZfDWK8kQsio9Wk3gtt2uVm363jgD8CCwuNuEfPyKhmoLW05WNyuV
         u2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328163; x=1787932963;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dZzEevn51g9AXgQqOI5uA/Xxatf9zurz5TF1P+mh5g=;
        b=e70cxkMihFauL4RAJMzhCNauvQQKgP/pAp7mxwLMG0n7j2vnnTrwAxJf+Zk/3B3BYK
         52PtgqqeoKcvUaQO+sknHd2w8KNLlq8mjNir3jvKowq+O2K+y37AfUyf/WKPFq4/ETIW
         ySwOuXUOmaVNKsFcxVW1hwvomqjC0c4Bewn+iWqojR5jzWJx9F9a7T++2Mu9cb1eEDhG
         cxoG7fOC1G8ELxDRNHoGA8iiDzlhnKj5l07e5AyYmDivsCJQyrZOXbCi7DGqmOm7z9zN
         omL2MAf7PChCXoJgSGqidabvhvZmhF9aW3qbZWFosuw/09K1plk+P0+YHl+Us8lkHh3C
         lAxg==
X-Forwarded-Encrypted: i=1; AHgh+RpFMea31Ej0n55MRWwf9zbOBSpKbCtG+OL91L6nAkkaHl1W3jMFif8KwyxKCu1xjl9AIXh7raRZYIs=@vger.kernel.org
X-Gm-Message-State: AFuF++lPkusraR9TltBd7XSwjtaFExnKaobPSJd2p9wlT/wCn4fpKF76
	dgof9EvQw7hxaC3IxmcqkmsRnbN2anOim70Xwy06ps1Ry8KUitVbUYT+tV2zkTBICiE=
X-Gm-Gg: AR+sD10dGHvdvMzecX6OuTFl9JXtYPeUJ5+4eSuIPvc756l9tw2hKK5YigipVXmwF18
	iDRKI4nj9v9tyzpJdIhOjp/rcCABL754dPRuxllTV6cm59asa/rXeB2NOiawlm4BiyeEuxZJV3n
	tUPPWGVqdd0bOm/bOvHdQlJ6UwVtJTFXzERd70DDw53NMSs10Bw3DTnr/W2RF7GYBBAeTDigtdn
	JJfEg68X73pzeOKM7IV9gQ+FHOr+WZgF2EERth8krAPrQhtOVlVestpC8SM2qI6T0LCFqh8Owgp
	bRgAW5XFgFfX7t0SvY601O2Co3G9wf0/yN4CXCX9bZVknDnagJM6jdKh5UMu5WFxfqbrfhUvGzS
	IiCmr/O5K8lHEbsjDi7pf9AYgUzpHDMjUC8u3Wag6u9oM3dsog2UZzskMC4UnNO1at3CHIDpKHz
	cHcUxUdXlIzafvCnVAhoBpjK8nf1SN1/tPsNVJ8Am980rd4ngkwempGOF9FjFdRCR9Hqhb/1jOf
	fyJikSk5MkhYFS3J09gm56XsOkuxMSCGWYqB4/bcQ==
X-Received: by 2002:a05:690c:660a:b0:80f:ddab:1cca with SMTP id 00721157ae682-849f8e84e37mr26940247b3.35.1787328163060;
        Fri, 21 Aug 2026 09:02:43 -0700 (PDT)
Received: from [192.168.1.169] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84511abb2bbsm42930907b3.5.2026.08.21.09.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 09:02:42 -0700 (PDT)
Message-ID: <65b42c5e-1ce3-474d-a14c-961deb337311@baylibre.com>
Date: Fri, 21 Aug 2026 11:02:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] iio: backend: Add support for CRC
To: Janani Sunil <janani.sunil@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-3-bb8fbd06d4eb@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260821-ad7768-driver-v4-3-bb8fbd06d4eb@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/26 9:06 AM, Janani Sunil wrote:
> Add a backend operation to enable or disable direction-specific CRC
> handling. On input data paths, the backend handles CRC data generated by
> the frontend. On output data paths, the backend generates CRC data for
> the frontend to verify.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  6 ++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index f7a4be8ec320..fbf5c39d7655 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -886,6 +886,39 @@ int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_num_lanes_set, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_crc_enable - Enable CRC handling
> + * @back: Backend device
> + *
> + * On input data paths, enable backend handling of CRC data generated by the
> + * frontend. On output data paths, enable the backend to generate CRC data for
> + * the frontend to verify.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_crc_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, crc_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_crc_enable, "IIO_BACKEND");
> +
> +/**
> + * iio_backend_crc_disable - Disable CRC handling
> + * @back: Backend device
> + *
> + * On input data paths, disable backend handling of CRC data generated by the
> + * frontend. On output data paths, disable CRC generation by the backend.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_crc_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, crc_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_crc_disable, "IIO_BACKEND");
> +
The descriptions are a bit unclear on how the data is actually sent, so not
really sure all of the explanation is worth it vs. just saying enables/disables
CRC.

Good enough for me though:

Reviewed-by: David Lechner <dlechner@baylibre.com>

