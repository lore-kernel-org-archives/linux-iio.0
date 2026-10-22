Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676118;
	b=Wpcf6cdIOXBv/Ev0SpU/W+A0BiO+rWB8jW248xvrqbTKWrAeZtVMY8N1EFPh1H7L2N+i
	 R0wkRtvViqMt051EKYbX+jpnpjf4eBYM+9dEku+4numiaXNT7DjpoyT3x6r/TR/LhyrKx
	 LwJuiJOqbMYpBFZCrMCnzVrPlG1Weot75DL8pej1CNtu6scgTxywjPhgsEkzFkqve+1+O
	 IHe6gXM14eB1RpjrTw+QM5tf/wprCgULlxzE50CR5/lFoEeHCbmAGv1e6K93RiCZ/pY4H
	 lWiUCob7YxPTQAHamTqoMJdm/izOdEErpdl6CP3Hup1yGWwIrug45Lh69qxyaR/usuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676118;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=oVTm7ek0li3Y8+8HmSzHDQ7p121jD4gpshcVEU+XW1A=;
	b=eR/RVkLrLrGGdyHp7Y+zQpm1AIRC6KnK8YuaL3fPhP9zgyZMuqaZXZFuOgWuN5tO9/2q
	 Vx+RZkHaBlzIj6snjfl4G+X9yFzeiRFN5yfg7yJ3dnpL8pj45N7n3zQE7eqKYCFkgizL/
	 usmUCWKTlE20XDHS5PFvPDzy/ZOcvVCXm7Qysj17cjOyPpI/RmHBVZq62P9ts8mWQdVmI
	 O+0wa0PnVt1aiQ62exmcBxINMBBYlVxlMt+RvGPM8KeG+1I3CDhKnBpjXJD+WVFQGNrbp
	 l6Oe77d7AQTSM/7UGxbXFh877twOdzW9g6f7ceQC+JmTadN3zJihZejV1EnYBbL1ZcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB120606A31A;
	Thu, 22 Oct 2026 13:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB120606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [IPV6:2a02:3102:b60c:d00:92f6:52ff:0:bd0] (dynamic-2a02-3102-b60c-0d00-92f6-52ff-0000-0bd0.310.pool.telefonica.de [IPv6:2a02:3102:b60c:d00:92f6:52ff:0:bd0])
	by rudorff.com (Postfix) with ESMTPSA id DC2A0404C5;
	Thu, 22 Oct 2026 15:35:07 +0200 (CEST)
Message-ID: <2b091dc3-9588-4042-8908-2fc3adba6cf5@rudorff.com>
Date: Thu, 22 Oct 2026 15:35:06 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add proximity
 sensor
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
 <20261016-iio-light-gp2ap002-v1-3-7c93312fa8d5@rudorff.com>
 <5531e454-0d84-48f2-af0d-1ab34c149760@oss.qualcomm.com>
Content-Language: en-US, de-DE
From: "chr[]" <chris@rudorff.com>
In-Reply-To: <5531e454-0d84-48f2-af0d-1ab34c149760@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 16.10.26 um 17:11 schrieb Konrad Dybcio:
> On 10/16/26 4:43 PM, Christoph Rudorff wrote:
>> J5 got a gp2ap002 sensor, add it and it's supplies to the device tree
>>
>> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
>> ---
>>   .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 19 ++++++++++
>>   arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 40 ++++++++++++++++++++++
> 
> It's odd for the regulator and pin setting to be common, but the
> sensor to only be there for one of these devices
> 
> Konrad

Hi Konrad,

in patchv3 I removed the settings from common
and renamed some labels.

Is that ok?

regards

chris


