Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797239;
	b=cRNzkRjAZIISdO0J4jyIVRhUnoB+oxld27SL6MHv8aiWJKJyoCQC8R+20FnIhFe5LDFX
	 rAzKgHim51g2UzSFek0yO5AT2wtKUhqaA32e02EEnGSwVuDfkoXkb8ysWcMf1KpzFosNg
	 E7ubHmHVcvq3nIz3HXPvQSHptxFtWmRZarHkGp/NN6BqdULs5afZWh7prc6dEotROTc0A
	 zDHbheiVP9/85ORF4cZGPGTvVymuA1uQQ/d9kBQR0x9K5d/msM+iaGcPK3cxw5F5OVDyz
	 6aII8hPxSWgvZsrpbX/lKrDTOVn+a49KOlp17SUkOCWHNLQ2V+qpjPAsnLEXZ2NbH9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797239;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GvTiaD6EP76UmQRAZH0J4/hKS8wT1IhdMe3Hcwt9r3o=;
	b=ull69reHYTxHBuzBKdQaPzqmqRLoNM5xOxJJDE84RBN+jHbwSQknv4JYBF5zuGp4R2vx
	 V1NCy/Po7cRxA+hEa4zZvqypFY/zOAB7Tb8OxwXUW7MGCAywUvNV4C+j5BYNDe2Mo8yrV
	 hjwlBWCNjXqXzMPzbAlDsf1phyhEJXEphBatpgTpm8E5hDA4qyYb2mhwpXa7sb/UOqT6/
	 9dRqNrsjAD46PlwFlBXlenJZ+zNftbG9gb7/2Zc+mHcO1zwi6Kgmj9JiUH+YWblbsCdIW
	 jsuSHJ8o+rG/2/8llCTtREGgCjA5KgNUn3FOsAMM3A/LT7O4ei0SiZkdXsihDWkWyHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB3606A326;
	Wed,  4 Nov 2026 13:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72AB3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [IPV6:2a02:3102:b60c:d00:92f6:52ff:0:bd0] (dynamic-2a02-3102-b60c-0d00-92f6-52ff-0000-0bd0.310.pool.telefonica.de [IPv6:2a02:3102:b60c:d00:92f6:52ff:0:bd0])
	by rudorff.com (Postfix) with ESMTPSA id 1334C4081B;
	Wed,  4 Nov 2026 14:00:28 +0100 (CET)
Message-ID: <eacf96b0-a4d8-414b-a3c6-b0d7913b1371@rudorff.com>
Date: Wed, 4 Nov 2026 14:00:26 +0100
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
Subject: Re: [PATCH v3 2/3] iio: light: gp2ap002: add led power supply
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
 <20261020-iio-light-gp2ap002-v3-2-b7e0946c9e79@rudorff.com>
 <ath32oZkOYl2UwqX@ashevche-desk.local>
Content-Language: en-US, de-DE
From: "chr[]" <chris@rudorff.com>
In-Reply-To: <ath32oZkOYl2UwqX@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,

Thanks for the review.
I'm about pretty up this patch. My comment on this:

Am 21.10.26 um 10:29 schrieb Andy Shevchenko:
 > On Tue, Oct 20, 2026 at 01:35:39PM +0200, Christoph Rudorff wrote:
 >
 > ...
 >
 >>   	ret = gp2ap002_init(gp2ap002);
 >>   	if (ret) {
 >>   		dev_err(dev, "initialization failed\n");
 >> -		goto out_disable_vio;
 >> +		goto out_disable_power;
 >>   	}
 >>   	pm_runtime_get_noresume(dev);
 >>   	pm_runtime_set_active(dev);
 >> @@ -616,10 +619,8 @@ static int gp2ap002_probe(struct i2c_client *client)
 >>   	pm_runtime_put_noidle(dev);
 >>   out_disable_pm:
 >>   	pm_runtime_disable(dev);
 >> -out_disable_vio:
 >> -	regulator_disable(gp2ap002->vio);
 >> -out_disable_vdd:
 >> -	regulator_disable(gp2ap002->vdd);
 >> +out_disable_power:
 >> +	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
 >>   	return ret;
 >
 > Wondering if we can use managed resources to disable regulators.
 >

Well, me too. But there is just one way to make devres bulk_disable: use 
devm_regulator_bulk_get_enable() but we want to set voltages before enabling.

With Best Regards,
chris


