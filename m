Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE930F803;
	Sun, 19 Apr 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776598202; cv=none; b=q/f25+cTRf7giH6y+/vdJtAPnFhnzqIJ/zkDPF+Q954P/HC+ZiTaqwPdYb00R3svpXxpKLGEDadWJREII4RQMbVlWNJMXbQiBl8p8CL7own6uhYk1yyLuFxAWG9qdKuh2Kv9vwqMtZYhVg1TFgVCR3lr49yRPYNXeHU/ecg+SEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776598202; c=relaxed/simple;
	bh=CHB4/6+0UEiC/NOhE0jTVNiOoZM6X5MNmZ8tDCiMuYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0VBQxnsSNK2LgBhDjyptqzJg8WbcUjAYIDHpga8+n4Pkz85J0JnQg/UGlbj9+YvB85TfY8Yyx6kuMhnw/DZGom4svI18RyPV3HAV4fVnP8Rleqhn/ghQKoz5mN+OFDzj97D3/Ph3XmEMSlUHFhaXNAHubNCuBa70woqdDDzqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLA4WNsv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLA4WNsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225EAC2BCAF;
	Sun, 19 Apr 2026 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776598201;
	bh=CHB4/6+0UEiC/NOhE0jTVNiOoZM6X5MNmZ8tDCiMuYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OLA4WNsveo1tU8lw+9Wf0KVQhwYkwgLbftZ6QU0ltrNthIzHFh7YY84NHYLb3NtFL
	 QGLu+DKfL53LBBBPKzmkCtqinWSZKaOBMnt9rEzXvxQw7qHbxmYFNjEnmymMK5uSor
	 CIvO10CDqrx+Z5lpe41cMEmctEOp/TQOERZNKce5usKvpWOO5CgCjQI3kBM6EODIu3
	 wPwBYqmDjVZ8JjwhGpRQejOKfHgIsFZs3OF4rXpUnP89cnVlZWbdyHOTDNTTGbGzx9
	 l9RPRTc10XMMfc49NaBJTovd6fQntVXC7Pu1XpsIvnGc53N8rhOMEBi90Atci9Rca/
	 QjNfUOYuMYIuA==
Date: Sun, 19 Apr 2026 12:29:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: tsl2772: add support for Avago
 APDS9900/9901 ALS/Proximity sensor
Message-ID: <20260419122950.67355f4c@jic23-huawei>
In-Reply-To: <20260419083125.35572-3-clamor95@gmail.com>
References: <20260419083125.35572-1-clamor95@gmail.com>
	<20260419083125.35572-3-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 11:31:23 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The Avago APDS990x has the same register set as the TAOS/AMS TSL2772 so
> just add the correct bindings and the appropriate LUX table derived from
> the values in the datasheet. Driver was tested on the LG Optimus Vu P895.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Hi Svyatoslav,

Just one small thing. 

Experience has given me a strong aversion to the use of wildcards
in naming within drivers.  They go wrong too often because companies
can seem to resist using similar names for very different parts.

> ---
>  drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index c8f15ba95267..8dab34bf00ca 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -127,6 +127,7 @@ enum {
>  	tmd2672,
>  	tsl2772,
>  	tmd2772,
> +	apds990x,

As above, just name this after one of the supported parts. apds9900
That doesn't stop you using it for multiple compatible devices.

Same applies for all the uses of x as a wildcard.

thanks,

Jonathan

>  	apds9930,
>  };

