Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA6407588;
	Tue,  5 May 2026 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979220; cv=none; b=i6uIfntm9k76DuQpwUoZJEnNWCv/+CTX5SFLIYQlDDHsZ02BtTVrHq+UxibukE4asqUUjOt5GKdzX4HHBahghtCj9lvaOj+rvStej9wLvNou6zey87FDDtW8/flXVZWpNgMcyvCSb+UecCMLh6FMNyislp4cvxid7foaONWHblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979220; c=relaxed/simple;
	bh=wC0QXhJtDMGYsPSRvDUrTtiLAciUB/vluz45+Tr1fNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSrAnp9CgvMheDNMmR+uDX+EHc7o1d9sxNsoGf1J7gC/PtqxKV+cBuEZOPu5kq+umlKQBSaZDHdpvQ94Wt9VhoJUgnxAfA4sKSkWuXuxSNbCdNKvisNAUXIuWvCY+tfQnBqi9zzv7PXt/tEIoJemNUOguOsJothx1W60gLJCZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFydhz8U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFydhz8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC31C2BCB4;
	Tue,  5 May 2026 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777979220;
	bh=wC0QXhJtDMGYsPSRvDUrTtiLAciUB/vluz45+Tr1fNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFydhz8UdGzolHxbJNvuwQhuFsfKkgc1SmnAXbHVZcct0QMZvx3vkBx23+KdmYvt8
	 VMJc4LGNxA8IWug69NedxeYcAWhwMQ1nzDuf+Uu1/iH3CyKjHPLqZauxDYJCGjaP35
	 w+Dnoph13THFkTSkKMQ08iCfqncjWXeWyjHjktg1W41v2YRno0TOFZYJuXMud3RwcL
	 u28kVKmwHyZzoZ7F4FEx+v/2IGtWK7r1R0RABHan//HXrtetdSwhGhQReXCbOjW+UG
	 QsJ6NaUqc5mJBM+jABse0TrgCL+9+4m0I8kP/sY0g1wKp9PLdymDK76XoJc8nVbPXx
	 5Ruz4FicgIACQ==
Date: Tue, 5 May 2026 12:06:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 01/12] iio: dac: ad5686: fix ref bit initialization
 for single-channel parts
Message-ID: <20260505120644.10bb6139@jic23-huawei>
In-Reply-To: <20260501-ad5686-fixes-v5-1-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
	<20260501-ad5686-fixes-v5-1-0b2f45488418@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 May 2026 10:14:54 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> The reference bit position was ignored when writing the register at the
> probe() function (!!val was used). When such bit is 1, internal voltage
> reference is disabled so that an external one can be used. For
> multi-channel devices, bit 0 of the Internal Reference Setup command
> behaves the same way, so AD5686_REF_BIT_MSK is created. The issue exists
> since support for single-channel devices were first introduced.
> 
> Fixes: be1b24d24541 ("iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied this patch to the fixes-togreg branch of iio.git and marked
it for stable.

Thanks

Jonathan

> ---
>  drivers/iio/dac/ad5686.c | 6 +++---
>  drivers/iio/dac/ad5686.h | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 9a384c50929b..1fc54c38b629 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -511,7 +511,7 @@ int ad5686_probe(struct device *dev,
>  		break;
>  	case AD5686_REGMAP:
>  		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
> -		ref_bit_msk = 0;
> +		ref_bit_msk = AD5686_REF_BIT_MSK;
>  		break;
>  	case AD5693_REGMAP:
>  		cmd = AD5686_CMD_CONTROL_REG;
> @@ -522,9 +522,9 @@ int ad5686_probe(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	val = (has_external_vref | ref_bit_msk);
> +	val = has_external_vref ? ref_bit_msk : 0;
>  
> -	ret = st->write(st, cmd, 0, !!val);
> +	ret = st->write(st, cmd, 0, val);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index e7d36bae3e59..36e16c5c4581 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -46,6 +46,7 @@
>  
>  #define AD5310_REF_BIT_MSK			BIT(8)
>  #define AD5683_REF_BIT_MSK			BIT(12)
> +#define AD5686_REF_BIT_MSK			BIT(0)
>  #define AD5693_REF_BIT_MSK			BIT(12)
>  
>  /**
> 

