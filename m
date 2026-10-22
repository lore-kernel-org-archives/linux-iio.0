Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679270;
	b=QBFdaOy++gIVWDt4TjgcdESHElygLHDC/pHo7ySOFlePpRl3rbiRzVGWoordA7l0mXek
	 IdyCFO2fk/kEm0QyMBC3hFBDWnjoiCtErEKBmMj8zb7DFzfeUiBt44Ixi1+RXvkHzu5b5
	 cmPI0aGVC1e07YSq5R6q17g65qu8P3rOeNzu4Uznus89oeW0d/ZdvDr6A8gKymQLmGdwn
	 II+TCicpezERcBuPWLvWn9cDZFN4N/9ZFiuq7MlVeglruLxyLctQ0jceMZk8UyKXgWeBQ
	 oPYIabJVheNp5PWgRy/ZL9NY0qBNsZhIisyirQZLtnwsnrgUVQI7PFqOzA85szR/wTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679270;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=KCOZF10R4aifn7iF0EF5+EvIMvOV7gjJwSD4YJ1R2Ec=;
	b=eOgvCUH6z+LqASK0aJgjEnasmGXUOyxGKd7X0sk8BIRQMytLNvdBGrSwQv8wkRHxkE4z
	 0ScFQWa1o7S+BMujUwAGcZ5Um1IIjA2XKGG+XS5w7MX+BJQJjBUZXB2J0Fblhqu2y2jOm
	 x/425BoS7Xv3mJ9QasEQUsDIntENDGiY/IR2d+tWAhiEELZ0KLthQjX8T6c6MUIhFkhsi
	 PkxQDpSx3AqIRcoIeYodXDpHb/JZ6S0ZivBdzG7c7BZ9RbEIzPKyIM70yCd8nagM1uSPU
	 xZ9Y4DWzbn64efcQfYUYK5cYyR4wRkRz3jF8nQFnfmAXWTzLhCke2VnNXwVxYNExo4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84999606A31F;
	Thu, 22 Oct 2026 14:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84999606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [IPV6:2a02:3102:b60c:d00:92f6:52ff:0:bd0] (dynamic-2a02-3102-b60c-0d00-92f6-52ff-0000-0bd0.310.pool.telefonica.de [IPv6:2a02:3102:b60c:d00:92f6:52ff:0:bd0])
	by rudorff.com (Postfix) with ESMTPSA id 158AC404C5;
	Thu, 22 Oct 2026 16:27:47 +0200 (CEST)
Message-ID: <0531c9d9-383e-4705-a70f-0200d3ee1073@rudorff.com>
Date: Thu, 22 Oct 2026 16:27:46 +0200
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
 <2b091dc3-9588-4042-8908-2fc3adba6cf5@rudorff.com>
 <a7114c6a-2ce4-4e16-8911-d5459d4bb362@oss.qualcomm.com>
Content-Language: en-US, de-DE
From: "chr[]" <chris@rudorff.com>
In-Reply-To: <a7114c6a-2ce4-4e16-8911-d5459d4bb362@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 22.10.26 um 15:46 schrieb Konrad Dybcio:
> On 10/22/26 3:35 PM, chr[] wrote:
>> Am 16.10.26 um 17:11 schrieb Konrad Dybcio:
>>> On 10/16/26 4:43 PM, Christoph Rudorff wrote:
>>>> J5 got a gp2ap002 sensor, add it and it's supplies to the device tree
>>>>
>>>> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
>>>> ---
>>>>    .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 19 ++++++++++
>>>>    arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 40 ++++++++++++++++++++++
>>>
>>> It's odd for the regulator and pin setting to be common, but the
>>> sensor to only be there for one of these devices
>>>
>>> Konrad
>>
>> Hi Konrad,
>>
>> in patchv3 I removed the settings from common
>> and renamed some labels.
>>
>> Is that ok?
> 
> I guess we'll see when you send it?

Sorry for the confusion. I already did:

https://lore.kernel.org/linux-arm-msm/20261020-iio-light-gp2ap002-v3-3-b7e0946c9e79@rudorff.com/

My patch set needs some rewording.

regards,
chris

> 
> Konrad

