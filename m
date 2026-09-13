Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5298221FD4;
	Sun, 13 Sep 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289971; cv=none; b=iZF/lel0N3b80VQAL58cZruktRSzHmOH6LsbQgDjOV2BbhpkJDvz8gQMs3QFtv1rjk8Cms1R27GcjUK4UBKzlTA77sI8gjU+k1rgO1MZxY3Va2H+iXSCwYsVBHmhE/x06AwQ6/cxrH0Jifdi3JU0j17tHEGjlRG5BwidJOPSGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289971; c=relaxed/simple;
	bh=30JdxxfnctuzQQcplp2ZpDOw3WNwpTTRcMdbjfo/hWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBXWexvqbzl7nwwVsgwEs+qty9vqtS39D/jhTsOlbdo/rgVoQ2ipVolo1BklYVv413S220kR5O7mUYIzE3BJ6Y896y1KGIwI+wr5LH0VX/RfnN6IpWtjbMNLtB3ByUm1NNZQsMTkUjh0QEznLfgEFyn0b1ivvdqczQ6qKRf3Z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD1z06Ma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD1z06Ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43FB1F000FF;
	Sun, 13 Sep 2026 08:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789289970;
	bh=bkszEUJOOnT0MnAIUqUL5L1rAxWgsJ/+d9BlDF6Z3KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jD1z06Mawe3mX4zcWsyOZ4jmLmRi1IEv/iqtC7ClG4FScoeyM888Xc6wljaXdG4of
	 e62L1lgJGAEpVFkt1MuKRLCp8JTlwIxPZqejm/OtX1cgw2eLgmYW+kRGxX0an9y/KG
	 AhFsjPKfojyL1qCDWhdJzihnjhXUmwDn9c7ApYXJ3A3yDxvkOCbyzQOZd/coR50YKW
	 8atCI5Ex1PNqUCum87wN6zyiW5CaOTztJjPtDJbwyPj6ftQpTX0bOayxecENqGsvbM
	 rjtOvK7aw0CYI/U+s7XT+mhVsseouL8nAx4dI9aVzv2My/3Jn5IRVwyQ2Y2i83oxXg
	 FUVPBt78LtM9Q==
Date: Sun, 13 Sep 2026 10:59:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Message-ID: <20260913-brainy-giraffe-of-climate-b9c8bc@quoll>
References: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
 <f84dff4406361f180bb85e4187a64e8f9fc21b18.1789032019.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f84dff4406361f180bb85e4187a64e8f9fc21b18.1789032019.git.johnerasmusmari.geronimo@analog.com>

On Fri, Sep 11, 2026 at 06:12:16AM +0800, John Erasmus Mari Geronimo wrote:
> Add device tree binding documentation for the Analog Devices
> MAX30210 temperature sensor.
> 
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> ---
>  .../iio/temperature/adi,max30210.yaml         | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> 

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

