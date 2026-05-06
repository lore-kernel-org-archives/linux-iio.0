Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881373F0ABC;
	Wed,  6 May 2026 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084637; cv=none; b=arm2gfM22C1twnY34TV71P2edL343VZD0mxOOZhwhEUZPiSEu1tbcLxJZzKGuHW9G/BrKQfQ8GE03aLg5bXgDFFjCWOYBntphjxjgcXLarvlWsxqwCcD10snM9ky6l7Fi/Jo0axAKnPZkKIVs/012x/o6EnP9v35yZT7EJzKtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084637; c=relaxed/simple;
	bh=sPb4GB0ZtU7M83xh8G/nHx/1MLvD9P0cvOvHlj8A2AY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TefBK3ycKG2JmR1u1CgtT+ud2scgFcZ3s3mIuoI7f3oCEo2/nKu5WuNhCjaDcUX2hPGeRm+BsmTe3QEMoF6Yma3XBM2SQ++pxV2y98JGsb1klXlfArf18Kg0XyEcfKFRpPUJ9hGoCrzWMa2hZiLLAg6jJV4mBzb3OVzXOxMhZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7pGbQdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7pGbQdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CD0C2BCB0;
	Wed,  6 May 2026 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084637;
	bh=sPb4GB0ZtU7M83xh8G/nHx/1MLvD9P0cvOvHlj8A2AY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I7pGbQdcMM1OlxTeiW6iNxg7gn0GulxTroTwq0KnxUW1NTdhxyTuicenDsRihBE0L
	 NAyJrIymM3Xx5lmi+l44hnpsuR5My7C84zCKlYixf9oAWc3Ws62vOnTQuySiDzTwKd
	 0Vf8MiwYbUO94REpqb5WJNtC0laU6oHMXSghQymaIGvOLn6zaKDXmSFr4MAmWewzlc
	 4yu1bs0PAtNYZjV46mL3H1nP3EAGZkxC3DpspdSRUZKY/kXQqiFs8LWxX44tLMkZq/
	 Uum7WHhsNGuwrX7CMLATy9AsvVO1tXLvuEy0jyRHE1YCE/y6OVFjV/K7EOvKI8bhYb
	 jz2Rye2jGe0HQ==
Date: Wed, 6 May 2026 17:23:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: ABI: Add DAC 500ohm, 3.85kohm, and 16kohm
 powerdown modes
Message-ID: <20260506172348.4c7aa875@jic23-huawei>
In-Reply-To: <20260505-dev-ad3531r-v1-1-2b4cc55f69e7@analog.com>
References: <20260505-dev-ad3531r-v1-0-2b4cc55f69e7@analog.com>
	<20260505-dev-ad3531r-v1-1-2b4cc55f69e7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 12:34:31 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Add powerdown mode entries for DACs with 500 Ohm, 3.85 kOhm, and
> 16 kOhm resistor to ground output impedance states. These are used
> by the AD3531/AD3531R 4-channel DAC.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Applied this one to the testing branch of iio.git.
I'm not bothered if the docs take a while to chase the fix
as not so important to backport given the meaning is obvious enough
and this is really just about completeness.

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 60dfeff8f2c9..925a33fd309a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -764,10 +764,13 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Specifies the output powerdown mode.
>  		DAC output stage is disconnected from the amplifier and
> +		500ohm_to_gnd: connected to ground via a 500Ohm resistor,
>  		1kohm_to_gnd: connected to ground via an 1kOhm resistor,
>  		2.5kohm_to_gnd: connected to ground via a 2.5kOhm resistor,
> +		3.85kohm_to_gnd: connected to ground via a 3.85kOhm resistor,
>  		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
>  		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
> +		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
>  		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
>  		32kohm_to_gnd: connected to ground via a 32kOhm resistor,
>  		42kohm_to_gnd: connected to ground via a 42kOhm resistor,
> 

