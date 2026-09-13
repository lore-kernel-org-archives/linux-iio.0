Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2C32E73E;
	Sun, 13 Sep 2026 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320323; cv=none; b=byZphWCEiJ5xpBXjZgBekZJFHXqjXbJBKDe1u9ALQtyfdalRSKPcrqwxW7keTXllGlWCpRj5kEldr9yX7pf1xjLhG4DmcNAzroVPP5srn0awTgM66weRKQGhAHWlV+ohSnjS6JHlsRU1ty8nxw9xZ8iVcPjGT3Sa8z+1Lrgwgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320323; c=relaxed/simple;
	bh=r0ik45f1aXCVgkgsqc3JyuqXoxR5Vtax3bqqhXswGIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkOYehq8QhNvuKGn4onjx221MYSOLleSuOuOwbEe1a14KO+BRwC+fJW2qmAUQh5QNuED1KTzjxVEUrdqJy+GIToj5wWB3ToJ9q1u2q/26Rws6B7a0i9KxsBJahKIBayw8ZJhd1BihnGCuMSzp8ID7rFVQLt3FcGo7KNFL3PdK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0Qnl1By; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0Qnl1By"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E0F1F000FF;
	Sun, 13 Sep 2026 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320321;
	bh=pQN9FxH8V61Ebbvxs59/peT+8WAU481hkCLfpVtAXqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I0Qnl1ByjqRmBPBCGzL0fjNmM9R1w1UytdZ3cxntciRmcFBwwCtsSSliN6FJxE0Wp
	 sBxPvhBUytkaSsbRoy5jQv6TzIds07YpnlsxAOfg+Nr6l7XBvmcO0jVlzKeRH8cj5i
	 BDWAcpsVKF4gBFMTCPgC94IXeMLpljGICBuFS+yeWLDSkZBcdwt3P68t/I4ji+i9Jp
	 Pv96jiQwnnp9PdVev34lk7vJ4c9sGZceCJ3/19JmqIP2ggonNQCRathXjzpgSSKVip
	 9YlDWQIbj1bfjDp2Kp/wDfFlykfpjqOjArrwS8TkPIN6WQwCJ4thxt/YPh6MM6Slli
	 pfU+ae524kyuQ==
Date: Sun, 13 Sep 2026 18:25:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <krzk+dt@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <conor+dt@kernel.org>
Subject: Re: [PATCH v3 0/2] Add support for Analog Devices MAX30210
Message-ID: <20260913182514.2cb04e08@jic23-hlaptop>
In-Reply-To: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
	<cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 06:12:15 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> Add IIO support and device-tree bindings for the Analog Devices MAX30210
> low-power digital temperature sensor.

Temperatures sensors submitted to IIO always need some descriptive text in
the cover letter to explain why they should be in IIO rather than hwmon.

Note I raised this on v1 and it's still not here.

Jonathan


> 
> Changes since v2:
> - Fix FIFO byte-count handling and sample decoding.
> - Fix IIO debug register read/write access.
> - Validate event threshold values and sampling-frequency register values.
> - Return the correct sampling-frequency format and reject direct reads while
>   buffered capture is enabled.
> - Clean up the Kconfig entry and device-tree supply declaration.
> 
> John Erasmus Mari Geronimo (2):
>   dt-bindings: iio: temperature: add ADI MAX30210
>   iio: temperature: add support for Analog Devices MAX30210
> 
>  .../iio/temperature/adi,max30210.yaml         |  61 ++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/max30210.c            | 689 ++++++++++++++++++
>  5 files changed, 769 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
>  create mode 100644 drivers/iio/temperature/max30210.c
> 

