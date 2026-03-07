Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B62ED87F;
	Sat,  7 Mar 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772888749; cv=none; b=kRwRbN+hjukgqBMS7dIrboEXfYKywyKzpM2P5tHQK+dMFMxHD2OcRbEa/7PB+z4scZJN3s4yywh4P1bqa+Tmsdj18DoIfzcD1ItxscnGN7a0/MaNCIrpHZKp+ZuPyw1m9nqsFjIKEWAdCahMeIIrXqhZgsnDeYmTDWld6WkkTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772888749; c=relaxed/simple;
	bh=MsGzxkbEd7S0wuk+Jeq/tsN463n/J1cX32rIpODmesU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frTrzHffrGPP1hnibrNGEAjubelM76LVHOdmZ29DJrkumKGOM94kua5k95Jq98lPZEgouaZtIUP6ylLlnnmC88ceGkdmqoTrz0v1pRJVwgO8V3QxPuwIaKSXRdTi1LUEticgct6t7Ae/USUF+QnrAWcWgfloFC3Wy28kR12EY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRZpboFj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRZpboFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD463C19422;
	Sat,  7 Mar 2026 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772888748;
	bh=MsGzxkbEd7S0wuk+Jeq/tsN463n/J1cX32rIpODmesU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jRZpboFjMjCp9FZQ7sIW7hjZJU3lvHSS2lvh3b5byqI3BRQqQ60uMzt1J9i85sJU+
	 FXeW/ToTk15/1P3oPYcD7Qijd8zb20wvDERjIahlE1HjLpR9QsEQ1V9Et2szPqlwE1
	 B8mYY4TQJoD3eaNzPfbLtloga0ijxzKP8kfmXFXnbuxXbr1N7uh6CEFxqEglIXP/TX
	 yJ2O1l8j6DuHq7e9cMJREJe18ihD+cu7VxXUu4q7v3iSiRFVfvpppgzcO0fjeVq5RO
	 taBHGvISG7QpiveAv4yDu7sPXlGY9k5CJUh2PYUgpsaGVp4vjxEvuoMxjjSAaFf0zL
	 yAd5m5vCy9uuQ==
Date: Sat, 7 Mar 2026 13:05:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <20260307130540.6d82be71@jic23-huawei>
In-Reply-To: <20260304080706.2844472-1-flavra@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	<20260304080706.2844472-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 6d269b844271..c80ef7c1ed12 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -77,6 +77,7 @@ enum iio_modifier {
>  	IIO_MOD_LIGHT_GREEN,
>  	IIO_MOD_LIGHT_BLUE,
>  	IIO_MOD_QUATERNION,
> +	IIO_MOD_PARTIAL_QUATERNION,
I nearly missed this.  This is a userspace header for a reason. The ABI is
fixed so we can't change the enumeration. We can only add to the end.

Good thing the discussion on the _ came up and made me wonder why the name
above was in near one with underscores!



>  	IIO_MOD_TEMP_AMBIENT,
>  	IIO_MOD_TEMP_OBJECT,
>  	IIO_MOD_NORTH_MAGN,
All userspace code using these would now be broken.
