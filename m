Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108144CAC2
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623821; cv=none; b=TIEQlmUOu5UENKXRmP+nrtub57hBGtg81Tf1w2Tv/kBb/KvbiRVlgusP/PnZStZtr/iNNaqZVXNFyFKbNzxb9AgHP+6vJ2kiGW+uXVmhuoYU3rcK3WYnltgfdyLFCyzMnWUyO4mbKess9G+m4Dznu+OaLFPkWmTsZ3x0aLaVHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623821; c=relaxed/simple;
	bh=P8HCEBD70snqwKdpaO75cGCjmvTTJXjD8qQCQ1uOKdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvrGEnVLXWvtZg4bcIhhIH3qsAKIbXtJn8/CovAAJsw409fBwKTdwHvQB7tJIOAX733zItOS055uym7Vr75rlRqs+YWGmyMy37Swz3cU9O35CGSqjaM/+gTJ8+I3I56fVPL0X3iLbyXvBp1hWpmczbcajFJR/hAnXPMhoC26tX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HDQjCFpY; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HDQjCFpY"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43cce34c881so4046812fac.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781623819; x=1782228619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgEPcrFDybOilEEFxetPSI7iakaIrltXJjjOqciP8Q4=;
        b=HDQjCFpYx1KaurIpevULR3IqppU1wtTzjAsWAnYJXgapPmPDBY0/KjkxEr7Cv2IC6K
         pQbXhbIB2vyAe9nBWOkmtYneBvMctAHrvdeu7DBUc8R6dpJdXrpylGdcVlGsPyuq+RUA
         5OxP0esCwr06jQLsFoA873DSdVK+1X6N81a+iGF2gCPpTT7LTcwS88AEYr5Ea1aYfesw
         koWb8E0o6j5ycztFTrdzd3Dn0BOjMMm5SwNKpDL0NfYSrNVEBPv2W1DcLUsqjybjqsX4
         JTS6Ot5tK/je/XLsDfudwI01xKzbtf06l9zQHPPtKfRaPuzOYbtG3StcOIdcF6Q6/ArK
         p2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623819; x=1782228619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgEPcrFDybOilEEFxetPSI7iakaIrltXJjjOqciP8Q4=;
        b=Ev98nXPyVZOZ4yiLToy90nFagNxEFDbipFIvXBUvGczJJtNHjBbrpG8lNCmu3pNVbT
         Pyanopnb5uG4qUIah/pe9kg9PFe7nqKa1lVvslAFP6C6aCu1yel+UcL2xe+MLelncTdo
         fwytRvtp7lZm+uyWnwXnLE7snq8VvaA18SUDWG91esDo0NMCMDmFOXYDAvY0mEXfTwMU
         vTxdOsvjk+6mAISdnDqqDCZa3+MOvylLx1ZM0e5IXMD4YbMlqQ7On1Ntobg+EvEz0sH3
         QTT0FEG+3griiba20vIfRsf4nYSHoBuoeGU5UhRuEs0UMkxWSpAZxeNed1bqy6w2inEx
         kUEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/50S4j1kSY2EVLmx2NbQr4Rje7Fx+mUMdC8BjbPDxYE81rZQm6OYR50ORdhIAUk2yJi1Cd1jBAh28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBkbc57E8Dbhvwo4TIpeZq4uzVwwfnCdNfb16u4g4sNlQyDSc
	ZYoJQQEij3nHaEFOYnmm5oJLQ+TREztRQwfbye6gWMsAvJnXJxARLcfaReWQGTR+tpY=
X-Gm-Gg: Acq92OGWnHLjHnIPJguHisNlD9qkDTnh/Yp3HrDOaEVRTzHArBqX7KocnHf159pG9d0
	GuwyucyE+/iBw+unaFZTDzPz3TJwqh/vGt1QqJQMgNk+/83kHgwvwo9ZF9P/ozo4r05bPA9LsOE
	GMzWeg1do53JIimsE1+u3Y1jAft0Dby9lXLhSariCWECCpaSjWTqtA6qP3sB4H0NT5DDy7uXmyw
	YRwa/MZVpnNS3tsf/W0qoguyjeTvM4+EB4FBB3j8OkvQqMhipgDdJqmhwOS2hyHKp9UzpRGApV6
	7odufa+2+I5Imab2hYHCRQLyd9Y1NF3Ih/jB3N6ukZQ420CQ48E5g7c4WWLgirc1pSggBaSdPVT
	8y25Dwyfsea8qzpTm5btlqNIeIgkRSNb3cakWtLwcMii1NniH0tOte8Dbn5S+kJg3NoeBrAzsX+
	s9YKVRmuSQYSgDhllJ4BKbrDxlQWlPh1+jNTEsVxHwq+wt0Cp1FPxGcWCWG0VKzknhMTEZ3qI1x
	fFL5T/SgYKh
X-Received: by 2002:a05:6870:e314:b0:42c:24f6:f190 with SMTP id 586e51a60fabf-4430b5e7c76mr3275033fac.17.1781623818663;
        Tue, 16 Jun 2026 08:30:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4430866fa15sm2376561fac.0.2026.06.16.08.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 08:30:18 -0700 (PDT)
Message-ID: <1aec0172-68b4-4542-83d4-5c05680c0096@baylibre.com>
Date: Tue, 16 Jun 2026 10:30:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: adc: ti-ads112c14: add measurement channel
 support
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 5:00 PM, David Lechner (TI) wrote:
> Add support for parsing devicetree properties for measurement channels
> and doing direct reads on these.
> 
> There are quite a lot of conditions that have to be met for each
> measurement to be made, so quite a bit of state and algorithms are
> required to handle it.
> 
> Channels are created dynamically since the number of possibilities is
> unreasonably large.
> 

...

>  static void ads112c14_populate_tables(struct ads112c14_data *data)
>  {
>  	u32 vref_uV, fsr_bits;
> -	int i;
> +
> +	for (u32 i = 0; i < data->num_measurements; i++) {
> +		struct ads112c14_measurement *measurement = &data->measurements[i];
> +
> +		switch (measurement->vref_source) {
> +		case ADS112C14_VREF_SOURCE_EXTERNAL:
> +			if (data->ext_ref_ohms)
> +				vref_uV = measurement->idac_current_uA *
> +					  measurement->iadc_count * data->ext_ref_ohms;

One thing I am considering is that if we have a resistor between
REFP and REFN rather than a voltage supply, then we should consider
the channel IIO_RESISTANCE rather than IIO_VOLTAGE.

In this case, the user doesn't care about voltage at all, but rather
the ratio of the REFP-REFN resistor to the measured resistance.


