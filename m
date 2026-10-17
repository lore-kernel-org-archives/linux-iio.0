Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823E348463;
	Sat, 17 Oct 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792228723; cv=none; b=H8cF8ugVUBTY/umG9jEo6v0r2t2Konh8+hJPIZIZ+20pCsG5eeMgAblzOUnBh66m4Fakbo26H7rNdseNUth9JjBkcOyG+QPUtpRZgFuU3xwM88JfL5tUTHflju0ubXP/27SkdDuuxbdZ6xzzLpU3ne4cxd+JLbGQyv0AF4JH0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792228723; c=relaxed/simple;
	bh=mCRVUildTZjTbw/jgx6UEUINOaa3DZg6f2l98SlXRrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6gxOoHP7x32vbr9ZoRlm1dyMqVP3slCUMhJkWPCCqpoTl77t0/Kuq7IVYtSsM9XN4HIxv4ccfc8wbyWS8pRB14vKeYspAqXrqbM3qX6DO6p2jOPgoOyRW28Gjc2SFwChqVss/I502QEo64BVBRM2zf5NULxvSMybg/nOK1sA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [IPV6:2a02:3102:b60c:d00:92f6:52ff:0:bd0] (dynamic-2a02-3102-b60c-0d00-92f6-52ff-0000-0bd0.310.pool.telefonica.de [IPv6:2a02:3102:b60c:d00:92f6:52ff:0:bd0])
	by rudorff.com (Postfix) with ESMTPSA id BE0B14035A;
	Sat, 17 Oct 2026 11:18:37 +0200 (CEST)
Message-ID: <3ef190ac-eac2-4c0d-b3b2-6fb627f086ef@rudorff.com>
Date: Sat, 17 Oct 2026 11:18:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: Update DT bindings for GP2AP002
To: Linus Walleij <linusw@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
 <20261016-iio-light-gp2ap002-v1-2-7c93312fa8d5@rudorff.com>
 <CAD++jLkSjbMRV_53rjpd1D+vxg=OVVWzVwiddUL0eqmSBoONHw@mail.gmail.com>
Content-Language: en-US, de-DE
From: "chr[]" <chris@rudorff.com>
In-Reply-To: <CAD++jLkSjbMRV_53rjpd1D+vxg=OVVWzVwiddUL0eqmSBoONHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Am 16.10.26 um 23:01 schrieb Linus Walleij:
> Hi Christoph,
> 
> thanks for your patch!
> 
> On Fri, Oct 16, 2026 at 4:43 PM Christoph Rudorff <chris@rudorff.com> wrote:
> 
>> +  vled-supply:
>> +    description: LED power supply a phandle to a regulator
> 
> What datasheet is this from?
> 
> My datasheet for the GP2AP002S00F clearly has only
> VIO and VCC, enjoy:
> https://dflund.se/~triad/krad/GP2AP002S00F.pdf

That's the paper I'm looking at. Pin LEDA wants power!
See page 8 "Recommended external circuit"

> 
> There is however two *outputs* from the GP2AP002S00F
> called LEDA and LEDC.
> 
> These read "LED Anode" and "LED Cathode" and is where
> the IR LED is supposed to be connected.

The LED is build in. And it wants power:
see page 4 "Absolute Maximum Ratings", 3x "supply"

Vcc and Vled want the same voltage so they may have the same supply.
In the downstream kernel they #ifdef that case having an optional third 
supply and #ifdef two options for that.

> 
> I'm just puzzled by this patch.
> 

In the end it makes it work on my device.

> Yours,
> Linus Walleij

@all,

thanks for your reviews, there will be version 2, soon.

Regards,

Christoph Rudorff


