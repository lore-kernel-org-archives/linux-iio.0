Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06A1DB95E;
	Sun,  2 Aug 2026 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785632173; cv=none; b=H0lB/DMfAvDh3xlHNrNpu0AeR3SOFBr74IJGHB7dI0sucOcEjiOyDQzmjmgXy23TZX4cwRB0crNRbvpcIaFTUnC2QujgTATVSKE6i40hNLHeE4Imgz5SqCGJjRJXjWwJCzURuNnyvQG4rzI3k1NZ3vd7soog2MKiybBFhdwDQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785632173; c=relaxed/simple;
	bh=udVJFSEJ6KhIAj+HjZweEB1Ptg5uOdfDVwXOTZ258GA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj8ZgKmcn0xqBFDPBHi2K++COnSwW1yRGSggf9ch3B/Qx+xoS7BrXDQQ1g01ZIg5PzBxuw+ZbYCVbTooQ1yWRCEGuM5VzQ2URLkMfwV06e6m6S6feKHpzhDfFmc96GJGh/2sVwp/S1FQmkzBzQ98bQFYq/HbdyOLU7YNm/FHzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPGl7V75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPGl7V75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BCA1F00AC4;
	Sun,  2 Aug 2026 00:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785632172;
	bh=X+sA+LN+pQEejB6N+3mwTOoymDEDhFvu7S/VkViafWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mPGl7V75JCqAJSupUbqbANP0PpuUQCZinFDLrSynfwxaqXW5tyokVzWrh3P1COS3m
	 nAtHXgkuFs6sjp+7D0exVO6r1RKIYg03TVOH+SmQjzNraxgEeJATpH11h1N/qjFTc2
	 0isLSiJpRYCbNqd/4LSzEX6zkBTglYEV0ImKN/OIRXUm96ptkkpZOudWwkpgvYkfmj
	 X00S+OPJgSEy6ftX043YKNZA4qT8Dy4VmIWfHpY4rtcLBl5LuRS7tkKyhR/sRdPOuY
	 osMuVbFDDxYHbM2jxWGdg6EtiwOnQ/Pwzftb3howX+AZXyC8EMziG3YFpWuJHxRoGT
	 gE/aXPnptbnAA==
Date: Sun, 2 Aug 2026 01:56:07 +0100
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
 R. Silva" <gustavoars@kernel.org>, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH v10 11/17] iio: frequency: ad9910: add basic parallel
 port support
Message-ID: <20260802015607.7d7d4dd8@jic23-huawei>
In-Reply-To: <20260729-ad9910-iio-driver-v10-11-aa1f6167729e@analog.com>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260729-ad9910-iio-driver-v10-11-aa1f6167729e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 09:25:38 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add parallel port support with amplitude, phase and frequency channels.
> Those will be buffered capable channels, but only basic control of offset
> and scale are implemented at this point. There are separate amplitude
> and phase control for polar destination, which will provide different scan
> types. Enabling and disabling of parallel mode will be implemented with
> buffer setup ops or with update_scan_mode() once IIO backend integration
> is in place.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hmm. Curious... clang --version gives 22.1.8 on x86_64.

make LLVM=1 LOCALVERSION= -j12 W=1 C=1
  DESCEND objtool
Documentation/.renames.txt: warning: ignored by one of the .gitignore files
  CC [M]  drivers/iio/frequency/ad9910.o
In file included from drivers/iio/frequency/ad9910.c:10:
In file included from ./include/linux/clk.h:13:
In file included from ./include/linux/kernel.h:26:
In file included from ./include/linux/math.h:6:
./arch/x86/include/asm/div64.h:113:8: error: invalid operand for instruction
  113 |                 asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
      |                      ^
<inline asm>:1:7: note: instantiated into assembly here
    1 |         addq $2147483648, %rax; adcq $0, %rdx
      |              ^~~~~~~~~~~~
1 error generated.
make[5]: *** [scripts/Makefile.build:289: drivers/iio/frequency/ad9910.o] Error 1
make[4]: *** [scripts/Makefile.build:549: drivers/iio/frequency] Error 2
make[3]: *** [scripts/Makefile.build:549: drivers/iio] Error 2
make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
make[1]: *** [/home/jic23/src/kernel/iio/Makefile:2184: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


> ---
>  drivers/iio/frequency/ad9910.c | 154 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
> 
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index b41b011af281..aaeff2e7640e 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c


>  static int ad9910_read_raw(struct iio_dev *indio_dev,
> @@ -691,6 +753,48 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
>  			*val = 0;
>  			*val2 = tmp64 >> 14;
>  			return IIO_VAL_INT_PLUS_NANO;
> +		case AD9910_CHAN_IDX_PARALLEL_PHASE:
> +			*val = 0;
> +			*val2 = AD9910_PI_NANORAD >> 15;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case AD9910_CHAN_IDX_PARALLEL_FREQ:
> +			tmp32 = FIELD_GET(AD9910_CFR2_FM_GAIN_MSK,
> +					  st->reg[AD9910_REG_CFR2].val32);
> +			tmp64 = (u64)st->data.sysclk_freq_hz << tmp32;
> +			tmp64 = ad9910_rational_scale(tmp64, NANO, BIT_ULL(32));

Process of elimination points me to this line which is a slim wrapper.

static inline u64 ad9910_rational_scale(u64 input, u64 scale, u64 reference)
{
	return mul_u64_add_u64_div_u64(input, scale, reference >> 1, reference);
}

David, any thoughts?

For now I'm backing out the series.

> +			*val = div_s64_rem(tmp64, NANO, val2);
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case AD9910_CHAN_IDX_PARALLEL_POLAR_AMP:
> +			tmp64 = (u64)st->data.output_current_uA *
> +				AD9910_NANO_MILLIAMP_PER_MICROAMP;
> +			*val = 0;
> +			*val2 = tmp64 >> 8;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE:
> +			*val = 0;
> +			*val2 = AD9910_PI_NANORAD >> 7;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
