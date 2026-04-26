Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9717C211;
	Sun, 26 Apr 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204784; cv=none; b=e7Xa5qyw6NsfrZJt7gsiYUcDFjll7TJUIQ1DI7sEsZkcYXbNXlB+CGnQm3nXEbHc48oxhwfjb9Y2EFb59Mee0s0iZTe5ylwyczeo2oUqf0/gZ1jeBCHs/uyjgcvdU8yDm8Dug97cJtrk2gHNTou70jK5U9alOURsWziXsDrTdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204784; c=relaxed/simple;
	bh=ErE2xi1w0NDzBHq6oZhqpbqyX8RETK0bI/NpmHLX5As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL1pSeec1sXM0yvPNUZzVQFiF3buID6ItIdq0ts5CUh2Q2/vGJpWkhP1pFqm5ZVNwnylkLFXdPxwkP5G5i5wlL7x6w0Ocb2CGVuWT/J3wxB3/uAfLSbaFNX9lSWSKusTDofA43Pthja6di0Abo2t9HYUxiyJDylRxg4fLiYJP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spKCwAWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spKCwAWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF0EC2BCAF;
	Sun, 26 Apr 2026 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777204783;
	bh=ErE2xi1w0NDzBHq6oZhqpbqyX8RETK0bI/NpmHLX5As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=spKCwAWtEU6vI1ZRi7GU+JgOb6llm5avsMA8MLaQySozMLEi/mdW4Fba93tal7mFr
	 EFt3l6FFr5WpfI0ec3R1devEuS6E9iWbGw9l2vvmvgEejK0rZmCfpTvobqaWDqitwd
	 zXHj6f9PCsx86yZ0T+AgKJLyYRzv69zDmDCTDL6gVarkbONsK0LYGGrQZHH2mjZpYO
	 ZTucQ1BtDqrt6b5feEJVnht4BhI5WNuinvQt/CC38/JQ5jtbTRl3MRYsV2fWMDg5zf
	 p1wGIxIMxfyPLwYAyLhh2RuHN8CVrFJdhevqVBGM91PO3wU/H+zlXigcIAH+2ODDV5
	 KZQbTcynmv0Rw==
Date: Sun, 26 Apr 2026 12:59:31 +0100
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
Subject: Re: [PATCH RFC v3 3/9] iio: frequency: ad9910: add simple parallel
 port mode support
Message-ID: <20260426125931.2312f8aa@jic23-huawei>
In-Reply-To: <20260417-ad9910-iio-driver-v3-3-29b93712a228@analog.com>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
	<20260417-ad9910-iio-driver-v3-3-29b93712a228@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:17:32 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add parallel port channel with frequency scale, frequency offset, phase
> offset, and amplitude offset extended attributes for configuring the
> parallel data path.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Really minor stuff - mostly follow on from review of previous patch.

> ---
>  drivers/iio/frequency/ad9910.c | 152 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index e9005037db1a..5b4076028a29 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c

>  struct ad9910_data {
> @@ -478,6 +490,10 @@ static ssize_t ad9910_ext_info_read(struct iio_dev *indio_dev,
>  		val = !!FIELD_GET(AD9910_CFR1_SOFT_POWER_DOWN_MSK,
>  				  st->reg[AD9910_REG_CFR1].val32);
>  		break;
> +	case AD9910_PP_FREQ_SCALE:
> +		val = BIT(FIELD_GET(AD9910_CFR2_FM_GAIN_MSK,
> +				    st->reg[AD9910_REG_CFR2].val32));
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -508,6 +524,113 @@ static ssize_t ad9910_ext_info_write(struct iio_dev *indio_dev,
>  					  AD9910_CFR1_SOFT_POWER_DOWN_MSK,
>  					  val32, true);
>  		break;
> +	case AD9910_PP_FREQ_SCALE:
> +		if (val32 > BIT(15) || !is_power_of_2(val32))
> +			return -EINVAL;
> +
> +		val32 = FIELD_PREP(AD9910_CFR2_FM_GAIN_MSK, ilog2(val32));
> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR2,
> +					  AD9910_CFR2_FM_GAIN_MSK,
> +					  val32, true);
As in previous, I'd prefer the more verbose
		if (ret)
			return ret;

		break;

Same for all the similar cases.


> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret ?: len;
> +}


> @@ -661,6 +808,11 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
>  			}
>  
>  			return ad9910_profile_set(st, tmp32);
> +		case AD9910_CHANNEL_PARALLEL_PORT:
> +			tmp32 = FIELD_PREP(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK, !!val);
> +			return ad9910_reg32_update(st, AD9910_REG_CFR2,
> +						   AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +						   tmp32, true);
Ah. So tmp32 isn't always an index.  Maybe just use local clearer named variables?
>  		default:
>  			return -EINVAL;
>  		}
> 

