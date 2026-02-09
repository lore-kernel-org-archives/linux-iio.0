Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DD2C0F72
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650904; cv=none; b=p13+TxHxg742MToVTHYIes/j0MULfme+m5XiYSUEpgEfxQnvyWWNbr4wS3GEo4cCGvIPvd7ywQUoZFwCsUXoZW/41uwz2XfqWHiRrsNGFLcd8cJd3uhz1lDMgd36L8G3jm9tCv8WzojQQwD8YYgF+CXdITUP7YtCv+wrEZp2yqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650904; c=relaxed/simple;
	bh=DTkjd0tNFRfFZrVjzA71TMao0DYCnAq9XUrVmaOJWbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bGPjjOaffbQNo04hQg3FYsxOB/OZXVuYhAMDflo8Zk5okbncMZNt4DBzt8/UWsAqMNaiVHyUsU1RBPnM2VI7ekjrmqajBHfvCAvBMFyHHlNbQBc/829eezeJuFQk2PHyWonzUQnbYqRdW9vgS7NWsDsoSaFvpFpTF66FB7wOvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n7IhtTW3; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n7IhtTW3"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c838069e5so3148104b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770650902; x=1771255702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9KZTHcq5eFjr9M/3mrNSgDFRjuluDN92D/wtKMFTk4A=;
        b=n7IhtTW3STJNle7++iMfAeuQvnynGeL+/R7BZBFHavWmez6as9nYPTkQqxk3ACnkPo
         ccUBvAKe57b4axD876mXMorFGSBF84VrwIZhaUenYvOsQZxNekL/P853sJs+FaLJkVmU
         q+YFVxK+Iyz/wIjp23w+6rPENtHk0765gImweDHLggXBeY63009AJEgiICdvRntqGohq
         bdShYlnO2xVLvVSb0HEcMDf5Q58xJwBnFWWVJVhyeS03miv6nCUVprwAAfUgzebyr9ja
         7J/HCpKDNP6bSfrBddNhfzze3x/eXyNpaSPx2gQ+0fydPCZyryR9fylNliNN1EZGZxnQ
         GAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770650902; x=1771255702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KZTHcq5eFjr9M/3mrNSgDFRjuluDN92D/wtKMFTk4A=;
        b=e4aqo9XjWiXfRxyogTOeqrALo9za1R5IiPy5vJbbQ0tOVv34OIBLDc71sLT35+iezm
         aEAQ96+ZbVHKEUgePFOI9VN0rxjrnPLGrO6mQaRT3yZH6bf0EArI6+YjEbtvjOj2T6ww
         a64LpJy0uHZ9drUCPKgql7hscIXJM4UowckyL8SAUirZaTmdZy2OukZjAVUiLunJHh6q
         I2Yn1vQiG4dwIWNSd9vRuXAZ4SkU7L9tNOcuU6XNcNqk9qDOjtodfxYucD8GOf4vq7Xb
         Sj2HDPJGnAOUjFJF02Ujf9uk9dANm52MqJkJcJSeNHvXwNXPIIbgd9lKuakYPgPSXMLl
         wSyg==
X-Forwarded-Encrypted: i=1; AJvYcCU04ucwrQdpS17n0hB6kTQ/xGnk/5K72X8b3e4r0uVXdm7DPBPpR9tXFg4pnDit4aBOBN53jOc122U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNauQ1pUeNF8toLd7jWGYRhgHj/mvtLGFi5Gev6rC18jQIRnGZ
	3DLo1MaVMOxC6x+OJF0f0kH1wTMaLc36ISpIJkTKVsyzOqX8i79qoKN2+7d7GENSEk1IkKDnpLb
	IJEAU
X-Gm-Gg: AZuq6aI/1PjxZDE/CcYThsq2UjFqQgZichNxamAJykVQU1b2Yzh6GFOc2JnfS0Rp+P5
	fsxpED+X8IkuzMT4ZfzaMz9QL7umbHREvTS/2cFWL8PAqPx4yvhqUXuGhtWlUHwdQFA8nJLxuZx
	X/d7UrDr7YNshicxzFApR/auz/XaFGBiNPi0u/JKeaHUxr8NlQtx4zPORVF1imYtsot4gFEoyei
	Yd7LW6m018qV755+EQwKLEjY5khvDTJc+mmPQZ9itL0zRAe/AV1ILSD62prwwtwEr/aQePWfa+S
	jMhcWyuLG3hbkla/zAzdWKKny44lwNtW9I4w/33vFt+CpKI7RsL2n/lxC5fsRvrwSs+McOGXyQM
	SepmynZsuJPjxRLxcyviytup46WRH5/mCY8XZ3dZdG+yo0c/gTCWctV4J8ff4FqpvZgw98RN935
	Ar8IT7crkZz6++0B4shXFwoV7cdcg+M5v9a6hCHMmQ0183WGvViQVf/DWTkOFB
X-Received: by 2002:a05:6808:c198:b0:45e:aba8:124e with SMTP id 5614622812f47-462fcf53c0bmr5694687b6e.23.1770650902598;
        Mon, 09 Feb 2026 07:28:22 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cee0:eb0c:b683:ad1d? ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb0d786sm6700789b6e.11.2026.02.09.07.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 07:28:22 -0800 (PST)
Message-ID: <becd9db1-818f-4aa8-8362-91a711861839@baylibre.com>
Date: Mon, 9 Feb 2026 09:28:21 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: backend: add devm_iio_backend_get_by_index()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
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
 <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/8/26 3:24 AM, Nuno Sá wrote:
> On Fri, 2026-02-06 at 18:07 +0200, Antoniu Miclaus wrote:
>> Add a new function to get an IIO backend by its index in the
>> io-backends device tree property. This is useful for multi-channel
>> devices that have multiple backends, where looking up by index is
>> more straightforward than using named backends.
>>
>> The new function directly uses the index to find the backend reference
>> in the io-backends property, avoiding the need for io-backend-names.
>>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>> ---
>>  drivers/iio/industrialio-backend.c | 51 ++++++++++++++++++++++++++++++
>>  include/linux/iio/backend.h        |  2 ++
>>  2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>> backend.c
>> index 447b694d6d5f..3b692d48481e 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(struct device *dev,
>> const char *name)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
>>  
>> +static struct iio_backend *
>> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
>> +				       struct fwnode_handle *fwnode,
>> +				       unsigned int index)
>> +{
>> +	struct fwnode_handle *fwnode_back;
>> +	struct iio_backend *back;
>> +	int ret;
>> +
>> +	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
>> +	if (IS_ERR(fwnode_back))
>> +		return dev_err_cast_probe(dev, fwnode_back,
>> +					  "Cannot get Firmware reference\n");
>> +
>> +	guard(mutex)(&iio_back_lock);
>> +	list_for_each_entry(back, &iio_back_list, entry) {
>> +		if (!device_match_fwnode(back->dev, fwnode_back))
>> +			continue;
>> +
>> +		fwnode_handle_put(fwnode_back);
>> +		ret = __devm_iio_backend_get(dev, back);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +
>> +		back->idx = index;
>> +
>> +		return back;
>> +	}
>> +
>> +	fwnode_handle_put(fwnode_back);
>> +	return ERR_PTR(-EPROBE_DEFER);
>> +}
> 
> I believe we don't necessarily need this. Why can't we use io-backend-names? I get
> that in here we just want something matching the number of channels we have so giving
> names is probably does not add much added value. But still, I would prefer t have
> more simplicity in the API and it should be fairly easy for the frontend to use the
> names argument.
> 
> _ Nuno Sá
> 

IMHO, using names in this case would just be annoying because we would have to
sprintf the string to add the index to the string. And also have to spend time
coming up with more complex DT bindings. Using the index seems much simpler.

If you really feel strongly about it though, maybe we could make a
devm_iio_backend_fwnode_get_fmt() function instead that handles the
sprintf() part so that we only have to write that once?


