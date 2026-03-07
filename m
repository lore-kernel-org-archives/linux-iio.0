Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A3239099
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907251; cv=none; b=QERlhets25nQUm/Ax7iEYuljt+jTN9Q4D2H3cMZvlUXd4gG680/7N3ujC3/hi42cyMPu0AYrdrSEb06Vy9purYN8gZ2O7beRgmsJ/DhINyOu7aFPRT/PK7B2QRIQ7ry/sJ25EWHzgFiXFagybhdATmqOuPd6Lv+xp+oAiaDyXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907251; c=relaxed/simple;
	bh=2bpNFQYrY+4AxovPokblGV+YZqGYq2o3LMzrIO8FHhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFoS6fO+FGJwn3MNigDXo1X5+nnzGZvAfpNCE5afKrVKpe1Ers2lz+ryG/isoRscfwJqSovMcFhRJr4RvfwDkVxSWZIQdfkVIismmtAT1WN7X6kcN3agNWqnczFutk+d/QbAn4JB4LuB+D3TdA45PCwSuamn+MOFFLM1sNGBcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U4Xu749u; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U4Xu749u"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4ba9abbecso12305764a34.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772907249; x=1773512049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRdsLK7weBsl9Qz7+q1Z86EFK/E2/7vFXBMivgf8qR4=;
        b=U4Xu749urpHkBRZdo4xn4HQ7iY2EWPU1T6nkw/cohHD447YV/J1RAV+KIKwEzFbtu4
         yIyxDlvxljsU6Tfm0VZVQssfTP/V2SqKX458mzIDfJr31Ul5onPkz1wf6ElyNuJJzpMU
         S3Uv5Kh3NmTEkf/d7HyWep2TtGb25V+NTs+gXFtD4EKzpt7FJEyhRWl64odkR4zyezXw
         mqzWJrPPHHkdOhW2E+OF3OrMC7ru91cRqoImKrfWQh1EjxoN/Kko6s0zItXTCH9xjkIF
         70bQ6yeN6kF1ehuNITcvognB/MY41mtnD+tSNku4ARQTTx6uLg9M8qqXfKy9c1LteiyY
         wLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772907249; x=1773512049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRdsLK7weBsl9Qz7+q1Z86EFK/E2/7vFXBMivgf8qR4=;
        b=JeBRcxCVcjUZRSvB/8xXOIF7YQSOZf0HkOrsnffTlOpyz/oyOx13HSW7utoArBnA5T
         do1fGxYX7v7+Ugfwj+4wAKrqaC6uDCLJz/ueB0xbvAHqi5AxNmzGZL5GJEEyoWjLdb2E
         twMjwFfh0RW87c6797X4O+VBilGx+VC7TV/x8wfa0RtWyRq3we8EAo26kKMWxQxUyPZT
         PgcQFYOBxYVyqyxm9yquZ+3u/MQKQEWRaNR6nUZB+bCn2g5jPEk9pkKnn+gaxZazhmbZ
         0iKs1hTaJ43JBYwa7BcrO/nkoYmAT8qBldcqona38zYV2qdTxFBlgeRJGfm0wwBIKtX2
         N6vw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0HePfTquEQNFHrFCQMsJX4UPYgTNf9Asiew0o/fq8efv0C+sfkuyWkguVpeXwtLuv7Yi33AKW8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44oPSLv5+3UVkx/HvlihTaBnR7XqyGl7/mu47qILL1LBYjV8D
	9o4b2gOS7sSsjPme+zo5e5k+FLD2Aqx33HQ2DhM0cG/YA3G1q4nJ9UEeLL3cMiBHGfQ=
X-Gm-Gg: ATEYQzyXBE3v8R4/8gqhgdjji3srXTs7X6DbJp0Ekzt1isIHgTGxuE1uJxIrDk+17ZA
	BG+9iA9XuO+jexCDpP+pOwbLBFoIcIHpPd9FbHYpl8n+lpVCBZOTK1y4evg8lAfNgE2QlYSX6qg
	woX6CaxnBmTu/tf7CPxmAKJz8uXzFCawBOlQhuzTSC2eBexOaVKtqKCrNpX5WFf6nxDlRaKw23M
	SeoB22EvVb4Kq4ZU6WhUbpiL5gIFtQULNcOnfOOl4NRXT6NUZ/DIRnUHmib2tjaQ4HxQb/F7JdF
	R+CWLbwg+eimyOhgjmQeee9sIHd3vekowh/87Fo3nDkZ/uuGeAKoSIIFwjpPVz4efiyNL2MK4Tr
	Hin2UDgdWJdm3sU9KH2QoMPVHkZIht4gSvbeD35PL4m2ORaJoV9JH5e67UlwAL15LnSHx3aNZWO
	AuhwYK9NHiU67S6HEvmuuby3zaz+tgwNiHIMual/iBKE5ICs2eg4WACptkyZ8k0C1sQhGShkTWd
	g9kZNgMLWSL
X-Received: by 2002:a05:6820:1ca3:b0:67b:ad2d:1226 with SMTP id 006d021491bc7-67bad2d15a5mr92348eaf.32.1772907248856;
        Sat, 07 Mar 2026 10:14:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bacd85dd6sm152199eaf.11.2026.03.07.10.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 10:14:08 -0800 (PST)
Message-ID: <ece644e9-fa6c-4be2-8159-4e8d1ef52cab@baylibre.com>
Date: Sat, 7 Mar 2026 12:14:06 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
To: kernel test robot <lkp@intel.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
References: <20260305113756.47243-5-antoniu.miclaus@analog.com>
 <202603080146.6a7IzS7i-lkp@intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <202603080146.6a7IzS7i-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/26 11:11 AM, kernel test robot wrote:
> Hi Antoniu,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on v7.0-rc2]
> [also build test ERROR on linus/master]
> [cannot apply to jic23-iio/togreg next-20260306]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-backend-use-__free-fwnode_handle-for-automatic-cleanup/20260305-194647
> base:   v7.0-rc2
> patch link:    https://lore.kernel.org/r/20260305113756.47243-5-antoniu.miclaus%40analog.com
> patch subject: [PATCH v5 4/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260308/202603080146.6a7IzS7i-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080146.6a7IzS7i-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603080146.6a7IzS7i-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/iio/adc/ad4080.c: In function 'ad4080_probe':
>>> drivers/iio/adc/ad4080.c:739:31: error: implicit declaration of function 'devm_spi_new_ancillary_device'; did you mean 'spi_new_ancillary_device'? [-Wimplicit-function-declaration]
>      739 |                 st->spi[ch] = devm_spi_new_ancillary_device(spi,
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                               spi_new_ancillary_device
>>> drivers/iio/adc/ad4080.c:739:29: error: assignment to 'struct spi_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      739 |                 st->spi[ch] = devm_spi_new_ancillary_device(spi,
>          |                             ^
> 
> 
The cover letter of the series should call out the dependency on the
SPI patches that have already been picked up.

There is even a git format for this that the bots understand to avoid
messages like this.
