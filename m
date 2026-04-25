Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBF4A07;
	Sat, 25 Apr 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777135233; cv=none; b=o8S7p5xhOE4ZxwNkobvXRsM9DcHPz75N0Hj/iJAwbP3dTcRgOgKlerjCy802EiGCNfNTomplPAr0oiHB3ob765pYQQ0uD1tPeAlVgzFFbhaGwrJKmoNzmAiXsUH7eP1teHzvfc3cmqXWkBtEZbWxE9neNnJ24WvcTVujbS8a7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777135233; c=relaxed/simple;
	bh=BQt+8EYpwF0VE3VbmyyQcqzXuxK9+TLYXM4VynjhgXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPQaB5LhjV4s3gD73v/bXZiMYQPch9ivSngUWQqhrQ9ngwxt/gT41C6FTlmixKCei22b6henCINs6mGrdvhMTjdxXI2RCG/6DAvCQVaqUvGRxoBXwyTc5eAKWmAK9xRD3Y4n9ShvKbFzX6AtE2NbgTOgMl/gNE6raKw4QoIfeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=braZCck+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="braZCck+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33229C2BCB0;
	Sat, 25 Apr 2026 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777135232;
	bh=BQt+8EYpwF0VE3VbmyyQcqzXuxK9+TLYXM4VynjhgXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=braZCck+EHwnhwmm7F462k80ZGZsnbS9S7EqfAK2KBGE5D0myN30ZJ3p878YPELR/
	 1G7JESsTEFKXGZSbN88C1/ViL8wb+sID4/JB8469r4o1ix+iePIaTqIqfio/gnjPAq
	 elQsjHBZxQIlrDgZLpO4CkZTuhLs0vl5WBJs6Po9LVIxZIwz48nxWxgRPRhD2jyPrM
	 qWrzayYzwG15CoF8sfYH5OkLZ6/lQYNaBUwLqTkrF9X3v7XA0uqSBu+SzEpUPG2eDA
	 djVch2fKk4OqFsMLq3asA08iSNv6GLAzrw8n9paqvJOmIxu4tYVEIgJ3R45q9WJCyb
	 7Tk9kmlMkV/hg==
Date: Sat, 25 Apr 2026 17:40:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 10/11] docs: iio: add documentation for adf41513
 driver
Message-ID: <20260425174022.0d1a6bd9@jic23-huawei>
In-Reply-To: <20260415-adf41513-iio-driver-v10-10-df61046d5457@analog.com>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
	<20260415-adf41513-iio-driver-v10-10-df61046d5457@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 10:51:53 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add documentation for ADF41513 driver, which describes the device
> driver files and shows how userspace may consume the ABI for various
> tasks.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/iio/adf41513.rst | 199 +++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst    |   1 +
>  MAINTAINERS                    |   1 +
>  3 files changed, 201 insertions(+)
> 
> diff --git a/Documentation/iio/adf41513.rst b/Documentation/iio/adf41513.rst
> new file mode 100644
> index 000000000000..4193c825b532
> --- /dev/null
> +++ b/Documentation/iio/adf41513.rst
> @@ -0,0 +1,199 @@

> +2. Device attributes
> +====================
> +
> +The ADF41513 driver provides the following IIO extended attributes for
> +frequency control and monitoring:
> +
> +Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
> +where X is the IIO index of the device. Under these folders reside a set of
> +device files that provide access to the synthesizer's functionality.
> +
> +The following table shows the ADF41513 related device files:
> +
> ++----------------------+-------------------------------------------------------+
> +| Device file          | Description                                           |
> ++======================+=======================================================+
> +| frequency            | RF output frequency control and readback (Hz)         |
> ++----------------------+-------------------------------------------------------+
> +| frequency_resolution | Target frequency resolution control (Hz)              |
> ++----------------------+-------------------------------------------------------+
> +| powerdown            | Power management control (0=active, 1=power down)     |
> ++----------------------+-------------------------------------------------------+
> +| phase                | RF output phase adjustment and readback (radians)     |
> ++----------------------+-------------------------------------------------------+

These seem to be truncated as the out_altvoltage0_ prefix isn't mentioned.
Fine to do that but add a note to say that more clearly.
I briefly read this as 'new ABI' though the examples a at the end of the file
make it clear that we are simply missing the prefix.



