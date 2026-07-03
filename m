Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305AB223708;
	Fri,  3 Jul 2026 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783041545; cv=none; b=ignj+ZHl5uxuePp9UaWzEwpf8Wf496exBOpcm6e7t+QUhDzoxV7344A8mkhxaakV0GzuHuatHmb76dYYLI71KPlR+mC2tWPFxcLeUyweDlrNzaVWQR7Ih/+Tdsr6T3BDelLlvzw3x6eu3NjC8cUUB7sQ/iExzCWN6sfE16GPZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783041545; c=relaxed/simple;
	bh=Cbn4viDp8af93+sqts6UdeNMt/J1EolsbRNbG7kByV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LA5Plbt5aB3S1x+/JeYqXT/F0rSde4OJw/ixgzMFkp5xkZOq/PNmmQ62FXogMBnM/eIFoYlnbzvCyCe8ran2i3xTfWSKZe9t4W7r0MWhdsLAFeuXq9dYOkSPK/KRmav7x7Slsd0D0mKngZVBPhyykZMhRTKu1H/ta0HUUEtXeBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CifXsRuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CifXsRuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A80D1F00A3A;
	Fri,  3 Jul 2026 01:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783041543;
	bh=QpzqHV5eNfljwM9BNUui3TR7zK9zZb1NHcedXzfay5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CifXsRuAO/0cn/qpw/xUwP8SieFV57WfqjyOzZHHW7kW1SQ/w/aIe3MCLrhg7fF48
	 GcSNblIK2X5c0Jj57aTsDnomb7HLVY9iL+OB4hYIocm4d0iqp1GGtdrofN0lDJquQP
	 KOPnonCnoIbTT2CFESrd8WvpHr1tgh+BanMtZPyFBUQu3FyXFTa8xwLKW13Gia3lIi
	 +JFZHzhIKAlN1AL+IhD5iD3rgy6qaJ4ZB2IstvcNGXXhj1etueyJnsYtubSLzbN2ID
	 +W+Ghb5ZllYfJxVbGcAlhxmgM1wCrTK0beHOcHpiiOLrrbyCPEFiZE0I13swGNKONP
	 FuZVM2xK5VVHg==
Date: Fri, 3 Jul 2026 02:18:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 03/16] iio: ABI: add parent entry for iio channels
Message-ID: <20260703021857.04fbcfd1@jic23-huawei>
In-Reply-To: <20260618-ad9910-iio-driver-v6-3-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-3-79125ffbe430@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 14:27:19 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add documentation for a read-only sysfs attribute that allows to expose
> parent-child relationships between IIO channels.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d9c4e3b53f29..e0f11b39511f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2154,6 +2154,23 @@ Description:
>  		specific attributes. This is useful for userspace to be able to
>  		better identify an individual channel.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_parent
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_parent
> +KernelVersion:	7.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute containing the sysfs name prefix of the parent
> +		channel for hierarchical channel relationships (e.g. "out_altvoltage0").
> +		The prefix uniquely identifies the parent channel and can be used by
> +		userspace to organize channels in tree-like structures that reflects
> +		the physical or logical relationships between them.

Reading this again after a while (sorry for delay) I think this needs a motivating
example to remind us what this means.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
>  KernelVersion:	4.18
>  Contact:	linux-iio@vger.kernel.org
> 

