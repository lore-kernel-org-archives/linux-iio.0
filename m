Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67E9463;
	Sun, 26 Apr 2026 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777210518; cv=none; b=cw5VupAC2vviAPK9nMdrfGxMSQn62dLm3FUquPYNJZ9sK2nmDAo0KsjjNF8dWBN8pRTz5CjdHQviRTP4KjmnqoGfFaRb27DSa7l2XQK3jtxvfkXjnplG+/MTCHCMeJLaLD60sn/53VzbjDzrpFal4WVbY9hYPxO2XpRr5sbmJdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777210518; c=relaxed/simple;
	bh=BTk1f/AuI4i/I+xYYcip7FB5zpuCoSY4klcFre4bdHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKuf4H1q4YkZSwXJ2ySbnCebi3ygdDE149P567cSBpmAg9JYHi+q4hDVZM8pFt6hq6ACu7AOHnZDtHcRdySsqDtNziZTRs0gu0/8LVyOb7CJhaXEl+gLzt9aPjzzcYbL+z64XCNAx3Z9GmBYvBNG1x2QBPX+0zm6Idsxpi5LLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4RSIU5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4RSIU5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6DAC2BCAF;
	Sun, 26 Apr 2026 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777210518;
	bh=BTk1f/AuI4i/I+xYYcip7FB5zpuCoSY4klcFre4bdHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C4RSIU5CHBBr4AfkDUzqM1n9d7o6sCJFgV96/93G5OjOx45k5q+WNuK2SOBFfqKS8
	 lOGK9g0t98N8/nC0amPMGbjxsE6eiasNd0NUoD+SidRANqMhlV5UBob5+5yDqDb+L+
	 hVDwzS/qFUQRaWotwljXu+AcBQVZAfHv2Z+N0TY9oIDV0p8IxA4rNroK13FpdwFdvp
	 MosKPWz2d0HGv3DNiFrmEAPHCyaumvL5PNs8TmDPyLfPWSNWulpvVVDuquVH/WvMvG
	 /iEyQmoIeojo5TUAclLjGxMI6yiaONhOAeNGlaW6ml6RcMWgXgspMpfMNGpKOH0VUi
	 LLqLAJKPtrPvw==
Date: Sun, 26 Apr 2026 14:35:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 03/10] iio: dac: ad5686: drop enum id
Message-ID: <20260426143510.4bcfb6d8@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-3-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-3-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:04 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Split chip info table into separate structs and expose them to the spi
> i2c drivers. That is the preferrable approach and allows for the drivers
> to have knowledge of the device info before the common probe function gets
> called. Those chip info structs may be shared by SPI and I2C driver
> variants.
> Channel declaration definitions are grouped according to channel count and
> DECLARE_AD5693_CHANNELS() macro is renamed to DECLARE_AD5683_CHANNELS() to
> match the regmap_type enum.
> Use spi_get_device_match_data() and i2c_get_match_data() to get chip info
> struct reference, passing it as parameter to the common probe function.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Nice. Given no one had any comments on v1 I'll assume everyone is fine with this
one.

Applied to the testing branch of iio.git.

thanks,

Jonathan
