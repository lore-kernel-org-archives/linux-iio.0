Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AD4A2050;
	Thu, 24 Sep 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262916; cv=none; b=dOrJoo/+EZo7xrGK2AIb1S3F39tlZIE/lan+exZ4dFz5rw4Yo2mzjlM4lWOo3O43AoaVnMlesUxRAJygBpcppoKnuqmDIuROrpAMp/0Ym6LoDEJLQrmn9GcqZBseROJJdDxpKW6TNRFcR8285WopM8oJ7112jFBsOiwVQndfO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262916; c=relaxed/simple;
	bh=cFCTVj3eLYV50+SlwfGI4Y8rNY/bJ9kf81IP6/mZvfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXixPITXMby8yULWwaAN6MjVD9yWUWvwuOWj1yiThhhRoyPZLpLQt9f/SWDFUec3sv3W43LKEp/5d8pR79lr6EMFy320EqidWAysZmt7OZTcI94IyUOBvc+ZXsubFzD/j4WtlpLE1cPZY8Qg9EdK7OUOBwqztntWf+sm8ecKD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIaMxXG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIaMxXG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767321F000FF;
	Thu, 24 Sep 2026 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262914;
	bh=Ew/4lA0mU6CwLmZ4wvwGnY4tHzAxYYulPEtOmIVvTMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TIaMxXG0PHCMypf4nn1UY/vy07D6PNRvmTvZpihTSxNv8AjOLl1KDixAiHndhaWzI
	 s7FbJnidkGEZPJwovN+0yVCeaMAigX4aHte781WGnc8YDJL/zt3jN4KKsQeaouuybg
	 IytW7iQF8qBBm4J+wMWdFwOpyUhzxwNsVLqDnOZMsbv9tmMUwcqW6IvWX4QgkdHFDl
	 nfFRulYoJCHvNDEQwuvb/d2FfG76dMY5ZJCYkmYUPi80zf7fXFpiExCtsVKo+He6lf
	 sDRKTFXdD5EDh0G4S8Kl8ClwvV1W9HPpkk1iBcsYLYP3YDvsQJNAx1EJlnseuZqUSN
	 1GXB4A0MIx1zg==
Date: Thu, 24 Sep 2026 10:15:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: conor+dt@kernel.org, nuno.sa@analog.com, devicetree@vger.kernel.org,
	Michael.Hennerich@analog.com, linux@analog.com,
	linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org, krzk+dt@kernel.org,
	andriy.shevchenko@intel.com, jic23@kernel.org,
	u.kleine-koenig@baylibre.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	dlechner@baylibre.com
Subject: Re: [PATCH v11 1/2] dt-bindings: iio: health: add adi,max86150
Message-ID: <179026291208.75492.4253010899051715264.robh@kernel.org>
References: <20260913104658.230422-1-shofiqtest@gmail.com>
 <20260913104658.230422-2-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913104658.230422-2-shofiqtest@gmail.com>


On Sun, 13 Sep 2026 13:46:55 +0300, Md Shofiqul Islam wrote:
> Add the Device Tree binding schema for the Analog Devices MAX86150
> integrated biosensor, which combines two photoplethysmography (PPG)
> channels (Red LED and IR LED) and one electrocardiogram (ECG) channel
> in a single I2C device.
> 
> The device requires four independent supply rails per the datasheet
> power tree: digital core (vdd), analog core (avdd), ECG reference
> (vref), and LED anode (leds).
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../bindings/iio/health/adi,max86150.yaml     | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

